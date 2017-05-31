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

% Last Modified by GUIDE v2.5 29-May-2017 12:19:20

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

%%Load Velocity Data%%%%%%%%%%
handles.MAG= varargin{1};
handles.VX = varargin{2};
handles.VY = varargin{3};
handles.VZ = varargin{4};

handles.VXt = varargin{5};
handles.VYt = varargin{6};
handles.VZt = varargin{7};

handles.CD = varargin{8};
handles.MASK=varargin{9};
handles.STL_MASK=varargin{10};
handles.delX = varargin{11};
handles.delY = varargin{12};
handles.delZ = varargin{13};
handles.delT = varargin{14};

handles.norm_handle =[];
handles.wss_axis = 11;


handles.avg_wss_mean = 0;
handles.avg_wss_std = 0;
handles.avg_wss_med = 0;
handles.avg_wss_lq = 0;
handles.avg_wss_uq =0;
handles.wss_mean = 0;
handles.wss_std = 0;
handles.wss_med = 0;
handles.wss_lq = 0;
handles.wss_uq =0;



handles.average_velocity = 0;
handles.volume = 0;
handles.kinetic_energy = 0;
handles.visc_energy_loss = 0;



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

update_mask(hObject,handles);


function update_mask(hObject,handles)

mask_type = get(handles.mask_type,'Value');
%%%VISUAL METHOD DECODING
%   1 = CD
%   2 = MAG
%   3 = Mask
vis_thresh = str2double(get(handles.lumen_thresh,'String'));

new_fig = ishandle(handles.wss_axis);
figure(handles.wss_axis);

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
    VOL = handles.CD;
    hpatch = patch(isosurface(VOL,vis_thresh*max(VOL(:)) ) );
    fv = isosurface(VOL,vis_thresh*max(VOL(:)));
    disp(['CD X:',num2str(min(fv.vertices(:,1))),' to ',num2str(max(fv.vertices(:,1)))]);
    disp(['CD Y:',num2str(min(fv.vertices(:,2))),' to ',num2str(max(fv.vertices(:,2)))]);
    disp(['CD Z:',num2str(min(fv.vertices(:,3))),' to ',num2str(max(fv.vertices(:,3)))]);
    isonormals(VOL,hpatch)

elseif mask_type == 2
    VOL = handles.MAG;
    hpatch = patch(isosurface(VOL,vis_thresh*max(VOL(:)) ) );
    isonormals(VOL,hpatch)
else
    vis_thresh = 0.5;
    VOL = handles.CD;
    hpatch = patch(handles.STL_MASK);

    fv = handles.STL_MASK;
    disp(['STL X:',num2str(min(fv.vertices(:,1))),' to ',num2str(max(fv.vertices(:,1)))]);
    disp(['STL Y:',num2str(min(fv.vertices(:,2))),' to ',num2str(max(fv.vertices(:,2)))]);
    disp(['STL Z:',num2str(min(fv.vertices(:,3))),' to ',num2str(max(fv.vertices(:,3)))]);
end

set(hpatch,'FaceColor','red','EdgeColor', 'none');
colormap('parula');
%reducepatch(hpatch,0.4);

camlight('headlight');
material('dull');
lighting gouraud
alpha(0.9)
set(handles.wss_axis, 'Renderer','OpenGL')
set(handles.wss_axis, 'RendererMode','Manual');
set(gca,'color','w');
set(gcf,'color','black');
daspect([1 1 1])

if new_fig ==1
    campos([cmpos]);
    camva([cmva]);
end

if(new_fig==0)
    view([-1 -1 0]);
    zoom(0.8);
    %xlim([1 (m_ylength)]);
    %ylim([1 (m_xlength)]);
    %zlim([1 (m_zlength)]);
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

handles.hpatch_wall = hpatch;

% Update handles structure
guidata(hObject, handles);

function lumen_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to lumen_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lumen_thresh as text
%        str2double(get(hObject,'String')) returns contents of lumen_thresh as a double
update_mask(hObject,handles);

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

update_norms(hObject,handles);


function update_norms(hObject,handles)

normal_type = get(handles.normal_type,'Value');
%%%VISUAL METHOD DECODING
%   3 = base on vector
%   1 = base on data mag
%   2 = base on data cd
norm_plot_type= get(handles.normal_plot_type,'Value');


new_fig = ishandle(handles.wss_axis);
figure(handles.wss_axis);    
if normal_type == 2
    isonormals(handles.MAG,handles.hpatch_wall)
elseif normal_type == 1
    isonormals(handles.CD,handles.hpatch_wall)
end

norms = (get(handles.hpatch_wall,'VertexNormals'));
verts = (get(handles.hpatch_wall,'Vertices'));

% Normalize the normals
norm_mag = sqrt( sum(norms.^2,2));
norms(:,1) = norms(:,1)./norm_mag;
norms(:,2) = norms(:,2)./norm_mag;
norms(:,3) = norms(:,3)./norm_mag;

scl = 5;
if norm_plot_type == 1
    if ishandle(handles.norm_handle) delete(handles.norm_handle); end
elseif norm_plot_type ==2
    if ishandle(handles.norm_handle) delete(handles.norm_handle); end
    handles.norm_handle = plot3( [verts(:,1)  verts(:,1) + scl*norms(:,1)]',[verts(:,2) verts(:,2)+scl*norms(:,2)]',[verts(:,3)  verts(:,3) + scl*norms(:,3)]','b','LineWidth',1.5);
elseif norm_plot_type == 3;
    if normal_type == 2
        handles.norm_handle = plot3( [verts(:,1)  verts(:,1) + scl*norms(:,1)]',[verts(:,2) verts(:,2)+scl*norms(:,2)]',[verts(:,3)  verts(:,3) + scl*norms(:,3)]','b','LineWidth',1.5);
    elseif normal_type ==3
        handles.norm_handle = plot3( [verts(:,1)  verts(:,1) + scl*norms(:,1)]',[verts(:,2) verts(:,2)+scl*norms(:,2)]',[verts(:,3)  verts(:,3) + scl*norms(:,3)]','g','LineWidth',1.5);
    end
end

handles.verts = verts;
handles.norms = norms;

% Update handles structure
guidata(hObject, handles);


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

update_wss(hObject,handles,0);


function update_wss(hObject,handles, time_update)

visc = str2double(get(handles.viscosity_value,'String'));
poly_num = str2num(get(handles.poly_num,'String'));
poly_order = str2num(get(handles.poly_order,'String'));
color_range = str2num(get(handles.color_range,'String'))/100;

del = 0.01; %0.0001;
conv = ( visc/1000 ) * ( 1 / 1000 ) / ( handles.delX / 1000 );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%          TIME RESOLVED WSS UPDATE                    %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if time_update == 1
    
    for time = 1:size(handles.VXt,4)
        
        time
        %%%%%%GET VELOCITY POSITIONS%%%%%
        for pos=1:size(handles.verts,1)
            norm_size= sqrt( handles.norms(pos,1).^2 + handles.norms(pos,2).^2 + handles.norms( pos,3).^2);
            handles.norms(pos,1) = handles.norms(pos,1)/norm_size;
            handles.norms(pos,2) = handles.norms(pos,2)/norm_size;
            handles.norms(pos,3) = handles.norms(pos,3)/norm_size;
            
            for poly_pos = 1:poly_num
                
                py = handles.verts(pos,1)- (poly_pos -1.0)*handles.norms(pos,1);
                px = handles.verts(pos,2)- (poly_pos -1.0)*handles.norms(pos,2);
                pz = handles.verts(pos,3)- (poly_pos -1.0)*handles.norms(pos,3);
                
                vx_wss(pos,poly_pos) = lin3dt(handles.VXt,time,px,py,pz);
                vy_wss(pos,poly_pos) = lin3dt(handles.VYt,time,px,py,pz);
                vz_wss(pos,poly_pos) = lin3dt(handles.VZt,time,px,py,pz);
            end
        end
        
        %%%%%%%%%NOW GET WSS%%%%%%%%
        for pos=1:size(handles.verts,1)
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
            normal= [handles.norms(pos,2) handles.norms(pos,1) handles.norms(pos,3)];
            
            vtwall = cross(vwall,normal);
            vtplus = cross(vplus,normal);
            
            wsst(pos,time)=abs(conv*( ( sqrt( sum(vtplus.^2))) - ( sqrt( sum(vtwall.^2))) )/del);
        end
        
    end
    
    
    %%%%% Calc OSI (note can fully due without knowing directionality %%%%%%%
    osi = std(wsst,1,2)./mean(wsst,2);
    idx = find( isnan(osi));
    osi(idx)=0.0;
    
    handles.wsst = wsst;
    handles.osi = osi;
    
    wss_temporal_avg = mean(wsst,2);
    wss2 = sort(wss_temporal_avg);
    handles.wss_mean = mean(wss_temporal_avg(:));
    handles.wss_std = std(wss_temporal_avg(:));
    handles.wss_med = median(wss_temporal_avg(:));
    handles.wss_lq = wss2( ceil(numel(wss2)*0.25) );
    handles.wss_uq = wss2( floor(numel(wss2)*0.75) );
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%          Average WSS UPDATE                          %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    
    %%%%%%GET VELOCITY POSITIONS%%%%%
    disp('Getting Norms');
    for pos=1:size(handles.verts,1)
        
        if( mod(pos,500)==1)
            disp(['Doing Point ', int2str(pos),' of ',num2str(size(handles.verts,1))]);
        end
        
        norm_size= sqrt( handles.norms(pos,1).^2 + handles.norms(pos,2).^2 + handles.norms( pos,3).^2);
        handles.norms(pos,1) = handles.norms(pos,1)/norm_size;
        handles.norms(pos,2) = handles.norms(pos,2)/norm_size;
        handles.norms(pos,3) = handles.norms(pos,3)/norm_size;
        
        
        for poly_pos = 1:poly_num
            
            py = handles.verts(pos,1)- (poly_pos -1.0)*handles.norms(pos,1);
            px = handles.verts(pos,2)- (poly_pos -1.0)*handles.norms(pos,2);
            pz = handles.verts(pos,3)- (poly_pos -1.0)*handles.norms(pos,3);
            
            vx_wss(pos,poly_pos) = lin3d(handles.VX,px,py,pz);
            vy_wss(pos,poly_pos) = lin3d(handles.VY,px,py,pz);
            vz_wss(pos,poly_pos) = lin3d(handles.VZ,px,py,pz);
        end
    end
    
    %%%%%%%%%NOW GET WSS%%%%%%%%
    disp('Getting Wss');
    for pos=1:size(handles.verts,1)
        
        if( mod(pos,500)==1)
            disp(['Doing Point ', int2str(pos),' of ',num2str(size(handles.verts,1))]);
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
        normal= [handles.norms(pos,2) handles.norms(pos,1) handles.norms(pos,3)];
        
        vtwall = cross(vwall,normal);
        vtplus = cross(vplus,normal);
        
        wss(pos)=abs( conv*( ( sqrt( sum(vtplus.^2))) - ( sqrt( sum(vtwall.^2))) )/del);
    end
    
    wss2 = sort(wss);
    handles.avg_wss_mean = mean(wss);
    handles.avg_wss_std = std(wss);
    handles.avg_wss_med = median(wss);
    handles.avg_wss_lq = wss2( ceil(numel(wss2)*0.25) );
    handles.avg_wss_uq = wss2( floor(numel(wss2)*0.75) );
    
    handles.wss = wss;
    
end

% Volume features
idx = handles.MASK > 0;
voxel_volume = handles.delX*handles.delY*handles.delZ;

% Average Velocity [mm/s]
handles.average_velocity = sqrt( mean(handles.VX(idx(:))).^2 + mean(handles.VY(idx(:))).^2 + mean(handles.VZ(idx(:))).^2 );

% Volume [mL]
handles.volume = 0.001*voxel_volume*sum(idx(:));

% Kinetic Energy [J]
density_of_blood = 1060; %kg/M^3
voxel_volume_M3 = (handles.delX/1000)*(handles.delY/1000)*(handles.delZ/1000);
vsquared = handles.VX(idx).^2 +handles.VY(idx).^2 + handles.VZ(idx).^2;
handles.kinetic_energy = 0.5*density_of_blood*voxel_volume_M3*sum( vsquared(:)/1000^2);
for time = 1:size(handles.VXt,4)
    
    VXT = handles.VXt(:,:,:,time);
    VYT = handles.VYt(:,:,:,time);
    VZT = handles.VZt(:,:,:,time);
    
    vsquared = VXT(idx).^2 +VYT(idx).^2 + VZT(idx).^2;
    handles.dyn_kinetic_energy(time) = 0.5*density_of_blood*voxel_volume_M3*sum( vsquared(:)/1000^2);
end
handles.dyn_kinetic_energy
    
% Viscous Energy Loss [W]
handles.visc_energy_loss = 0;

% Update handles structure
guidata(hObject, handles);

update_wss_text(hObject, handles);
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

function update_wss_text(hObject, handles)
% hObject    handle to poly_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

temp_text = sprintf('Avg WSS : Median = %2.2f [%2.2f %2.2f], Mean = %2.2f (+/- %2.2f)' ...
    ,handles.avg_wss_med ...
    ,handles.avg_wss_lq ...
    ,handles.avg_wss_uq ...
    ,handles.avg_wss_mean ...
    ,handles.avg_wss_std);

temp_text2 = sprintf('WSS : Median = %2.2f [%2.2f %2.2f], Mean = %2.2f (+/- %2.2f)' ...
    ,handles.wss_med ...
    ,handles.wss_lq ...
    ,handles.wss_uq ...
    ,handles.wss_mean ...
    ,handles.wss_std);

temp_text3 = sprintf('Average Velocity [mm/s]= %f\nVolume [ml] = %f\nKinetic Energy [mJ] = %f\nViscous Energy Loss [W] = %f\n' ...
    ,handles.average_velocity ...
    ,handles.volume ...
    ,1000*handles.kinetic_energy ...
    ,handles.visc_energy_loss);

tt = sprintf('%s\n%s\n%s\n',temp_text,temp_text2,temp_text3);

set(handles.wss_text,'string',tt);




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


update_wss(hObject,handles,1);


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

num_rot =str2double(get(handles.rot_num,'String'));


new_fig = ishandle(handles.wss_axis);
figure(handles.wss_axis);
set(gcf,'InvertHardCopy','off');
axis manual
axs = [0 0 1];

for n=0:num_rot
    
    
    figure(handles.wss_axis);
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

figure(handles.wss_axis);
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

color_range = str2num(get(handles.color_range,'String'))/100;
visual_type = get(handles.visual_type,'Value');
%%%%Visual Type Decoding%%%%%
% 1 - Steady WSS
% 2 - Osilatory WSS
% 3 - Time WSS


%%%%%%ASSIGN COLORS %%%%%%%%%%%%%%


if visual_type == 1 %%%%AVERAGE
    max_wss = max(handles.wss(:));
    cmap = parula(512);
    Cdata = zeros(size(handles.verts(1),1),3);
    for pos =1:size(handles.verts,1)
        cpos = 1+floor(512*abs(handles.wss(pos))/max_wss/color_range);
        if(cpos>512)
            cpos = 512;
        end
        Cdata(pos,:) = cmap(cpos,:);
    end
    
    new_fig = ishandle(handles.wss_axis);
    figure(handles.wss_axis);
    
    set(handles.hpatch_wall,'FaceColor','interp','EdgeColor', 'none','FaceVertexCData',Cdata);
    
    t = colorbar('YLim',[0.0 1.0],'YTick',[0.0 1.0],'YTickLabel',{'0',num2str(max_wss*color_range)},'FontSize',22);
    set(get(t,'Label'),'String','Shear Stress (N/m^2)');
    
elseif visual_type == 2
    
    max_osi = max(handles.osi(:));
    cmap = parula(512);
    Cdata = zeros(size(handles.verts(1),1),3);
    for pos =1:size(handles.verts,1)
        cpos = 1+floor(512*abs(handles.osi(pos))/max_osi/color_range);
        if(cpos>512)
            cpos = 512;
        end
        Cdata(pos,:) = cmap(cpos,:);
    end
    
    new_fig = ishandle(handles.wss_axis);
    figure(handles.wss_axis);
    % hpatch = patch(isosurface(sCD,vis_thresh));
    % reducepatch(hpatch,0.4);
    set(handles.hpatch_wall,'FaceColor','interp','EdgeColor', 'none','FaceVertexCData',Cdata);
    %set(hpatch,'FaceVertexCData',Cdata);
    
    t = colorbar('YLim',[0.0 1.0],'YTick',[0.0 1.0],'YTickLabel',{'0',num2str(max_osi*color_range)},'FontSize',22);
    set(get(t,'Label'),'String','Oscillator Shear Stress (N/m^2)','Color','w');
    
elseif ( visual_type == 3 || visual_type == 4 )
    max_wss = max(handles.wsst(:));
    cmap = parula(512);
    Cdata = zeros(size(handles.verts(1),1),3);
    
    for time = 1:size(handles.wsst,2)
        for pos =1:size(handles.verts,1)
            cpos = 1+floor(512*abs(handles.wsst(pos,time))/max_wss/color_range);
            if(cpos>512)
                cpos = 512;
            end
            Cdata(pos,:) = cmap(cpos,:);
        end
        
        new_fig = ishandle(handles.wss_axis);
        figure(handles.wss_axis);
        % hpatch = patch(isosurface(sCD,vis_thresh));
        % reducepatch(hpatch,0.4);
        set(handles.hpatch_wall,'FaceColor','interp','EdgeColor', 'none','FaceVertexCData',Cdata);
        %set(hpatch,'FaceVertexCData',Cdata);
        
        t = colorbar('YLim',[0.0 1.0],'YTick',[0.0 1.0],'YTickLabel',{'0',num2str(max_wss*color_range)},'FontSize',22);
        set(get(t,'Label'),'String','Shear Stress (N/m^2)','Color','w');
        
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

base_name = get(handles.box_filename,'string');

hist_name = [base_name,'.hist'];
raw_name  = [base_name,'.box_vals'];

wss_out = wss(1,box_idx);

dlmwrite(hist_name,[hist_xout; hist_nout]','\t');
dlmwrite(raw_name,[1:length(box_idx); wss_out]','\t');


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


