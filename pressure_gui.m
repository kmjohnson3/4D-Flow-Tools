function varargout = pressure_gui(varargin)
% PRESSURE_GUI M-file for pressure_gui.fig
%      PRESSURE_GUI, by itself, creates a new PRESSURE_GUI or raises the existing
%      singleton*.
%
%      H = PRESSURE_GUI returns the handle to a new PRESSURE_GUI or the handle to
%      the existing singleton*.
%
%      PRESSURE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRESSURE_GUI.M with the given input arguments.
%
%      PRESSURE_GUI('Property','Value',...) creates a new PRESSURE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pressure_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pressure_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help pressure_gui

% Last Modified by GUIDE v2.5 12-Sep-2014 09:21:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @pressure_gui_OpeningFcn, ...
    'gui_OutputFcn',  @pressure_gui_OutputFcn, ...
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

% --- Executes just before pressure_gui is made visible.
function pressure_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pressure_gui (see VARARGIN)


%%Load Velocity Data%%%%%%%%%%
handles.MASK = varargin{1};
handles.VELX = varargin{2};
handles.VELY = varargin{3};
handles.VELZ = varargin{4};
handles.VELXt = varargin{5};
handles.VELYt = varargin{6};
handles.VELZt = varargin{7};
handles.delX = varargin{8};
handles.delY = varargin{9};
handles.delZ = varargin{10};
handles.tres = varargin{11};

% Choose default command line output for pressure_gui
handles.output = hObject;

handles.POINTS_FOUND = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pressure_gui wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = pressure_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles

% Get default command line output from handles structure
varargout{1} = handles.pressure;
delete(handles.figure1);

function viscosity_Callback(hObject, eventdata, handles)
% hObject    handle to viscosity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of viscosity as text
%        str2double(get(hObject,'String')) returns contents of viscosity as a double


% --- Executes during object creation, after setting all properties.
function viscosity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to viscosity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function density_Callback(hObject, eventdata, handles)
% hObject    handle to density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of density as text
%        str2double(get(hObject,'String')) returns contents of density as a double

% --- Executes during object creation, after setting all properties.
function density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end


% --- Executes on button press in grad_update.
function grad_update_Callback(hObject, eventdata, handles)
% hObject    handle to grad_update (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

calc_gradient(handles);
update_pressure(handles);

function calc_gradient(handles)

global tframes;
%Raw Data
global MASK;
global VELX;
global VELY;
global VELZ;
global VELXt;
global VELYt;
global VELZt;
global GRADx;
global GRADy;
global GRADz;
global plist;


VELX = handles.VELX;
VELY = handles.VELY;
VELZ = handles.VELZ;
VELXt = handles.VELXt;
VELYt = handles.VELYt;
VELZt = handles.VELZt;
MASK = handles.MASK;
delX = handles.delX;
delY = handles.delY;
delZ = handles.delZ;
tres= handles.tres;


for mask_num = 1:size(MASK,4)
    
    if (tres == 0)
        disp('tres is 0, making one up...')
        tres = 1000
    end
    
    visc = str2double(get(handles.viscosity,'String'))/1000;
    dens = str2double(get(handles.density,'String'));
    
    %%%%%%%%%%%%%%%%%%%%%STEP 1: Setup For Calc%%%%%%%%%%%%%
    
    %%Points to use
    plist{mask_num} = find( MASK(:,:,:,mask_num) );
    
    tframes = numel(VELXt);
    GRADx{mask_num} = zeros(size(plist{mask_num},1),size(plist{mask_num},2),tframes);
    GRADy{mask_num} = zeros(size(plist{mask_num},1),size(plist{mask_num},2),tframes);
    GRADz{mask_num} = zeros(size(plist{mask_num},1),size(plist{mask_num},2),tframes);
    
    %%%%%%%%%%%%%%%%%%%%%STEP 2: Gradient Calc%%%%%%%%%%%%%
    
    DIM = size(VELXt{1}.Data.vals);
    points = length(plist{mask_num});
    
    %%%DERIVATIVE CONVERSIONS
    conv_vel = -1/1000; %mm/s to m/s
    conv_vel2= 1/1000/1000;
    
    conv_dx = 1/delX*1000; % mm to m
    conv_dx2= 1/delX/delX*1000*1000;
    
    conv_dy = 1/delY*1000;
    conv_dy2= 1/delY/delY*1000*1000;
    
    conv_dz = 1/delZ*1000;
    conv_dz2= 1/delZ/delZ*1000*1000;
    
    conv_dt = 1/tres*1000;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%   Step 2.3 Derivatives                           %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for time = 1:tframes
        
        %% Load PC Data
        disp('Load Data');
        VX = single( VELXt{time}.Data.vals );
        VY = single( VELYt{time}.Data.vals );
        VZ = single( VELZt{time}.Data.vals );
        
        %% Load Time
        time_plus1 = mod( time,tframes)+1;
        time_minus1= mod( time-2,tframes)+1;
        VXp = single( VELXt{time_plus1}.Data.vals );
        VYp = single( VELYt{time_plus1}.Data.vals );
        VZp = single( VELZt{time_plus1}.Data.vals );
        
        VXm = single( VELXt{time_minus1}.Data.vals );
        VYm = single( VELYt{time_minus1}.Data.vals );
        VZm = single( VELZt{time_minus1}.Data.vals );
        
       disp(['Point Number ',int2str(0),' of ',num2str(points)])
            
        for pos = 1:points
            
            if 5000*floor(pos/5000)==pos
                disp(['Point Number ',int2str(pos),' of ',num2str(points)])
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%   Step 2.1 Setup Derivative Space                %%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            %%%%Setup Derivative Space For Derivatives
            [x0 y0 z0] = ind2sub(DIM,plist{mask_num}(pos));
            
            if ( (x0 < 2 ) || (y0 < 2 ) || (z0 < 2) || (x0 > DIM(1)-1) || (y0 > DIM(2)-1) || (z0 > DIM(3)-1))
                GRADx(pos,:) = 0;
                GRADy(pos,:) = 0;
                GRADz(pos,:) = 0;
            else
                
                %%%velocity Terms
                vx = conv_vel*VX(x0,y0,z0);
                vy = conv_vel*VY(x0,y0,z0);
                vz = conv_vel*VZ(x0,y0,z0);
                
                %%%mask values (TEMP?)
                mxp = 1.0; %sMASK(x0+1,y0,z0);
                myp = 1.0; %sMASK(x0,y0+1,z0);
                mzp = 1.0; %sMASK(x0,y0,z0+1);
                mxm = 1.0; %sMASK(x0-1,y0,z0);
                mym = 1.0; %sMASK(x0,y0-1,z0);
                mzm = 1.0; %sMASK(x0,y0,z0-1);
                
                %%First Derivatives
                dvxdt = conv_vel*( VXp(x0,y0,z0) - VXm(x0,y0,z0) )/(2*tres/1000);
                dvydt = conv_vel*( VYp(x0,y0,z0) - VYm(x0,y0,z0) )/(2*tres/1000);
                dvzdt = conv_vel*( VZp(x0,y0,z0) - VZm(x0,y0,z0) )/(2*tres/1000);
                
                dvxdx = conv_vel*( VX(x0+1,y0,z0)*mxp - VX(x0-1,y0,z0)*mxm )/(2*delX/1000);
                dvxdy = conv_vel*( VX(x0,y0+1,z0)*myp - VX(x0,y0-1,z0)*mym )/(2*delY/1000);
                dvxdz = conv_vel*( VX(x0,y0,z0+1)*mzp - VX(x0,y0,z0-1)*mzm )/(2*delZ/1000);
                
                dvydx = conv_vel*( VY(x0+1,y0,z0)*mxp - VY(x0-1,y0,z0)*mxm )/(2*delX/1000);
                dvydy = conv_vel*( VY(x0,y0+1,z0)*myp - VY(x0,y0-1,z0)*mym )/(2*delY/1000);
                dvydz = conv_vel*( VY(x0,y0,z0+1)*mzp - VY(x0,y0,z0-1)*mzm )/(2*delZ/1000);
                
                dvzdx = conv_vel*( VZ(x0+1,y0,z0)*mxp - VZ(x0-1,y0,z0)*mxm )/(2*delX/1000);
                dvzdy = conv_vel*( VZ(x0,y0+1,z0)*myp - VZ(x0,y0-1,z0)*mym )/(2*delY/1000);
                dvzdz = conv_vel*( VZ(x0,y0,z0+1)*mzp - VZ(x0,y0,z0-1)*mzm )/(2*delZ/1000);
                
                %%2nd Derivatives
                dvxdx2 = conv_vel*( VX(x0+1,y0,z0)*mxp -2*VX(x0,y0,z0) + VX(x0-1,y0,z0)*mxm )/(delX/1000)^2;
                dvxdy2 = conv_vel*( VX(x0,y0+1,z0)*myp -2*VX(x0,y0,z0) + VX(x0,y0-1,z0)*mym )/(delY/1000)^2;
                dvxdz2 = conv_vel*( VX(x0,y0,z0+1)*mzp -2*VX(x0,y0,z0) + VX(x0,y0,z0-1)*mzm )/(delZ/1000)^2;
                
                dvydx2 = conv_vel*( VY(x0+1,y0,z0)*mxp -2*VY(x0,y0,z0) + VY(x0-1,y0,z0)*mxm )/(delX/1000)^2;
                dvydy2 = conv_vel*( VY(x0,y0+1,z0)*myp -2*VY(x0,y0,z0) + VY(x0,y0-1,z0)*mym )/(delY/1000)^2;
                dvydz2 = conv_vel*( VY(x0,y0,z0+1)*mzp -2*VY(x0,y0,z0) + VY(x0,y0,z0-1)*mzm )/(delZ/1000)^2;
                
                dvzdx2 = conv_vel*( VZ(x0+1,y0,z0)*mxp -2*VZ(x0,y0,z0) + VZ(x0-1,y0,z0)*mxm )/(delX/1000)^2;
                dvzdy2 = conv_vel*( VZ(x0,y0+1,z0)*myp -2*VZ(x0,y0,z0) + VZ(x0,y0-1,z0)*mym )/(delY/1000)^2;
                dvzdz2 = conv_vel*( VZ(x0,y0,z0+1)*mzp -2*VZ(x0,y0,z0) + VZ(x0,y0,z0-1)*mzm )/(delZ/1000)^2;
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%   Step 2.4 Navier-Stokes                         %%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                
                GRADx{mask_num}(pos,time) =   -dens*dvxdt ...
                    -dens*vx*dvxdx  ...
                    -dens*vy*dvxdy  ...
                    -dens*vz*dvxdz ...
                    +visc*dvxdx2 ...
                    +visc*dvxdy2 ...
                    +visc*dvxdz2;
                GRADy{mask_num}(pos,time) =  -dens*dvydt  ...
                    -dens*vx*dvydx ...
                    -dens*vy*dvydy ...
                    -dens*vz*dvydz ...
                    +visc*dvydx2 ...
                    +visc*dvydy2 ...
                    +visc*dvydz2;
                GRADz{mask_num}(pos,time) =  -dens*dvzdt    ...
                    -dens*vx*dvzdx ...
                    -dens*vy*dvzdy ...
                    -dens*vz*dvzdz  ...
                    +visc*dvzdx2 ...
                    +visc*dvzdy2 ...
                    +visc*dvzdz2;
            end
        end
    end
end % mask num

function update_pressure(handles)

global MASK;
global GRADx;
global GRADy;
global GRADz;
global PRESSURE;
global plist;
global xlist;
global ylist;
global zlist;
global tframes;

global delX;
global delY;
global delZ;

global POINTS_FOUND;

signVx = 1;
signVy = 1;
signVz = 1;


for mask_num = 1:size(MASK,4)
    
    sMASK = MASK(:,:,:,mask_num);
    [size_x size_y size_z] = size(sMASK);
    
    %%%%%%Step 1. Get Neighbors of Each Pixel %%%%%%%
    disp('Getting Neighbors');
    
    POINTS_FOUND = 1;
    points = size(plist{mask_num},1);
    
    [xlist ylist zlist] = ind2sub(size(sMASK),plist{mask_num});
    nbs=zeros(points,6);
    
    sMASK = sMASK.*zeros(size(sMASK));
    sMASK(plist{mask_num}) = 1:points;
    
    for pos = 1:points
        
        x0 = xlist(pos);
        y0 = ylist(pos);
        z0 = zlist(pos);
        
        if(x0 < size_x)
            if( sMASK(x0+1,y0,z0)>0)
                nbs(pos,1) = sMASK(x0+1,y0,z0);
            end
        end
        
        if(x0 > 1)
            if( sMASK(x0-1,y0,z0)>0)
                nbs(pos,2) = sMASK(x0-1,y0,z0);
            end
        end
        
        if(y0 < size_y)
            if( sMASK(x0,y0+1,z0)>0)
                nbs(pos,3) = sMASK(x0,y0+1,z0);
            end
        end
        
        if(y0 > 1)
            if( sMASK(x0,y0-1,z0)>0)
                nbs(pos,4) = sMASK(x0,y0-1,z0);
            end
        end
        
        if(z0 < size_z)
            if( sMASK(x0,y0,z0+1)>0)
                nbs(pos,5) = sMASK(x0,y0,z0+1);
            end
        end
        
        if(z0 > 1)
            if( sMASK(x0,y0,z0-1)>0)
                nbs(pos,6) = sMASK(x0,y0,z0-1);
            end
        end
    end
    sMASK = sMASK > 0;
    
    %%%%%%Step 2. Initial Setup (Simple Integration) %%%%%%%
    disp('Populating Matrix');
    num_counted = 0;
    counted = zeros(points,1);
    start_cnt = 1;
    new_points =1;
    PRESSURE = zeros(points,tframes);
    regions = 0;
    non_zero = nnz(nbs)
    
    A = spalloc(non_zero+1,points,2*(non_zero+1));
    B = zeros(non_zero+1,tframes);
    counter = 0;
    num_counted = 0;
    for idx = 1:points
        if mod(idx,1000) == 0
            disp(['Loop index: ',num2str(idx)]);
        end
        
        xp = nbs(idx,1);
        xm = nbs(idx,2);
        yp = nbs(idx,3);
        ym = nbs(idx,4);
        zp = nbs(idx,5);
        zm = nbs(idx,6);
        
        if xp ~= 0% && counted(xp)==0
            counter = counter+1;
            %counted(xp) = 1;
            num_counted = num_counted+1;
            %cnt_idx(num_counted)=xp;
            %PRESSURE(xp,:) = PRESSURE(idx,:) +signVx*GRADx(idx,:)*delX/1000;
            A(num_counted, idx) = -1;
            A(num_counted,xp) = 1;
            B(num_counted,:) = signVx*(GRADx{mask_num}(idx,:)+GRADx{mask_num}(xp,:))/2*delX/1000;
        end
        
        if xm ~= 0 %&& counted(xm)==0
            %counted(xm) = 1;
            num_counted = num_counted+1;
            %cnt_idx(num_counted)=xm;
            %PRESSURE(xm,:) = PRESSURE(idx,:) - signVx*GRADx(idx,:)*delX/1000;
            A(num_counted, idx) = 1;
            A(num_counted,xm) = -1;
            B(num_counted,:) = signVx*(GRADx{mask_num}(idx,:)+GRADx{mask_num}(xm,:))/2*delX/1000;
        end
        
        if yp ~= 0% &&  counted(yp)==0
            %counted(yp) = 1;
            num_counted = num_counted+1;
            %cnt_idx(num_counted)=yp;
            %PRESSURE(yp,:) = PRESSURE(idx,:) +signVy*GRADy(idx,:)*delY/1000;
            A(num_counted, idx) = -1;
            A(num_counted,yp) = 1;
            B(num_counted,:) = signVy*(GRADy{mask_num}(idx,:)+GRADy{mask_num}(yp,:))/2*delY/1000;
        end
        
        if ym ~= 0% && counted(ym)==0
            %counted(ym) = 1;
            num_counted = num_counted+1;
            %cnt_idx(num_counted)=ym;
            %PRESSURE(ym,:) = PRESSURE(idx,:) - signVy*GRADy(idx,:)*delY/1000;
            A(num_counted, idx) = 1;
            A(num_counted,ym) = -1;
            B(num_counted,:) = signVy*(GRADy{mask_num}(idx,:)+GRADy{mask_num}(ym,:))/2*delY/1000;
        end
        
        if zp ~= 0% && counted(zp)==0
            %counted(zp) = 1;
            num_counted = num_counted+1;
            %cnt_idx(num_counted)=zp;
            %PRESSURE(zp,:) = PRESSURE(idx,:) + signVz*GRADz(idx,:)*delZ/1000;
            A(num_counted, idx) = -1;
            A(num_counted,zp) = 1;
            B(num_counted,:) = signVz*(GRADz{mask_num}(idx,:)+GRADz{mask_num}(zp,:))/2*delZ/1000;
        end
        
        if zm ~= 0% && counted(zm)==0
            %counted(zm) = 1;
            num_counted = num_counted+1;
            %cnt_idx(num_counted)=zm;
            %PRESSURE(zm,:) = PRESSURE(idx,:) - signVz*GRADz(idx,:)*delZ/1000;
            A(num_counted, idx) = 1;
            A(num_counted,zm) = -1;
            B(num_counted,:) = signVz*(GRADz{mask_num}(idx,:)+GRADz{mask_num}(zm,:))/2*delZ/1000;
        end
    end
    
    
    disp('Matrix Solution');
    A(num_counted+1,1) = 1;
    B(num_counted + 1,:) = 0;
    A = A(1:num_counted+1,:);
    non_iterPress = zeros(points,tframes);
    
    for t = 1:tframes
        non_iterPress(:,t) = A\B(:,t);
    end
    PRESSURE = non_iterPress;
    
    % Populate
    pressure{mask_num}.vals  = non_iterPress;
    pressure{mask_num}.plist = plist{mask_num};
end % Multiple mask

handles.pressure = pressure;

% Update handles structure
guidata(handles.figure1, handles);

% --- Executes on button press in quit_button.
function quit_button_Callback(hObject, eventdata, handles)
% hObject    handle to quit_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(handles.figure1);



