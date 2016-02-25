function varargout = twod_visual_gui(varargin)
% TWOD_VISUAL_GUI M-file for twod_visual_gui.fig
%      TWOD_VISUAL_GUI, by itself, creates a new TWOD_VISUAL_GUI or raises the existing
%      singleton*.
%
%      H = TWOD_VISUAL_GUI returns the handle to a new TWOD_VISUAL_GUI or the handle to
%      the existing singleton*.
%
%      TWOD_VISUAL_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWOD_VISUAL_GUI.M with the given input arguments.
%
%      TWOD_VISUAL_GUI('Property','Value',...) creates a new TWOD_VISUAL_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before twod_visual_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to twod_visual_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help twod_visual_gui

% Last Modified by GUIDE v2.5 01-May-2007 16:34:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @twod_visual_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @twod_visual_gui_OutputFcn, ...
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


% --- Executes just before twod_visual_gui is made visible.
function twod_visual_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to twod_visual_gui (see VARARGIN)

% Choose default command line output for twod_visual_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes twod_visual_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global old_mip_type;
old_mip_type =0;


% --- Outputs from this function are returned to the command line.
function varargout = twod_visual_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in update_image.
function update_image_Callback(hObject, eventdata, handles)
% hObject    handle to update_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_images(handles);




function update_images(handles)

warning off

global sMAG;
global sCD;
global sMASK;
global vis_axis;
global vis_alpha;
global vis_thresh;
global VELX;
global VELY;
global VELZ;
global m_xlength;
global m_ylength;
global m_zlength;
global XPTS;
global YPTS;
global ZPTS;

global xslice;
global yslice;
global zslice;

global mipx_cd;
global mipy_cd;
global mipz_cd;

global mipx_mag;
global mipy_mag;
global mipz_mag;

global mipx_velx;
global mipy_velx;
global mipz_velx;

global mipx_vely;
global mipy_vely;
global mipz_vely;

global mipx_velz;
global mipy_velz;
global mipz_velz;

global old_mip_type;

image_type = get(handles.image_type,'Value');
%%%VISUAL METHOD DECODING
%   1 = velocity wheel
%   2 = mip CD
%   3 = mip MAG

mip_dir = get(handles.mip_dir,'Value');
%%%MIP DIRECTION 
% 1 = X
% 2 = Y
% 3 = Z

vel_dir = get(handles.vel_dir,'Value');
%%%MIP DIRECTION 
% 1 = X + Y
% 2 = Y + Z
% 3 = Z + X

max_vel = str2double(get(handles.max_vel,'String'));

mip_type = get(handles.mip_type,'Value');
% 1 = masked average
% 2 = max cd point

new_fig = ishandle(vis_axis);
figure(vis_axis);
clf;

if image_type == 1 %Velocity wheel
    MAP = hsv(2000);
        
    if( (mip_type==1) & (  (old_mip_type ~= mip_type) | (size(mipx_velx == 0) ) ) ) %average with mask
        mipx_velx=  reshape(sum(sMASK.*VELX,1)./sum(sMASK,1),[m_ylength m_zlength]);         
        mipy_velx = reshape(sum(sMASK.*VELX,2)./sum(sMASK,2),[m_xlength m_zlength]);
        mipz_velx = reshape(sum(sMASK.*VELX,3)./sum(sMASK,3),[m_xlength m_ylength]);
        
        mipx_vely=  reshape(sum(sMASK.*VELY,1)./sum(sMASK,1),[m_ylength m_zlength]);         
        mipy_vely = reshape(sum(sMASK.*VELY,2)./sum(sMASK,2),[m_xlength m_zlength]);
        mipz_vely = reshape(sum(sMASK.*VELY,3)./sum(sMASK,3),[m_xlength m_ylength]);
        
        mipx_velz=  reshape(sum(sMASK.*VELZ,1)./sum(sMASK,1),[m_ylength m_zlength]);         
        mipy_velz = reshape(sum(sMASK.*VELZ,2)./sum(sMASK,2),[m_xlength m_zlength]);
        mipz_velz = reshape(sum(sMASK.*VELZ,3)./sum(sMASK,3),[m_xlength m_ylength]);
    elseif( (mip_type==2) & (  (old_mip_type ~= mip_type) | (size(mipx_velx == 0) ) ) )%average with mask 
        
        [CX IX] =  max(sCD,[],1);
        [CY IY] =  max(sCD,[],2);
        [CZ IZ] =  max(sCD,[],3);
                
        IX = reshape( IX, [m_ylength m_zlength]) ;
        IY = reshape( IY, [m_xlength m_zlength]) ;
        IZ = reshape( IZ, [m_xlength m_ylength]) ;
        
        for ii=1:m_xlength
         for jj=1:m_ylength
             mipz_velz(ii,jj) = VELZ(ii,jj,IZ(ii,jj))*(0.15 < sMAG(ii,jj,IZ(ii,jj)));
             mipz_vely(ii,jj) = VELY(ii,jj,IZ(ii,jj))*(0.15 < sMAG(ii,jj,IZ(ii,jj)));
             mipz_velx(ii,jj) = VELX(ii,jj,IZ(ii,jj))*(0.15 < sMAG(ii,jj,IZ(ii,jj)));
         end
        end
        
        for ii=1:m_xlength
         for jj=1:m_zlength
             mipy_velz(ii,jj) = VELZ(ii,IY(ii,jj),jj)*(0.15 < sMAG(ii,IY(ii,jj),jj));
             mipy_vely(ii,jj) = VELY(ii,IY(ii,jj),jj)*(0.15 < sMAG(ii,IY(ii,jj),jj));
             mipy_velx(ii,jj) = VELX(ii,IY(ii,jj),jj)*(0.15 < sMAG(ii,IY(ii,jj),jj));
         end
        end
        
        for ii=1:m_ylength
         for jj=1:m_zlength
             mipx_velz(ii,jj) = VELZ(IX(ii,jj),ii,jj)*(0.15 < sMAG(IX(ii,jj),ii,jj));
             mipx_vely(ii,jj) = VELY(IX(ii,jj),ii,jj)*(0.15 < sMAG(IX(ii,jj),ii,jj));
             mipx_velx(ii,jj) = VELX(IX(ii,jj),ii,jj)*(0.15 < sMAG(IX(ii,jj),ii,jj));
         end
        end
        
    elseif( (mip_type==3) & (  (old_mip_type ~= mip_type) | (size(mipx_velx == 0) ) ) )%average with mask 

        [CX IX] =  max(sCD,[],1);
        [CY IY] =  max(sCD,[],2);
        [CZ IZ] =  max(sCD,[],3);
                
        IX = reshape( IX, [m_ylength m_zlength]) ;
        IY = reshape( IY, [m_xlength m_zlength]) ;
        IZ = reshape( IZ, [m_xlength m_ylength]) ;
        
        for ii=1:m_xlength
         for jj=1:m_ylength
             mipz_velz(ii,jj) = VELZ(ii,jj,IZ(ii,jj))*sMASK(ii,jj,IZ(ii,jj));
             mipz_vely(ii,jj) = VELY(ii,jj,IZ(ii,jj))*sMASK(ii,jj,IZ(ii,jj));
             mipz_velx(ii,jj) = VELX(ii,jj,IZ(ii,jj))*sMASK(ii,jj,IZ(ii,jj));
         end
        end
        
        for ii=1:m_xlength
         for jj=1:m_zlength
             mipy_velz(ii,jj) = VELZ(ii,IY(ii,jj),jj)*(sMASK(ii,IY(ii,jj),jj));
             mipy_vely(ii,jj) = VELY(ii,IY(ii,jj),jj)*(sMASK(ii,IY(ii,jj),jj));
             mipy_velx(ii,jj) = VELX(ii,IY(ii,jj),jj)*(sMASK(ii,IY(ii,jj),jj));
         end
        end
        
        for ii=1:m_ylength
         for jj=1:m_zlength
             mipx_velz(ii,jj) = VELZ(IX(ii,jj),ii,jj)*(sMASK(IX(ii,jj),ii,jj));
             mipx_vely(ii,jj) = VELY(IX(ii,jj),ii,jj)*(sMASK(IX(ii,jj),ii,jj));
             mipx_velx(ii,jj) = VELX(IX(ii,jj),ii,jj)*(sMASK(IX(ii,jj),ii,jj));
         end
        end
    end
    old_mip_type = mip_type;
    
        
    if mip_dir == 1
        if vel_dir==1 
            vtemp = mipx_velx + i*mipx_vely;
        elseif vel_dir == 2
            vtemp = mipx_vely + i*mipx_velz;
        elseif vel_dir ==3
            vtemp = mipx_velz + i*mipx_velx;
        elseif vel_dir == 4
            vtemp = mipx_velx;
        elseif vel_dir == 5
            vtemp = mipx_vely;
        else
            vtemp = mipx_velz;
        end


    elseif mip_dir ==2
        if vel_dir==1 
            vtemp = mipy_velx + i*mipy_vely;
        elseif vel_dir == 2
            vtemp = mipy_vely + i*mipy_velz;
        elseif vel_dir == 3
            vtemp = mipy_velz + i*mipy_velx;
        elseif vel_dir == 4
            vtemp = mipy_velx;
        elseif vel_dir == 5
            vtemp = mipy_vely;
        else
            vtemp = mipy_velz;
        end
        
        
    else
        if vel_dir==1 
            vtemp = mipz_velx + i*mipz_vely;
        elseif vel_dir == 2
            vtemp = mipz_vely + i*mipz_velz;
        elseif vel_dir == 3
            vtemp = mipz_velz + i*mipz_velx;
        elseif vel_dir == 4
            vtemp = mipz_velx;
        elseif vel_dir == 5
            vtemp = mipz_vely;
        else
            vtemp = mipz_velz;
        end
        
    end
    
    theta = angle(vtemp);
    rad   = abs(vtemp)/max_vel/10;;
    DIM = size(rad);

    imv=zeros(DIM(1),DIM(2),3);
    for ii=1:DIM(1)
     for jj=1:DIM(2)
       if rad(ii,jj) >= 1.0
        imv(ii,jj,:)=            MAP( 1001 + floor(999*theta(ii,jj)/pi),:);
       elseif rad(ii,jj) < 1.0 
        imv(ii,jj,:)= rad(ii,jj)*MAP( 1001 + floor(999*theta(ii,jj)/pi),:);
       else
        imv(ii,jj,:)=0;
       end
      end
    end
    image(imv);
    
elseif image_type == 2 %CD

    if ( size(mipx_cd)==0)
        mipx_cd = reshape(max(sCD,[],1),[m_ylength m_zlength]);
        mipy_cd = reshape(max(sCD,[],2),[m_xlength m_zlength]);
        mipz_cd = reshape(max(sCD,[],3),[m_xlength m_ylength]);
    end

    if mip_dir == 1
        im = mipx_cd;
    elseif mip_dir ==2
        im = mipy_cd;
    else
        im = mipz_cd;
    end
    colormap('gray');
    imagesc(im);
elseif image_type == 3 %mag

    if ( size(mipx_mag)==0)
        mipx_mag = reshape(max(sMAG,[],1),[m_ylength m_zlength]);
        mipy_mag = reshape(max(sMAG,[],2),[m_xlength m_zlength]);
        mipz_mag = reshape(max(sMAG,[],3),[m_xlength m_ylength]);
    end

    if mip_dir == 1
        im = mipx_mag;
    elseif mip_dir ==2
        im = mipy_mag;
    else
        im = mipz_mag;
    end
    colormap('gray');
    imagesc(im);
end






set(gca,'color','black');
set(gcf,'color','black');
daspect([1 1 1])






% --- Executes on button press in save_image.
function save_image_Callback(hObject, eventdata, handles)
% hObject    handle to save_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global vis_axis;
figure(vis_axis);
set(gcf,'InvertHardCopy','off');
fname = get(handles.save_name,'String');
%print('-opengl','-f1','-r150','-djpeg100',fname);
print('-opengl','-f1','-dbmp',fname);

% --- Executes on selection change in image_type.
function image_type_Callback(hObject, eventdata, handles)
% hObject    handle to image_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns image_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from image_type

update_images(handles);


% --- Executes during object creation, after setting all properties.
function image_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in vel_dir.
function vel_dir_Callback(hObject, eventdata, handles)
% hObject    handle to vel_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns vel_dir contents as cell array
%        contents{get(hObject,'Value')} returns selected item from vel_dir

update_images(handles);


% --- Executes during object creation, after setting all properties.
function vel_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vel_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mip_dir.
function mip_dir_Callback(hObject, eventdata, handles)
% hObject    handle to mip_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns mip_dir contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mip_dir

update_images(handles);

% --- Executes during object creation, after setting all properties.
function mip_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mip_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function max_vel_Callback(hObject, eventdata, handles)
% hObject    handle to max_vel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_vel as text
%        str2double(get(hObject,'String')) returns contents of max_vel as a double


% --- Executes during object creation, after setting all properties.
function max_vel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_vel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in mip_type.
function mip_type_Callback(hObject, eventdata, handles)
% hObject    handle to mip_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns mip_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mip_type
update_images(handles);


% --- Executes during object creation, after setting all properties.
function mip_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mip_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function save_name_Callback(hObject, eventdata, handles)
% hObject    handle to save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of save_name as text
%        str2double(get(hObject,'String')) returns contents of save_name as a double


% --- Executes during object creation, after setting all properties.
function save_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


