clear 
clc

rcxres = 384;
rcyres = 384;
rczres = 384;

base_dir = uigetdir();

% Names of file
vx_name =fullfile(base_dir,'comp_vd_1.dat');
vy_name =fullfile(base_dir,'comp_vd_2.dat');
vz_name =fullfile(base_dir,'comp_vd_3.dat');
mag_name = fullfile(base_dir,'MAG.dat');

VELX = memmapfile(vx_name,'Format',{'int16',[rcxres rcyres rczres],'vals'});
VELY = memmapfile(vy_name,'Format',{'int16',[rcxres rcyres rczres],'vals'});
VELZ = memmapfile(vz_name,'Format',{'int16',[rcxres rcyres rczres],'vals'});
MAG =  memmapfile(mag_name,'Format',{'int16',[rcxres rcyres rczres],'vals'});

[poly_fitx,poly_fity, poly_fitz] = background_phase_correction(MAG,VELX,VELY,VELZ);


ANGIO = single(zeros(size(VELX.Data.vals)));
Vx = single(zeros(size(VELX.Data.vals)));
Vy = single(zeros(size(VELX.Data.vals)));
Vz = single(zeros(size(VELX.Data.vals)));

xrange = single( linspace(-1,1,size(VELX.Data.vals,1)) );
yrange = single( linspace(-1,1,size(VELY.Data.vals,2)) );
zrange = single( linspace(-1,1,size(VELZ.Data.vals,3)) );

VENC = 600;

[y,x] = meshgrid(yrange,xrange);
for slice = 1: size(ANGIO,3)
    
    
    vx_slice = single(VELX.Data.vals(:,:,slice) );
    vy_slice = single(VELY.Data.vals(:,:,slice) );
    vz_slice = single(VELZ.Data.vals(:,:,slice) );
    mag_slice= single(MAG.Data.vals(:,:,slice) );
    
    
        z = zrange(slice);
        vx_slice = vx_slice - evaluate_poly(x,y,z,poly_fitx);
        vy_slice = vy_slice - evaluate_poly(x,y,z,poly_fity);
        vz_slice = vz_slice - evaluate_poly(x,y,z,poly_fitz);
    vmag =sqrt(vx_slice.^2 + vy_slice.^2 + + vz_slice.^2);
    ANGIO(:,:,slice)= mag_slice.*sin( pi/2 * vmag/VENC);
    Vx(:,:,slice) = vx_slice;
    Vy(:,:,slice) = vy_slice;
    Vz(:,:,slice) = vz_slice;
    
end


new_dir = fullfile(base_dir,'CORRECTED2');
mkdir(new_dir);

MAG2 = MAG.Data.vals;
fid = fopen(fullfile(new_dir,'MAG.dat'),'w');
fwrite(fid,MAG2,'short');
fclose(fid);

fid = fopen(fullfile(new_dir,'CD.dat'),'w');
fwrite(fid,ANGIO,'short');
fclose(fid);

fid = fopen(fullfile(new_dir,'comp_vd_1.dat'),'w'); fwrite(fid,Vx,'short'); fclose(fid);
fid = fopen(fullfile(new_dir,'comp_vd_2.dat'),'w'); fwrite(fid,Vy,'short'); fclose(fid);
fid = fopen(fullfile(new_dir,'comp_vd_3.dat'),'w'); fwrite(fid,Vz,'short'); fclose(fid);
fid = fopen(fullfile(new_dir,'ph_000_vd_1.dat'),'w'); fwrite(fid,Vx,'short'); fclose(fid);
fid = fopen(fullfile(new_dir,'ph_000_vd_2.dat'),'w'); fwrite(fid,Vy,'short'); fclose(fid);
fid = fopen(fullfile(new_dir,'ph_000_vd_3.dat'),'w'); fwrite(fid,Vz,'short'); fclose(fid);
fid = fopen(fullfile(new_dir,'ph_000_cd.dat'),'w'); fwrite(fid,ANGIO,'short'); fclose(fid);
MAG2 = MAG.Data.vals;
fid = fopen(fullfile(new_dir,'ph_000_mag.dat'),'w'); fwrite(fid,MAG2,'short'); fclose(fid);



imshow(max(ANGIO(:,:,128:end-128),[],3),[])
