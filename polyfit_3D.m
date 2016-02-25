function [poly_fitx,poly_fity,poly_fitz ] =  polyfit_3D(MAG,VX,VY,VZ,fit_order,cd_thresh, noise_thresh)

VENC = 1000;
Mask = int8(zeros(size(MAG.Data.vals)));
max_MAG = max(MAG.Data.vals(:));

% Create angiogram
for slice = 1:size(Mask,3)
    
    % Grab a slice
    mag_slice = single( MAG.Data.vals(:,:,slice));
    vx_slice = single(VX.Data.vals(:,:,slice));
    vy_slice = single(VY.Data.vals(:,:,slice));
    vz_slice = single(VZ.Data.vals(:,:,slice));
    
%     [y,x,z] = meshgrid( handles.xrange,handles.yrange,handles.zrange(slice) );    
%     vx_slice = vx_slice - evaluate_poly(x,y,z,handles.poly_vals{1},handles.px,handles.py,handles.pz);
%     vy_slice = vy_slice - evaluate_poly(x,y,z,handles.poly_vals{2},handles.px,handles.py,handles.pz);
%     vz_slice = vz_slice - evaluate_poly(x,y,z,handles.poly_vals{3},handles.px,handles.py,handles.pz);

    CD = sqrt(vx_slice.^2 + vy_slice.^2 + + vz_slice.^2);
    Mask(:,:,slice) = ( mag_slice > noise_thresh*max_MAG) .* ( CD < cd_thresh*VENC);
end

%lots of memory problems with vectorization!!! solve Ax = B by (A^hA) x = (A^h *b)
if fit_order == 0
    
    px = 0;
    py = 0;
    pz = 0;
        
    poly_fitx.vals  = mean(VX.Data.vals(:));
    poly_fitx.px = 0;
    poly_fitx.py = 0;
    poly_fitx.pz = 0;
    
    poly_fity.vals  = mean(VY.Data.vals(:));
    poly_fity.px = 0;
    poly_fity.py = 0;
    poly_fity.pz = 0;
    
    poly_fitz.vals  = mean(VZ.Data.vals(:));
    poly_fitz.px = 0;
    poly_fitz.py = 0;
    poly_fitz.pz = 0;
    
        
else   
    [px py pz]=meshgrid(0:fit_order,0:fit_order,0:fit_order);
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
        
    xrange = single( linspace(-1,1,size(VX.Data.vals,1)) );
    yrange = single( linspace(-1,1,size(VY.Data.vals,2)) );
    zrange = single( linspace(-1,1,size(VZ.Data.vals,3)) );
    
    for slice = 1:numel(zrange)
        vx_slice = single(VX.Data.vals(:,:,slice) );
        vy_slice = single(VY.Data.vals(:,:,slice) );
        vz_slice = single(VZ.Data.vals(:,:,slice) );
        
        [y,x,z] = meshgrid( xrange,yrange,zrange(slice) );  
        idx = find( Mask(:,:,slice) > 0);
        x = x(idx);
        y = y(idx);
        z = z(idx);
        vx_slice = vx_slice(idx);
        vy_slice = vy_slice(idx);
        vz_slice = vz_slice(idx);
        
        for i = 1:N
            for j = 1:N
                AhA(i,j) =  AhA(i,j) + sum( ( x.^px(i).*y.^py(i).*z.^pz(i)).*( ( x.^px(j).*y.^py(j).*z.^pz(j))));
            end
        end
        
        for i = 1:N
            AhBx(i) = AhBx(i) + sum( vx_slice.* ( x.^px(i).*y.^py(i).*z.^pz(i)));
            AhBy(i) = AhBy(i) + sum( vy_slice.* ( x.^px(i).*y.^py(i).*z.^pz(i)));
            AhBz(i) = AhBz(i) + sum( vz_slice.* ( x.^px(i).*y.^py(i).*z.^pz(i)));
        end
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


