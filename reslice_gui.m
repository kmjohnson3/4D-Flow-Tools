function varargout = reslice_gui(varargin)
% RESLICE_GUI M-file for reslice_gui.fig
%      RESLICE_GUI, by itself, creates a new RESLICE_GUI or raises the existing
%      singleton*.
%
%      H = RESLICE_GUI returns the handle to a new RESLICE_GUI or the handle to
%      the existing singleton*.
%
%      RESLICE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESLICE_GUI.M with the given input arguments.
%
%      RESLICE_GUI('Property','Value',...) creates a new RESLICE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before reslice_gui_OpeningFunction gets called.
%      An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to reslice_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help reslice_gui

% Last Modified by GUIDE v2.5 12-Mar-2009 12:42:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @reslice_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @reslice_gui_OutputFcn, ...
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


% --- Executes just before reslice_gui is made visible.
function reslice_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to reslice_gui (see VARARGIN)

% Choose default command line output for reslice_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes reslice_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = reslice_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function cdname_Callback(hObject, eventdata, handles)
% hObject    handle to cdname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cdname as text
%        str2double(get(hObject,'String')) returns contents of cdname as a double


% --- Executes during object creation, after setting all properties.
function cdname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cdname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function magname_Callback(hObject, eventdata, handles)
% hObject    handle to magname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of magname as text
%        str2double(get(hObject,'String')) returns contents of magname as a double


% --- Executes during object creation, after setting all properties.
function magname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to magname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function load_menu_Callback(hObject, eventdata, handles)
% hObject    handle to load_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function load_mag_Callback(hObject, eventdata, handles)
% hObject    handle to load_mag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





function magnam_Callback(hObject, eventdata, handles)
% hObject    handle to magname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of magname as text
%        str2double(get(hObject,'String')) returns contents of magname as a double


% --- Executes during object creation, after setting all properties.
function magnam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to magname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rcxres_Callback(hObject, eventdata, handles)
% hObject    handle to rcxres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rcxres as text
%        str2double(get(hObject,'String')) returns contents of rcxres as a double


% --- Executes during object creation, after setting all properties.
function rcxres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rcxres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rcyres_Callback(hObject, eventdata, handles)
% hObject    handle to rcyres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rcyres as text
%        str2double(get(hObject,'String')) returns contents of rcyres as a double


% --- Executes during object creation, after setting all properties.
function rcyres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rcyres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rczres_Callback(hObject, eventdata, handles)
% hObject    handle to rczres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rczres as text
%        str2double(get(hObject,'String')) returns contents of rczres as a double


% --- Executes during object creation, after setting all properties.
function rczres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rczres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xfov_Callback(hObject, eventdata, handles)
% hObject    handle to xfov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xfov as text
%        str2double(get(hObject,'String')) returns contents of xfov as a double


% --- Executes during object creation, after setting all properties.
function xfov_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xfov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yfov_Callback(hObject, eventdata, handles)
% hObject    handle to yfov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yfov as text
%        str2double(get(hObject,'String')) returns contents of yfov as a double


% --- Executes during object creation, after setting all properties.
function yfov_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yfov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zfov_Callback(hObject, eventdata, handles)
% hObject    handle to zfov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zfov as text
%        str2double(get(hObject,'String')) returns contents of zfov as a double


% --- Executes during object creation, after setting all properties.
function zfov_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zfov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tframes_Callback(hObject, eventdata, handles)
% hObject    handle to tframes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tframes as text
%        str2double(get(hObject,'String')) returns contents of tframes as a double


% --- Executes during object creation, after setting all properties.
function tframes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tframes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tres_Callback(hObject, eventdata, handles)
% hObject    handle to tres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tres as text
%        str2double(get(hObject,'String')) returns contents of tres as a double


% --- Executes during object creation, after setting all properties.
function tres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function mask_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to mask_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mask_alpha as text
%        str2double(get(hObject,'String')) returns contents of mask_alpha as a double


% --- Executes during object creation, after setting all properties.
function mask_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mask_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mask_beta_Callback(hObject, eventdata, handles)
% hObject    handle to mask_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mask_beta as text
%        str2double(get(hObject,'String')) returns contents of mask_beta as a double


% --- Executes during object creation, after setting all properties.
function mask_beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mask_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mask_method.
function mask_method_Callback(hObject, eventdata, handles)
% hObject    handle to mask_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns mask_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mask_method


% --- Executes during object creation, after setting all properties.
function mask_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mask_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mask_iterations_Callback(hObject, eventdata, handles)
% hObject    handle to mask_iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mask_iterations as text
%        str2double(get(hObject,'String')) returns contents of mask_iterations as a double


% --- Executes during object creation, after setting all properties.
function mask_iterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mask_iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reslice_button.
function reslice_button_Callback(hObject, eventdata, handles)
% hObject    handle to reslice_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global xfov;
global yfov;
global zfov;
global rcxres;
global rcyres;
global rczres;
global U_pcvipr;
global O_pcvipr;

%Image Size
rcxres = str2double(get(handles.rcxres,'String'));
rcyres = str2double(get(handles.rcyres,'String'));
rczres = str2double(get(handles.rczres,'String'));

%%Get Image and Extract Orientation
fname = get(handles.dicom_file_name,'String');
image = dicomread(fname);
header= dicominfo(fname);

%%Show 2D Image
axes(handles.twod);
imagesc(double(image));
colormap('gray');
set(gca,'XTick',[],'YTick',[]);

%Read in Mag for Test
mag_type = get(handles.mag_data_type,'Value');
if mag_type == 1 %short16 little endian
    MAG =single( reshape(fread(fopen(get(handles.magname,'String'),'r'),rcxres*rcyres*rczres,'short'),[rcxres rcyres rczres]) );
elseif mag_type == 2 %float32 little endian
    MAG =single( reshape(fread(fopen(get(handles.magname,'String'),'r'),rcxres*rcyres*rczres,'float'),[rcxres rcyres rczres]) );
elseif mag_type == 3 %short little endian 
    MAG =single( reshape(fread(fopen(get(handles.magname,'String'),'rb'),rcxres*rcyres*rczres,'short','b'),[rcxres rcyres rczres]) );
elseif mag_type == 4 %short little endian 
    MAG =single( reshape(fread(fopen(get(handles.magname,'String'),'rb'),rcxres*rcyres*rczres,'float','b'),[rcxres rcyres rczres]) );
end


%Check
U_pcvipr
O_pcvipr

%%%Unit Vector Inverse
UI_pcvipr = inv( U_pcvipr);

%%What Size will ne image be
res2d = 512;
fov =320;
[xt yt] = meshgrid(0:res2d-1,0:res2d-1);

OV_2d = header.ImagePositionPatient;
XV_2d = header.ImageOrientationPatient(1:3)*header.ReconstructionDiameter/res2d;
YV_2d = header.ImageOrientationPatient(4:6)*header.ReconstructionDiameter/res2d;

%Raw Scanner Coordinates
XX_2d_raw = OV_2d(1) + xt*XV_2d(1) + yt*YV_2d(1); % + (slice-1)*ZV_pcvipr(1);
YY_2d_raw = OV_2d(2) + xt*XV_2d(2) + yt*YV_2d(2); % + (slice-1)*ZV_pcvipr(2);
ZZ_2d_raw = OV_2d(3) + xt*XV_2d(3) + yt*YV_2d(3); % + (slice-1)*ZV_pcvipr(3);

%%%Convert to PC VIPR coordinates 
%%% A* x-pcvipr + b = x-scanner
%%% A^-1*( x-scanner - b) = x-pcvipr
XX_2d_raw = XX_2d_raw - O_pcvipr(1);
YY_2d_raw = YY_2d_raw - O_pcvipr(2);
ZZ_2d_raw = ZZ_2d_raw - O_pcvipr(3);
XX_2d_r = UI_pcvipr(1,1)*XX_2d_raw + UI_pcvipr(1,2)*YY_2d_raw + UI_pcvipr(1,3)*ZZ_2d_raw;
YY_2d_r = UI_pcvipr(2,1)*XX_2d_raw + UI_pcvipr(2,2)*YY_2d_raw + UI_pcvipr(2,3)*ZZ_2d_raw;
ZZ_2d_r = UI_pcvipr(3,1)*XX_2d_raw + UI_pcvipr(3,2)*YY_2d_raw + UI_pcvipr(3,3)*ZZ_2d_raw;

%%Get a starting point
mag_slice = volume_interp( MAG,XX_2d_r,YY_2d_r,ZZ_2d_r,[res2d res2d]);
clear MAG;

%%Show 3D Image
axes(handles.threed);
imagesc(mag_slice);
colormap('gray');
set(gca,'XTick',[],'YTick',[]);


% --- Executes on selection change in visual_method.
function visual_method_Callback(hObject, eventdata, handles)
% hObject    handle to visual_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns visual_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from visual_method

update_images(handles)

% --- Executes during object creation, after setting all properties.
function visual_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to visual_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function mipz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mipz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate mipz
imagesc(zeros(10,10),[0 1]);
set(gca,'XTickLabel','')
set(gca,'YTickLabel','')
colormap('gray');

% --- Executes during object creation, after setting all properties.
function mipx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mipx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate mipx
imagesc(zeros(10,10),[0 1]);
set(gca,'XTickLabel','')
set(gca,'YTickLabel','')
colormap('gray');




% --- Executes during object creation, after setting all properties.
function mipy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mipy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate mipy

imagesc(zeros(10,10),[0 1]);
set(gca,'XTickLabel','')
set(gca,'YTickLabel','')
colormap('gray');

function startX_Callback(hObject, eventdata, handles)
% hObject    handle to startX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startX as text
%        str2double(get(hObject,'String')) returns contents of startX as a double
update_images(handles);

% --- Executes during object creation, after setting all properties.
function startX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stopX_Callback(hObject, eventdata, handles)
% hObject    handle to stopX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stopX as text
%        str2double(get(hObject,'String')) returns contents of stopX as a double
update_images(handles);

% --- Executes during object creation, after setting all properties.
function stopX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stopX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function startY_Callback(hObject, eventdata, handles)
% hObject    handle to startY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startY as text
%        str2double(get(hObject,'String')) returns contents of startY as a double
update_images(handles);

% --- Executes during object creation, after setting all properties.
function startY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stopY_Callback(hObject, eventdata, handles)
% hObject    handle to stopY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stopY as text
%        str2double(get(hObject,'String')) returns contents of stopY as a double

update_images(handles);

% --- Executes during object creation, after setting all properties.
function stopY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stopY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stopZ_Callback(hObject, eventdata, handles)
% hObject    handle to stopZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stopZ as text
%        str2double(get(hObject,'String')) returns contents of stopZ as a double
update_images(handles);


% --- Executes during object creation, after setting all properties.
function stopZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stopZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function startZ_Callback(hObject, eventdata, handles)
% hObject    handle to startZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startZ as text
%        str2double(get(hObject,'String')) returns contents of startZ as a double
update_images(handles);

% --- Executes during object creation, after setting all properties.
function startZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gridlines.
function gridlines_Callback(hObject, eventdata, handles)
% hObject    handle to gridlines (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gridlines
update_images(handles)



% --- Executes on slider movement.
function gamma_slider_Callback(hObject, eventdata, handles)
% hObject    handle to gamma_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

update_images(handles)


% --- Executes during object creation, after setting all properties.
function gamma_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on selection change in cd_data_type.
function cd_data_type_Callback(hObject, eventdata, handles)
% hObject    handle to cd_data_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns cd_data_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cd_data_type


% --- Executes during object creation, after setting all properties.
function cd_data_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cd_data_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mag_data_type.
function mag_data_type_Callback(hObject, eventdata, handles)
% hObject    handle to mag_data_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns mag_data_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mag_data_type


% --- Executes during object creation, after setting all properties.
function mag_data_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mag_data_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in parameter_read.
function parameter_read_Callback(hObject, eventdata, handles)
% hObject    handle to parameter_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global U_pcvipr;
global O_pcvipr;

%%%Reads external files for parameters
[parameter value]=textread('pcvipr_header.txt', '%s %s');  

%%%Matrix
idx = find(strcmp('matrixx',parameter));
rcxres = str2num( value{idx} );
set(handles.rcxres,'string',num2str(rcxres));

idx = find(strcmp('matrixy',parameter));
rcyres = str2num( value{idx} );
set(handles.rcyres,'string',num2str(rcyres));

idx = find(strcmp('matrixz',parameter));
rczres = str2num( value{idx} );
set(handles.rczres,'string',num2str(rczres));

%%%Time Stuff
idx = find(strcmp('frames',parameter));
frames = str2num( value{idx} );
if(frames==-1)
    frames = 3;
end
set(handles.tframes,'string',num2str(frames));

idx = find(strcmp('timeres',parameter));
tres = str2num( value{idx} )/1000;
set(handles.tres,'string',num2str(tres));

idx = find(strcmp('version',parameter));
version = str2num( value{idx} );

if version > 1
    idx = find(strcmp('ix',parameter));
    ix = str2num( value{idx} );
    idx = find(strcmp('iy',parameter));
    iy = str2num( value{idx} );
    idx = find(strcmp('iz',parameter));
    iz = str2num( value{idx} );

    idx = find(strcmp('jx',parameter));
    jx = str2num( value{idx} );
    idx = find(strcmp('jy',parameter));
    jy = str2num( value{idx} );
    idx = find(strcmp('jz',parameter));
    jz = str2num( value{idx} );

    idx = find(strcmp('kx',parameter));
    kx = str2num( value{idx} );
    idx = find(strcmp('ky',parameter));
    ky = str2num( value{idx} );
    idx = find(strcmp('kz',parameter));
    kz = str2num( value{idx} );
    
    idx = find(strcmp('sx',parameter));
    sx = str2num( value{idx} );
    idx = find(strcmp('sy',parameter));
    sy = str2num( value{idx} );
    idx = find(strcmp('sz',parameter));
    sz = str2num( value{idx} );

    %%PC VIPR Orientation
    U_pcvipr = zeros(3,3);
    U_pcvipr(1,:) = [ ix  jx kx];
    U_pcvipr(2,:) = [ iy  jy ky];
    U_pcvipr(3,:) = [ iz  jz kz];
    O_pcvipr      = [ sx; sy; sz];
else
   disp('ERROR:Please Recon with Latest Recon to Get header!!');
end


% --- Executes on button press in ensight_box.
function ensight_box_Callback(hObject, eventdata, handles)
% hObject    handle to ensight_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ensight_box
global ensight_flag;
ensight_flag = get(hObject,'Value');


% --- Executes on button press in cine_anatomy_checkbox.
function cine_anatomy_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to cine_anatomy_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cine_anatomy_checkbox
global cine_anatomy_flag;
cine_anatomy_flag = get(hObject,'Value');





% --- Executes on button press in frame_by_frame_box.
function frame_by_frame_box_Callback(hObject, eventdata, handles)
% hObject    handle to frame_by_frame_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frame_by_frame_box
global frame_by_frame;
frame_by_frame = get(hObject,'Value');






function dicom_file_name_Callback(hObject, eventdata, handles)
% hObject    handle to dicom_file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dicom_file_name as text
%        str2double(get(hObject,'String')) returns contents of dicom_file_name as a double


% --- Executes during object creation, after setting all properties.
function dicom_file_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dicom_file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in get_file.
function get_file_Callback(hObject, eventdata, handles)
% hObject    handle to get_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[ name path ] = uigetfile('*.dcm');
set(handles.dicom_file_name,'String',[path name]);

% --- Executes on button press in flow_pushbutton.
function flow_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to flow_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global xfov;
global yfov;
global zfov;
global rcxres;
global rcyres;
global rczres;
global U_pcvipr;
global O_pcvipr;

%Image Size
rcxres = str2double(get(handles.rcxres,'String'));
rcyres = str2double(get(handles.rcyres,'String'));
rczres = str2double(get(handles.rczres,'String'));

%%Get Image and Extract Orientation
fname = get(handles.dicom_file_name,'String');
image = dicomread(fname);
header= dicominfo(fname);

%%Show 2D Image
axes(handles.twod);
imagesc(double(image));
colormap('gray');
set(gca,'XTick',[],'YTick',[]);

%%%Unit Vector Inverse
UI_pcvipr = inv( U_pcvipr);

%%What Size will ne image be
res2d = 512;
fov =320;
[xt yt] = meshgrid(0:res2d-1,0:res2d-1);

OV_2d = header.ImagePositionPatient;
XV_2d = header.ImageOrientationPatient(1:3)*header.ReconstructionDiameter/res2d;
YV_2d = header.ImageOrientationPatient(4:6)*header.ReconstructionDiameter/res2d;
ZV_2d = cross(XV_2d,YV_2d);

%Raw Scanner Coordinates
XX_2d_raw = OV_2d(1) + xt*XV_2d(1) + yt*YV_2d(1); % + (slice-1)*ZV_pcvipr(1);
YY_2d_raw = OV_2d(2) + xt*XV_2d(2) + yt*YV_2d(2); % + (slice-1)*ZV_pcvipr(2);
ZZ_2d_raw = OV_2d(3) + xt*XV_2d(3) + yt*YV_2d(3); % + (slice-1)*ZV_pcvipr(3);

%%%Convert to PC VIPR coordinates 
%%% A* x-pcvipr + b = x-scanner
%%% A^-1*( x-scanner - b) = x-pcvipr
XX_2d_raw = XX_2d_raw - O_pcvipr(1);
YY_2d_raw = YY_2d_raw - O_pcvipr(2);
ZZ_2d_raw = ZZ_2d_raw - O_pcvipr(3);
XX_2d_r = UI_pcvipr(1,1)*XX_2d_raw + UI_pcvipr(1,2)*YY_2d_raw + UI_pcvipr(1,3)*ZZ_2d_raw;
YY_2d_r = UI_pcvipr(2,1)*XX_2d_raw + UI_pcvipr(2,2)*YY_2d_raw + UI_pcvipr(2,3)*ZZ_2d_raw;
ZZ_2d_r = UI_pcvipr(3,1)*XX_2d_raw + UI_pcvipr(3,2)*YY_2d_raw + UI_pcvipr(3,3)*ZZ_2d_raw;

%---------------------------------------------------------------
% Rotation for Flow
%---------------------------------------------------------------
%normalize unit vectors
V_2d = zeros(3,3);
V_2d(:,1) = XV_2d / sqrt( sum(XV_2d.^2));
V_2d(:,2) = YV_2d / sqrt( sum(YV_2d.^2));
V_2d(:,3) = ZV_2d / sqrt( sum(ZV_2d.^2));
U_pcvipr(1,:) = U_pcvipr(1,:) / sqrt( sum(U_pcvipr(1,:).^2));
U_pcvipr(2,:) = U_pcvipr(2,:) / sqrt( sum(U_pcvipr(2,:).^2));
U_pcvipr(3,:) = U_pcvipr(3,:) / sqrt( sum(U_pcvipr(3,:).^2));

%%Rotating PC VIPR Coord to 2D is opposite of interpolations
Flow_Rot = inv(V_2d)*U_pcvipr

%---------------------------------------------------------------
% Magnitude Interpolation
%---------------------------------------------------------------
tres    = str2double(get(handles.tres,'String'));
tframes = str2double(get(handles.tframes,'String'));

TEMP = single(zeros(rcxres,rcyres,rczres));

for time=0:tframes
    disp(['Read Frame ',int2str(time),' of ',int2str(tframes)]);
    if time==0
        mag_name = get(handles.magname,'String');
    else
        mag_name = sprintf('ph_%03d_mag.dat',time-1);
    end

    %Read in Mag for Test
    mag_type = get(handles.mag_data_type,'Value');
    if mag_type == 1 %short16 little endian
        TEMP =single( reshape(fread(fopen(mag_name,'r'),rcxres*rcyres*rczres,'short'),[rcxres rcyres rczres]) );
    elseif mag_type == 2 %float32 little endian
        TEMP =single( reshape(fread(fopen(mag_name,'r'),rcxres*rcyres*rczres,'float'),[rcxres rcyres rczres]) );
    elseif mag_type == 3 %short little endian
        TEMP =single( reshape(fread(fopen(mag_name,'rb'),rcxres*rcyres*rczres,'short','b'),[rcxres rcyres rczres]) );
    elseif mag_type == 4 %short little endian
        TEMP =single( reshape(fread(fopen(mag_name,'rb'),rcxres*rcyres*rczres,'float','b'),[rcxres rcyres rczres]) );
    end
    mag_slice(:,:,time+1) = volume_interp( TEMP,XX_2d_r,YY_2d_r,ZZ_2d_r,[res2d res2d]);

    %%Show 3D Image
    axes(handles.threed);
    imagesc(mag_slice(:,:,time+1));
    colormap('gray');
    set(gca,'XTick',[],'YTick',[]);
    drawnow;
end

%---------------------------------------------------------------
% Complex Difference Interpolation
%---------------------------------------------------------------
for time=0:tframes
    disp(['Read Frame ',int2str(time),' of ',int2str(tframes)]);
    if time==0
        cd_name = get(handles.cdname,'String');
    else
        cd_name = sprintf('ph_%03d_cd.dat',time-1);
    end

    %Read in Mag for Test
    cd_type = get(handles.cd_data_type,'Value');
    if mag_type == 1 %short16 little endian
        TEMP =single( reshape(fread(fopen(cd_name,'r'),rcxres*rcyres*rczres,'short'),[rcxres rcyres rczres]) );
    elseif mag_type == 2 %float32 little endian
        TEMP =single( reshape(fread(fopen(cd_name,'r'),rcxres*rcyres*rczres,'float'),[rcxres rcyres rczres]) );
    elseif mag_type == 3 %short little endian
        TEMP =single( reshape(fread(fopen(cd_name,'rb'),rcxres*rcyres*rczres,'short','b'),[rcxres rcyres rczres]) );
    elseif mag_type == 4 %short little endian
        TEMP =single( reshape(fread(fopen(cd_name,'rb'),rcxres*rcyres*rczres,'float','b'),[rcxres rcyres rczres]) );
    end
    cd_slice(:,:,time+1) = volume_interp( TEMP,XX_2d_r,YY_2d_r,ZZ_2d_r,[res2d res2d]);

    %%Show 3D Image
    axes(handles.threed);
    imagesc(cd_slice(:,:,time+1));
    colormap('gray');
    set(gca,'XTick',[],'YTick',[]);
    drawnow;
end

%---------------------------------------------------------------
% Velocity (Requires Rotation)
%---------------------------------------------------------------

    for time=0:(tframes)

        disp(['Read Frame ',int2str(time),' of ',int2str(tframes)]);

        if time ==0
            vx_name ='comp_vd_1.dat';
            vy_name ='comp_vd_2.dat';
            vz_name ='comp_vd_3.dat';
        else
            vx_name = sprintf('ph_%03d_vd_1.dat',time-1);
            vy_name = sprintf('ph_%03d_vd_2.dat',time-1);
            vz_name = sprintf('ph_%03d_vd_3.dat',time-1);
        end

        fid=fopen(vx_name,'r');
        TEMP= single(reshape(fread(fid,'short'),[rcxres rcyres rczres]));
        fclose(fid);
        vx_slice_temp = volume_interp( TEMP,XX_2d_r,YY_2d_r,ZZ_2d_r,[res2d res2d]);

        fid=fopen(vy_name,'r');
        TEMP= single(reshape(fread(fid,'short'),[rcxres rcyres rczres]));
        fclose(fid);
        vy_slice_temp = volume_interp( TEMP,XX_2d_r,YY_2d_r,ZZ_2d_r,[res2d res2d]);

        fid=fopen(vz_name,'r');
        TEMP= single(reshape(fread(fid,'short'),[rcxres rcyres rczres]));
        fclose(fid);
        vz_slice_temp = volume_interp( TEMP,XX_2d_r,YY_2d_r,ZZ_2d_r,[res2d res2d]);

       %%%Apply rotation
       vx_slice(:,:,time+1) = Flow_Rot(1,1)*vx_slice_temp + Flow_Rot(1,2)*vy_slice_temp + Flow_Rot(1,3)*vz_slice_temp;
       vy_slice(:,:,time+1) = Flow_Rot(2,1)*vx_slice_temp + Flow_Rot(2,2)*vy_slice_temp + Flow_Rot(2,3)*vz_slice_temp;
       vz_slice(:,:,time+1) = Flow_Rot(3,1)*vx_slice_temp + Flow_Rot(3,2)*vy_slice_temp + Flow_Rot(3,3)*vz_slice_temp;
       
        %%Show 3D Image
        axes(handles.threed);
        imagesc(vz_slice(:,:,time+1));
        colormap('gray');
        set(gca,'XTick',[],'YTick',[]);
        drawnow;
       
end

%---------------------------------------------------------------
% Data Export
%---------------------------------------------------------------

disp(['Resolution 2D:',num2str(fov/res2d)])
save_path = get(handles.save_path,'string');
mkdir(save_path);

fid = fopen([save_path,'/mag_slice.dat'],'w');
fwrite(fid, mag_slice,'float');
fclose(fid);

fid = fopen([save_path,'/cd_slice.dat'],'w');
fwrite(fid, cd_slice,'float');
fclose(fid);

fid = fopen([save_path,'/vx_slice.dat'],'w');
fwrite(fid, vx_slice,'float');
fclose(fid);

fid = fopen([save_path,'/vy_slice.dat'],'w');
fwrite(fid, vy_slice,'float');
fclose(fid);

fid = fopen([save_path,'/vz_slice.dat'],'w');
fwrite(fid, vz_slice,'float');
fclose(fid);


function save_path_Callback(hObject, eventdata, handles)
% hObject    handle to save_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of save_path as text
%        str2double(get(hObject,'String')) returns contents of save_path as a double


% --- Executes during object creation, after setting all properties.
function save_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to save_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


