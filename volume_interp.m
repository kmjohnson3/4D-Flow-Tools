function mag_slice = volume_interp( MAG,X,Y,Z,IM_SZ)

%%Get a starting point
XF = floor(X);
YF = floor(Y);
ZF = floor(Z);

%%find points outside matrix
MASK = (XF < 1 ) | (YF < 1) | (ZF < 1) | (XF > size(MAG,1)-1) | (YF > size(MAG,2)-1) | (ZF > size(MAG,3)-1);
idx = find(MASK);
XF(idx) = 1;
YF(idx) = 1;
ZF(idx) = 1;

dx = (X(:) - XF(:)).*double(1-MASK(:));
dy = (Y(:) - YF(:)).*double(1-MASK(:));
dz = (Z(:) - ZF(:)).*double(1-MASK(:));
mdx = (1 - dx).*double(1-MASK(:));
mdy = (1 - dy).*double(1-MASK(:));
mdz = (1 - dz).*double(1-MASK(:));

mag_slice=zeros(IM_SZ);
idx = sub2ind(size(MAG),XF,YF,ZF);
mag_slice(:)= mag_slice(:)+  mdy.*mdx.*mdz.*MAG(idx(:));
idx = sub2ind(size(MAG),XF,YF+1,ZF);
mag_slice(:)= mag_slice(:)+  mdx.*dy.*mdz.*MAG(idx(:));
idx = sub2ind(size(MAG),XF+1,YF,ZF);
mag_slice(:)= mag_slice(:)+  dx.*mdy.*mdz.*MAG(idx(:));
idx = sub2ind(size(MAG),XF+1,YF+1,ZF);
mag_slice(:)= mag_slice(:)+  dx.*dy.*mdz.*MAG(idx(:));
idx = sub2ind(size(MAG),XF,YF,ZF+1);
mag_slice(:)= mag_slice(:)+  mdx.*mdy.*dz.*MAG(idx(:));
idx = sub2ind(size(MAG),XF,YF+1,ZF+1);
mag_slice(:)= mag_slice(:)+  mdx.*dy.*dz.*MAG(idx(:));
idx = sub2ind(size(MAG),XF+1,YF,ZF+1);
mag_slice(:)= mag_slice(:)+  dx.*mdy.*dz.*MAG(idx(:));
idx = sub2ind(size(MAG),XF+1,YF+1,ZF+1);
mag_slice(:)= mag_slice(:)+  dx.*dy.*dz.*MAG(idx(:));

