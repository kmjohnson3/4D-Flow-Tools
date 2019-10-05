function data = readPCVIPR(varargin)
%  readPCVIPR() function reads in 4D flow data generated from PC VIPR
%  acquisition.
%   
%   Written by Phil Corrado 2017
%   
%   Inputs:
%       dir (optional): Directory where pcvipr data files are located. If
%       omitted, dialog box will pop up to select directory
%
%   Outputs: 
%       data: struct containing some non-PHI header information as well as the 4D flow data
%           all data is in int16 format
%           data.mag contains time-resolved magnitude image data
%           data.cd contains time-resolved angiogram image data
%           data.velX, data.velY, and data.velZ contain time-resolved
%           velocity data in mm/s
%
    if nargin>0 && ischar(varargin{1}) && size(varargin{1},1)==1 && exist(varargin{1},'dir')==7
        dir = varargin{1};
    else
        dir = uigetdir();
    end
    pcVIPRHeaderFilePath = fullfile(dir,'pcvipr_header.txt');
    if exist(pcVIPRHeaderFilePath, 'file')==2
        fid = fopen(pcVIPRHeaderFilePath);
        if fid<0
            error('Could not open pcvipr_header.txt file.');
        else
            C = textscan(fid,'%s %s');
            field = C{1};
            value = C{2};
            fclose(fid);

            fov = lookup(field,value,'fovx',3);

            data.xSize = lookup(field,value,'matrixx',1);
            data.ySize = lookup(field,value,'matrixy',1);
            data.zSize = lookup(field,value,'matrixz',1);
            data.nT = lookup(field,value,'frames',1);
            data.dT = lookup(field,value,'timeres',1);
            data.VENC = lookup(field,value,'VENC',1);

            data.spacing = fov./[data.xSize;data.ySize;data.zSize];
            data.headerPos = lookup(field,value,'sx',3);
            data.orientation = lookup(field,value,'ix',9)./repmat(data.spacing,3,1);
               
            if nargin<2 || ~ischar(varargin{2}) || size(varargin{2},1)~=1 || ~strcmp(varargin{2},'headerOnly')

                data.cd = zeros(data.xSize,data.ySize,data.zSize,data.nT, 'int16');
                data.mag = zeros(data.xSize,data.ySize,data.zSize,data.nT, 'int16');
                data.velX = zeros(data.xSize,data.ySize,data.zSize,data.nT, 'int16');
                data.velY = zeros(data.xSize,data.ySize,data.zSize,data.nT, 'int16');
                data.velZ = zeros(data.xSize,data.ySize,data.zSize,data.nT, 'int16');

                for ii=1:data.nT
                    name = fullfile(dir,sprintf('ph_%03d_cd.dat',ii-1));
                    if ~exist(name, 'file')
                        error('Could not find CD.dat file.');
                    end
                    m = memmapfile(name,'Format','int16');
                    data.cd(:,:,:,ii) = reshape(m.Data,[data.xSize,data.ySize,data.zSize]);

                    name = fullfile(dir,sprintf('ph_%03d_mag.dat',ii-1));
                    if ~exist(name, 'file')
                        error('Could not find MAG.dat file.');
                    end
                    m = memmapfile(name,'Format','int16');
                    data.mag(:,:,:,ii) = reshape(m.Data,[data.xSize,data.ySize,data.zSize]);

                    name = fullfile(dir,sprintf('ph_%03d_vd_1.dat',ii-1));
                    if ~exist(name, 'file')
                        error('Could not find file "ph_%03d_vd_1.dat".',ii-1);
                    end
                    m = memmapfile(name,'Format','int16');
                    data.velX(:,:,:,ii) = reshape(m.Data,[data.xSize,data.ySize,data.zSize]);

                    name = fullfile(dir,sprintf('ph_%03d_vd_2.dat',ii-1));

                    if ~exist(name, 'file')
                        error('Could not find file "ph_%03d_vd_2.dat".',ii-1);
                    end
                    m = memmapfile(name,'Format','int16');
                    data.velY(:,:,:,ii) = reshape(m.data,[data.xSize,data.ySize,data.zSize]);

                    name = fullfile(dir,sprintf('ph_%03d_vd_3.dat',ii-1));
                    if ~exist(name, 'file')
                        error('Could not find file "ph_%03d_vd_3.dat".',ii-1);
                    end
                    m = memmapfile(name,'Format','int16');
                    data.velZ(:,:,:,ii) = reshape(m.Data,[data.xSize,data.ySize,data.zSize]);
                end
            end
        end
    else
        error('Could not find pcvipr_header.txt file.');
    end
end

function value = lookup(fields,values,field, length)
    index = find(cellfun(@(s) strcmp(field, s), fields));
    value = cellfun(@str2num,values(index:(index+length-1)));
end