function standalone_background_correction(varargin)
% function standalone_background_correction
% 
%   Usage: standalone_background_correction(base_dir)
%          standalone_background_correction(base_dir, 'fitonly')
%          standalone_background_correction(base_dir, 'fitonly', maskFile, fitorder)
%          standalone_background_correction(base_dir, 'writeonly')
%
% standalone_background_correction
% corrects PCVIPR 4D Flow Data for background phase offsets
%
% Written by Kevin Johnson
% Updated by Phil Corrado June 2018 to be faster by correcting all slices
% at once

    if nargin>0 && exist(varargin{1}, 'dir')
        base_dir = varargin{1};
    else
        base_dir = uigetdir();
    end
    data = readPCVIPR(base_dir);

    vx_name =fullfile(base_dir,'comp_vd_1.dat');
    vy_name =fullfile(base_dir,'comp_vd_2.dat');
    vz_name =fullfile(base_dir,'comp_vd_3.dat');
    mag_name = fullfile(base_dir,'MAG.dat');

    VELX = memmapfile(vx_name,'Format',{'int16',[data.xSize data.ySize data.zSize],'vals'});
    VELY = memmapfile(vy_name,'Format',{'int16',[data.xSize data.ySize data.zSize],'vals'});
    VELZ = memmapfile(vz_name,'Format',{'int16',[data.xSize data.ySize data.zSize],'vals'});
    MAG =  memmapfile(mag_name,'Format',{'int16',[data.xSize data.ySize data.zSize],'vals'});
        
    if nargin < 2 || ~ischar(varargin{2}) || ~strcmp(varargin{2},'writeonly')
        if nargin < 4 || ~exist(varargin{3}, 'file') || ~isnumeric(varargin{4})
            [poly_fitx,poly_fity, poly_fitz] = background_phase_correction(MAG,VELX,VELY,VELZ);
        else
            mask = niftiread(varargin{3});
            fit_order = varargin{4};
            
            % Plot Mask
            slice = round(size(VELX.Data.vals,3)/2);
            vx_slice = single(VELX.Data.vals(:,:,slice) );
            vy_slice = single(VELY.Data.vals(:,:,slice) );
            vz_slice = single(VELZ.Data.vals(:,:,slice) );
            mag_slice= single(MAG.Data.vals(:,:,slice) );
            
            idx = find( mask(:,:,slice) > 0);
            mag_slice = 200 * mag_slice/max(mag_slice(:));
            mag_slice(idx) = 257; %#ok<FNDSB>
            
            map =[ gray(200); jet(10)];
            figure();
            imagesc(mag_slice,[0,200+10]);
            colormap(map);
            set(gca,'XTickLabel','')
            set(gca,'YTickLabel','')
            daspect([1 1 1]);
            
            % Fit background phase
            [px,py,pz]=meshgrid(0:fit_order,0:fit_order,0:fit_order);
            idx2 = find( (px+py+pz) <= fit_order);
            px = px(idx2);
            py = py(idx2);
            pz = pz(idx2);
            A = [px(:) py(:) pz(:)];
            N = size(A,1);
            AhA = zeros(N,N);
            AhBx = zeros(N,1);
            AhBy = zeros(N,1);
            AhBz = zeros(N,1);
            
            xrange = single( linspace(-1,1,size(VELX.Data.vals,1)) );
            yrange = single( linspace(-1,1,size(VELY.Data.vals,2)) );
            zrange = single( linspace(-1,1,size(VELZ.Data.vals,3)) );
            [y,x,z] = meshgrid( yrange,xrange,zrange );
            idx = find( mask > 0);
            x = x(idx);
            y = y(idx);
            z = z(idx);

                
            for i = 1:N
                for j = 1:N
                    AhA(i,j) =  AhA(i,j) + sum( ( x.^px(i).*y.^py(i).*z.^pz(i)).*( ( x.^px(j).*y.^py(j).*z.^pz(j))));
                end
            end
            
            for i = 1:N
                AhBx(i) = AhBx(i) + sum( single(VELX.Data.vals(idx)).* ( x.^px(i).*y.^py(i).*z.^pz(i)));
                AhBy(i) = AhBy(i) + sum( single(VELY.Data.vals(idx)).* ( x.^px(i).*y.^py(i).*z.^pz(i)));
                AhBz(i) = AhBz(i) + sum( single(VELZ.Data.vals(idx)).* ( x.^px(i).*y.^py(i).*z.^pz(i)));
            end
            
            poly_fitx.vals = linsolve(AhA,AhBx);
            poly_fitx.px = px;
            poly_fitx.py = py;
            poly_fitx.pz = pz;
            
            poly_fity.vals = linsolve(AhA,AhBy);
            poly_fity.px = px;
            poly_fity.py = py;
            poly_fity.pz = pz;
            
            poly_fitz.vals = linsolve(AhA,AhBz);
            poly_fitz.px = px;
            poly_fitz.py = py;
            poly_fitz.pz = pz;
        end
    else 
        data = readPCVIPR(base_dir);
        a = load(fullfile(base_dir,'bgPhaseFitCoefficients.mat'));
        poly_fitx = a.poly_fitx;
        poly_fity = a.poly_fity;
        poly_fitz = a.poly_fitz;
    end

    if nargin <2 || ~ischar(varargin{2}) || ~strcmp(varargin{2},'fitonly')
        xrange = single( linspace(-1,1,data.xSize) );
        yrange = single( linspace(-1,1,data.ySize) );
        zrange = single( linspace(-1,1,data.zSize) );

        [y,x,z] = ndgrid(yrange,xrange,zrange);

        new_dir = fullfile(base_dir,'CORRECTED');
        mkdir(new_dir);

        fid = fopen(fullfile(new_dir,'comp_vd_1.dat'),'w');
        fwrite(fid,double(VELX.Data.vals) - evaluate_poly(x,y,z,poly_fitx),'int16');
        fclose(fid);

        fid = fopen(fullfile(new_dir,'comp_vd_2.dat'),'w');
        fwrite(fid,double(VELY.Data.vals) - evaluate_poly(x,y,z,poly_fity),'int16');
        fclose(fid);

        fid = fopen(fullfile(new_dir,'comp_vd_3.dat'),'w');
        fwrite(fid,double(VELZ.Data.vals) - evaluate_poly(x,y,z,poly_fitz),'int16');
        fclose(fid);

        copyfile(fullfile(base_dir,'pcvipr_header.txt'),fullfile(new_dir,'pcvipr_header.txt'));

        for ii = 1:data.nT
            copyfile(fullfile(base_dir,sprintf('ph_%.3d_mag.dat',ii-1)),fullfile(new_dir,sprintf('ph_%.3d_mag.dat',ii-1)));
            copyfile(fullfile(base_dir,sprintf('ph_%.3d_cd.dat',ii-1)),fullfile(new_dir,sprintf('ph_%.3d_cd.dat',ii-1)));

            fid = fopen(fullfile(new_dir,sprintf('ph_%.3d_vd_1.dat',ii-1)),'w');
            fwrite(fid,double(data.velX(:,:,:,ii)) - evaluate_poly(x,y,z,poly_fitx),'int16');
            fclose(fid);

            fid = fopen(fullfile(new_dir,sprintf('ph_%.3d_vd_2.dat',ii-1)),'w');
            fwrite(fid,double(data.velY(:,:,:,ii)) - evaluate_poly(x,y,z,poly_fity),'int16');
            fclose(fid);

            fid = fopen(fullfile(new_dir,sprintf('ph_%.3d_vd_3.dat',ii-1)),'w');
            fwrite(fid,double(data.velZ(:,:,:,ii)) - evaluate_poly(x,y,z,poly_fitz),'int16');
            fclose(fid);
        end
    else
        save(fullfile(base_dir,'bgPhaseFitCoefficients.mat'),'poly_fitx','poly_fity','poly_fitz');
    end
end
