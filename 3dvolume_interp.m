function mag_slice = 3dvolume_interp( MAG,X,Y,Z,IM_SZ)

%%Get a starting point
XF = floor(X);
YF = floor(Y);
ZF = floor(Z);

%%find points outside matrix
MASK = (XF < 1 ) | (YF < 1) | (ZF < 1) | (XF > rcxres-1) | (YF > rcyres-1) | (ZF > rczres-1);
idx = find(MASK);
XF(idx) = 1;
YF(idx) = 1;
ZF(idx) = 1;

dx = (XX_2d_r(:) - XF(:)).*double(1-MASK(:));
dy = (YY_2d_r(:) - YF(:)).*double(1-MASK(:));
dz = (ZZ_2d_r(:) - ZF(:)).*double(1-MASK(:));
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

