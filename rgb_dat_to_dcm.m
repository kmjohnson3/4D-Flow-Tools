function varargout = rgb_dat_to_dcm(varargin)



% JPG_TO_DCM MATLAB code for jpg_to_dcm.fig
%      JPG_TO_DCM, by itself, creates a new JPG_TO_DCM or raises the existing
%      singleton*.
%
%      H = JPG_TO_DCM returns the handle to a new JPG_TO_DCM or the handle to
%      the existing singleton*.
%
%      JPG_TO_DCM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JPG_TO_DCM.M with the given input arguments.
%
%      JPG_TO_DCM('Property','Value',...) creates a new JPG_TO_DCM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before jpg_to_dcm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to jpg_to_dcm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help jpg_to_dcm

% Last Modified by GUIDE v2.5 18-Dec-2013 13:43:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @jpg_to_dcm_OpeningFcn, ...
                   'gui_OutputFcn',  @jpg_to_dcm_OutputFcn, ...
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


% --- Executes just before jpg_to_dcm is made visible.
function jpg_to_dcm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to jpg_to_dcm (see VARARGIN)

% Choose default command line output for jpg_to_dcm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes jpg_to_dcm wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = jpg_to_dcm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in DicomButton.
function DicomButton_Callback(hObject, eventdata, handles)
% hObject    handle to DicomButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dicompath
[name dicompath] = uigetfile( ...
    {  '*.sdcopen;*.dcm','Dicom (*.dcm,*.sdcopen)'; ...
    '*.*',  'All Files (*.*)'}, ...
    'Select a Dicom', ...
    'MultiSelect', 'off');
set( handles.dicomName,'String',fullfile(dicompath,name));

global dcm_header
dicom_filename = get(handles.dicomName,'String');
dcm_header =  dicominfo(dicom_filename);
set(handles.seriesNumber,'String',num2str(dcm_header.SeriesNumber+5));

% --- Executes on button press in jpgButton.
function jpgButton_Callback(hObject, eventdata, handles)
% hObject    handle to jpgButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dicompath
% [ folder_name ] = uigetdir(dicompath,'Select Location of JPG');
[file_name,folder_name] = uigetfile( ...
    {  '*.dat;*.JPG;*.jpeg','RGB Dat (*.dat)'; ...
    '*.*',  'All Files (*.*)'}, ...
    'Select a RGB dat file', ...
    'MultiSelect', 'off',...
    dicompath);

set( handles.jpgFolder,'String',fullfile(dicompath,file_name));

function jpgFolder_Callback(hObject, eventdata, handles)
% hObject    handle to jpgFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of jpgFolder as text
%        str2double(get(hObject,'String')) returns contents of jpgFolder as a double


% --- Executes during object creation, after setting all properties.
function jpgFolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to jpgFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dicomName_Callback(hObject, eventdata, handles)
% hObject    handle to dicomName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dicomName as text
%        str2double(get(hObject,'String')) returns contents of dicomName as a double


% --- Executes during object creation, after setting all properties.
function dicomName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dicomName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function seriesNumber_Callback(hObject, eventdata, handles)
% hObject    handle to seriesNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of seriesNumber as text
%        str2double(get(hObject,'String')) returns contents of seriesNumber as a double


% --- Executes during object creation, after setting all properties.
function seriesNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seriesNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in convertButton.
function convertButton_Callback(hObject, eventdata, handles)
% hObject    handle to convertButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dicom_filename = get(handles.dicomName,'String');
dcm_header =  dicominfo(dicom_filename);

rgb_file = get(handles.jpgFolder,'String')

fid = fopen(rgb_file);
RGB = fread(fid,'uint8');
xres = round( ( numel(RGB)/3 )^(1/3))
RGB =  reshape(RGB,[3 xres xres xres]);

sname = get(handles.seriesName,'String');
new_series = str2num( get(handles.seriesNumber,'String'));

%New Series
dcm_header.SeriesInstanceUID = dicomuid;

h = figure('Name','Preview');
him = [];
for ii=1:size(RGB,4)
    
    D = RGB(:,:,:,ii);
    D = permute(D,[2 3 1]); 
    if ii == 1
        him = imshow(D);
    else
         him = imshow(D);
        %set(him,'CData',D); % just update the data, not the whole figure
    end
    drawnow
    
    dcm_new = dcm_header;
    dcm_new.SeriesNumber = new_series;
    dcm_new.SeriesDescription = sname;
    dcm_new.InstanceNumber = ii -1;
    name = sprintf('I%03d.dcm.sdcopen',ii-1);
    dicomwrite(D,name,dcm_new);
end
close(h)



function seriesName_Callback(hObject, eventdata, handles)
% hObject    handle to seriesName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of seriesName as text
%        str2double(get(hObject,'String')) returns contents of seriesName as a double


% --- Executes during object creation, after setting all properties.
function seriesName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seriesName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
