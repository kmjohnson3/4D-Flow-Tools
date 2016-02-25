function varargout = options_gui(varargin)
% OPTIONS_GUI M-file for options_gui.fig
%      OPTIONS_GUI, by itself, creates a new OPTIONS_GUI or raises the existing
%      singleton*.
%
%      H = OPTIONS_GUI returns the handle to a new OPTIONS_GUI or the handle to
%      the existing singleton*.
%
%      OPTIONS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPTIONS_GUI.M with the given input arguments.
%
%      OPTIONS_GUI('Property','Value',...) creates a new OPTIONS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before options_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to options_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help options_gui

% Last Modified by GUIDE v2.5 17-Apr-2007 15:07:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @options_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @options_gui_OutputFcn, ...
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


% --- Executes just before options_gui is made visible.
function options_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to options_gui (see VARARGIN)

% Choose default command line output for options_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes options_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = options_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pressure_flag.
function pressure_flag_Callback(hObject, eventdata, handles)
% hObject    handle to pressure_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pressure_flag

global pressure_flag;
pressure_flag = (get(handles.pressure_flag,'Value'));


% --- Executes on button press in wss_flag.
function wss_flag_Callback(hObject, eventdata, handles)
% hObject    handle to wss_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of wss_flag
global wss_flag;
wss_flag = (get(handles.wss_flag,'Value'));



% --- Executes on button press in visual_flag.
function visual_flag_Callback(hObject, eventdata, handles)
% hObject    handle to visual_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of visual_flag
global visual_flag;
visual_flag = (get(handles.visual_flag,'Value'));


% --- Executes on button press in flow_flag.
function flow_flag_Callback(hObject, eventdata, handles)
% hObject    handle to flow_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of flow_flag
global flow_flag;
flow_flag = (get(handles.flow_flag,'Value'));



% --- Executes on button press in save_flag.
function save_flag_Callback(hObject, eventdata, handles)
% hObject    handle to save_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of save_flag
global save_flag;
save_flag = (get(handles.save_flag,'Value'));



