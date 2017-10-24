function varargout = resample_data(varargin)
% RESAMPLE_DATA M-file for resample_data.fig
%      RESAMPLE_DATA, by itself, creates a new RESAMPLE_DATA or raises the existing
%      singleton*.
%
%      H = RESAMPLE_DATA returns the handle to a new RESAMPLE_DATA or the handle to
%      the existing singleton*.
%
%      RESAMPLE_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESAMPLE_DATA.M with the given input arguments.
%
%      RESAMPLE_DATA('Property','Value',...) creates a new RESAMPLE_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before resample_data_OpeningFunction gets called.
%      An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to resample_data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help resample_data

% Last Modified by GUIDE v2.5 08-Dec-2009 14:18:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @resample_data_OpeningFcn, ...
                   'gui_OutputFcn',  @resample_data_OutputFcn, ...
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


% --- Executes just before resample_data is made visible.
function resample_data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to resample_data (see VARARGIN)

% Choose default command line output for resample_data
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes resample_data wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = resample_data_OutputFcn(hObject, eventdata, handles) 
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

global dicom_dir;
global dicom_files;
global header;

global dicom_X;
global dicom_Y;
global dicom_Z;
global dicom_V;
%slash = '\'; %windows
slash = '/'; %linux


dicom_dir = uigetdir('')
set(handles.dicom_file_name,'String',dicom_dir);
dicom_files = dir(dicom_dir)
dicom_files = dicom_files(find(~[dicom_files.isdir]))

name = dicom_files(1).name;
header= dicominfo([dicom_dir,slash,name]);

dicom_V = single(zeros(header.Width,header.Height,numel(dicom_files)));

[xt yt] = meshgrid(0:header.Width-1,0:header.Height-1);

%Get 3D Images and Extract Orientation

pos= 1;
name = dicom_files(pos).name;
header= dicominfo([dicom_dir,slash,name]);
OV_dicom = header.ImagePositionPatient;
XV_dicom = header.ImageOrientationPatient(1:3)*header.ReconstructionDiameter/double(header.Height);
YV_dicom = header.ImageOrientationPatient(4:6)*header.ReconstructionDiameter/double(header.Width);
ZV_dicom  = -header.ImagePositionPatient;

pos= 2;
name = dicom_files(pos).name;
header= dicominfo([dicom_dir,slash,name]);
ZV_dicom = ZV_dicom   + header.ImagePositionPatient;


global U_dicom;
global O_dicom;

%%DICOM Orientation
U_dicom = zeros(3,3);
U_dicom(:,1) = YV_dicom;
U_dicom(:,2) = XV_dicom
U_dicom(:,3) = ZV_dicom
O_dicom      = OV_dicom

for pos = 1:numel(dicom_files)
    name = dicom_files(pos).name;
    dicom_V(:,:,pos) = single( dicomread([dicom_dir,slash,name]));
    
    %%Show 3D Image
    axes(handles.threed);
    imagesc(dicom_V(:,:,pos));
    colormap('gray');
    set(gca,'XTick',[],'YTick',[]);
    drawnow;
end
 
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




% --- Executes on button press in reslice_backwards.
function reslice_backwards_Callback(hObject, eventdata, handles)
% hObject    handle to reslice_backwards (see GCBO)
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
global U_dicom;
global O_dicom;
global dicom_V;

%Image Size
rcxres = str2double(get(handles.rcxres,'String'));
rcyres = str2double(get(handles.rcyres,'String'));
rczres = str2double(get(handles.rczres,'String'));

UI_dicom = inv(U_dicom);

U_dicom 
O_dicom

U_pcvipr
O_pcvipr

[yt xt] = meshgrid(0:rcyres-1,0:rcxres-1);

RIMAGE = zeros(rcxres,rcyres,rczres);

fid = fopen(get(handles.magname,'String'));   
for slice = 1:rczres

    %fseek(fid,4*rcxres*rcyres*(slice-1),'bof');
    
    %%FIX Seek Issue Later
    %Read in Mag for Test
    mag_type = get(handles.mag_data_type,'Value');
    if mag_type == 1 %short16 little endian
        MAG = reshape(fread(fid,rcxres*rcyres,'short'),[rcxres rcyres]);
    elseif mag_type == 2 %float32 little endian
        MAG = reshape(fread(fid,rcxres*rcyres,'float'),[rcxres rcyres]);
    end

    XX_pcvipr = U_pcvipr(1,1)*xt + U_pcvipr(1,2)*yt + U_pcvipr(1,3)*(slice-1) + O_pcvipr(1);
    YY_pcvipr = U_pcvipr(2,1)*xt + U_pcvipr(2,2)*yt + U_pcvipr(2,3)*(slice-1) + O_pcvipr(2);
    ZZ_pcvipr = U_pcvipr(3,1)*xt + U_pcvipr(3,2)*yt + U_pcvipr(3,3)*(slice-1) + O_pcvipr(3);

    %%%Convert to Dicom coordinates 
    %%% A* x-dicom + b = x-scanner
    %%% A^-1*( x-scanner - b) = x-dicom
    XX_pcvipr = XX_pcvipr - O_dicom(1);
    YY_pcvipr = YY_pcvipr - O_dicom(2);
    ZZ_pcvipr = ZZ_pcvipr - O_dicom(3);
    XX_pcvipr_r = UI_dicom(1,1)*XX_pcvipr + UI_dicom(1,2)*YY_pcvipr + UI_dicom(1,3)*ZZ_pcvipr;
    YY_pcvipr_r = UI_dicom(2,1)*XX_pcvipr + UI_dicom(2,2)*YY_pcvipr + UI_dicom(2,3)*ZZ_pcvipr;
    ZZ_pcvipr_r = UI_dicom(3,1)*XX_pcvipr + UI_dicom(3,2)*YY_pcvipr + UI_dicom(3,3)*ZZ_pcvipr;

    %%Get a starting point
    mag_slice = volume_interp( dicom_V, 1+XX_pcvipr_r,1+YY_pcvipr_r,1+ZZ_pcvipr_r,[rcxres rcyres]);
  
    %%Show 3D Image
    axes(handles.threed);
    imagesc(mag_slice);
    colormap('gray');
    set(gca,'XTick',[],'YTick',[]);
    
     %%Show 3D Image
    axes(handles.twod);
    imagesc(MAG);
    colormap('gray');
    set(gca,'XTick',[],'YTick',[]);
    
    drawnow;
    
    RIMAGE(:,:,slice)= mag_slice;
end
fclose(fid);
fid = fopen(get(handles.save_path,'string'),'w');
fwrite(fid,RIMAGE,'float');
fclose(fid);





