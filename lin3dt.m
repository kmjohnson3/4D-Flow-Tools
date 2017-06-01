function [ v ] =lin3dt( IMAGE2,time,x,y,z)

if(round([x y x])==[x y z])
    v = IMAGE2(x,y,z,time);
else 

% P = [x y z];
% biaspoint=floor(P);                 %sets start point for trilinear interp
% point2=biaspoint + [1 0 0];         %then the eight corners around the cube
% point3=biaspoint + [1 1 0];
% point4=biaspoint + [1 0 1];
% point5=biaspoint + [1 1 1];
% point6=biaspoint + [0 0 1];
% point7=biaspoint + [0 1 1];
% point8=biaspoint + [0 1 0];
% 
% deltax = x - floor(x);
% deltay = y - floor(y);
% deltaz = z - floor(z);
% 
% v=(IMAGE2(biaspoint(1),biaspoint(2),biaspoint(3)))*(1-deltax)*(1-deltay)*(1-deltaz)+ ...
%     (IMAGE2(point2(1),point2(2),point2(3)))*(deltax)*(1-deltay)*(1-deltaz)+...
%     (IMAGE2(point3(1),point3(2),point3(3)))*(deltax)*(deltay)*(1-deltaz)+...
%     (IMAGE2(point4(1),point4(2),point4(3)))*(deltax)*(1-deltay)*(deltaz)+...
%     (IMAGE2(point5(1),point5(2),point5(3)))*(1-deltax)*(1-deltay)*(deltaz)+...
%     (IMAGE2(point6(1),point6(2),point6(3)))*(1-deltax)*(deltay)*(deltaz)+...
%     (IMAGE2(point7(1),point7(2),point7(3)))*(deltax)*(deltay)*(deltaz)+...
%     (IMAGE2(point8(1),point8(2),point8(3)))*(1-deltax)*(deltay)*(1-deltaz);

sx = floor(x);
sy = floor(y);
sz = floor(z);

delx=x-sx;                  %the relative positions with respect to the bias point
dely=y-sy;
delz=z-sz;
mdelx = 1.0 - delx;
mdely = 1.0 - dely;
mdelz = 1.0 - delz;

if( ( sx<1) || (sy<1) || (sz<1) )
    v=0;
elseif (  ( sx>=size(IMAGE2,1)) || ( sy>=size(IMAGE2,2)) || ( sz>=size(IMAGE2,3)) )
v=0;
else
v =(mdelx*(IMAGE2(sx  ,sy  ,sz  ,time)*mdely + ... 
           IMAGE2(sx  ,sy+1,sz  ,time)*dely) + ... 
    delx* (IMAGE2(sx+1,sy  ,sz  ,time)*mdely + ...
           IMAGE2(sx+1,sy+1,sz  ,time)*dely) )*mdelz + ...
   (mdelx*(IMAGE2(sx  ,sy  ,sz+1,time)*mdely + ... 
           IMAGE2(sx  ,sy+1,sz+1,time)*dely) + ... 
    delx* (IMAGE2(sx+1,sy  ,sz+1,time)*mdely + ...
           IMAGE2(sx+1,sy+1,sz+1,time)*dely) )* delz;
end
       
end




