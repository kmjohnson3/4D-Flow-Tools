function varargout = wss_gui(varargin)
% WSS_GUI M-file for wss_gui.fig
%      WSS_GUI, by itself, creates a new WSS_GUI or raises the existing
%      singleton*.
%
%      H = WSS_GUI returns the handle to a new WSS_GUI or the handle to
%      the existing singleton*.
%
%      WSS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WSS_GUI.M with the given input arguments.
%
%      WSS_GUI('Property','Value',...) creates a new WSS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before wss_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to wss_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help wss_gui

% Last Modified by GUIDE v2.5 14-Mar-2008 14:35:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @wss_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @wss_gui_OutputFcn, ...
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


% --- Executes just before wss_gui is made visible.
function wss_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to wss_gui (see VARARGIN)

% Choose default command line output for wss_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes wss_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = wss_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in mask_update.
function mask_update_Callback(hObject, eventdata, handles)
% hObject    handle to mask_update (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_mask(handles);


function update_mask(handles)

global sMAG;
global sCD;
global sMASK;
global vis_axis;
global vis_alpha;
global wss_axis;
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

global verts;
global norms;
global norm_handle;
global hpatch;

mask_type = get(handles.mask_type,'Value');
%%%VISUAL METHOD DECODING
%   1 = CD
%   2 = MAG

vis_thresh = str2double(get(handles.lumen_thresh,'String'));

new_fig = ishandle(wss_axis);
figure(wss_axis);

if new_fig == 1
    cmpos = campos;
    cmva  = camva;
    zoom reset 
end  

set(gca,'CameraPositionMode','manual');
set(gca,'CameraTargetMode','manual');
set(gca,'CameraUpVectorMode','manual');
set(gca,'CameraViewAngleMode','manual');
clf;

if mask_type == 1
    hpatch = patch(isosurface(sCD,vis_thresh));
else
    hpatch = patch(isosurface(sMAG,vis_thresh));
end
colormap('jet');
reducepatch(hpatch,0.4);
set(hpatch,'FaceColor','red','EdgeColor', 'none');
isonormals(sCD,hpatch)

camlight right; 
lighting gouraud
alpha(0.9)
set(vis_axis, 'Renderer','OpenGL')
set(vis_axis, 'RendererMode','Manual');
set(gca,'color','black');
set(gcf,'color','black');
daspect([1 1 1])

if new_fig ==1
    campos([cmpos]);
    camva([cmva]);
end

if(new_fig==0)

view([-1 -1 0]);
zoom(0.8);
xlim([1 (m_ylength)]);
ylim([1 (m_xlength)]);
zlim([1 (m_zlength)]);
scrsz = get(0,'ScreenSize');
SIZE=[(scrsz(3)*1/2-64) scrsz(4)*1/4 scrsz(3)*1/2 scrsz(4)*1/2];
set(gcf,'Position',SIZE);
set(gcf,'Name','WSS Window');
end

hold on
axis equal tight off vis3d;
% norms = (get(hpatch,'VertexNormals'));
% verts = (get(hpatch,'Vertices'));
% 
% scl = 15
% norm_handle = plot3( [verts(:,1)  verts(:,1) + scl*norms(:,1)]',[verts(:,2) verts(:,2)+scl*norms(:,2)]',[verts(:,3)  verts(:,3) + scl*norms(:,3)]','b','LineWidth',2)

function lumen_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to lumen_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lumen_thresh as text
%        str2double(get(hObject,'String')) returns contents of lumen_thresh as a double


% --- Executes during object creation, after setting all properties.
function lumen_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lumen_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mask_type.
function mask_type_Callback(hObject, eventdata, handles)
% hObject    handle to mask_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns mask_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mask_type


% --- Executes during object creation, after setting all properties.
function mask_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mask_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in normal_type.
function normal_type_Callback(hObject, eventdata, handles)
% hObject    handle to normal_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns normal_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from normal_type


% --- Executes during object creation, after setting all properties.
function normal_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to normal_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in normal_plot_type.
function normal_plot_type_Callback(hObject, eventdata, handles)
% hObject    handle to normal_plot_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns normal_plot_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from normal_plot_type


% --- Executes during object creation, after setting all properties.
function normal_plot_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to normal_plot_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_norms(handles);


function update_norms(handles) 

global sMAG;
global sCD;
global sMASK;
global vis_axis;
global vis_alpha;
global wss_axis;
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

global verts;
global norms;
global norm_handle;
global norm_mag_handle;
global norm_cd_handle;


global hpatch;

normal_type = get(handles.normal_type,'Value');
%%%VISUAL METHOD DECODING
%   3 = base on vector
%   1 = base on data mag
%   2 = base on data cd 
norm_plot_type= get(handles.normal_plot_type,'Value');


new_fig = ishandle(wss_axis);
figure(wss_axis);

if normal_type == 2
    isonormals(sMAG,hpatch)
elseif normal_type == 1
    isonormals(sCD,hpatch)
end
    
norms = (get(hpatch,'VertexNormals'));
verts = (get(hpatch,'Vertices'));

scl = 15;
if norm_plot_type == 1
   if ishandle(norm_handle) delete(norm_handle); end
elseif norm_plot_type ==2 
   if ishandle(norm_handle) delete(norm_handle); end
   norm_handle = plot3( [verts(:,1)  verts(:,1) + scl*norms(:,1)]',[verts(:,2) verts(:,2)+scl*norms(:,2)]',[verts(:,3)  verts(:,3) + scl*norms(:,3)]','b','LineWidth',1.5);
elseif norm_plot_type == 3;    
    if normal_type == 2
        norm_handle = plot3( [verts(:,1)  verts(:,1) + scl*norms(:,1)]',[verts(:,2) verts(:,2)+scl*norms(:,2)]',[verts(:,3)  verts(:,3) + scl*norms(:,3)]','b','LineWidth',1.5);
    elseif normal_type ==3
        norm_handle = plot3( [verts(:,1)  verts(:,1) + scl*norms(:,1)]',[verts(:,2) verts(:,2)+scl*norms(:,2)]',[verts(:,3)  verts(:,3) + scl*norms(:,3)]','g','LineWidth',1.5);
    end
end




function viscosity_value_Callback(hObject, eventdata, handles)
% hObject    handle to viscosity_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of viscosity_value as text
%        str2double(get(hObject,'String')) returns contents of viscosity_value as a double


% --- Executes during object creation, after setting all properties.
function viscosity_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to viscosity_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in wss_update.
function wss_update_Callback(hObject, eventdata, handles)
% hObject    handle to wss_update (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_wss(handles,0);


function update_wss(handles, time_update)

global sMAG;
global sCD;
global sMASK;
global vis_axis;
global vis_alpha;
global wss_axis;
global vis_thresh;
global VELX;
global VELY;
global VELZ;

global VELXt;
global VELYt;
global VELZt;
global tframes;
global m_xlength;
global m_ylength;
global m_zlength;
global XPTS;
global YPTS;
global ZPTS;

global delX;
global delY;
global delZ;

global verts;
global norms;
global norm_handle;
global norm_mag_handle;
global norm_cd_handle;
global color_range;
global hpatch;
global Cdata;
global visc;
global wss;
global wsst;
global osi;

visc = str2double(get(handles.viscosity_value,'String'));
poly_num = str2num(get(handles.poly_num,'String'));
poly_order = str2num(get(handles.poly_order,'String'));
color_range = str2num(get(handles.color_range,'String'))/100;

del = 0.01; %0.0001;
conv = ( visc/1000 ) * ( 1 / 1000 ) / ( delX / 1000 );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%          TIME RESOLVED WSS UPDATE                    %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if time_update == 1

    for time = 1:tframes
        
        time
        %%%%%%GET VELOCITY POSITIONS%%%%%
        for pos=1:size(verts,1)
            norm_size= sqrt( norms(pos,1).^2 + norms(pos,2).^2 + norms( pos,3).^2);
            norms(pos,1) = norms(pos,1)/norm_size;
            norms(pos,2) = norms(pos,2)/norm_size;
            norms(pos,3) = norms(pos,3)/norm_size;

            for poly_pos = 1:poly_num

                py = verts(pos,1)- (poly_pos -1.0)*norms(pos,1);
                px = verts(pos,2)- (poly_pos -1.0)*norms(pos,2);
                pz = verts(pos,3)- (poly_pos -1.0)*norms(pos,3);

                vx_wss(pos,poly_pos) = lin3dt(VELXt,time,px,py,pz);
                vy_wss(pos,poly_pos) = lin3dt(VELYt,time,px,py,pz);
                vz_wss(pos,poly_pos) = lin3dt(VELZt,time,px,py,pz);
            end
        end

        %%%%%%%%%NOW GET WSS%%%%%%%%
        for pos=1:size(verts,1)
            fit_vx = polyfit(1:poly_num,vx_wss(pos,:),poly_order);
            fit_vy = polyfit(1:poly_num,vy_wss(pos,:),poly_order);
            fit_vz = polyfit(1:poly_num,vz_wss(pos,:),poly_order);

            vxwall = polyval(fit_vx,1);
            vywall = polyval(fit_vy,1);
            vzwall = polyval(fit_vz,1);

            vxplus = polyval(fit_vx,1+del);
            vyplus = polyval(fit_vy,1+del);
            vzplus = polyval(fit_vz,1+del);

            vplus = [vxplus vyplus vzplus]; %- (sum([vxplus vyplus vzplus].*[norm(pos,2) norm(pos,1) norm(3,pos)]))*[norm(pos,2) norm(pos,1) norm(3,pos)]
            vwall = [vxwall vywall vzwall]; %- (sum([vxwall vywall vzwall].*[norm(pos,2) norm(pos,1) norm(3,pos)]))*[norm(pos,2) norm(pos,1) norm(3,pos)]
            normal= [norms(pos,2) norms(pos,1) norms(pos,3)];

            vtwall = cross(vwall,normal);
            vtplus = cross(vplus,normal);

            wsst(pos,time)=abs(conv*( ( sqrt( sum(vtplus.^2))) - ( sqrt( sum(vtwall.^2))) )/del);
        end

    end

    
    %%%%% Calc OSI (note can fully due without knowing directionality %%%%%%%
    osi = std(wsst,1,2)./mean(wsst,2);
    idx = find( isnan(osi));
    osi(idx)=0.0;
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%          Average WSS UPDATE                          %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else

    %%%%%%GET VELOCITY POSITIONS%%%%%
    disp('Getting Norms');
    for pos=1:size(verts,1)
        
        if( mod(pos,500)==1)
            disp(['Doing Point ', int2str(pos),' of ',size(verts,1)]);
        end
        
        norm_size= sqrt( norms(pos,1).^2 + norms(pos,2).^2 + norms( pos,3).^2);
        norms(pos,1) = norms(pos,1)/norm_size;
        norms(pos,2) = norms(pos,2)/norm_size;
        norms(pos,3) = norms(pos,3)/norm_size;


        for poly_pos = 1:poly_num

            py = verts(pos,1)- (poly_pos -1.0)*norms(pos,1);
            px = verts(pos,2)- (poly_pos -1.0)*norms(pos,2);
            pz = verts(pos,3)- (poly_pos -1.0)*norms(pos,3);

            vx_wss(pos,poly_pos) = lin3d(VELX,px,py,pz);
            vy_wss(pos,poly_pos) = lin3d(VELY,px,py,pz);
            vz_wss(pos,poly_pos) = lin3d(VELZ,px,py,pz);
        end
    end

    %%%%%%%%%NOW GET WSS%%%%%%%%
    disp('Getting Wss');
    for pos=1:size(verts,1)
        
        if( mod(pos,500)==1)
            disp(['Doing Point ', int2str(pos),' of ',size(verts,1)]);
        end
        
        fit_vx = polyfit(1:poly_num,vx_wss(pos,:),poly_order);
        fit_vy = polyfit(1:poly_num,vy_wss(pos,:),poly_order);
        fit_vz = polyfit(1:poly_num,vz_wss(pos,:),poly_order);

        vxwall = polyval(fit_vx,1);
        vywall = polyval(fit_vy,1);
        vzwall = polyval(fit_vz,1);

        vxplus = polyval(fit_vx,1+del);
        vyplus = polyval(fit_vy,1+del);
        vzplus = polyval(fit_vz,1+del);

        vplus = [vxplus vyplus vzplus]; %- (sum([vxplus vyplus vzplus].*[norm(pos,2) norm(pos,1) norm(3,pos)]))*[norm(pos,2) norm(pos,1) norm(3,pos)]
        vwall = [vxwall vywall vzwall]; %- (sum([vxwall vywall vzwall].*[norm(pos,2) norm(pos,1) norm(3,pos)]))*[norm(pos,2) norm(pos,1) norm(3,pos)]
        normal= [norms(pos,2) norms(pos,1) norms(pos,3)];

        vtwall = cross(vwall,normal);
        vtplus = cross(vplus,normal);

        wss(pos)=abs( conv*( ( sqrt( sum(vtplus.^2))) - ( sqrt( sum(vtwall.^2))) )/del);
    end


end


update_image(handles);

function poly_num_Callback(hObject, eventdata, handles)
% hObject    handle to poly_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poly_num as text
%        str2double(get(hObject,'String')) returns contents of poly_num as a double


% --- Executes during object creation, after setting all properties.
function poly_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poly_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function poly_order_Callback(hObject, eventdata, handles)
% hObject    handle to poly_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poly_order as text
%        str2double(get(hObject,'String')) returns contents of poly_order as a double


% --- Executes during object creation, after setting all properties.
function poly_order_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poly_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in update_time_wss.
function update_time_wss_Callback(hObject, eventdata, handles)
% hObject    handle to update_time_wss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


update_wss(handles,1);


function color_range_Callback(hObject, eventdata, handles)
% hObject    handle to color_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of color_range as text
%        str2double(get(hObject,'String')) returns contents of color_range as a double


% --- Executes during object creation, after setting all properties.
function color_range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function rot_num_Callback(hObject, eventdata, handles)
% hObject    handle to rot_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rot_num as text
%        str2double(get(hObject,'String')) returns contents of rot_num as a double


% --- Executes during object creation, after setting all properties.
function rot_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rot_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rotate_button.
function rotate_button_Callback(hObject, eventdata, handles)
% hObject    handle to rotate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

rotfunc(handles,0);


function rotfunc ( handles, save_rot)


global xslice_handle;
global yslice_handle;
global zslice_handle;

global sMAG;
global sCD;
global sMASK;

global m_xlength;
global m_ylength;
global m_zlength;
global wss_axis;

num_rot =str2double(get(handles.rot_num,'String'));


new_fig = ishandle(wss_axis);
figure(wss_axis);
set(gcf,'InvertHardCopy','off');
axis manual
axs = [0 0 1];

for n=0:num_rot
      
    
      figure(wss_axis);  
      pnt=int2str(n);
      disp(n);
      theta=360/(num_rot+1);
      camorbit(theta,0,'camera');
      
      %rotate(vis_axis,[1 0 0],180)
      
      if save_rot == 1
        fname=['ROTATE',sprintf('%03d',n),'.jpg'];
        print('-opengl','-f1','-r200','-djpeg100',fname);
      end
        
      drawnow
end

% --- Executes on button press in rot_and_save.
function rot_and_save_Callback(hObject, eventdata, handles)
% hObject    handle to rot_and_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

rotfunc(handles,1);

function file_name_Callback(hObject, eventdata, handles)
% hObject    handle to file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of file_name as text
%        str2double(get(hObject,'String')) returns contents of file_name as a double


% --- Executes during object creation, after setting all properties.
function file_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_button.
function save_button_Callback(hObject, eventdata, handles)
% hObject    handle to save_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global wss_axis;
figure(wss_axis);
set(gcf,'InvertHardCopy','off');
fname = get(handles.file_name,'String');
print('-opengl','-f1','-r200','-djpeg100',fname);



% --- Executes on button press in update_image.
function update_image_Callback(hObject, eventdata, handles)
% hObject    handle to update_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_image(handles);


function update_image(handles)

global sMAG;
global sCD;
global sMASK;
global vis_axis;
global vis_alpha;
global wss_axis;
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
global tframes;
global delX;
global delY;
global delZ;

global verts;
global norms;
global norm_handle;
global norm_mag_handle;
global norm_cd_handle;
global color_range;
global hpatch;
global Cdata;
global visc;
global wss;
global wsst;
global osi;

color_range = str2num(get(handles.color_range,'String'))/100;
visual_type = get(handles.visual_type,'Value');
%%%%Visual Type Decoding%%%%%
% 1 - Steady WSS
% 2 - Osilatory WSS
% 3 - Time WSS


%%%%%%ASSIGN COLORS %%%%%%%%%%%%%%


if visual_type == 1 %%%%AVERAGE
    max_wss = max(wss(:))
    cmap = jet(512);
    Cdata = zeros(size(verts(1),1),3);
    for pos =1:size(verts,1)
        cpos = 1+floor(512*abs(wss(pos))/max_wss/color_range);
        if(cpos>512)
            cpos = 512;
        end
        Cdata(pos,:) = cmap(cpos,:);
    end

    new_fig = ishandle(wss_axis);
    figure(wss_axis);
    % hpatch = patch(isosurface(sCD,vis_thresh));
    % reducepatch(hpatch,0.4);
    set(hpatch,'FaceColor','interp','EdgeColor', 'none','FaceVertexCData',Cdata);
    %set(hpatch,'FaceVertexCData',Cdata);

    colorbar('YLim',[0.0 1.0],'YTick',[0.0 1.0],'YTickLabel',{'0',num2str(max_wss*color_range)},'FontSize',22) %,'YLabel','Shear Stress (N/m^2)');


elseif visual_type == 2
    
    max_osi = max(osi(:))
    cmap = jet(512);
    Cdata = zeros(size(verts(1),1),3);
    for pos =1:size(verts,1)
        cpos = 1+floor(512*abs(osi(pos))/max_osi/color_range);
        if(cpos>512)
            cpos = 512;
        end
        Cdata(pos,:) = cmap(cpos,:);
    end

    new_fig = ishandle(wss_axis);
    figure(wss_axis);
    % hpatch = patch(isosurface(sCD,vis_thresh));
    % reducepatch(hpatch,0.4);
    set(hpatch,'FaceColor','interp','EdgeColor', 'none','FaceVertexCData',Cdata);
    %set(hpatch,'FaceVertexCData',Cdata);

    colorbar('YLim',[0.0 1.0],'YTick',[0.0 1.0],'YTickLabel',{'0',num2str(max_osi*color_range)},'FontSize',22) %,'YLabel','Shear Stress (N/m^2)');
    
    
elseif ( visual_type == 3 || visual_type == 4 )
    max_wss = max(wsst(:))
    cmap = jet(512);
    Cdata = zeros(size(verts(1),1),3);

    for time = 1:tframes
        for pos =1:size(verts,1)
            cpos = 1+floor(512*abs(wsst(pos,time))/max_wss/color_range);
            if(cpos>512)
                cpos = 512;
            end
            Cdata(pos,:) = cmap(cpos,:);
        end

        new_fig = ishandle(wss_axis);
        figure(wss_axis);
        % hpatch = patch(isosurface(sCD,vis_thresh));
        % reducepatch(hpatch,0.4);
        set(hpatch,'FaceColor','interp','EdgeColor', 'none','FaceVertexCData',Cdata);
        %set(hpatch,'FaceVertexCData',Cdata);

        colorbar('YLim',[0.0 1.0],'YTick',[0.0 1.0],'YTickLabel',{'0',num2str(max_wss*color_range)},'FontSize',22) %,'YLabel','Shear Stress (N/m^2)');
        if visual_type == 3
          pause(0.5);
        elseif visual_type == 4 
           set(gcf,'InvertHardCopy','off');
          fname=['TIME_WSS',sprintf('%03d',time),'.jpg'];
          print('-opengl','-f1','-r200','-djpeg100',fname);
        end
    end

end



% --- Executes on selection change in visual_type.
function visual_type_Callback(hObject, eventdata, handles)
% hObject    handle to visual_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns visual_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from visual_type


% --- Executes during object creation, after setting all properties.
function visual_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to visual_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on slider movement.
function box_xslide_Callback(hObject, eventdata, handles)
% hObject    handle to box_xslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

update_box(handles);



% --- Executes during object creation, after setting all properties.
function box_xslide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to box_xslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function box_yslide_Callback(hObject, eventdata, handles)
% hObject    handle to box_yslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_box(handles);

% --- Executes during object creation, after setting all properties.
function box_yslide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to box_yslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function box_zslide_Callback(hObject, eventdata, handles)
% hObject    handle to box_zslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

update_box(handles);

% --- Executes during object creation, after setting all properties.
function box_zslide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to box_zslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function box_xsize_Callback(hObject, eventdata, handles)
% hObject    handle to box_xsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of box_xsize as text
%        str2double(get(hObject,'String')) returns contents of box_xsize as a double
update_box(handles);


% --- Executes during object creation, after setting all properties.
function box_xsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to box_xsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function box_ysize_Callback(hObject, eventdata, handles)
% hObject    handle to box_ysize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of box_ysize as text
%        str2double(get(hObject,'String')) returns contents of box_ysize as a double
update_box(handles);

% --- Executes during object creation, after setting all properties.
function box_ysize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to box_ysize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function box_zsize_Callback(hObject, eventdata, handles)
% hObject    handle to box_zsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of box_zsize as text
%        str2double(get(hObject,'String')) returns contents of box_zsize as a double
update_box(handles);

% --- Executes during object creation, after setting all properties.
function box_zsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to box_zsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function update_box(handles)

global sMAG;
global sCD;
global sMASK;
global vis_axis;
global vis_alpha;
global wss_axis;
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
global tframes;
global delX;
global delY;
global delZ;

global verts;
global norms;
global norm_handle;
global norm_mag_handle;
global norm_cd_handle;
global color_range;
global hpatch;
global Cdata;
global visc;
global wss;
global wsst;
global osi;
global box_idx;
global box_handle;

global hist_xout;
global hist_nout;

%%%%%%Delete Object or Not %%%%%%%%%%%%%%
new_fig = ishandle(wss_axis);
figure(wss_axis);

if ishandle(box_handle)
    delete(box_handle);
end


phix = ( (get(handles.box_xrot,'Value')*pi - pi/2 ));
phiy = ( (get(handles.box_yrot,'Value')*pi - pi/2 ));
phiz = ( (get(handles.box_zrot,'Value')*pi - pi/2 ));

xpos = floor(1 + (get(handles.box_xslide,'Value')*( m_ylength-1) ));
ypos = floor(1 + (get(handles.box_yslide,'Value')*( m_xlength-1) ));
zpos = floor(1 + (get(handles.box_zslide,'Value')*( m_zlength-1) ));

xsize = str2num(get(handles.box_xsize,'String'));
ysize = str2num(get(handles.box_ysize,'String'));
zsize = str2num(get(handles.box_zsize,'String'));

[xB,yB,zB] = meshgrid(linspace(-xsize,xsize,2), ...
                      linspace(-ysize,ysize,2), ...
                      linspace(-zsize,zsize,2));
Tes = [ 1 2 3 4;
        5 6 7 8;
        1 3 5 7;
        2 4 6 8;
        3 4 7 8; 
        1 2 5 6];

Rx = [ 1 0        0; 
       0 cos(phix) sin(phix);   
       0 -sin(phix) cos(phix)];
Ry = [ cos(phiy) 0   -sin(phiy); 
       0         1        0;   
       sin(phiy) 0    cos(phiy)];
Rz = [ cos(phiz) sin(phiz) 0;   
      -sin(phiz) cos(phiz) 0;
      0 0 1];
  
RT = Rx*Ry*Rz;      

XB = [xB(:) yB(:) zB(:)]';
size(XB)
XB = ( RT*XB )' + repmat([xpos ypos zpos],[8 1]);;




%Rotate the Box




%Visualize Control
box_on = get(handles.box_on,'Value');

%%%VISUAL Box Color DECODING
%   1 = White
%   2 = Blue
%   3 = Yellow
%   4 = Green
%   5 = Red
box_color= get(handles.box_color,'Value');
if box_color == 1 
    col = 'w';
elseif box_color == 2
    col = 'b';
elseif box_color == 3
    col = 'y';
elseif box_color == 4
    col = 'g';
elseif box_color == 5
    col = 'r';
end 

box_alpha=1.0 - 0.25*(get(handles.box_alpha,'Value')-1);

if(box_on)
    box_handle = tetramesh(Tes,XB,'FaceAlpha',box_alpha,'FaceColor',col,'EdgeColor','none');
end



%%%%%Find Indices Within the box
rverts(:,3) = verts(:,3)-zpos;
rverts(:,2) = verts(:,2)-ypos;
rverts(:,1) = verts(:,1)-xpos;
size(rverts)

Rx = [ 1 0        0; 
       0 cos(-phix) sin(-phix);   
       0 -sin(-phix) cos(-phix)];
Ry = [ cos(-phiy) 0   -sin(-phiy); 
       0         1        0;   
       sin(-phiy) 0    cos(-phiy)];
Rz = [ cos(-phiz) sin(-phiz) 0;   
      -sin(-phiz) cos(-phiz) 0;
      0 0 1];
  
RT = Rx*Ry*Rz;   

rverts = (RT*(rverts'))';

size(rverts)

box_idx = find( (abs(rverts(:,1)) < xsize) & (abs(rverts(:,2)) < ysize) & (abs(rverts(:,3)) < zsize));

% box_idx = find( (verts(:,1) < (xpos+xsize))  & (verts(:,1) > (xpos-xsize)) & ...
%     (verts(:,2) < (ypos+ysize))  & (verts(:,2) > (ypos-ysize)) & ...
%     (verts(:,3) < (zpos+zsize))  & (verts(:,3) > (zpos-zsize)));

if length(box_idx) > 0
    avg_wss = mean(wss(1,box_idx));
else
    avg_wss = 0;
end

%%%%%%Update Stats            
set(handles.box_points,'String',num2str(length(box_idx)));
set(handles.avg_wss,'String',avg_wss);

if length(box_idx) > 0
[hist_nout,hist_xout] = hist(wss(1,box_idx),str2num(get(handles.hist_bins,'String')));
axes(handles.hist_axes)
bar(hist_xout,hist_nout);
xlim([0 max(wss(1,box_idx))]);
xlabel('Avg WSS');
ylabel('Number of Points');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function box_filename_Callback(hObject, eventdata, handles)
% hObject    handle to box_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of box_filename as text
%        str2double(get(hObject,'String')) returns contents of box_filename as a double


% --- Executes during object creation, after setting all properties.
function box_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to box_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in box_save.
function box_save_Callback(hObject, eventdata, handles)
% hObject    handle to box_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global wss;
global wsst;
global osi;
global box_idx;
global hist_nout;
global hist_xout;


base_name = get(handles.box_filename,'string');

hist_name = [base_name,'.hist'];
raw_name  = [base_name,'.box_vals'];

wss_out = wss(1,box_idx);


dlmwrite(hist_name,[hist_xout; hist_nout]','\t');
dlmwrite(raw_name,[1:length(box_idx); wss_out]','\t');


% fid = fopen(hist_name,'w');
% fwrite(fid,wss(box_idx),'float');
% fclose(fid);
% 
% fid = fopen(raw_name,'w');
% fwrite(fid,wss(box_idx),'float');
% fclose(fid);



% --- Executes on selection change in box_color.
function box_color_Callback(hObject, eventdata, handles)
% hObject    handle to box_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns box_color contents as cell array
%        contents{get(hObject,'Value')} returns selected item from box_color


update_box(handles);


% --- Executes during object creation, after setting all properties.
function box_color_CreateFcn(hObject, eventdata, handles)
% hObject    handle to box_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in box_on.
function box_on_Callback(hObject, eventdata, handles)
% hObject    handle to box_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of box_on
update_box(handles)




function hist_bin_Callback(hObject, eventdata, handles)
% hObject    handle to hist_bin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hist_bin as text
%        str2double(get(hObject,'String')) returns contents of hist_bin as a double
update_box(handles)

% --- Executes during object creation, after setting all properties.
function hist_bin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hist_bin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in box_alpha.
function box_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to box_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns box_alpha contents as cell array
%        contents{get(hObject,'Value')} returns selected item from box_alpha
update_box(handles)

% --- Executes during object creation, after setting all properties.
function box_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to box_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on slider movement.
function box_xrot_Callback(hObject, eventdata, handles)
% hObject    handle to box_xrot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_box(handles)

% --- Executes during object creation, after setting all properties.
function box_xrot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to box_xrot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

set(hObject,'Value',0.5);


% --- Executes on slider movement.
function box_yrot_Callback(hObject, eventdata, handles)
% hObject    handle to box_yrot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_box(handles)

% --- Executes during object creation, after setting all properties.
function box_yrot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to box_yrot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


set(hObject,'Value',0.5);

% --- Executes on slider movement.
function box_zrot_Callback(hObject, eventdata, handles)
% hObject    handle to box_zrot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_box(handles)

% --- Executes during object creation, after setting all properties.
function box_zrot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to box_zrot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

set(hObject,'Value',0.5);



% --- Executes on button press in auto_center.
function auto_center_Callback(hObject, eventdata, handles)
% hObject    handle to auto_center (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sMAG;
global sCD;
global sMASK;
global vis_axis;
global vis_alpha;
global wss_axis;
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
global tframes;
global delX;
global delY;
global delZ;
global verts;
global norms;
global norm_handle;
global norm_mag_handle;
global norm_cd_handle;
global color_range;
global hpatch;
global Cdata;
global visc;
global wss;
global wsst;
global osi;
global box_idx;
global box_handle;
global hist_xout;
global hist_nout;



xpos = floor(1 + (get(handles.box_xslide,'Value')*( m_ylength-1) ));
ypos = floor(1 + (get(handles.box_yslide,'Value')*( m_xlength-1) ));
zpos = floor(1 + (get(handles.box_zslide,'Value')*( m_zlength-1) ));

xsize = str2num(get(handles.box_xsize,'String'));
ysize = str2num(get(handles.box_ysize,'String'));
zsize = str2num(get(handles.box_zsize,'String'));

phix = ( (get(handles.box_xrot,'Value')*pi/2 ));
phiy = ( (get(handles.box_yrot,'Value')*pi/2 ));
phiz = ( (get(handles.box_zrot,'Value')*pi/2 ));

[xB,yB,zB] = meshgrid((-xsize:xsize),(-ysize:ysize),(-zsize:zsize));

Rx = [ 1 0        0; 
       0 cos(phix) sin(phix);   
       0 -sin(phix) cos(phix)];
Ry = [ cos(phiy) 0   -sin(phiy); 
       0         1        0;   
       sin(phiy) 0    cos(phiy)];
Rz = [ cos(phiz) sin(phiz) 0;   
      -sin(phiz) cos(phiz) 0;
      0 0 1];
  
RT = Rx*Ry*Rz;      

XB = [xB(:) yB(:) zB(:)]';
XB = ( RT*XB )' + repmat([xpos ypos zpos],[numel(XB)/3 1]);;

%%%%Find Values in Box
COMx=0;
COMy=0;
COMz=0;
M0=0;

for pos=1:numel(xB)
    X = XB(pos,:);
    V = lin3d(sCD,X(2),X(1),X(3));
    M0 = M0 + V;
    COMx = X(1)*V + COMx;
    COMy = X(2)*V + COMy;
    COMz = X(3)*V + COMz;
end
COMx= COMx/M0
COMy= COMy/M0
COMz= COMz/M0
set(handles.box_xslide,'Value',round(COMx-1)/( m_ylength-1));
set(handles.box_yslide,'Value',round(COMy-1)/( m_xlength-1));
set(handles.box_zslide,'Value',round(COMz-1)/( m_zlength-1));
update_box(handles)

% --- Executes on button press in auto_align.
function auto_align_Callback(hObject, eventdata, handles)
% hObject    handle to auto_align (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global sMAG;
global sCD;
global sMASK;
global vis_axis;
global vis_alpha;
global wss_axis;
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
global tframes;
global delX;
global delY;
global delZ;
global verts;
global norms;
global norm_handle;
global norm_mag_handle;
global norm_cd_handle;
global color_range;
global hpatch;
global Cdata;
global visc;
global wss;
global wsst;
global osi;
global box_idx;
global box_handle;
global hist_xout;
global hist_nout;

xpos = floor(1 + (get(handles.box_xslide,'Value')*( m_ylength-1) ));
ypos = floor(1 + (get(handles.box_yslide,'Value')*( m_xlength-1) ));
zpos = floor(1 + (get(handles.box_zslide,'Value')*( m_zlength-1) ));

xsize = str2num(get(handles.box_xsize,'String'));
ysize = str2num(get(handles.box_ysize,'String'));
zsize = str2num(get(handles.box_zsize,'String'));

phix = ( (get(handles.box_xrot,'Value')*pi - pi/2 ));
phiy = ( (get(handles.box_yrot,'Value')*pi - pi/2 ));
phiz = ( (get(handles.box_zrot,'Value')*pi - pi/2 ));

MIN_ERR = 1e99;

for pass =1:2
    if pass ==1
        res = 5;
        range = linspace( -pi/4,pi/4,res);
        phix0 = phix;
        phiy0 = phiy;
    else
        res = 5;
        maxp = pi / res / 4;
        range = linspace( -maxp,maxp,res);
        phix0 = phix;
        phiy0 = phiy;
    end

for cphix = range + phix0
 for cphiy = range + phiy0
  
    [xB,yB,zB] = meshgrid((-xsize:xsize),(-ysize:ysize),(-zsize:zsize));
      
    Rx = [ 1 0        0; 
       0 cos(cphix) sin(cphix);   
       0 -sin(cphix) cos(cphix)];
    Ry = [ cos(cphiy) 0   -sin(cphiy); 
       0         1        0;   
       sin(cphiy) 0    cos(cphiy)];
    Rz = [ cos(phiz) sin(phiz) 0;   
      -sin(phiz) cos(phiz) 0;
      0 0 1];
    RT = Rx*Ry*Rz;      

    XB = [xB(:) yB(:) zB(:)]';
    XB = ( RT*XB )' + repmat([xpos ypos zpos],[numel(XB)/3 1]);;
    
    for slice = 1:size(xB,3)
        COMx(slice)=0;
        COMy(slice)=0;
        M0=0;
        
        for x=1:xsize*2+1
         for y=1:ysize*2+1
            pos = sub2ind(size(xB),y,x,slice);
            X = XB(pos,:);
            V = lin3d(sCD,X(2),X(1),X(3));
            M0 = M0 + V;
            COMx(slice) =x*V + COMx(slice);
            COMy(slice) =y*V + COMy(slice);
         end
        end
        COMx(slice) = COMx(slice)/M0;
        COMy(slice) = COMy(slice)/M0;
    end
    ERR = abs(std(COMx)^2 + std(COMy)^2);
    
    if ERR < MIN_ERR
        phix = cphix;
        phiy = cphiy;
        MIN_ERR =ERR;
    end
 end    
end
disp(['Pass ',int2str(pass),': ',num2str(MIN_ERR)]);

end

set(handles.box_xrot,'Value',(phix+pi/2)/(pi));
set(handles.box_yrot,'Value',(phiy+pi/2)/(pi));

update_box(handles)


% --- Executes during object creation, after setting all properties.
function update_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to update_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function hist_axes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hist_axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate hist_axes


