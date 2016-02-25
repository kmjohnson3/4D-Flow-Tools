function varargout = visual_gui(varargin)
% VISUAL_GUI M-file for visual_gui.fig
%      VISUAL_GUI, by itself, creates a new VISUAL_GUI or raises the existing
%      singleton*.
%
%      H = VISUAL_GUI returns the handle to a new VISUAL_GUI or the handle to
%      the existing singleton*.
%
%      VISUAL_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VISUAL_GUI.M with the given input arguments.
%
%      VISUAL_GUI('Property','Value',...) creates a new VISUAL_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before visual_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to visual_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help visual_gui

% Last Modified by GUIDE v2.5 24-Jan-2008 19:15:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @visual_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @visual_gui_OutputFcn, ...
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


% --- Executes just before visual_gui is made visible.
function visual_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to visual_gui (see VARARGIN)

% Choose default command line output for visual_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes visual_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = visual_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in visual_update.
function visual_update_Callback(hObject, eventdata, handles)
% hObject    handle to visual_update (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_images(handles);



function update_images(handles)

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

global ind;
global old_ind_step;
global lx;
global ly;
global lz;

image_type = get(handles.image_type,'Value');
%%%VISUAL METHOD DECODING
%   1 = just mask
%   2 = streamlines
%   3 = vector plot
%   4 = massless particles
%   5 = 2D plots at planes

mask_image = get(handles.mask_image,'Value');
%%%MASK IMAGE TYPE
% 1 = Mag 
% 2 = CD
% 3 = Mag + Segment
% 4 = CD + Segment

vector_scale = str2double(get(handles.vector_scale,'String'));
stream_scale=str2double(get(handles.stream_scale,'String'));
vis_thresh = str2double(get(handles.lumen_threshold,'String'));
vis_alpha  = str2double(get(handles.lumen_alpha,'String'));
s = str2double(get(handles.vel_spacing,'String'));
stream_segs = str2double(get(handles.stream_segs,'String'));
vect_thick = str2double(get(handles.vect_thick,'String'));
vel_max = 10*str2double(get(handles.vel_max,'String'));
vel_min = 10*str2double(get(handles.vel_min,'String'));

new_fig = ishandle(vis_axis);


figure(vis_axis);

if new_fig == 1
    cmpos = campos;
    cmva  = camva;
    curcamup = get(gca,'CameraUpVector');
    zoom reset 

end  

set(gca,'CameraPositionMode','manual');
set(gca,'CameraTargetMode','manual');
set(gca,'CameraUpVectorMode','manual');
set(gca,'CameraViewAngleMode','manual');
clf;

if mask_image == 1
    IM = sMAG;
elseif mask_image ==2
    IM = sCD;
elseif mask_image == 3
    IM = sMAG.*sMASK;
elseif mask_image == 4
    IM = sCD.*sMASK;
end

hpatch = patch(isosurface(IM,vis_thresh));
clear IM;
set(hpatch,'FaceColor', 'white', 'EdgeColor', 'none');
reducepatch(hpatch,0.2);
%lighting none
lighting phong
camlight right; 

alpha(vis_alpha)
set(vis_axis, 'Renderer','OpenGL')
set(vis_axis, 'RendererMode','Manual');
set(gca,'color','black');
set(gcf,'color','black');
daspect([1 1 1])

if new_fig ==1
    campos([cmpos]);
    camva([cmva]);
    camup([curcamup]);
    
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
set(gcf,'Name','Plot Window');
end

hold on

CMAP=jet(1000);
COLOR=sMASK.*sqrt( VELX.^2 +VELY.^2 + VELZ.^2);
MAX_CL = max(COLOR(:));

if( (old_ind_step ~= s) )
    
    old_ind_step = s;
    ind = find(sMASK(1:s:m_xlength,1:s:m_ylength,1:s:m_zlength));
    lx = length(1:s:m_xlength)
    ly = length(1:s:m_ylength)
    lz = length(1:s:m_zlength)
end
    

if( image_type ==2)

    SCALE = 1.0/stream_scale*MAX_CL;
    
        
    for z0=2:s:(m_zlength-2);
        for x0=2:s:(m_xlength-2)
            for y0=2:s:(m_ylength-2)

                if( lin3d(sMASK,x0,y0,z0) == 1)

                    XN=x0;
                    YN=y0;
                    ZN=z0;
                    inside=0;
                    count=1;
                    good=0;
                    
                    xdat(count)=XN;
                    ydat(count)=YN;
                    zdat(count)=ZN;
                    vdat(count)=0;
                    
                    while (inside==0)
                        
                        
                        XP=XN - lin3d(VELX,XN,YN,ZN)/SCALE;
                        YP=YN - lin3d(VELY,XN,YN,ZN)/SCALE;
                        ZP=ZN - lin3d(VELZ,XN,YN,ZN)/SCALE;

                        vel = lin3d(COLOR,XN,YN,ZN);

                        if vel < vel_min
                            inside = 1;
                        end

                        if (vel > vel_max)
                            vel = vel_max;
                        end
                        co=CMAP(floor(1+vel/vel_max*999),:);
                        count = count +1;

                        xdat(count)=XP;
                        ydat(count)=YP;
                        zdat(count)=ZP;
                        vdat(count)=vel;
                        
                        %plot3( [YN YP],[XN XP],[ZN ZP],'color',co,'LineWidth',vect_thick);
                        %line('XData',[YN YP],'YData',[XN XP],'ZData',[ZN ZP],'Color',co,'LineWidth',vect_thick)

                        if( (ZP > (m_zlength-2)) || (ZP < 2))
                            inside=1;
                            good=1;
                        elseif( (YP > (m_ylength-2)) || (YP < 2))
                            inside=1;
                            good =1;
                        elseif( (XP > (m_xlength-2)) || (XP < 2))
                            inside=1;
                            good=1;
                        elseif (lin3d(sMASK,XP,YP,ZP)< 0.1)
                            inside=1;
                        elseif(count > stream_segs) 
                            inside=1;
                            good =1;
                        end

                        XN=XP;
                        YN=YP;
                        ZN=ZP;

                    end
                    
                    if( good == 1)
                        for pos=2:count
                            co=CMAP(floor(1+vdat(pos)/vel_max*999),:);
                            line('XData',[ydat(pos-1) ydat(pos)],'YData',[xdat(pos-1) xdat(pos)],'ZData',[zdat(pos-1) zdat(pos)],'Color',co,'LineWidth',vect_thick)
                        end
                    end
                    clear xdat
                    clear ydat
                    clear zdat
                    clear vdat

                end
            end
        end
    end

elseif (image_type == 3)

    SCALE = 1.0/vector_scale * MAX_CL;
    
    for k = 1:length(ind)
        [x,y,z] = ind2sub([lx,ly,lz],ind(k));
        x= 1+(x-1)*s;
        y= 1+(y-1)*s;
        z= 1+(z-1)*s;
        
        
         vel = COLOR(x,y,z);

         if vel < vel_min
             continue
         end

         if (vel > vel_max)
            vel = vel_max;
         end
         co=CMAP(floor(1+vel/vel_max*999),:);
         %line('XData',[YN YP],'YData',[XN XP],'ZData',[ZN ZP],'Color',co,'LineWidth',vect_thick)
         %line('XData',[(y-VELY(x,y,z)/SCALE) (y+VELY(x,y,z)/SCALE)],'YData',[(x-VELX(x,y,z)/SCALE) (x+VELX(x,y,z)/SCALE)],'Zdata', [(z-VELZ(x,y,z)/SCALE) (z+VELZ(x,y,z)/SCALE)],'color',co,'LineWidth',vect_thick);
         line('XData',[(y) (y-VELY(x,y,z)/SCALE)],'YData',[(x) (x-VELX(x,y,z)/SCALE)],'Zdata', [(z) (z-VELZ(x,y,z)/SCALE)],'color',co,'LineWidth',vect_thick);
    
    end
    

elseif( image_type == 4 )

    SCALE = 1.0/stream_scale*MAX_CL;

    clear global XPTS;
    clear global YPTS;
    clear global ZPTS;

    XPTS=0;
    YPTS=0;
    ZPTS=0;
    CPTS=0;
    TOT = 0;

    disp('Getting Points');
    for z0=(m_zlength-6):s:(m_zlength-2);
        for x0=2:s:(m_xlength-2)
            for y0=2:s:(m_ylength-2)

                if( lin3d(sMASK,x0,y0,z0) == 1)

                    TOT = TOT +1;

                    XN=x0;
                    YN=y0;
                    ZN=z0;
                    inside=0;
                    count=1;

                    XPTS(TOT,1)=XN;
                    YPTS(TOT,1)=YN;
                    ZPTS(TOT,1)=ZN;

                    vel = lin3d(COLOR,XN,YN,ZN);
                    if vel < vel_min
                        inside = 1;
                    end

                    if (vel > vel_max)
                        vel = vel_max;
                    end
                    CPTS(TOT,1)=vel;


                    for inside=1:stream_segs

                        XP=XN - lin3d(VELX,XN,YN,ZN)/SCALE;
                        YP=YN - lin3d(VELY,XN,YN,ZN)/SCALE;
                        ZP=ZN - lin3d(VELZ,XN,YN,ZN)/SCALE;

                        XN=XP;
                        YN=YP;
                        ZN=ZP;

                        if(XP <1) XN = 1; end
                        if(YP <1) YN = 1; end
                        if(ZP <1) ZN = 1; end
                        if(XP >= m_xlength) XN = m_xlength-1; end
                        if(YP >= m_ylength) YN = m_ylength-1; end
                        if(ZP >= m_zlength) ZN = m_zlength-1; end

                        vel = lin3d(COLOR,XN,YN,ZN);
                        if vel < vel_min
                            vel =0;
                        end

                        if (vel > vel_max)
                            vel = vel_max;
                        end
                        co=CMAP(floor(1+vel/vel_max*999),:);
                        count = count +1;

                        XPTS(TOT,count)=XN;
                        YPTS(TOT,count)=YN;
                        ZPTS(TOT,count)=ZN;
                        RPTS(TOT,count)=co(1);
                        GPTS(TOT,count)=co(2);
                        BPTS(TOT,count)=co(3);


                        %plot3( [YN YP],[XN XP],[ZN ZP],'color',co,'LineWidth',vect_thick);
                        %line('XData',[YN YP],'YData',[XN XP],'ZData',[ZN ZP],'Color',co,'LineWidth',vect_thick)
                    end
                end
            end
        end
    end

    disp(TOT);
    disp(count);
    disp('Plot Time')
    for time = 1:(stream_segs-1)
        H = plot3(  (YPTS(:,time:(time+1)))',(XPTS(:,time:(time+1)))',(ZPTS(:,time:(time+1),:))','LineWidth',vect_thick,'Color','r'); %'Color',RPTS(:,time)',GPTS(:,time)',BPTS(:,time)');
        drawnow
        pause(0.05);
        delete(H);
    end


elseif ( image_type == 5 )

    SCALE = 0.2/vector_scale * MAX_CL;

    for x0=xslice
        for y0=2:s:(m_ylength-1)
            for z0=2:s:(m_zlength-1)

                if( lin3d(sMASK,x0,y0,z0) == 1)

                                        XN=x0;
                    YN=y0;
                    ZN=z0;
                    inside=0;
                    count=1;
                    good=0;
                    
                    xdat(count)=XN;
                    ydat(count)=YN;
                    zdat(count)=ZN;
                    vdat(count)=0;
                    
                    while (inside==0)
                        
                        
                        XP=XN - lin3d(VELX,XN,YN,ZN)/SCALE;
                        YP=YN - lin3d(VELY,XN,YN,ZN)/SCALE;
                        ZP=ZN - lin3d(VELZ,XN,YN,ZN)/SCALE;

                        vel = lin3d(COLOR,XN,YN,ZN);

                        if vel < vel_min
                            inside = 1;
                        end

                        if (vel > vel_max)
                            vel = vel_max;
                        end
                        co=CMAP(floor(1+vel/vel_max*999),:);
                        count = count +1;

                        xdat(count)=XP;
                        ydat(count)=YP;
                        zdat(count)=ZP;
                        vdat(count)=vel;
                        
                        %plot3( [YN YP],[XN XP],[ZN ZP],'color',co,'LineWidth',vect_thick);
                        %line('XData',[YN YP],'YData',[XN XP],'ZData',[ZN ZP],'Color',co,'LineWidth',vect_thick)

                        if( (ZP > (m_zlength-2)) || (ZP < 2))
                            inside=1;
                            good=1;
                        elseif( (YP > (m_ylength-2)) || (YP < 2))
                            inside=1;
                            good =1;
                        elseif( (XP > (m_xlength-2)) || (XP < 2))
                            inside=1;
                            good=1;
                        elseif (lin3d(sMASK,XP,YP,ZP)== 0)
                            inside=1;
                        elseif(count > stream_segs) 
                            inside=1;
                            good =1;
                        end

                        XN=XP;
                        YN=YP;
                        ZN=ZP;

                    end
                    
                    if( good == 1)
                        for pos=2:count
                            co=CMAP(floor(1+vdat(pos)/vel_max*999),:);
                            line('XData',[ydat(pos-1) ydat(pos)],'YData',[xdat(pos-1) xdat(pos)],'ZData',[zdat(pos-1) zdat(pos)],'Color',co,'LineWidth',vect_thick)
                        end
                    end
                    clear xdat
                    clear ydat
                    clear zdat
                    clear vdat
                end
            end
        end
    end

    for x0=2:s:(m_xlength-1)
        for y0=yslice
            for z0=2:s:(m_zlength-1)
                 if( lin3d(sMASK,x0,y0,z0) == 1)

                                        XN=x0;
                    YN=y0;
                    ZN=z0;
                    inside=0;
                    count=1;
                    good=0;
                    
                    xdat(count)=XN;
                    ydat(count)=YN;
                    zdat(count)=ZN;
                    vdat(count)=0;
                    
                    while (inside==0)
                        
                        
                        XP=XN - lin3d(VELX,XN,YN,ZN)/SCALE;
                        YP=YN - lin3d(VELY,XN,YN,ZN)/SCALE;
                        ZP=ZN - lin3d(VELZ,XN,YN,ZN)/SCALE;

                        vel = lin3d(COLOR,XN,YN,ZN);

                        if vel < vel_min
                            inside = 1;
                        end

                        if (vel > vel_max)
                            vel = vel_max;
                        end
                        co=CMAP(floor(1+vel/vel_max*999),:);
                        count = count +1;

                        xdat(count)=XP;
                        ydat(count)=YP;
                        zdat(count)=ZP;
                        vdat(count)=vel;
                        
                        %plot3( [YN YP],[XN XP],[ZN ZP],'color',co,'LineWidth',vect_thick);
                        %line('XData',[YN YP],'YData',[XN XP],'ZData',[ZN ZP],'Color',co,'LineWidth',vect_thick)

                        if( (ZP > (m_zlength-2)) || (ZP < 2))
                            inside=1;
                            good=1;
                        elseif( (YP > (m_ylength-2)) || (YP < 2))
                            inside=1;
                            good =1;
                        elseif( (XP > (m_xlength-2)) || (XP < 2))
                            inside=1;
                            good=1;
                        elseif (lin3d(sMASK,XP,YP,ZP)== 0)
                            inside=1;
                        elseif(count > stream_segs) 
                            inside=1;
                            good =1;
                        end

                        XN=XP;
                        YN=YP;
                        ZN=ZP;

                    end
                    
                    if( good == 1)
                        for pos=2:count
                            co=CMAP(floor(1+vdat(pos)/vel_max*999),:);
                            line('XData',[ydat(pos-1) ydat(pos)],'YData',[xdat(pos-1) xdat(pos)],'ZData',[zdat(pos-1) zdat(pos)],'Color',co,'LineWidth',vect_thick)
                        end
                    end
                    clear xdat
                    clear ydat
                    clear zdat
                    clear vdat
                 end
            end
        end
    end

    for x0=2:s:(m_xlength-1)
        for y0=2:s:(m_ylength-1)
            for z0=zslice
                if( lin3d(sMASK,x0,y0,z0) == 1)
                    XN=x0;
                    YN=y0;
                    ZN=z0;
                    inside=0;
                    count=1;
                    good=0;
                    
                    xdat(count)=XN;
                    ydat(count)=YN;
                    zdat(count)=ZN;
                    vdat(count)=0;
                    
                    while (inside==0)
                        
                        
                        XP=XN - lin3d(VELX,XN,YN,ZN)/SCALE;
                        YP=YN - lin3d(VELY,XN,YN,ZN)/SCALE;
                        ZP=ZN - lin3d(VELZ,XN,YN,ZN)/SCALE;

                        vel = lin3d(COLOR,XN,YN,ZN);

                        if vel < vel_min
                            inside = 1;
                        end

                        if (vel > vel_max)
                            vel = vel_max;
                        end
                        co=CMAP(floor(1+vel/vel_max*999),:);
                        count = count +1;

                        xdat(count)=XP;
                        ydat(count)=YP;
                        zdat(count)=ZP;
                        vdat(count)=vel;
                        
                        %plot3( [YN YP],[XN XP],[ZN ZP],'color',co,'LineWidth',vect_thick);
                        %line('XData',[YN YP],'YData',[XN XP],'ZData',[ZN ZP],'Color',co,'LineWidth',vect_thick)

                        if( (ZP > (m_zlength-2)) || (ZP < 2))
                            inside=1;
                            good=1;
                        elseif( (YP > (m_ylength-2)) || (YP < 2))
                            inside=1;
                            good =1;
                        elseif( (XP > (m_xlength-2)) || (XP < 2))
                            inside=1;
                            good=1;
                        elseif (lin3d(sMASK,XP,YP,ZP)== 0)
                            inside=1;
                        elseif(count > stream_segs) 
                            inside=1;
                            good =1;
                        end

                        XN=XP;
                        YN=YP;
                        ZN=ZP;

                    end
                    
                    if( good == 1)
                        for pos=2:count
                            co=CMAP(floor(1+vdat(pos)/vel_max*999),:);
                            line('XData',[ydat(pos-1) ydat(pos)],'YData',[xdat(pos-1) xdat(pos)],'ZData',[zdat(pos-1) zdat(pos)],'Color',co,'LineWidth',vect_thick)
                        end
                    end
                    clear xdat
                    clear ydat
                    clear zdat
                    clear vdat
                end
            end
        end
    end



end





set(vis_axis, 'Renderer','OpenGL')
GH = get(vis_axis,'Renderer');
disp(GH);

function lumen_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to lumen_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lumen_alpha as text
%        str2double(get(hObject,'String')) returns contents of lumen_alpha as a double


% --- Executes during object creation, after setting all properties.
function lumen_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lumen_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lumen_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to lumen_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lumen_threshold as text
%        str2double(get(hObject,'String')) returns contents of lumen_threshold as a double


% --- Executes during object creation, after setting all properties.
function lumen_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lumen_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in image_type.
function image_type_Callback(hObject, eventdata, handles)
% hObject    handle to image_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns image_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from image_type


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





function stream_scale_Callback(hObject, eventdata, handles)
% hObject    handle to stream_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stream_scale as text
%        str2double(get(hObject,'String')) returns contents of stream_scale as a double


% --- Executes during object creation, after setting all properties.
function stream_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stream_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vector_scale_Callback(hObject, eventdata, handles)
% hObject    handle to vector_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vector_scale as text
%        str2double(get(hObject,'String')) returns contents of vector_scale as a double


% --- Executes during object creation, after setting all properties.
function vector_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vector_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function vel_spacing_Callback(hObject, eventdata, handles)
% hObject    handle to vel_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vel_spacing as text
%        str2double(get(hObject,'String')) returns contents of vel_spacing as a double


% --- Executes during object creation, after setting all properties.
function vel_spacing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vel_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function stream_segs_Callback(hObject, eventdata, handles)
% hObject    handle to stream_segs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stream_segs as text
%        str2double(get(hObject,'String')) returns contents of stream_segs as a double


% --- Executes during object creation, after setting all properties.
function stream_segs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stream_segs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function vect_thick_Callback(hObject, eventdata, handles)
% hObject    handle to vect_thick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vect_thick as text
%        str2double(get(hObject,'String')) returns contents of vect_thick as a double


% --- Executes during object creation, after setting all properties.
function vect_thick_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vect_thick (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function vel_min_Callback(hObject, eventdata, handles)
% hObject    handle to vel_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vel_min as text
%        str2double(get(hObject,'String')) returns contents of vel_min as a double


% --- Executes during object creation, after setting all properties.
function vel_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vel_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vel_max_Callback(hObject, eventdata, handles)
% hObject    handle to vel_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vel_max as text
%        str2double(get(hObject,'String')) returns contents of vel_max as a double


% --- Executes during object creation, after setting all properties.
function vel_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vel_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on slider movement.
function slide_x_Callback(hObject, eventdata, handles)
% hObject    handle to slide_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_slices(handles)


% --- Executes during object creation, after setting all properties.
function slide_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slide_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slide_z_Callback(hObject, eventdata, handles)
% hObject    handle to slide_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_slices(handles);


% --- Executes during object creation, after setting all properties.
function slide_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slide_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slide_y_Callback(hObject, eventdata, handles)
% hObject    handle to slide_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

update_slices(handles);


% --- Executes during object creation, after setting all properties.
function slide_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slide_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in update_slice.
function update_slice_Callback(hObject, eventdata, handles)
% hObject    handle to update_slice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_slices(handles);



function update_slices(handles)

global xslice_handle;
global yslice_handle;
global zslice_handle;

global sMAG;
global sCD;
global sMASK;

global m_xlength;
global m_ylength;
global m_zlength;
global vis_axis;

global xslice;
global yslice;
global zslice;

global VELX;
global VELY;
global VELZ;

figure(vis_axis);

slice_type = get(handles.slice_type,'Value');
%%%VISUAL METHOD DECODING
%   1 = No Slices
%   2 = Mag slices
%   3 = CD slices
%   4 = Vel slices

if ishandle(xslice_handle)
delete(xslice_handle);
delete(yslice_handle);
delete(zslice_handle);
end

if ( slice_type ~= 1)

xslice = floor(1 + (get(handles.slide_x,'Value')*( m_xlength-1) ));
yslice = floor(1 + (get(handles.slide_y,'Value')*( m_ylength-1) ));
zslice = floor(1 + (get(handles.slide_z,'Value')*( m_zlength-1) ));

hold on;


[X Y] = meshgrid(1:m_xlength,1:m_ylength);
Z = zslice*ones(m_ylength,m_xlength);
C = double(sMAG(:,:,zslice))';
if slice_type == 4
    colormap('jet');
else
    colormap('gray');
end
if( slice_type == 2)
    C = double(sMAG(:,:,zslice))';
elseif (slice_type ==3)
    C = double(sCD(:,:,zslice))';
elseif (slice_type == 4)
    C = double(sqrt(VELX(:,:,zslice).^2 + VELY(:,:,zslice).^2 + VELZ(:,:,zslice).^2))';
end
    
xslice_handle = surf(Y,X,Z,C,'EdgeColor', 'none');

hold on 

[X Y] = meshgrid(1:m_zlength,1:m_xlength);
Z = yslice*ones(m_xlength,m_zlength);
if( slice_type == 2)
    C = reshape(double(sMAG(:,yslice,:)),[m_xlength m_zlength]);
elseif (slice_type ==3)
    C = reshape(double(sCD(:,yslice,:)),[m_xlength m_zlength]);
elseif (slice_type == 4)
    C = reshape(double(sqrt(VELX(:,yslice,:).^2 + VELY(:,yslice,:).^2 + VELZ(:,yslice,:).^2)),[m_xlength m_zlength]);;
end
if slice_type == 4
    colormap('jet');
else
    colormap('gray');
end
yslice_handle = surf(Z,Y,X,C,'EdgeColor', 'none');

[X Y] = meshgrid(1:m_zlength,1:m_ylength);
Z = xslice*ones(m_ylength,m_zlength);
if( slice_type == 2)
    C = reshape(double(sMAG(xslice,:,:)),[m_ylength m_zlength]);
elseif (slice_type ==3)
   C = reshape(double(sCD(xslice,:,:)),[m_ylength m_zlength]);
elseif (slice_type == 4)
    C = reshape(double(sqrt(VELX(xslice,:,:).^2 + VELY(xslice,:,:).^2 + VELZ(xslice,:,:).^2)),[m_ylength m_zlength]);;
end

if slice_type == 4
    colormap('jet');
else
    colormap('gray');
end
zslice_handle = surf(Y,Z,X,C,'EdgeColor', 'none');

end


% --- Executes on selection change in slice_type.
function slice_type_Callback(hObject, eventdata, handles)
% hObject    handle to slice_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns slice_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from slice_type


% --- Executes during object creation, after setting all properties.
function slice_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slice_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function num_rot_Callback(hObject, eventdata, handles)
% hObject    handle to num_rot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_rot as text
%        str2double(get(hObject,'String')) returns contents of num_rot as a double


% --- Executes during object creation, after setting all properties.
function num_rot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_rot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in rotate_type.
function rotate_type_Callback(hObject, eventdata, handles)
% hObject    handle to rotate_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns rotate_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rotate_type


% --- Executes during object creation, after setting all properties.
function rotate_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rotate_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in apply_rot.
function apply_rot_Callback(hObject, eventdata, handles)
% hObject    handle to apply_rot (see GCBO)
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
global vis_axis;

rot_type = get(handles.rotate_type,'Value');
% 1 = about x 
% 2 = about y 
% 3 = about z
% 4 = about x flip x 
% 5 = about y flip y
% 6 = about z flip z
% 7 = about current  



num_rot = str2double(get(handles.num_rot,'String'));


figure(vis_axis);
set(gcf,'InvertHardCopy','off');

axis manual

if rot_type == 1
    axs = [1 0 0];
    view([0 0]);
elseif rot_type ==2
    axs = [0 1 0];
    view([0 0]);
elseif rot_type ==3
    axs = [0 0 1];
    view([0 0]);
elseif rot_type == 4
    axs = [-1 0 0];
    view([90 0]);
elseif rot_type == 5
    axs = [0 -1 0];
    view([90 0]);
elseif rot_type == 6 
    axs = [0 0 -1];
    set(gca,'CameraUpVector',[0 0 -1]);
elseif rot_type == 7
    axs = [0 0 1];
end
axs
    
for n=0:num_rot
      
    
      figure(vis_axis);  
      pnt=int2str(n);
      disp(n);
      theta=360/(num_rot+1);
      if rot_type == 7
          camorbit(theta,0,'camera');
      else
        camorbit(theta,0,'data',axs)
      end
      
      %rotate(vis_axis,[1 0 0],180)
      
      if save_rot == 1
        fname=['ROTATE',sprintf('%03d',n),'.jpg'];
        print('-opengl','-f1','-r100','-djpeg100',fname);
      end
        
      drawnow
end





% --- Executes on button press in save_rot.
function save_rot_Callback(hObject, eventdata, handles)
% hObject    handle to save_rot (see GCBO)
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


% --- Executes on button press in save_current.
function save_current_Callback(hObject, eventdata, handles)
% hObject    handle to save_current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global vis_axis;
figure(vis_axis);
set(gcf,'InvertHardCopy','off');
fname = get(handles.file_name,'String');
print('-opengl','-f1','-r100','-djpeg100',fname);



% --- Executes on selection change in mask_image.
function mask_image_Callback(hObject, eventdata, handles)
% hObject    handle to mask_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns mask_image contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mask_image


% --- Executes during object creation, after setting all properties.
function mask_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mask_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on key press over slide_x with no controls selected.
function slide_x_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to slide_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


