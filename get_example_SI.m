%function [velx vely velz pressure flowr wss sx sy sz st dx dy dz dt] = get_example

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
clc
close all
clear 

dens=1000;      %kg/m^3
visc=4e-3;      %
T=1;            %s

%%%%%%1. Define input pressure/shear/flow
Pressure=0;
FLOW=0;
SHEAR=0;
C_0=0; %2800.0; %Constant Pressure Drop (Pa/m)
D = 300.0; %Dynamic Scaling Factor (Pa/m)
R  =0.002; %Radius in Meters
C=[7.58 5.41 1.52 0.52 0.83 0.69 0.26 0.54 0.27 0.10];
Phi=[-174 89 -22 -34 -127 135 152 44 -72 11]/180*pi;
C = D*C;

%Plot Pressure
t= (0:19) / 20 *T; 
    
for n=1:10

    %parameters
%     Omega=2*pi*n/T;
%     Worm  = sqrt( R*dens*Omega/visc);
%     Lambda= sqrt(-1)^(3/2)*Worm;
%        %( sqrt(-1)-1 )/sqrt(2)*Worm;
    Omega=2*pi*n/T;
    Lambda= sqrt( sqrt(-1)^3*Omega*dens/visc);
       
    Pressure=Pressure + C(n).*cos(Omega*t + Phi(n) );
    FLOW = FLOW + real( pi*R^4 * C(n) * exp( sqrt(-1)*(Omega*t + Phi(n))) / ( visc * Lambda^2 * R^2 )* ( 1 - 2*besselj(1,Lambda*R)/(Lambda*R*besselj(0,Lambda*R)) ));
    SHEAR= SHEAR + real( C(n)/Lambda* exp( sqrt(-1)*(Omega*t + Phi(n))) * besselj(1,Lambda*R)/besselj(0,Lambda*R));
        
    %FLOW=FLOW + sqrt(-1)*pi*R^4/visc/Worm^2*-D*C(n)*( (1-2*besselj(1,Lambda)/Lambda/besselj(0,Lambda) )*exp(sqrt(-1)*(Omega*t + Phi(n) ) ) );
    %SHEAR=SHEAR + -R/Lambda*-D*C(n)*bessel(1,Lambda)/bessel(0,Lambda)*exp(sqrt(-1)*Omega*t + Phi(n) );
end
%Add zero frequency
Pressure=Pressure + C_0;
FLOW= FLOW + pi*R^4/8/visc*C_0;
SHEAR=SHEAR + -R/2*C_0;


figure
plot(t,FLOW*10^6);
title('Flow');
ylabel('flow (ml/s)');
xlabel('time(s)');

figure
plot(t,Pressure*0.0075);
title('Pressure');
ylabel('Pressure Gradient (mmHg/m)');
xlabel('time(s)');

figure
plot(t,SHEAR);
title('Shear Stress');
ylabel('Stress (Pa)');
xlabel('time(s)');


%%%Fill Matrix
fov = 0.015; %5 cm fov
res = 64;  %3s resolution
spc = linspace(-fov/2,fov/2,res);

[x y z] = meshgrid(spc,spc,spc);
r = sqrt( x(:,:,1).^2 + y(:,:,1).^2);
idx = find(r>R);
r(idx)=R;

dx = spc(2)-spc(1);

Velocity=0;
for index=1:20
    t_sel=t(index) ;
      
    Velocity=0*Velocity;
    for n=1:10
        Omega=2*pi*n/T;
        Lambda= sqrt( sqrt(-1)^3*Omega*dens/visc);
        SHAPE = ( 1 - besselj(0,Lambda*r)/besselj(0,Lambda*R));
        NUM = C(n)*exp( sqrt(-1)*(Omega*t_sel + Phi(n)));
        DEM = visc*Lambda^2;
        Velocity = Velocity + real( NUM/DEM*SHAPE);
               
        %Velocity=Velocity + sqrt(-1)*R^2/visc/Worm^2*besselj(0,ZETA)./besselj(0,Lambda) )*exp(sqrt(-1)*(Omega*t_sel+Phi(n)) );
        %Velocity=Velocity + sqrt(-1)*R^2/visc/Worm^2*-D*C(n)*(1- besselj(0,ZETA)./besselj(0,Lambda) ).*exp(sqrt(-1)*(Omega*t_sel+Phi(n)) );
    end
    Velocity=Velocity + R^2/4/visc*C_0*(1-r.^2/R^2);

    surf(x(:,:,1),y(:,:,1),real(Velocity),'EdgeColor','none');
    axis([-fov/2 fov/2 -fov/2 fov/2 -1 1]) ;
    Zlabel('Velocity','FontSize',16);
    drawnow 
    M(index)=getframe;
    
    velz(:,:,:,index) = 1000*real(repmat(Velocity,[1 1 length(spc)]));
    vely(:,:,:,index) = 1000*zeros(size(x));
    velx(:,:,:,index) = 1000*zeros(size(x));
  
end




Velocity=0;
r= [R-0.00001 R];
for index=1:20
    t_sel=t(index) ;
    
    VT=0
    for n=1:10
        Omega=2*pi*n/T;
        Lambda= sqrt( sqrt(-1)^3*Omega*dens/visc);
        SHAPE = ( 1 - besselj(0,Lambda*r)/besselj(0,Lambda*R));
        NUM = C(n)*exp( sqrt(-1)*(Omega*t_sel + Phi(n)));
        DEM = visc*Lambda^2;
        VT = VT + real( NUM/DEM*SHAPE);
               
    end
    VT=VT + R^2/4/visc*C_0*(1-r.^2/R^2);
    
    SHEARt(index) = ( VT(2)-VT(1) )/0.00001*visc;
  
  
end

FLOWt= squeeze( sum(sum(velz(:,:,16,:),1),2))*dx*dx/1000;
figure
plot(t,FLOWt*10^6);
title('FlowT');
ylabel('flow (ml/s)');
xlabel('time(s)');

figure
plot(t,SHEARt);
title('ShearT');
ylabel('WSS (Pa)');
xlabel('time(s)');

dx = spc(2)-spc(1)
dy = spc(2)-spc(1)
dz = spc(2)-spc(1)
dt = 1/20/T

break 

%%%%%Export To Files
cmd = mean(sqrt(velx.^2 + vely.^2 + velz.^2),4);
fid=fopen('CD.dat','w');
fwrite(fid,cmd,'float');
fclose(fid);

vx_name = 'comp_vd_1.dat';
vy_name = 'comp_vd_2.dat';
vz_name = 'comp_vd_3.dat';

fid=fopen(vx_name,'w');
fwrite(fid,mean(velx,4),'short');
fclose(fid);

fid=fopen(vy_name,'w');
fwrite(fid,mean(vely,4),'short');
fclose(fid);

fid=fopen(vz_name,'w');
fwrite(fid,mean(velz,4),'short');
fclose(fid);

for time = 1:20
     vx_name = sprintf('ph_%03d_vd_1.dat',time-1);
     vy_name = sprintf('ph_%03d_vd_2.dat',time-1);
     vz_name = sprintf('ph_%03d_vd_3.dat',time-1);
     
     fid=fopen(vx_name,'w');
     fwrite(fid,velx(:,:,:,time),'short');
     fclose(fid);
     
     fid=fopen(vy_name,'w');
     fwrite(fid,vely(:,:,:,time),'short');
     fclose(fid);
     
     fid=fopen(vz_name,'w');
     fwrite(fid,velz(:,:,:,time),'short');
     fclose(fid);
end
     
     
     
     
     
     



