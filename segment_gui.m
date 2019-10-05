function varargout = segment_gui(varargin)
% SEGMENT_GUI M-file for segment_gui.fig
%      SEGMENT_GUI, by itself, creates a new SEGMENT_GUI or raises the existing
%      singleton*.
%
%      H = SEGMENT_GUI returns the handle to a new SEGMENT_GUI or the handle to
%      the existing singleton*.
%
%      SEGMENT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEGMENT_GUI.M with the given input arguments.
%
%      SEGMENT_GUI('Property','Value',...) creates a new SEGMENT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before segment_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to segment_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help segment_gui

% Last Modified by GUIDE v2.5 03-Apr-2015 16:29:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @segment_gui_OpeningFcn, ...
    'gui_OutputFcn',  @segment_gui_OutputFcn, ...
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


% --- Executes just before segment_gui is made visible.
function segment_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to segment_gui (see VARARGIN)

% Choose default command line output for segment_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Init Log
SS{1} = 'Start of PC Tool ';
SS{2} = datestr(now);
set(handles.status,'String',SS);
set(handles.status,'Value',2);

% Make options invisible
set(handles.mask_alpha_name,'Visible','off');
set(handles.mask_alpha,'Visible','off');

% UIWAIT makes segment_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%Read Header
a = read_header(handles);
if a==1
    load_data(handles);
end

global pc_data_loaded;
pc_data_loaded = 0;

global pressure_flag;
pressure_flag = 0;

global mask_num;
global mask_names;
mask_num = 0;
mask_names = '';



% --- Outputs from this function are returned to the command line.
function varargout = segment_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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

global tframes;
tframes = str2double(get(handles.tframes,'String'));


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


% --- Executes on button press in load_button.
function load_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Read Header
a = read_header(handles);
if a==1
    load_data(handles);
end

function load_data(handles)

global xfov;
global yfov;
global zfov;
global rcxres;
global rcyres;
global rczres;
global MAG;
global CD;
global delX;
global delY;
global delZ;
global tres;
global tframes;
global VENC;
global VELX;
global VELY;
global VELZ;
global poly_vals;
global phase_correction;
global base_dir;

xfov = str2double(get(handles.xfov,'String'));
yfov = str2double(get(handles.yfov,'String'));
zfov = str2double(get(handles.zfov,'String'));

rcxres = str2double(get(handles.rcxres,'String'));
rcyres = str2double(get(handles.rcyres,'String'));
rczres = str2double(get(handles.rczres,'String'));

tstr = get(handles.rcxres,'string');
set(handles.stopX,'string',tstr);
tstr = get(handles.rcyres,'string');
set(handles.stopY,'string',tstr);
tstr = get(handles.rczres,'string');
set(handles.stopZ,'string',tstr);

tres    = str2double(get(handles.tres,'String'));
tframes = str2double(get(handles.tframes,'String'));

delX = xfov / rcxres;
delY = yfov / rcyres;
delZ = zfov / rczres;

load_pc_data(handles);
update_angio(handles);
update_images(handles);
update_export_variables(handles)

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


% --- Executes on selection change in mask_method.
function mask_method_Callback(hObject, eventdata, handles)
% hObject    handle to mask_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns mask_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mask_method

%%%%KMJ Segmentation Method %%%%
mask_method = get(handles.mask_method,'Value');
%%%Decoding
%% 1 = mask on CD
%% 2 = mask on Max
%% 3 = mixture model (not there yet)
%% 4 = load from mimics
%% 5 = load from mimics CE-MRA

if mask_method < 4 && mask_method > 1
    set(handles.mask_alpha_name,'Visible','on');
    set(handles.mask_alpha,'Visible','on');
else
    set(handles.mask_alpha_name,'Visible','off');
    set(handles.mask_alpha,'Visible','off');
end


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


% --- Executes on button press in mask_button.
function mask_button_Callback(hObject, eventdata, handles)
% hObject    handle to mask_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global m_xstart;
global m_xstop;
global m_ystart;
global m_ystop;
global m_zstart;
global m_zstop;
global m_alpha;
global m_beta;

global m_xlength;
global m_ylength;
global m_zlength;

global xfov;
global yfov;
global zfov;
global rcxres;
global rcyres;
global rczres;
global MAG;
global ANGIO;
global MASK;

global U_pcvipr;
global O_pcvipr;

global mask_names;
global mask_num;

%%%%KMJ Segmentation Method %%%%
mask_method = get(handles.mask_method,'Value');
%%%Decoding
%% 1 = Nothing
%% 2 = mask on CD
%% 3 = mask on Max
%% 4 = load from mimics
%% 5 = load from mimics MRA

if mask_method < 4
    
    mask_names{1} = 'Mask';  %MWL - delete this
    mask_num = 1;
    
    m_alpha = str2double(get(handles.mask_alpha,'String'));
    
    %%%%%SIMPLE THRESHOLD TO BEGING WITH %%%%%%%%%%
    if( mask_method == 2)
        MASK = single( ANGIO );
        MASK = MASK > m_alpha*max(MASK(:));
        
    elseif( mask_method == 3 )
        MASK = single( MAG.Data.vals );
        MASK = MASK > m_alpha*max(MASK(:));
    end
else
    
    uiwait(mimics_import_chain);
    
end

%get Crop values based on mask
m_xstart = size(MASK,1);
m_xstop = 0;
m_ystart = size(MASK,2);
m_ystop = 0;
m_zstart = size(MASK,3);
m_zstop = 0;

[y x ] = meshgrid(1:size(MASK,1),1:size(MASK,2));
for z = 1:size(MASK,3)
    slice = sum(squeeze(MASK(:,:,z,:)),3);
    if max(slice(:)) > 0
        if( z > m_zstop)
            m_zstop = z;
        end
        
        if( z < m_zstart)
            m_zstart = z;
        end
        
        idx = find( slice > 0);
        
        if min(y(idx)) < m_ystart
            m_ystart = min(y(idx));
        end
        
        if min(x(idx)) < m_xstart
            m_xstart = min(x(idx));
        end
        
        if max(y(idx)) > m_ystop
            m_ystop = max(y(idx));
        end
        if max(x(idx)) > m_xstop
            m_xstop = max(x(idx));
        end
    end
end

m_xstop = m_xstop + 4;
if( m_xstop > size(MASK,1))
    m_xstop  = size(MASK,1);
end

m_ystop = m_ystop + 4;
if( m_ystop > size(MASK,2))
    m_ystop  = size(MASK,2);
end

m_zstop = m_zstop + 4;
if( m_zstop > size(MASK,3))
    m_zstop  = size(MASK,3);
end

m_xstart = m_xstart - 4;
if( m_xstart < 1)
    m_xstart  = 1;
end

m_ystart = m_ystart - 4;
if( m_ystart < 1)
    m_ystart  = 1;
end

m_zstart = m_zstart - 4;
if( m_zstart < 1)
    m_zstart  = 1;
end

set(handles.startX,'String',num2str(m_xstart));
set(handles.stopX,'String',num2str(m_xstop));
set(handles.startY,'String',num2str(m_ystart));
set(handles.stopY,'String',num2str(m_ystop));
set(handles.startZ,'String',num2str(m_zstart));
set(handles.stopZ,'String',num2str(m_zstop));

update_export_variables(handles)
update_images(handles);

% --- Executes on selection change in visual_method.
function visual_method_Callback(hObject, eventdata, handles)
% hObject    handle to visual_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns visual_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from visual_method


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



function update_angio(handles)

global MAG;
global VELX;
global VELY;
global VELZ;

global ANGIO;
global poly_fitx;
global poly_fity;
global poly_fitz;
global VENC;
global phase_correction;


figure(handles.figure1);
drawnow
ANGIO = single(zeros(size(VELX.Data.vals)));

xrange = single( linspace(-1,1,size(VELX.Data.vals,1)) );
yrange = single( linspace(-1,1,size(VELY.Data.vals,2)) );
zrange = single( linspace(-1,1,size(VELZ.Data.vals,3)) );

log_message(handles,'Updating Angiogram');
[y,x] = meshgrid(yrange,xrange);
for slice = 1: size(ANGIO,3)
    
    update_log_message(handles,['Updating Angiogram Slice ',num2str(slice),' of ',num2str(size(ANGIO,3))]);
    
    vx_slice = single(VELX.Data.vals(:,:,slice) );
    vy_slice = single(VELY.Data.vals(:,:,slice) );
    vz_slice = single(VELZ.Data.vals(:,:,slice) );
    mag_slice= single(MAG.Data.vals(:,:,slice) );
    
    if phase_correction ==1
        z = zrange(slice);
        vx_slice = vx_slice - evaluate_poly(x,y,z,poly_fitx);
        vy_slice = vy_slice - evaluate_poly(x,y,z,poly_fity);
        vz_slice = vz_slice - evaluate_poly(x,y,z,poly_fitz);
    end
    vmag =sqrt(vx_slice.^2 + vy_slice.^2 + + vz_slice.^2);
    ANGIO(:,:,slice)= mag_slice.*sin( pi/2 * vmag/VENC/2);
end
log_message(handles,'Angio Done');

function update_images(handles)

global m_xstart;
global m_xstop;
global m_ystart;
global m_ystop;
global m_zstart;
global m_zstop;

global m_xlength;
global m_ylength;
global m_zlength;

global xfov;
global yfov;
global zfov;
global rcxres;
global rcyres;
global rczres;
global MAG;
global ANGIO;
global MASK;
global mask_num;
global VELX;
global VELY;
global VELZ;
global TEMP
global poly_fitx;
global poly_fity;
global poly_fitz;
global VENC;
global phase_correction;

%%%COPY VALUES%%%%%%
gridlines =(get(handles.gridlines,'Value'));
m_xstart = str2double(get(handles.startX,'String'));
m_xstop  = str2double(get(handles.stopX,'String'));
m_ystart = str2double(get(handles.startY,'String'));
m_ystop  = str2double(get(handles.stopY,'String'));
m_zstart = str2double(get(handles.startZ,'String'));
m_zstop  = str2double(get(handles.stopZ,'String'));
rcxres = str2double(get(handles.rcxres,'String'));
rcyres = str2double(get(handles.rcyres,'String'));
rczres = str2double(get(handles.rczres,'String'));

gamma = get(handles.gamma_slider,'Value');

visual_method = get(handles.visual_method,'Value');
%%%VISUAL METHOD DECODING
%   1 = cd mip
%   2 = mag mip
%   3 = cd mip + overlay
%   4 = mag mip + overlay

m_xlength = m_xstop - m_xstart +1;
m_ylength = m_ystop - m_ystart +1;
m_zlength = m_zstop - m_zstart +1 ;

xrange = single( linspace(-1,1,size(VELX.Data.vals,1)) );
yrange = single( linspace(-1,1,size(VELY.Data.vals,2)) );
zrange = single( linspace(-1,1,size(VELZ.Data.vals,3)) );


if( (visual_method ==1) || (visual_method==3) )
    TEMP = ANGIO;
elseif( (visual_method ==2) || (visual_method==4) )
    TEMP  = single(MAG.Data.vals);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% XMIPS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


blank=128*ones(rcyres+128,rczres+128);
axes(handles.mipx)
im = squeeze(max(TEMP(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop) ,[],1));
im = im * 195 / max(im(:));

if( visual_method > 2)
    
    for pos = 1:mask_num
        mask_mip =(reshape(max(MASK(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop,pos),[],1),[m_ylength m_zlength]));
        idx = find( (mask_mip==1) & ( im < 201) );
        im(idx) = 200+10*pos;
    end
    blank(m_ystart:m_ystop,m_zstart:m_zstop)=im;
    map =[ gray(200); jet(10*mask_num)];
    imagesc(blank,[0,200+10*mask_num]);
    colormap(map);
    
else
    blank(m_ystart:m_ystop,m_zstart:m_zstop)=im.^gamma;
    imagesc(blank,[0 200^gamma]);
    colormap('gray');
end

ylim([ m_ystart (m_ystart+max([m_ylength m_zlength])-1)]);
xlim([ m_zstart (m_zstart+max([m_ylength m_zlength])-1)]);

if(gridlines ==1 )
    grid on;
    set(gca,'XColor','r');
    set(gca,'YColor','r');
    xlabel('Z-Pos');
    ylabel('Y-Pos');
else
    grid off
    set(gca,'XTickLabel','')
    set(gca,'YTickLabel','')
end
drawnow

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% YMIPS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes(handles.mipy)
blank=128*ones(rcxres+128,rczres+128);
im = squeeze(max(TEMP(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop) ,[],2));
im = im * 195 / max(im(:));

if( visual_method > 2)
    
    for pos = 1:mask_num
        mask_mip =(reshape(max(MASK(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop,pos),[],2),[m_xlength m_zlength]));
        idx = find( (mask_mip==1) & ( im < 201) );
        im(idx) = 200+10*pos;
    end
    blank(m_xstart:m_xstop,m_zstart:m_zstop)=im;
    map =[ gray(200); jet(10*mask_num)];
    imagesc(blank,[0,200+10*mask_num]);
    colormap(map);
else
    blank(m_xstart:m_xstop,m_zstart:m_zstop)=im.^gamma;
    imagesc(blank,[0 200^gamma]);
    colormap('gray');
end

if(gridlines ==1 )
    grid on;
    set(gca,'XColor','r');
    set(gca,'YColor','r');
    xlabel('Z-Pos');
    ylabel('X-Pos');
else
    grid off
    set(gca,'XTickLabel','')
    set(gca,'YTickLabel','')
end
xlim([m_zstart (m_zstart -1+ max([m_xlength m_zlength]))]);
ylim([m_xstart (m_xstart -1+ max([m_xlength m_zlength]))]);
drawnow


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ZMIPS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes(handles.mipz)
blank=128*ones(rcxres+128,rcyres+128);
im = squeeze(max(TEMP(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop) ,[],3));
im = im * 195 / max(im(:));

if( visual_method > 2)
    for pos = 1:mask_num
        mask_mip =(reshape(max(MASK(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop,pos),[],3),[m_xlength m_ylength]));
        idx = find( (mask_mip==1) & ( im < 201) );
        im(idx) = 200+10*pos;
    end
    blank(m_xstart:m_xstop,m_ystart:m_ystop)=im;
    map =[ gray(200); jet(10*mask_num)];
    imagesc(blank,[0,200+10*mask_num]);
    colormap(map);
else
    blank(m_xstart:m_xstop,m_ystart:m_ystop)=im.^gamma;
    imagesc(blank,[0 200^gamma]);
    colormap('gray');
end

if(gridlines ==1 )
    grid on;
    set(gca,'XColor','r');
    set(gca,'YColor','r');
    xlabel('Y-Pos');
    ylabel('X-Pos');
else
    grid off
    set(gca,'XTickLabel','')
    set(gca,'YTickLabel','')
end

xlim([(m_ystart) (m_ystart-1 +max([m_ylength m_xlength]))]);
ylim([(m_xstart) (m_xstart-1 +max([m_ylength m_xlength]))]);
drawnow


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

read_header(handles);


function status = read_header(handles)

global U_pcvipr;
global O_pcvipr;
global VENC;
global base_dir;
global exam;

%% Have User Select Folder
base_dir = uigetdir([],'Select the Location of Reconstructed Data');

%%%Reads external files for parameters
name = fullfile(base_dir,'pcvipr_header.txt');
if( 0==exist(name))
    uiwait(msgbox([name,' does not exist. Enter manully but scanner coordinates will be wrong'],'Warning!!'));
    status =0;
    return;
end

[parameter value]=textread(name, '%s %s');
status =1;

%%%EXAM
idx = find(strcmp('exam',parameter));
exam = str2num( value{idx} );

%%%FOVS
idx = find(strcmp('fovx',parameter));
xfov = str2num( value{idx} );
set(handles.xfov,'string',num2str(xfov));

idx = find(strcmp('fovy',parameter));
yfov = str2num( value{idx} );
set(handles.yfov,'string',num2str(yfov));

idx = find(strcmp('fovz',parameter));
zfov = str2num( value{idx} );
set(handles.zfov,'string',num2str(zfov));

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

idx = find(strcmp('VENC',parameter));
VENC = str2num( value{idx} );

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
    uiwait(msgbox('pcvipr_header.txt is old. Scanner coordinates will be wrong','Warning!!'));
end




function mimics_name_Callback(hObject, eventdata, handles)
% hObject    handle to mimics_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mimics_name as text
%        str2double(get(hObject,'String')) returns contents of mimics_name as a double


% --- Executes during object creation, after setting all properties.
function mimics_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mimics_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mimics_push.
function mimics_push_Callback(hObject, eventdata, handles)
% hObject    handle to mimics_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[name path] = uigetfile( ...
    {  '*.txt','Text (*.txt)'; ...
    '*.*',  'All Files (*.*)'}, ...
    'Select All Mimics Files', ...
    'MultiSelect', 'on');
global mask_names;
global mask_num;

if iscell(name)
    mimics_files = size(name,2)
    for ii = 1:mimics_files
        mimics_names{ii} = [path name{ii}]
        mask_names{ii} =  name{ii};
    end
    mask_num = mimics_files;
else
    mimics_names{1} = [path name]
    mask_names{1} =  name;
    mask_num = 1;
end
set(handles.mimics_list,'String',mimics_names)

% --- Executes on selection change in mimics_list.
function mimics_list_Callback(hObject, eventdata, handles)
% hObject    handle to mimics_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns mimics_list contents as cell array
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


% --- Executes on button press in load_mra_button.
function load_mra_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_mra_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%This loads a CE-MRA Dataset
path = uigetdir('','Select MRA Dicom Folder');

global mra_image;
global mra_info;
global mra_meta_data;

h = waitbar(0,'Reading DICOM Files...','WindowStyle','modal');

dicom_files = dir(path);

slice_pos = 1;
N = numel(dicom_files);
info_exists =0;
for file_pos = 1 : N
    if dicom_files(file_pos,1).isdir == 0
        if info_exists == 0
            mra_info = dicominfo([path,'\',dicom_files(file_pos,1).name]);
            mra_image =zeros(mra_info.Width,mra_info.Height,N-2);
            info_exists =1;
        end
        mra_image(:,:,slice_pos) = dicomread([path,'\',dicom_files(file_pos,1).name]);
        slice_pos = slice_pos + 1;
        waitbar(file_pos/N*0.3,h);
    end
end


%%%Convert
global MRA;
global CD;
MRA = zeros(size(CD));

global rcxres;
global rcyres;
global rczres;

global O_pcvipr
global U_pcvipr

%%%MRA Unit Vectors
OV_mra = mra_info.ImagePositionPatient;
XV_mra = mra_info.ImageOrientationPatient(1:3)*mra_info.ReconstructionDiameter/mra_info.Width;
YV_mra = mra_info.ImageOrientationPatient(4:6)*mra_info.ReconstructionDiameter/mra_info.Height;
ZV_mra = -cross(XV_mra,YV_mra).*mra_info.SliceThickness;
Orientation = mra_info.PatientPosition;

U_mra(1,:) = [ XV_mra(1) YV_mra(1) ZV_mra(1)];
U_mra(2,:) = [ XV_mra(2) YV_mra(2) ZV_mra(2)];
U_mra(3,:) = [ XV_mra(3) YV_mra(3) ZV_mra(3)];
O_mra      = [ OV_mra(1); OV_mra(2); OV_mra(3)];
UI_mra = inv(U_mra);

U_mra
UI_mra
O_mra

U_pcvipr
O_pcvipr

[xt yt] = meshgrid(0:rcxres-1,0:rcyres-1);
for slice = 1:6:rczres
    waitbar(slice/rczres*0.7+0.3,h);
    
    %%Raw Scanner Coordinates for PC VIPR
    XX_pcvipr_raw = O_pcvipr(1) + xt*U_pcvipr(1,1) + yt*U_pcvipr(1,2) + (slice-1)*U_pcvipr(1,3);
    YY_pcvipr_raw = O_pcvipr(2) + xt*U_pcvipr(2,1) + yt*U_pcvipr(2,2) + (slice-1)*U_pcvipr(2,3);
    ZZ_pcvipr_raw = O_pcvipr(3) + xt*U_pcvipr(3,1) + yt*U_pcvipr(3,2) + (slice-1)*U_pcvipr(3,3);
    
    disp(['Slice:',num2str(slice),'  Range X [',num2str(min(XX_pcvipr_raw(:))),' ',num2str(max(XX_pcvipr_raw(:))),' ] Y [',num2str(min(YY_pcvipr_raw(:))),' ',num2str(max(YY_pcvipr_raw(:))),' ] Z [ ',num2str(min(ZZ_pcvipr_raw(:))),' ',num2str(max(ZZ_pcvipr_raw(:))),' ] ']);
    
    %%%Convert to MRA coordinates
    %%% A* x-mra + b = x-scanner
    %%% A^-1*( x-scanner - b) = x-mra
    XX_pcvipr_raw = XX_pcvipr_raw - O_mra(1);
    YY_pcvipr_raw = YY_pcvipr_raw - O_mra(2);
    ZZ_pcvipr_raw = ZZ_pcvipr_raw - O_mra(3);
    
    XX_pcvipr_mra = UI_mra(1,1)*XX_pcvipr_raw + UI_mra(1,2)*YY_pcvipr_raw + UI_mra(1,3)*ZZ_pcvipr_raw;
    YY_pcvipr_mra = UI_mra(2,1)*XX_pcvipr_raw + UI_mra(2,2)*YY_pcvipr_raw + UI_mra(2,3)*ZZ_pcvipr_raw;
    ZZ_pcvipr_mra = UI_mra(3,1)*XX_pcvipr_raw + UI_mra(3,2)*YY_pcvipr_raw + UI_mra(3,3)*ZZ_pcvipr_raw;
    
    disp(['Slice:',num2str(slice),'  Range X [',num2str(min(XX_pcvipr_mra(:))),' ',num2str(max(XX_pcvipr_mra(:))),' ] Y [',num2str(min(YY_pcvipr_mra(:))),' ',num2str(max(YY_pcvipr_mra(:))),' ] Z [ ',num2str(min(ZZ_pcvipr_mra(:))),' ',num2str(max(ZZ_pcvipr_mra(:))),' ] ']);
    
    MRA(:,:,slice) = volume_interp( mra_image,XX_pcvipr_mra,YY_pcvipr_mra,ZZ_pcvipr_mra,[rcxres rcyres]);
end
close(h);

global MAG
MAG = MRA;

% --- Executes on button press in update_button.
function update_button_Callback(hObject, eventdata, handles)
% hObject    handle to update_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_images(handles);


% --- Executes on button press in load_parameters.
function load_parameters_Callback(hObject, eventdata, handles)
% hObject    handle to load_parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[name path] = uigetfile( ...
    {  '*.mat','Parameters (*.mat)'; ...
    '*.*',  'All Files (*.*)'}, ...
    'Select Previous Processing Parameters', ...
    'MultiSelect', 'off');
if iscell(name)
    old_parameters_name = size(name,2)
    for ii = 1:mimics_files
        old_parameters_name{ii} = [path name{ii}]
    end
else
    old_parameters_name{1} = [path name]
end

load( old_parameters_name{1} );

set(handles.stopX,'string',par.stopX);
set(handles.stopY,'string',par.stopY);
set(handles.stopZ,'string',par.stopZ);
set(handles.startX,'string',par.startX);
set(handles.startY,'string',par.startY);
set(handles.startZ,'string',par.startZ);

update_images(handles);

% --- Executes on button press in draw_roi.
function draw_roi_Callback(hObject, eventdata, handles)
% hObject    handle to draw_roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global x_rect;
global z_rect;
m_xstart = str2double(get(handles.startX,'String'));
m_xstop  = str2double(get(handles.stopX,'String'));
m_ystart = str2double(get(handles.startY,'String'));
m_ystop  = str2double(get(handles.stopY,'String'));
m_zstart = str2double(get(handles.startZ,'String'));
m_zstop  = str2double(get(handles.stopZ,'String'));

%%%
x_rect = imrect(handles.mipx,[m_zstart m_ystart (m_zstop - m_zstart) (m_ystop -m_ystart)]);
y_rect = imrect(handles.mipy,[m_zstart m_xstart (m_zstop - m_zstart) (m_xstop -m_xstart)]);
z_rect = imrect(handles.mipz,[m_ystart m_xstart (m_ystop - m_ystart) (m_xstop -m_xstart)]);

%%%Cross ROI Resizing
addNewPositionCallback(x_rect,@(p) (set_crossx(x_rect,y_rect,z_rect,handles)));
addNewPositionCallback(y_rect,@(p) (set_crossy(x_rect,y_rect,z_rect,handles)));
addNewPositionCallback(z_rect,@(p) (set_crossz(x_rect,y_rect,z_rect,handles)));


function set_crossx(x_rect,y_rect,z_rect,handles)
px = getPosition(x_rect);
py = getPosition(y_rect);
pz = getPosition(z_rect);
setPosition(y_rect,[px(1) py(2) px(3) py(4)] );
setPosition(z_rect,[px(2) pz(2) px(4) pz(4)] );
set_start_stop(px,pz,handles);

return

function set_crossy(x_rect,y_rect,z_rect,handles)
px = getPosition(x_rect);
py = getPosition(y_rect);
pz = getPosition(z_rect);
setPosition(x_rect,[py(1) px(2) py(3) px(4)] );
setPosition(z_rect,[pz(1) py(2) pz(3) py(4)] );
set_start_stop(px,pz,handles);

return


function set_crossz(x_rect,y_rect,z_rect,handles)
px = getPosition(x_rect);
py = getPosition(y_rect);
pz = getPosition(z_rect);
setPosition(x_rect,[px(1) pz(1) px(3) pz(3)] );
setPosition(y_rect,[py(1) pz(2) py(3) pz(4)] );
set_start_stop(px,pz,handles);

return

function set_start_stop(px,pz,handles)
set(handles.startX,'string',floor(pz(2)));
set(handles.startY,'string',floor(pz(1)));
set(handles.startZ,'string',floor(px(1)));
set(handles.stopX,'string',floor(pz(4)+pz(2)));
set(handles.stopY,'string',floor(pz(3)+pz(1)));
set(handles.stopZ,'string',floor(px(3)+px(1)));
return





% --- Executes on selection change in phase_method.
function phase_method_Callback(hObject, eventdata, handles)
% hObject    handle to phase_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns phase_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from phase_method

%%%%KMJ Phase Correction Method
phase_method = get(handles.phase_method,'Value');

global rcxres;
global rcyres;
global rczres;
global MAG;
global phase_correction;
global P_VELX;
global P_VELY;
global P_VELZ;
global P_MAG;
global base_dir;
global poly_fitx;
global poly_fity;
global poly_fitz;
global VELX;
global VELY;
global VELZ;

% Now use mapping
phase_correction = 0;

%%%Decoding
% 1 = Null
% 2 = None
% 3 = Polynomial
% 4 = Phantom
% 5 = Phantom Polynomial
switch phase_method
    case 3
        phase_correction =1;
        [poly_fitx,poly_fity, poly_fitz] = background_phase_correction(MAG,VELX,VELY,VELZ);
        update_angio(handles);
    case 4
        phase_correction =1;
        phantom_dir = uigetdir('','Select Folder the Phantom Data is in');
        
        P_MAG = memmapfile(fullfile(phantom_dir,'MAG.dat'),'Format',{'int16',[rcxres rcyres rczres],'vals'});
        P_VELX  = memmapfile(fullfile(phantom_dir,'comp_vd_1.dat'),'Format',{'int16',[rcxres rcyres rczres],'vals'});
        P_VELY  = memmapfile(fullfile(phantom_dir,'comp_vd_2.dat'),'Format',{'int16',[rcxres rcyres rczres],'vals'});
        P_VELZ  = memmapfile(fullfile(phantom_dir,'comp_vd_3.dat'),'Format',{'int16',[rcxres rcyres rczres],'vals'});
        
        update_angio(handles);
    case 5
        phase_correction =1;
        phantom_dir = uigetdir('','Select Folder the Phantom Data is in');
        
        P_MAG = memmapfile(fullfile(phantom_dir,'MAG.dat'),'Format',{'int16',[rcxres rcyres rczres],'vals'});
        P_VELX  = memmapfile(fullfile(phantom_dir,'comp_vd_1.dat'),'Format',{'int16',[rcxres rcyres rczres],'vals'});
        P_VELY  = memmapfile(fullfile(phantom_dir,'comp_vd_2.dat'),'Format',{'int16',[rcxres rcyres rczres],'vals'});
        P_VELZ  = memmapfile(fullfile(phantom_dir,'comp_vd_3.dat'),'Format',{'int16',[rcxres rcyres rczres],'vals'});
        
        [poly_fitx,poly_fity, poly_fitz] = background_phase_correction(P_MAG,P_VELX,P_VELY,P_VELZ);
        update_angio(handles);
    otherwise
        
end

% Put into handles
handles.poly_fitx = poly_fitx;
handles.poly_fity = poly_fity;
handles.poly_fitz = poly_fitz;





% --- Executes during object creation, after setting all properties.
function phase_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phase_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function load_pc_data(handles)

global pc_data_loaded;

%Masking parameters
global m_xstart;
global m_xstop;
global m_ystart;
global m_ystop;
global m_zstart;
global m_zstop;
global m_xlength;
global m_ylength;
global m_zlength;
global base_dir;


%%%Data Acquisition Parameters
global tframes;
global tres;
global rcxres;
global rcyres;
global rczres;
global xfov;
global yfov;
global zfov;
global delX;
global delY;
global delZ;

%Raw Data
global MAG;
global CD;
global MASK;
global MAGt;
global VELX;
global VELY;
global VELZ;
global VELXt;
global VELYt;
global VELZt;

global phase_correction;
global px;
global py;
global pz;
global poly_vals;
global base_dir;

%%Load Velocity Data%%%%%%%%%%
log_message(handles,'Loading Time Averaged Velocity Data');

vx_name =fullfile(base_dir,'comp_vd_1.dat');
vy_name =fullfile(base_dir,'comp_vd_2.dat');
vz_name =fullfile(base_dir,'comp_vd_3.dat');
mag_name = fullfile(base_dir,'MAG.dat');



s=dir(vx_name)
bytes_per=s.bytes/(rcxres*rcyres*rczres);



% Memory Maps to VELXmm
log_message(handles,'Maping time averaged data to memory');
if bytes_per==2
VELX = memmapfile(vx_name,'Format',{'int16',[rcxres rcyres rczres],'vals'});
VELY = memmapfile(vy_name,'Format',{'int16',[rcxres rcyres rczres],'vals'});
VELZ = memmapfile(vz_name,'Format',{'int16',[rcxres rcyres rczres],'vals'});
MAG =  memmapfile(mag_name,'Format',{'int16',[rcxres rcyres rczres],'vals'});
else
   VELX = memmapfile(vx_name,'Format',{'single',[rcxres rcyres rczres],'vals'});
    VELY = memmapfile(vy_name,'Format',{'single',[rcxres rcyres rczres],'vals'});
    VELZ = memmapfile(vz_name,'Format',{'single',[rcxres rcyres rczres],'vals'});
MAG =  memmapfile(mag_name,'Format',{'single',[rcxres rcyres rczres],'vals'}); 
end

% Map dynamic data to disk
if tframes ~= 0
    
    for time=0:(tframes-1)
        
        if time==0
            log_message(handles,['Mapping Frame ',int2str(time+1),' of ',int2str(tframes)]);
        else
            update_log_message(handles,['Mapping Frame ',int2str(time+1),' of ',int2str(tframes)]);
        end
        
        if tframes == 1
            vx_name =fullfile(base_dir,'comp_vd_1.dat');
            vy_name =fullfile(base_dir,'comp_vd_2.dat');
            vz_name =fullfile(base_dir,'comp_vd_3.dat');
            mag_name=fullfile(base_dir,'MAG.dat');
        else
            vx_name = fullfile(base_dir,sprintf('ph_%03d_vd_1.dat',time));
            vy_name = fullfile(base_dir,sprintf('ph_%03d_vd_2.dat',time));
            vz_name = fullfile(base_dir,sprintf('ph_%03d_vd_3.dat',time));
            mag_name = fullfile(base_dir,sprintf('ph_%03d_mag.dat',time));
        end
        
        if bytes_per == 2
        VELXt{time+1}=memmapfile(vx_name,'Format',{'int16',[rcxres rcyres rczres],'vals'});
        VELYt{time+1}=memmapfile(vy_name,'Format',{'int16',[rcxres rcyres rczres],'vals'});
        VELZt{time+1}=memmapfile(vz_name,'Format',{'int16',[rcxres rcyres rczres],'vals'});
        MAGt{time+1} =memmapfile(mag_name,'Format',{'int16',[rcxres rcyres rczres],'vals'});
        else
                    VELXt{time+1}=memmapfile(vx_name,'Format',{'single',[rcxres rcyres rczres],'vals'});
        VELYt{time+1}=memmapfile(vy_name,'Format',{'single',[rcxres rcyres rczres],'vals'});
        VELZt{time+1}=memmapfile(vz_name,'Format',{'single',[rcxres rcyres rczres],'vals'});
        MAGt{time+1} =memmapfile(mag_name,'Format',{'single',[rcxres rcyres rczres],'vals'});
        end
    end
end
pc_data_loaded = 1;


% --- Executes on button press in cine_anatomy_checkbox.
function cine_anatomy_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to cine_anatomy_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cine_anatomy_checkbox
update_export_variables(handles)

% --- Executes on button press in pressure_button.
function pressure_button_Callback(hObject, eventdata, handles)
% hObject    handle to pressure_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pressure_button
global pc_data_loaded;

if pc_data_loaded ==0
    log_message(handles,'Loading PC Data');
    load_pc_data(handles);
end

global VELX;
global VELY;
global VELZ;
global VELXt;
global VELYt;
global VELZt;
global MAGt;
global delX;
global delY;
global delZ;
global tres;
global MASK;
global PRESSURE;
global pressure_flag;

if( numel(MASK)==0)
    uiwait(msgbox(['Error no mask exists. Can not calculate pressure'],'Warning!!'));
    return;
end

log_message(handles,'Calculating Pressure');
PRESSURE = pressure_gui(MASK,VELX,VELY,VELZ,VELXt,VELYt,VELZt,delX,delY,delZ,tres);
set(handles.pressure_status,'String','Calculated');
log_message(handles,'Done');
pressure_flag = 1;

update_export_variables(handles)

function log_message( handles, message)
SS = get(handles.status,'String');
SS{end+1} = message;
set(handles.status,'String',SS);
set(handles.status,'Value',max(numel(SS),2));
drawnow

function update_log_message( handles, message)
SS = get(handles.status,'String');
SS{end} = message;
set(handles.status,'String',SS);
set(handles.status,'Value',max(numel(SS),2));
drawnow

% --- Executes on button press in wss_button.
function wss_button_Callback(hObject, eventdata, handles)
% hObject    handle to wss_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global ANGIO;
global VELX;
global VELY;
global VELZ;
global VELXt;
global VELYt;
global VELZt;
global MAG;
global delX;
global delY;
global delZ;
global tres;
global MASK;
global STL_MASK;
global m_xstart;
global m_xstop;
global m_ystart;
global m_ystop;
global m_zstart;
global m_zstop;
global tframes;
global mask_names;

%% TEMP
sCD = single(ANGIO(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop)); %TEMP
for pos=1:size(MASK,4)
    sMASK{pos}.Volume = MASK(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop,pos);
    sMASK{pos}.Name = mask_names{pos};
end

sVELX = single(VELX.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop));
sVELY = single(VELY.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop));
sVELZ = single(VELZ.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop));

sVELXt = zeros(size(sCD,1),size(sCD,2),size(sCD,3),tframes,'single');
sVELYt = zeros(size(sCD,1),size(sCD,2),size(sCD,3),tframes,'single');
sVELZt = zeros(size(sCD,1),size(sCD,2),size(sCD,3),tframes,'single');
for phase = 1:tframes
    sVELXt(:,:,:,phase) = VELXt{phase}.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop);
    sVELYt(:,:,:,phase) = VELYt{phase}.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop);
    sVELZt(:,:,:,phase) = VELZt{phase}.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop);
end

for pos = 1:numel(STL_MASK)
    sSTL{pos} = STL_MASK{pos};
    sSTL{pos}.vertices(:,1) =  STL_MASK{pos}.vertices(:,2) - (m_ystart - 1);
    sSTL{pos}.vertices(:,2) =  STL_MASK{pos}.vertices(:,1) - (m_xstart - 1);
    sSTL{pos}.vertices(:,3) =  STL_MASK{pos}.vertices(:,3) - (m_zstart - 1);
end

% Get all possible magntudes
sMAG{1}.Volume = single( MAG.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop)); %TEMP
sMAG{1}.Name = 'PC-Magnitude';

% Setup volume to select
global extra_volumes;
if numel(extra_volumes) > 0 
    for pos = 1:numel(extra_volumes)
        sMAG{pos+1}.Volume = single( extra_volumes{pos}.vol.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop));
        sMAG{pos+1}.Name = extra_volumes{pos}.name;
    end
end
wss_gui(sMAG,sVELX,sVELY,sVELZ,sVELXt,sVELYt,sVELZt,sCD,sMASK,sSTL,delX,delY,delZ,tres);


function status_Callback(hObject, eventdata, handles)
% hObject    handle to status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of status as text
%        str2double(get(hObject,'String')) returns contents of status as a double


% --- Executes during object creation, after setting all properties.
function status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in status.
function listbox10_Callback(hObject, eventdata, handles)
% hObject    handle to status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns status contents as cell array
%        contents{get(hObject,'Value')} returns selected item from status


% --- Executes during object creation, after setting all properties.
function listbox10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function update_export_variables(handles)

global MASK;
cine_anatomy_flag = get(handles.cine_anatomy_checkbox,'Value');
global pressure_flag;
global grad_export_flag;
global mask_num;
global mask_names;
global PRESSURE;
global extra_volumes;

spos =1;
ss{1} = 'Magnitude'; spos=spos+1;
ss{2} = 'ComplexDifference';  spos=spos+1;
ss{3} = 'Velocity'; spos=spos+1;
ss{4} = 'AvgVelocity'; spos=spos+1;

if(numel(extra_volumes)>0)
      for pos = 1:numel(extra_volumes)
        ss{spos} = extra_volumes{pos}.name;
        spos =spos+1;
    end
end

if(numel(MASK,1)~=0)
    for pos = 1:mask_num
        ss{spos} = mask_names{pos};
        spos =spos+1;
    end
end

if cine_anatomy_flag==1
    ss{spos}= 'MagnitudeCINE'; spos = spos+1;
    ss{spos}= 'AngiogramCINE'; spos = spos+1;
end

if pressure_flag ==1
    for pos =1:numel(PRESSURE)
        ss{spos} = ['Pressure_Mask',num2str(pos)]; spos=spos+1;
    end
end

if grad_export_flag ==1
    ss{spos} = 'P_Gradient'; spos=spos+1;
end

set(handles.export_variable_list,'String',ss);




% --- Executes on button press in export_button.
function export_button_Callback(hObject, eventdata, handles)
% hObject    handle to export_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global phase_correction;
global poly_fitx;
global poly_fity;
global poly_fitz;
global exam;
global base_dir;

%Raw Data
global MAG;
global extra_volumes;
global ANGIO;
global MASK;
global VELX;
global VELY;
global VELZ;
global VELXt;
global VELYt;
global VELZt;
global MAGt;
global PRESSURE;
global plist;
global mask_num;
global mask_names;
global VENC;

%Masking parameters
global m_alpha;
global m_xstart;
global m_xstop;
global m_ystart;
global m_ystop;
global m_zstart;
global m_zstop;
global m_xlength;
global m_ylength;
global m_zlength;

%%%Data Acquisition Parameters
global tframes;
global tres;
global rcxres;
global rcyres;
global rczres;
global xfov;
global yfov;
global zfov;
global delX;
global delY;
global delZ;

%%Phantom Images
global P_VX;
global P_VY;
global P_VZ;
global P_MAG;

global GRADx;
global GRADy;
global GRADz;

m_xlength = m_xstop - m_xstart +1;
m_ylength = m_ystop - m_ystart +1;
m_zlength = m_zstop - m_zstart +1 ;


%Save Crop Values for Future Processing
par.startX = m_xstart;
par.startY = m_ystart;
par.startZ = m_zstart;
par.stopX = m_xstop;
par.stopY = m_ystop;
par.stopZ = m_zstop;
save(fullfile(base_dir,'crop_parameters.mat'),'par');


cine_anatomy_flag = get(handles.cine_anatomy_checkbox,'Value');
global pressure_flag;
grad_export_flag = 0;

%% --------------------------------------------------------
% parameters, need to be manually entered for each data set
% ---------------------------------------------------------
patientName     = ['Patient'];

numSlices      = m_zlength;   % number of slices / partitions
szy            = m_xlength;
szx            = m_ylength;

% update text output
outStr = ['Dicom --> EnSight, generating case & geo files ... '];
disp(outStr);
drawnow;

% create new directory for EnSight & matlab files
ensightDirPath  = fullfile(base_dir,sprintf('%s%s','EnSight_',patientName));
[s,mess,messid] = mkdir(ensightDirPath);

%%------------------------------------------------
% generate case file
% ------------------------------------------------
casePathName  = sprintf('%s%s%s','EnSight_',patientName,'.case');
geoPathName   = sprintf('%s%s%s','EnSight_',patientName,'.geo');
dataPathName  = sprintf('%s%s%s','EnSight_',patientName,'_');
geoFileName   = sprintf('EnSight_%s%s%',patientName,'.geo');
dataFileName  = sprintf('EnSight_%s%s%',patientName,'_');

% open text file an write data
fidCase  = fopen(fullfile(ensightDirPath,casePathName), 'wt');
fprintf(fidCase,'FORMAT\n');
fprintf(fidCase,'type:	 ensight gold\n');
fprintf(fidCase,'GEOMETRY\n');
fprintf(fidCase,'model:	 %s\n',geoFileName);
fprintf(fidCase,'VARIABLE\n');
fprintf(fidCase,'scalar per node:	 Magnitude	 %s.mag\n',dataFileName );
fprintf(fidCase,'scalar per node:	 Speed_SumSquares	 %s.cd\n',dataFileName );
fprintf(fidCase,'scalar per node:	 Speed_MeanAbsVel	 %s.cd\n',dataFileName );
fprintf(fidCase,'scalar per node:	 Speed_PseudoComplDiff	 %s.cd\n',dataFileName );

for pos =1:numel(extra_volumes)
    fprintf(fidCase,['scalar per node:	 ',extra_volumes{pos}.name,' %s.',extra_volumes{pos}.name,'\n'],dataFileName );
end

if(size(MASK,1)~=0)
    for pos = 1:mask_num
        fprintf(fidCase,'scalar per node:	 %s	 %s**.%s\n',mask_names{pos},dataFileName,mask_names{pos});
    end
end

if cine_anatomy_flag==1
    fprintf(fidCase,'scalar per node:	 MagnitudeCINE	 %s**.mag_cine\n',dataFileName );
    fprintf(fidCase,'scalar per node:	 AngiogramCINE	 %s**.cd_cine\n',dataFileName );
end

if pressure_flag ==1
    for pos=1:numel(PRESSURE)
        disp(pos);
        fprintf(fidCase,'scalar per node:	 Pressure%d  %s**.pressure%d\n',pos,dataFileName,pos);
    end
end

if grad_export_flag ==1
    fprintf(fidCase,'vector per node:	 P_Gradient	 %s**.pgrad\n',dataFileName );
end
fprintf(fidCase,'vector per node:	 Velocity	 %s**.vel\n',dataFileName );
fprintf(fidCase,'TIME\n');
fprintf(fidCase,'time set:		 1\n');
fprintf(fidCase,'number of steps:	 %s\n',num2str(tframes));
fprintf(fidCase,'filename start number:	 0\n');
fprintf(fidCase,'filename increment:	 1\n');
fprintf(fidCase,'time values:\n');
if tres==0
    fprintf(fidCase,'%4d\n',0);
else
    fprintf(fidCase,'%4d\n',(1:tframes)*round(tres*1000));
end
fclose(fidCase); % close file
% end generate case file


%%-------------------------------------------------
% generate geo file
% ------------------------------------------------
% open binary file an write data
fidGeo  = fopen(fullfile(ensightDirPath,geoPathName), 'w', 'ieee-be');
matSize = szx * szy;
part    = 1;

% generate and write header
geoheaderStr(1:8) = 'C Binary';
geoheaderStr(9:80) = ' ';
fwrite(fidGeo,geoheaderStr,'char');
geoheaderStr(1:21) = 'Ensight Geometry File';
geoheaderStr(22:80) = ' ';
fwrite(fidGeo,geoheaderStr,'char');
geoheaderStr(1:44) = 'Created by MATLAB routine, (c) M. Markl 2006';
geoheaderStr(45:80) = ' ';
fwrite(fidGeo,geoheaderStr,'char');
geoheaderStr(1:14) = 'node id assign';
geoheaderStr(15:80) = ' ';
fwrite(fidGeo,geoheaderStr,'char');
geoheaderStr(1:17) = 'element id assign';
geoheaderStr(18:80) = ' ';
fwrite(fidGeo,geoheaderStr,'char');
geoheaderStr(1:4) = 'part';
geoheaderStr(5:80) = ' ';
fwrite(fidGeo,geoheaderStr,'char');
fwrite(fidGeo,part,'int');
geoheaderStr(1:12) = 'Total Volume';
geoheaderStr(13:80) = ' ';
fwrite(fidGeo,geoheaderStr,'char');
geoheaderStr(1:5) = 'block';
geoheaderStr(6:80) = ' ';
fwrite(fidGeo,geoheaderStr,'char');

%%KMJ Swap x/y
fwrite(fidGeo,szy,'int');
fwrite(fidGeo,szx,'int');
fwrite(fidGeo,numSlices,'int');

% needed for coordiante definition (KMJ New)
[Xcor Ycor Zcor] = meshgrid( (0:m_ylength-1)*delX,(0:m_xlength-1)*delY,(0:m_zlength-1)*delZ);  %position in mm

fwrite(fidGeo,Xcor,'float'); % x-coordinate
fwrite(fidGeo,Ycor,'float'); % y-coordinate
fwrite(fidGeo,Zcor,'float'); % z-coordinate
fclose(fidGeo); % close geo file
% end generate geo file

clear Xcor;
clear Ycor;
clear Zcor;

%----------------------------------------------------------------------
%  Write out files
%----------------------------------------------------------------------

if phase_correction==1
    xrange = single( linspace(-1,1,size(VELX.Data.vals,1)) );
    yrange = single( linspace(-1,1,size(VELY.Data.vals,2)) );
    zrange = single( linspace(-1,1,size(VELZ.Data.vals,3)) );
    [y,x,z] = meshgrid( yrange(m_ystart:m_ystop),xrange(m_xstart:m_xstop),zrange(m_zstart:m_zstop));
end


for phase = 1:tframes
    
    % update text output
    outStr = ['  Generating EnSight data files , phase ',num2str(phase),' ...'];
    if phase==1
        log_message(handles,outStr)
    else
        update_log_message(handles,outStr)
    end
    
    part         = 1;
    
    geoheaderStr(1:5) = 'block';
    geoheaderStr(6:80) = ' ';
    
    % generate data files
    % ------------------------------------------------
    % open binary file an write data
    if phase==1
        MagFileName = sprintf('%s%s',dataPathName,'.mag')
        MagFullFileName = fullfile(ensightDirPath,MagFileName)
        fidMag       = fopen(MagFullFileName, 'w', 'ieee-be');
        [dummy szStr]= size(sprintf('%s%s','Magnitude, time ',num2str(phase-1)));
        dataheaderStr(1:szStr) = sprintf('%s%s','Magnitude, time ',num2str(phase-1));
        dataheaderStr(szStr+1:80) = ' ';
        fwrite(fidMag,dataheaderStr,'char');
        dataheaderStr(1:4) = 'part';
        dataheaderStr(5:80) = ' ';
        fwrite(fidMag,dataheaderStr,'char');
        fwrite(fidMag,part,'int');
        fwrite(fidMag,geoheaderStr,'char');
        TEMP = single( MAG.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop)); %TEMP
        fwrite(fidMag,TEMP(:),'float');
        fclose(fidMag);
    end
    
    if phase==1
        for pos =1 :numel(extra_volumes)
            MagFileName = sprintf('%s%s',dataPathName,'.',extra_volumes{pos}.name)
            MagFullFileName = fullfile(ensightDirPath,MagFileName)
            fidMag       = fopen(MagFullFileName, 'w', 'ieee-be');
            [dummy szStr]= size(sprintf('%s%s',extra_volumes{pos}.name,', time ',num2str(phase-1)));
            dataheaderStr(1:szStr) = sprintf('%s%s',extra_volumes{pos}.name,', time ',num2str(phase-1));
            dataheaderStr(szStr+1:80) = ' ';
            fwrite(fidMag,dataheaderStr,'char');
            dataheaderStr(1:4) = 'part';
            dataheaderStr(5:80) = ' ';
            fwrite(fidMag,dataheaderStr,'char');
            fwrite(fidMag,part,'int');
            fwrite(fidMag,geoheaderStr,'char');
            TEMP = single( extra_volumes{pos}.vol.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop)); %TEMP
            fwrite(fidMag,TEMP(:),'float');
            fclose(fidMag);
        end
    end
    
    
    if phase==1
        CDFileName = sprintf('%s%s',dataPathName,'.cd')
        CDFullFileName = fullfile(ensightDirPath,CDFileName)
        fidCD        = fopen(CDFullFileName, 'w', 'ieee-be');
        [dummy szStr]= size(sprintf('%s%s','ComplexDifference, time ',num2str(phase-1)));
        dataheaderStr(1:szStr) = sprintf('%s%s','ComplexDifference, time ',num2str(phase-1));
        dataheaderStr(szStr+1:80) = ' ';
        fwrite(fidCD,dataheaderStr,'char');
        dataheaderStr(1:4) = 'part';
        dataheaderStr(5:80) = ' ';
        fwrite(fidCD,dataheaderStr,'char');
        fwrite(fidCD,part,'int');
        fwrite(fidCD,geoheaderStr,'char');
        TEMP = single( ANGIO(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop));
        fwrite(fidCD,TEMP(:),'float');
        fclose(fidCD);
    end
    
    if phase==1
        
        FlowFileName = sprintf('%s.avgvel',dataPathName);
        FlowFullFileName = fullfile(ensightDirPath,FlowFileName);
        fidFlow      = fopen(FlowFullFileName, 'w', 'ieee-be');
        [dummy szStr]= size(sprintf('%s%s','AvgVelocity, time ',num2str(phase-1)));
        dataheaderStr(1:szStr) = sprintf('%s%s','AvgVelocity, time ',num2str(phase-1));
        dataheaderStr(szStr+1:80) = ' ';
        fwrite(fidFlow,dataheaderStr,'char');
        dataheaderStr(1:4) = 'part';
        dataheaderStr(5:80) = ' ';
        fwrite(fidFlow,dataheaderStr,'char');
        fwrite(fidFlow,part,'int');
        fwrite(fidFlow,geoheaderStr,'char');
        
        TEMP= single(VELY.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop));
        if phase_correction==1
            TEMP = TEMP - evaluate_poly(x,y,z,poly_fity);
        end
        fwrite(fidFlow,-TEMP/1000,'float');
        
        TEMP= single(VELX.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop));
        if phase_correction==1
            TEMP = TEMP - evaluate_poly(x,y,z,poly_fitx);
        end
        fwrite(fidFlow,-TEMP /1000,'float');
        
        TEMP= single(VELZ.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop));
        if phase_correction ==1
            TEMP = TEMP - evaluate_poly(x,y,z,poly_fitz);
        end
        fwrite(fidFlow,-TEMP /1000,'float');
        fclose(fidFlow);
    end
    
    
    FlowFileName = sprintf('%s%02d.vel',dataPathName,phase-1);
    FlowFullFileName = fullfile(ensightDirPath,FlowFileName);
    fidFlow      = fopen(FlowFullFileName, 'w', 'ieee-be');
    [dummy szStr]= size(sprintf('%s%s','Velocity, time ',num2str(phase-1)));
    dataheaderStr(1:szStr) = sprintf('%s%s','Velocity, time ',num2str(phase-1));
    dataheaderStr(szStr+1:80) = ' ';
    fwrite(fidFlow,dataheaderStr,'char');
    dataheaderStr(1:4) = 'part';
    dataheaderStr(5:80) = ' ';
    fwrite(fidFlow,dataheaderStr,'char');
    fwrite(fidFlow,part,'int');
    fwrite(fidFlow,geoheaderStr,'char');
    
    
    %% Vd 1
    TEMP=single(VELYt{phase}.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop));
    if phase_correction==1
        TEMP = TEMP - evaluate_poly(x,y,z,poly_fity);
    end
    if cine_anatomy_flag == 1;
        VMAG = TEMP.^2;
    end
    fwrite(fidFlow,-TEMP/1000,'float');
    
    %% Vd 2
    TEMP=single(VELXt{phase}.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop));
    if phase_correction==1
        TEMP = TEMP - evaluate_poly(x,y,z,poly_fitx);
    end
    if cine_anatomy_flag == 1;
        VMAG = VMAG + TEMP.^2;
    end
    fwrite(fidFlow,-TEMP/1000,'float');
    
    %% Vd 3
    TEMP=single(VELZt{phase}.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop));
    if phase_correction ==1
        TEMP = TEMP - evaluate_poly(x,y,z,poly_fitz);
    end
    if cine_anatomy_flag == 1;
        VMAG = sqrt(VMAG + TEMP.^2);
    end
    fwrite(fidFlow,-TEMP/1000,'float');
    fclose(fidFlow);
    
    if(size(MASK,1)~=0)
        
        for pos = 1:mask_num
            MaskFileName = sprintf('%s%02d.%s',dataPathName,phase-1,mask_names{pos});
            MaskFullFileName = fullfile(ensightDirPath,MaskFileName);
            
            fidMask       = fopen(MaskFullFileName, 'w', 'ieee-be');
            [dummy szStr]= size(sprintf('%s%s','Mask, time ',num2str(phase-1)));
            dataheaderStr(1:szStr) = sprintf('%s%s','Mask, time ',num2str(phase-1));
            dataheaderStr(szStr+1:80) = ' ';
            fwrite(fidMask,dataheaderStr,'char');
            dataheaderStr(1:4) = 'part';
            dataheaderStr(5:80) = ' ';
            fwrite(fidMask,dataheaderStr,'char');
            fwrite(fidMask,part,'int');
            fwrite(fidMask,geoheaderStr,'char');
            TEMP = single(MASK(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop,pos));
            fwrite(fidMask,TEMP,'float');
            fclose(fidMask);
        end
    end
    
    if pressure_flag==1
        
        for pos=1:numel(PRESSURE)
            PressureFileName = sprintf('%s%02d.pressure%d',dataPathName,phase-1,pos);
            PressureFullFileName = fullfile(ensightDirPath,PressureFileName);
            
            fidPressure  = fopen(PressureFullFileName, 'w', 'ieee-be');
            
            [dummy szStr]= size(sprintf('%s%s','Pressure%d, time ',num2str(phase-1),pos));
            dataheaderStr(1:szStr) = sprintf('%s%s','Pressure%d, time ',num2str(phase-1),pos);
            dataheaderStr(szStr+1:80) = ' ';
            fwrite(fidPressure,dataheaderStr,'char');
            dataheaderStr(1:4) = 'part';
            dataheaderStr(5:80) = ' ';
            fwrite(fidPressure,dataheaderStr,'char');
            fwrite(fidPressure,part,'int');
            fwrite(fidPressure,geoheaderStr,'char');
            
            TEMP = single(zeros(size(ANGIO)));
            TEMP( PRESSURE{pos}.plist) = 0.007501*PRESSURE{pos}.vals(:,phase);
            TEMP = TEMP( m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop );
            % write pressure (mmHg)
            fwrite(fidPressure,TEMP(:),'float');
            fclose(fidPressure);
        end
        
    end
    
    if grad_export_flag==1
        dataPathPGrad= (sprintf('%s%s%s',dataPathName,num2str(phase-1,'%02d'),'.pgrad'));
        fidPGrad  = fopen(dataPathPGrad, 'w', 'ieee-be');
        [dummy szStr]= size(sprintf('%s%s','P_Gradient, time ',num2str(phase-1)));
        dataheaderStr(1:szStr) = sprintf('%s%s','P_Gradient, time ',num2str(phase-1));
        dataheaderStr(szStr+1:80) = ' ';
        fwrite(fidPGrad,dataheaderStr,'char');
        dataheaderStr(1:4) = 'part';
        dataheaderStr(5:80) = ' ';
        fwrite(fidPGrad,dataheaderStr,'char');
        fwrite(fidPGrad,part,'int');
        fwrite(fidPGrad,geoheaderStr,'char');
        
        imagePress = zeros(size(sCD));
        imagePress(plist) = -GRADy(:,phase);
        fwrite(fidPGrad,imagePress(:),'float');
        
        imagePress = zeros(size(sCD));
        imagePress(plist) = -GRADx(:,phase);
        fwrite(fidPGrad,imagePress(:),'float');
        
        imagePress = zeros(size(sCD));
        imagePress(plist) = -GRADz(:,phase);
        fwrite(fidPGrad,imagePress(:),'float');
        
        clear imagePress;
        
    end
    
    if cine_anatomy_flag==1
        CineMagFileName = sprintf('%s%02d.mag_cine',dataPathName,phase-1);
        CineMagFullFileName = fullfile(ensightDirPath,CineMagFileName);
        fidMagCine       = fopen(CineMagFullFileName, 'w', 'ieee-be');
        [dummy szStr]= size(sprintf('%s%s','MagnitudeCINE, time ',num2str(phase-1)));
        dataheaderStr(1:szStr) = sprintf('%s%s','MagnitudeCINE, time ',num2str(phase-1));
        dataheaderStr(szStr+1:80) = ' ';
        fwrite(fidMagCine,dataheaderStr,'char');
        dataheaderStr(1:4) = 'part';
        dataheaderStr(5:80) = ' ';
        fwrite(fidMagCine,dataheaderStr,'char');
        fwrite(fidMagCine,part,'int');
        fwrite(fidMagCine,geoheaderStr,'char');
        TEMP=single(MAGt{phase}.Data.vals(m_xstart:m_xstop,m_ystart:m_ystop,m_zstart:m_zstop));
        fwrite(fidMagCine,TEMP,'float');
        
        
        CineAngioFileName = sprintf('%s%02d.cd_cine',dataPathName,phase-1);
        CineAngioFullFileName = fullfile(ensightDirPath,CineAngioFileName);
        fidAngioCine       = fopen(CineAngioFullFileName, 'w', 'ieee-be');
        [dummy szStr]= size(sprintf('%s%s','AngioCINE, time ',num2str(phase-1)));
        dataheaderStr(1:szStr) = sprintf('%s%s','AngioCINE, time ',num2str(phase-1));
        dataheaderStr(szStr+1:80) = ' ';
        fwrite(fidAngioCine,dataheaderStr,'char');
        dataheaderStr(1:4) = 'part';
        dataheaderStr(5:80) = ' ';
        fwrite(fidAngioCine,dataheaderStr,'char');
        fwrite(fidAngioCine,part,'int');
        fwrite(fidAngioCine,geoheaderStr,'char');
        idx = VMAG > VENC;
        VMAG(idx) = VENC;
        TEMP = TEMP.*sin( pi/2 * VMAG / VENC);
        fwrite(fidAngioCine,TEMP,'float');
    end
    fclose('all');
    
end; % end phase loop
log_message(handles,'Done.');


% --- Executes on selection change in export_variable_list.
function export_variable_list_Callback(hObject, eventdata, handles)
% hObject    handle to export_variable_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns export_variable_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from export_variable_list


% --- Executes during object creation, after setting all properties.
function export_variable_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to export_variable_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in show_in_folder_button.
function show_in_folder_button_Callback(hObject, eventdata, handles)
% hObject    handle to show_in_folder_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    global base_dir;
    eval(['!explorer ',fullfile(base_dir,'Ensight_Patient')]);
catch
    disp('Windows ONLY');
end




% --- Executes on button press in add_volume_button.
function add_volume_button_Callback(hObject, eventdata, handles)
% hObject    handle to add_volume_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handl

global extra_volumes;
global rcxres;
global rcyres;
global rczres;

[name path] = uigetfile( ...
    {  '*.dat','Volumes (*.dat)'; ...
    '*.*',  'All Files (*.*)'}, ...
    'Select Additional Volumes', ...
    'MultiSelect', 'on');

extra_volumes = [];
if iscell(name)
    for ii = 1:size(name,2)
        disp(['Load ', name{ii}]);
        extra_volumes{ii}.name = name{ii};
        extra_volumes{ii}.vol  = memmapfile(fullfile(path,name{ii}),'Format',{'single',[rcxres rcyres rczres],'vals'});
    end
else
    disp(['Load ', name]);
    extra_volumes{1}.name = name;
    extra_volumes{1}.vol  = memmapfile(fullfile(path,name),'Format',{'single',[rcxres rcyres rczres],'vals'});
    
end

update_export_variables(handles);


