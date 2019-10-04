function varargout = background_phase_correction(varargin)
% BACKGROUND_PHASE_CORRECTION M-file for background_phase_correction.fig
%      BACKGROUND_PHASE_CORRECTION, by itself, creates a new BACKGROUND_PHASE_CORRECTION or raises the existing
%      singleton*.
%
%      H = BACKGROUND_PHASE_CORRECTION returns the handle to a new BACKGROUND_PHASE_CORRECTION or the handle to
%      the existing singleton*.
%
%      BACKGROUND_PHASE_CORRECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BACKGROUND_PHASE_CORRECTION.M with the given input arguments.
%
%      BACKGROUND_PHASE_CORRECTION('Property','Value',...) creates a new BACKGROUND_PHASE_CORRECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before background_phase_correction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to background_phase_correction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help background_phase_correction

% Last Modified by GUIDE v2.5 10-Sep-2014 15:46:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @background_phase_correction_OpeningFcn, ...
    'gui_OutputFcn',  @background_phase_correction_OutputFcn, ...
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


% --- Executes just before background_phase_correction is made visible.
function background_phase_correction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to background_phase_correction (see VARARGIN)

% Update handles structure
guidata(hObject, handles);


set(handles.status_axes,'XTickLabel','')
set(handles.status_axes,'YTickLabel','')
set(handles.status_axes,'Xtick',[]);
set(handles.status_axes,'Ytick',[]);
set(handles.status_axes,'box','off');

%%Load Velocity Data%%%%%%%%%%
handles.MAG= varargin{1};
handles.VX = varargin{2};
handles.VY = varargin{3};
handles.VZ = varargin{4};

handles.max_mag = max(handles.MAG.Data.vals(:));

handles.poly_fitx.vals =0;
handles.poly_fitx.px =0;
handles.poly_fitx.py =0;
handles.poly_fitx.pz =0;

handles.poly_fity.vals =0;
handles.poly_fity.px =0;
handles.poly_fity.py =0;
handles.poly_fity.pz =0;

handles.poly_fitz.vals =0;
handles.poly_fitz.px =0;
handles.poly_fitz.py =0;
handles.poly_fitz.pz =0;

%Range
handles.xrange = single( linspace(-1,1,size(handles.VX.Data.vals,1)) );
handles.yrange = single( linspace(-1,1,size(handles.VY.Data.vals,2)) );
handles.zrange = single( linspace(-1,1,size(handles.VZ.Data.vals,3)) );

% Update handles structure
guidata(hObject, handles);

update_images(handles);

uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = background_phase_correction_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Get default command line output from handles structure
varargout{1} = handles.poly_fitx;
varargout{2} = handles.poly_fity;
varargout{3} = handles.poly_fitz;

delete(handles.figure1);

% --- Executes on slider movement.
function image_slider_Callback(hObject, eventdata, handles)
% hObject    handle to image_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_images(handles)

function update_images(handles);

rczres = size(handles.MAG.Data.vals,3);

cd_thresh = (get(handles.cd_thresh_slider,'Value'));
noise_thresh = 0.3*(get(handles.noise_thresh_slider,'Value'));
slice =1 + floor(get(handles.image_slider,'Value')*(rczres-1));
apply_pc = get(handles.apply_box,'Value');

% Get magnitude
vx_slice = single(handles.VX.Data.vals(:,:,slice) );
vy_slice = single(handles.VY.Data.vals(:,:,slice) );
vz_slice = single(handles.VZ.Data.vals(:,:,slice) );
mag_slice= single(handles.MAG.Data.vals(:,:,slice) );

%Range
if apply_pc ==1
    [y,x,z] = meshgrid( handles.yrange,handles.xrange,handles.zrange(slice) );    
    vx_slice = vx_slice - evaluate_poly(x,y,z,handles.poly_fitx);
    vy_slice = vy_slice - evaluate_poly(x,y,z,handles.poly_fity);
    vz_slice = vz_slice - evaluate_poly(x,y,z,handles.poly_fitz);
end
vmag =sqrt(vx_slice.^2 + vy_slice.^2 + + vz_slice.^2);

VENC = 1000;

axes(handles.mag_axes);
idx = find( (mag_slice > noise_thresh*handles.max_mag) & (vmag < cd_thresh*VENC));
mag_slice = 200 * mag_slice/max(mag_slice(:));
mag_slice(idx) = 257;

map =[ gray(200); jet(10)];
imagesc(mag_slice,[0,200+10]);
colormap(map);
set(gca,'XTickLabel','')
set(gca,'YTickLabel','')
daspect([1 1 1]);

axes(handles.vel_axes);

vmax = floor(500*get(handles.vmax_slider,'Value'));
set( handles.vmax_text,'String',num2str(vmax));

vel_mag = sqrt(vx_slice.^2 + vy_slice.^2 + vz_slice.^2);
vel_mag = 200*vel_mag/vmax;
idx = vel_mag >= 199;
vel_mag(idx)=199;

imagesc(vel_mag,[0 210]);%.*MAG(:,:,slice));

set(gca,'XTickLabel','')
set(gca,'YTickLabel','')
colormap(map);
daspect([1 1 1]);
drawnow;
drawnow;


% --- Executes during object creation, after setting all properties.
function image_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in update_button.
function update_button_Callback(hObject, eventdata, handles)
% hObject    handle to update_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fit_order = str2double(get(handles.fit_order,'String'));
cd_thresh = (get(handles.cd_thresh_slider,'Value'));
noise_thresh = 0.3*(get(handles.noise_thresh_slider,'Value'));

[poly_fitx,poly_fity,poly_fitz] = polyfit_3D( handles.MAG,handles.VX,handles.VY,handles.VZ,fit_order,cd_thresh, noise_thresh,handles);
handles.poly_fitx = poly_fitx;
handles.poly_fity = poly_fity;
handles.poly_fitz = poly_fitz;

% Update handles structure
guidata(hObject, handles);

global iter;
iter = iter + 1;
set(handles.iter_text,'String',num2str(iter));
update_images(handles);


function fit_order_Callback(hObject, eventdata, handles)
% hObject    handle to fit_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fit_order as text
%        str2double(get(hObject,'String')) returns contents of fit_order as a double


% --- Executes during object creation, after setting all properties.
function fit_order_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fit_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in apply_box.
function apply_box_Callback(hObject, eventdata, handles)
% hObject    handle to apply_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of apply_box
update_images(handles);


% --- Executes on slider movement.
function vmax_slider_Callback(hObject, eventdata, handles)
% hObject    handle to vmax_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
update_images(handles);

% --- Executes during object creation, after setting all properties.
function vmax_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vmax_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function noise_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to noise_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of noise_thresh as text
%        str2double(get(hObject,'String')) returns contents of noise_thresh as a double

update_images(handles);


% --- Executes during object creation, after setting all properties.
function noise_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noise_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cd_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to cd_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cd_thresh as text
%        str2double(get(hObject,'String')) returns contents of cd_thresh as a double
update_images(handles);

% --- Executes during object creation, after setting all properties.
function cd_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cd_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_iter_Callback(hObject, eventdata, handles)
% hObject    handle to num_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_iter as text
%        str2double(get(hObject,'String')) returns contents of num_iter as a double


% --- Executes during object creation, after setting all properties.
function num_iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function cd_thresh_slider_Callback(hObject, eventdata, handles)
% hObject    handle to cd_thresh_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

update_images(handles);

% --- Executes during object creation, after setting all properties.
function cd_thresh_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cd_thresh_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function noise_thresh_slider_Callback(hObject, eventdata, handles)
% hObject    handle to noise_thresh_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

update_images(handles);

% --- Executes during object creation, after setting all properties.
function noise_thresh_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noise_thresh_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.poly_fitx.vals =0;
handles.poly_fitx.px =0;
handles.poly_fitx.py =0;
handles.poly_fitx.pz =0;

handles.poly_fity.vals =0;
handles.poly_fity.px =0;
handles.poly_fity.py =0;
handles.poly_fity.pz =0;

handles.poly_fitz.vals =0;
handles.poly_fitz.px =0;
handles.poly_fitz.py =0;
handles.poly_fitz.pz =0;

% Update handles structure
guidata(hObject, handles);

update_images(handles);
iter = 0;
set(handles.iter_text,'String',num2str(iter));


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

% --- Executes on button press in Quit.
function Quit_Callback(hObject, eventdata, handles)
% hObject    handle to Quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1);




function [poly_fitx,poly_fity,poly_fitz ] =  polyfit_3D(MAG,VX,VY,VZ,fit_order,cd_thresh, noise_thresh,handles)

VENC = 1000;
Mask = int8(zeros(size(MAG.Data.vals)));
CD = single(MAG.Data.vals).*sin(sqrt(single(VX.Data.vals.^2 + VY.Data.vals.^2 + + VZ.Data.vals.^2))/VENC*pi/2);
max_MAG = max(MAG.Data.vals(:));
max_CD = max(CD(:));

% Create angiogram
for slice = 1:size(Mask,3)
    
    % Grab a slice
    mag_slice = single( MAG.Data.vals(:,:,slice));
    cd_slice = single(CD(:,:,slice));

    Mask(:,:,slice) = ( mag_slice > noise_thresh*max_MAG) .* ( cd_slice < cd_thresh*max_CD);
end


%lots of memory problems with vectorization!!! solve Ax = B by (A^hA) x = (A^h *b)
if fit_order == 0
    
    px = 0;
    py = 0;
    pz = 0;
        
    poly_fitx.vals  = mean(VX.Data.vals(:));
    poly_fitx.px = 0;
    poly_fitx.py = 0;
    poly_fitx.pz = 0;
    
    poly_fity.vals  = mean(VY.Data.vals(:));
    poly_fity.px = 0;
    poly_fity.py = 0;
    poly_fity.pz = 0;
    
    poly_fitz.vals  = mean(VZ.Data.vals(:));
    poly_fitz.px = 0;
    poly_fitz.py = 0;
    poly_fitz.pz = 0;
    
        
else   
    [px,py,pz]=meshgrid(0:fit_order,0:fit_order,0:fit_order);
    idx2 = find( (px+py+pz) <= fit_order);
    px = px(idx2);
    py = py(idx2);
    pz = pz(idx2);
    A = [px(:) py(:) pz(:)];
    
    N = size(A,1);
    
    AhA = zeros(N,N);
    AhBx = zeros(N,1);
    AhBy = zeros(N,1);
    AhBz = zeros(N,1);
        
    xrange = single( linspace(-1,1,size(VX.Data.vals,1)) );
    yrange = single( linspace(-1,1,size(VY.Data.vals,2)) );
    zrange = single( linspace(-1,1,size(VZ.Data.vals,3)) );
    
    axes(handles.status_axes);
    I = zeros(2,numel(zrange));
    
    for slice = 1:numel(zrange)
        
        I(:,slice)=1;
        imshow(I,[0 1]);
        daspect([13 1 1])
        set(gca,'XTickLabel','')
        set(gca,'YTickLabel','')
        drawnow
        
        vx_slice = single(VX.Data.vals(:,:,slice) );
        vy_slice = single(VY.Data.vals(:,:,slice) );
        vz_slice = single(VZ.Data.vals(:,:,slice) );
        
        [y,x,z] = meshgrid( yrange,xrange,zrange(slice) );  
        idx = find( Mask(:,:,slice) > 0);
        x = x(idx);
        y = y(idx);
        z = z(idx);
        vx_slice = vx_slice(idx);
        vy_slice = vy_slice(idx);
        vz_slice = vz_slice(idx);
        
        for i = 1:N
            for j = 1:N
                AhA(i,j) =  AhA(i,j) + sum( ( x.^px(i).*y.^py(i).*z.^pz(i)).*( ( x.^px(j).*y.^py(j).*z.^pz(j))));
            end
        end
        
        for i = 1:N
            AhBx(i) = AhBx(i) + sum( vx_slice.* ( x.^px(i).*y.^py(i).*z.^pz(i)));
            AhBy(i) = AhBy(i) + sum( vy_slice.* ( x.^px(i).*y.^py(i).*z.^pz(i)));
            AhBz(i) = AhBz(i) + sum( vz_slice.* ( x.^px(i).*y.^py(i).*z.^pz(i)));
        end
    end
        
    poly_fitx.vals = linsolve(AhA,AhBx);
    poly_fitx.px = px;
    poly_fitx.py = py;
    poly_fitx.pz = pz;
        
    poly_fity.vals = linsolve(AhA,AhBy);
    poly_fity.px = px;
    poly_fity.py = py;
    poly_fity.pz = pz;
    
    poly_fitz.vals = linsolve(AhA,AhBz);
    poly_fitz.px = px;
    poly_fitz.py = py;
    poly_fitz.pz = pz;
    
end
