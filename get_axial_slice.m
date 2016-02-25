function get_axial_slice( slice, time_averaged_flag)

%%%Reads external files for parameters
[parameter value]=textread('pcvipr_header.txt', '%s %s');

%%%FOVS
idx = find(strcmp('fovx',parameter));
xfov = str2num( value{idx} );

idx = find(strcmp('fovy',parameter));
yfov = str2num( value{idx} );

idx = find(strcmp('fovz',parameter));
zfov = str2num( value{idx} );

%%%Matrix
idx = find(strcmp('matrixx',parameter));
rcxres = str2num( value{idx} );

idx = find(strcmp('matrixy',parameter));
rcyres = str2num( value{idx} );

idx = find(strcmp('matrixz',parameter));
rczres = str2num( value{idx} );

%%%Time Stuff
idx = find(strcmp('frames',parameter));
frames = str2num( value{idx} );
if(frames==-1 || time_averaged_flag==1)
    frames = 0;
end



idx = find(strcmp('timeres',parameter));
tres = str2num( value{idx} )/1000;

idx = find(strcmp('VENC',parameter));
VENC = str2num( value{idx} );

for time=0:(frames)
        disp(['Read Frame ',int2str(time),' of ',int2str(frames)]);

        if time ==0 || frames==3 || time_averaged_flag==1
            vx_name ='comp_vd_1.dat';
            vy_name ='comp_vd_2.dat';
            vz_name ='comp_vd_3.dat';
            cd_name = 'CD.dat';
            mag_name = 'MAG.dat';
        else
            vx_name = sprintf('ph_%03d_vd_1.dat',time-1);
            vy_name = sprintf('ph_%03d_vd_2.dat',time-1);
            vz_name = sprintf('ph_%03d_vd_3.dat',time-1);
            cd_name = sprintf('ph_%03d_cd.dat',time-1);
            mag_name = sprintf('ph_%03d_mag.dat',time-1);
        end

        
        
       %%%Apply rotation
       vx_slice(:,:,time+1) = read_slice(vx_name,slice,rcxres,rcyres);
       vy_slice(:,:,time+1) = read_slice(vy_name,slice,rcxres,rcyres);
       vz_slice(:,:,time+1) = read_slice(vz_name,slice,rcxres,rcyres);
       mag_slice(:,:,time+1) = read_slice(mag_name,slice,rcxres,rcyres);
       cd_slice(:,:,time+1) = read_slice(cd_name,slice,rcxres,rcyres);
end       

fid = fopen(['cd_slice',num2str(slice),'.dat'],'w');
fwrite(fid, cd_slice,'float');
fclose(fid);

fid = fopen(['mag_slice',num2str(slice),'.dat'],'w');
fwrite(fid, mag_slice,'float');
fclose(fid);

fid = fopen(['vx_slice',num2str(slice),'.dat'],'w');
fwrite(fid, vx_slice,'float');
fclose(fid);

fid = fopen(['vy_slice',num2str(slice),'.dat'],'w');
fwrite(fid, vy_slice,'float');
fclose(fid);

fid = fopen(['vz_slice',num2str(slice),'.dat'],'w');
fwrite(fid, vz_slice,'float');
fclose(fid);




function IM = read_slice( name,slice,rcxres, rcyres )

fid = fopen(name);
fseek(fid,rcxres*rcyres*(slice-1)*2,'bof');
IM = reshape( fread(fid,rcxres*rcyres,'short'),[rcxres rcyres]);
fclose(fid);







