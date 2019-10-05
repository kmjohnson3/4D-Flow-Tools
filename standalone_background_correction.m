function standalone_background_correction(varargin)
% function standalone_background_correction
% 
%   Usage: standalone_background_correction(base_dir)
%          standalone_background_correction(base_dir, 'fitonly')
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
        
    if nargin <2 || ~ischar(varargin{2}) || ~strcmp(varargin{2},'writeonly')
        [poly_fitx,poly_fity, poly_fitz] = background_phase_correction(MAG,VELX,VELY,VELZ);
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
