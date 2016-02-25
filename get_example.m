function [velx vely velz pressure flowr wss sx sy sz st dx dy dz dt] = get_example

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Exact solution to Navier-stokes for simple tube
%%%   Inputs:
%%%       [sx,sy,sz,st]         Size of Matrix to create
%%%       [dx,dy,dz,dt]         Spacing in each dir
%%%
%%%   Outputs:
%%%         WSS,Pressure,flow     Scalars with respect to time
%%%         velx,vely,velz        4D Matrix

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


dens=1; %g/cm^3
visc=4e-2; %p
T=1;    %s
dx =0.005;
dz =1.0;

%%%%%%1. Define input pressure/shear/flow

Pressure=0;
FLOW=0;
SHEAR=0;
C_0=20;
D  =30;
R=0.30;
C=[7.58 5.41 1.52 0.52 0.83 0.69 0.26 0.54 0.27 0.10];
Phi=[-174 89 -22 -34 -127 135 152 44 -72 11];
Phi=Phi/180*pi;
R=0.65;

%Plot Pressure
t= (0:19) / 20 *T; 
    
for n=1:10
    Pressure=Pressure + C(n).*cos( (2*n*pi/T)*t + Phi(n) );
    Grad= -D*cos(2*pi*n/T);
    Omega=2*pi*n/T;
    Worm  = R*sqrt( dens*Omega/visc);
    Lambda=( sqrt(-1)-1 )/sqrt(2)*Worm;
    FLOW=FLOW + sqrt(-1)*pi*R^4/visc/Worm^2*-D*C(n)*( (1-2*besselj(1,Lambda)/Lambda/besselj(0,Lambda) )*exp(sqrt(-1)*(Omega*t + Phi(n) ) ) );
    SHEAR=SHEAR + -R/Lambda*-D*C(n)*bessel(1,Lambda)/bessel(0,Lambda)*exp(sqrt(-1)*Omega*t + Phi(n) );

end
%Add zero frequency
Pressure=Pressure*D + C_0;
FLOW=FLOW + pi*R^4/8/visc*C_0;
SHEAR=SHEAR + -R/2*C_0;


%%%%%%%2.Fill Matrix





%Plots
figure
subplot(2,1,1)
[AX,H1,H2]=plotyy(t,real(SHEAR),t,Pressure);
title('Shear Part III Section ii', 'fontsize',18);
set(get(AX(1),'Ylabel'),'String','Shear (dynes/cm^2)','fontsize',16)
set(get(AX(2),'Ylabel'),'String','Pressure (dynes/cm^2)','fontsize',16)
subplot(2,1,2)
[AX,H1,H2]=plotyy(t,real(FLOW),t,Pressure);
title('Flow Part III Section ii', 'fontsize',18);
set(get(AX(1),'Ylabel'),'String','Flow (cm^2/s)','fontsize',16)
set(get(AX(2),'Ylabel'),'String','Pressure (dynes/cm^2)','fontsize',16)



figure
[x y]=meshgrid(-R:0.05:R, -R:0.05:R) ;
r= sqrt(x.^2+y.^2);

for i=1:length(x)
    for j=1:length(y)
        if r(i,j)>R
            r(i,j)=R;
        end
    end
end

sx = length(-R:dx:R);
sy = length(-R:dx:R);
sz = length(-R:dz:R);
st = 20;


Velocity=0;
for index=1:20

    t_sel=(index-1)/20*T ;
       
    Velocity=0*Velocity;
    for n=1:10
        Omega=2*pi*n/T;
        Worm  = R*sqrt( dens*Omega/visc);
        Lambda=( sqrt(-1)-1 )/sqrt(2)*Worm;
        ZETA= Lambda*r/R;
        %Velocity=Velocity + sqrt(-1)*R^2/visc/Worm^2*-D*C(n)*(1- besselj(0,ZETA)./besselj(0,Lambda) )*exp(sqrt(-1)*(Omega*t_sel+Phi(n)) );
        Velocity=Velocity + sqrt(-1)*R^2/visc/Worm^2*-D*C(n)*(1- besselj(0,ZETA)./besselj(0,Lambda) ).*exp(sqrt(-1)*(Omega*t_sel+Phi(n)) );
    end
    Velocity=Velocity + R^2/4/visc*-C_0*(1-r.^2/R^2);

%     surf(x,y,real(Velocity));
%     axis([-R R -R R -100 100]) ;
%     Zlabel('Velocity','FontSize',16);
%     drawnow 
    
    velz(:,:,:,index) = 10*real(repmat(Velocity,[1 1 length(-R:dz:R)]));
    vely(:,:,:,index) = 10*zeros(sx,sy,sz);
    velx(:,:,:,index) = 10*zeros(sx,sy,sz);
  
end


pressure = real(Pressure);
flowr    = real(FLOW);
wss      = real(SHEAR);

dx = dx;
dy = dx;
dz = dz;
dt = 1/20/T;


