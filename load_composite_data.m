function status = load_composite_data( header)

global CD;
global MAG;
global VELX;
global VELY;
global VELZ;

%%Matlab won't take runtime string or number of bits
cd_type = header.cd_data_type;
if cd_type == 1 %short16 little endian
    CD =single( reshape(fread(fopen(header.cdname,'r'),header.rcxres*header.rcyres*header.rczres,'short'),[header.rcxres header.rcyres header.rczres]) );
elseif cd_type == 2 %float32 little endian
    CD =single( reshape(fread(fopen(header.cdname,'r'),header.rcxres*header.rcyres*header.rczres,'float'),[header.rcxres header.rcyres header.rczres]) );
elseif cd_type == 3 %short little endian
    CD =single( reshape(fread(fopen(header.cdname,'rb'),header.rcxres*header.rcyres*header.rczres,'short','b'),[header.rcxres header.rcyres header.rczres]) );
elseif cd_type == 4 %short little endian
    CD =single( reshape(fread(fopen(header.cdname,'rb'),header.rcxres*header.rcyres*header.rczres,'short','b'),[header.rcxres header.rcyres header.rczres]) );
end
CD = CD / max(CD(:));

%% Magnitude Data
mag_type = header.mag_data_type;
if mag_type == 1 %short16 little endian
    MAG =single( reshape(fread(fopen(header.magname,'r'),header.rcxres*header.rcyres*header.rczres,'short'),[header.rcxres header.rcyres header.rczres]) );
elseif mag_type == 2 %float32 little endian
    MAG =single( reshape(fread(fopen(header.magname,'r'),header.rcxres*header.rcyres*header.rczres,'float'),[header.rcxres header.rcyres header.rczres]) );
elseif mag_type == 3 %short little endian
    MAG =single( reshape(fread(fopen(header.magname,'rb'),header.rcxres*header.rcyres*header.rczres,'short','b'),[header.rcxres header.rcyres header.rczres]) );
elseif mag_type == 4 %short little endian
    MAG =single( reshape(fread(fopen(header.magname,'rb'),header.rcxres*header.rcyres*header.rczres,'short','b'),[header.rcxres header.rcyres header.rczres]) );
end
MAG= MAG/ max(MAG(:));

%%%Flow Data Names are Fixed
VELX =single( reshape(fread(fopen(header.velxname,'r'),header.rcxres*header.rcyres*header.rczres,'short'),[header.rcxres header.rcyres header.rczres]) );
VELY =single( reshape(fread(fopen(header.velyname,'r'),header.rcxres*header.rcyres*header.rczres,'short'),[header.rcxres header.rcyres header.rczres]) );
VELZ =single( reshape(fread(fopen(header.velzname,'r'),header.rcxres*header.rcyres*header.rczres,'short'),[header.rcxres header.rcyres header.rczres]) );

status =1;