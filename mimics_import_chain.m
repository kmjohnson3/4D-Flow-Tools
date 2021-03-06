function varargout = mimics_import_chain(varargin)
% MIMICS_IMPORT_CHAIN MATLAB code for mimics_import_chain.fig
%      MIMICS_IMPORT_CHAIN, by itself, creates a new MIMICS_IMPORT_CHAIN or raises the existing
%      singleton*.
%
%      H = MIMICS_IMPORT_CHAIN returns the handle to a new MIMICS_IMPORT_CHAIN or the handle to
%      the existing singleton*.
%
%      MIMICS_IMPORT_CHAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MIMICS_IMPORT_CHAIN.M with the given input arguments.
%
%      MIMICS_IMPORT_CHAIN('Property','Value',...) creates a new MIMICS_IMPORT_CHAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mimics_import_chain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mimics_import_chain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mimics_import_chain

% Last Modified by GUIDE v2.5 26-Oct-2016 11:12:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @mimics_import_chain_OpeningFcn, ...
    'gui_OutputFcn',  @mimics_import_chain_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before mimics_import_chain is made visible.
function mimics_import_chain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mimics_import_chain (see VARARGIN)

% Choose default command line output for mimics_import_chain
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mimics_import_chain wait for user response (see UIRESUME)
% uiwait(handles.figure1);

set(handles.axes1,'XTickLabel','')
set(handles.axes1,'YTickLabel','')
set(handles.axes1,'Xtick',[]);
set(handles.axes1,'Ytick',[]);
set(handles.axes1,'box','off');

% Setup volume to select
global extra_volumes;
voptions = {'PC-Magnitude','PC-MRA'};
if numel(extra_volumes) > 0 
    for pos = 1:numel(extra_volumes)
        voptions{end+1} = extra_volumes{pos}.name;
    end
end
set(handles.volume_select,'String',voptions);
update_images(handles)

function update_images(handles)

global ANGIO_MIMICS;
update_mimics_angio(handles);

%%% Display
axes(handles.x_mip_fig);
im = squeeze(max(ANGIO_MIMICS,[],1));
im = im * 195 / max(im(:));
blank =im;
map =[ gray(200)];
imagesc(blank,[0,200]);
set(gca,'XTickLabel','','XTick',[])
set(gca,'YTickLabel','','YTick',[])
colormap(map);

axes(handles.y_mip_fig);
im = squeeze(max(ANGIO_MIMICS,[],2));
im = im * 195 / max(im(:));
blank =im;
map =[ gray(200)];
imagesc(blank,[0,200]);
set(gca,'XTickLabel','','XTick',[])
set(gca,'YTickLabel','','YTick',[])
colormap(map);


axes(handles.z_mip_fig);
im = squeeze(max(ANGIO_MIMICS,[],3));
im = im * 195 / max(im(:));
blank =im;
map =[ gray(200)];
imagesc(blank,[0,200]);
set(gca,'XTickLabel','','XTick',[])
set(gca,'YTickLabel','','YTick',[])
colormap(map);


function update_mimics_angio(handles)

global ANGIO;
global MAG;
global ANGIO_MIMICS; 
global extra_volumes;

pos = get(handles.volume_select,'Value')

if pos ==1 
    disp('Using PC-MRA');
    ANGIO_MIMICS = ANGIO;
elseif pos==2
    disp('Using Mag');
    ANGIO_MIMICS = MAG.Data.vals;
else
    ANGIO_MIMICS = extra_volumes{pos-2}.vol.Data.vals;
end


% --- Outputs from this function are returned to the command line.
function varargout = mimics_import_chain_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in mimics_select.
function mimics_select_Callback(hObject, eventdata, handles)
% hObject    handle to mimics_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[name path] = uigetfile( ...
    {'*.txt;*.stl','Text/STL (*.txt/*.stl)'; ...
    '*.*',  'All Files (*.*)'}, ...
    'Select All Mimics Files', ...
    'MultiSelect', 'on');
global mask_names;
global mask_num;

if iscell(name)
    mimics_files = size(name,2)
    for ii = 1:mimics_files
        mimics_names{ii} = [path name{ii}]
    end
    mask_num = mimics_files;
else
    mimics_names{1} = [path name]
    mask_num = 1;
end
set(handles.mimics_list,'String',mimics_names)
update_mimics_angio(handles);

global ANGIO_MIMICS;
global delX;
global delY;
global delZ;

%% Now convert to coord
mimics_names = get(handles.mimics_list,'String');

mask_count = 0;
stl_count = 0;
for num= 1:length(mimics_names)
    if ~isempty( strfind( mimics_names{num},'.stl'))
        stl_count = stl_count +1;
    else
        mask_count = mask_count + 1;
    end
end
mask_num = mask_count;    

%%%Have to convert to scanner coordinates
global MASK;
global STL_MASK;
MASK = single( zeros( size(ANGIO_MIMICS,1),size(ANGIO_MIMICS,2),size(ANGIO_MIMICS,3),mask_num));

mask_count = 1;
stl_count = 1;
for num= 1:length(mimics_names)
    
    if ~isempty( strfind( mimics_names{num},'.stl'))
        % Import an STL mesh, returning a PATCH-compatible face-vertex structure
        fv = stlread(mimics_names{num});
        fv.vertices(:,1) = fv.vertices(:,1)/delX+1;
        fv.vertices(:,2) = fv.vertices(:,2)/delY+1;
        fv.vertices(:,3) = fv.vertices(:,3)/delZ+1;

        disp(['STL X:',num2str(min(fv.vertices(:,1))),' to ',num2str(max(fv.vertices(:,1)))]);
        disp(['STL Y:',num2str(min(fv.vertices(:,2))),' to ',num2str(max(fv.vertices(:,2)))]);
        disp(['STL Z:',num2str(min(fv.vertices(:,3))),' to ',num2str(max(fv.vertices(:,3)))]);
        
        STL_MASK{stl_count} = fv;
        [pathstr,name,ext] = fileparts(mimics_names{num})
        STL_MASK{stl_count}.Name = [name ext];
        stl_count = stl_count +1;
    else
        
        %%%Load up the mimics file
        [xM yM zM intensity] = textread(mimics_names{num},'%f,%f,%f,%f');
        xM = xM/delX+1;
        yM = yM/delX+1;
        zM = zM/delZ+1;
        
        disp(['Mask X:',num2str(min(xM(:))),' to ',num2str(max(xM(:)))]);
        disp(['Mask Y:',num2str(min(yM(:))),' to ',num2str(max(yM(:)))]);
        disp(['Mask Z:',num2str(min(zM(:))),' to ',num2str(max(zM(:)))]);
        
        idx = sub2ind(size(ANGIO_MIMICS),round(xM),round(yM),round(zM)) + (mask_count-1)*size(ANGIO_MIMICS,1)*size(ANGIO_MIMICS,2)*size(ANGIO_MIMICS,3);
        MASK(idx)=1;
        
        
        [pathstr,name,ext] = fileparts(mimics_names{num})
        mask_names{mask_count} = [name ext];
        
        mask_count = mask_count +1;
    end 
end

%%% Display
axes(handles.x_mip_fig);
im = squeeze(max(ANGIO_MIMICS,[],1));
im = im * 195 / max(im(:));
for pos = 1:mask_num
    mask_mip = squeeze( max(MASK(:,:,:,pos),[],1));
    idx = find( (mask_mip==1) & ( im < 201) );
    im(idx) = 200+10*pos;
end
blank =im;
map =[ gray(200); jet(10*mask_num)];
imagesc(blank,[0,200+10*mask_num]);
set(gca,'XTickLabel','','XTick',[])
set(gca,'YTickLabel','','YTick',[])
colormap(map);

axes(handles.y_mip_fig);
im = squeeze(max(ANGIO_MIMICS,[],2));
im = im * 195 / max(im(:));
for pos = 1:mask_num
    mask_mip = squeeze( max(MASK(:,:,:,pos),[],2));
    idx = find( (mask_mip==1) & ( im < 201) );
    im(idx) = 200+10*pos;
end
blank =im;
map =[ gray(200); jet(10*mask_num)];
imagesc(blank,[0,200+10*mask_num]);
set(gca,'XTickLabel','','XTick',[])
set(gca,'YTickLabel','','YTick',[])
colormap(map);


axes(handles.z_mip_fig);
im = squeeze(max(ANGIO_MIMICS,[],3));
im = im * 195 / max(im(:));
for pos = 1:mask_num
    mask_mip = squeeze( max(MASK(:,:,:,pos),[],3));
    idx = find( (mask_mip==1) & ( im < 201) );
    im(idx) = 200+10*pos;
end
blank =im;
map =[ gray(200); jet(10*mask_num)];
imagesc(blank,[0,200+10*mask_num]);
set(gca,'XTickLabel','','XTick',[])
set(gca,'YTickLabel','','YTick',[])
colormap(map);

% --- Executes on selection change in mimics_list.
function mimics_list_Callback(hObject, eventdata, handles)
% hObject    handle to mimics_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mimics_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mimics_list


% --- Executes during object creation, after setting all properties.
function mimics_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mimics_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mimics_start_button.
function mimics_start_button_Callback(hObject, eventdata, handles)
% hObject    handle to mimics_start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eval('!C:\Program Files\Materialise\Mimics Research 17.0\Mimics.exe &')


% --- Executes on button press in export_dicom_button.
function export_dicom_button_Callback(hObject, eventdata, handles)
% hObject    handle to export_dicom_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global ANGIO_MIMICS;
global base_dir;
global delX;
global delY;
global delZ;

delX
delY
delZ

update_mimics_angio(handles);
info = dicominfo('dummy_pcvipr_anon.dcm');
CD2 = int16(65000*ANGIO_MIMICS/max(ANGIO_MIMICS(:)));

info.SliceThickness = delZ

% Set size
info.ImagePositionPatient(1) = 0;
info.ImagePositionPatient(2) = 0;
info.ImagePositionPatient(3) = 0;

% Set
info.ImageOrientationPatient(1) = 0;
info.ImageOrientationPatient(2) = 1;
info.ImageOrientationPatient(3) = 0;
info.ImageOrientationPatient(4) = 1;
info.ImageOrientationPatient(5) = 0;
info.ImageOrientationPatient(6) = 0;

info.AcquisitionMatrix = [size(ANGIO_MIMICS,1) 0 0 size(ANGIO_MIMICS,2)];
info.Rows = size(ANGIO_MIMICS,1);
info.Columns = size(ANGIO_MIMICS,2);

info.PixelSpacing = [delX delX];  %% Mimics only supports square pixels....
info.SliceLocation = 0;

folder = fullfile(base_dir,'mimics_dcm');
mkdir(folder)

I = zeros(2,size(ANGIO_MIMICS,3));

axes(handles.axes1)

for slice = 1:size(ANGIO_MIMICS,3)
    
    % Set size
    info.ImagePositionPatient(1) = 0;
    info.ImagePositionPatient(2) = 0;
    info.ImagePositionPatient(3) = delZ*(slice-1);
    
    name = fullfile( folder, sprintf('I%03d.dcm',slice-1));
    
    dicomwrite(CD2(:,:,slice), name, info,'CreateMode','Copy');
    I(:,slice)=1;
    imshow(I,[0 1]);
    daspect([13 1 1])
    colormap('gray');
    set(gca,'XTickLabel','')
    set(gca,'YTickLabel','')
    h = text(0,0,['Exporting Slice ',num2str(slice),' of ',num2str(size(ANGIO_MIMICS,3))]);
    
    drawnow;
end
delete(h)
text(0,0,'Done');

set(handles.mimics_help,'String',['1) Please start Mimics   2) File->New Project and import data in ',folder,'  3)Segment and export masks as grayscale']);

% --- Executes during object creation, after setting all properties.
function mimics_help_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mimics_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in done_button.
function done_button_Callback(hObject, eventdata, handles)
% hObject    handle to done_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1)


% --- Executes on selection change in volume_select.
function volume_select_Callback(hObject, eventdata, handles)
% hObject    handle to volume_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns volume_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from volume_select
update_images(handles);

% --- Executes during object creation, after setting all properties.
function volume_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volume_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
