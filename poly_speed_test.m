global rcxres;
global rcyres;
global rczres;
global MAG;
global VELX;
global VELY;
global VELZ;


idx = find( MAG > 0.6*max( MAG(:)));
%lots of memory problems!!! solve Ax = B by (A^hA) x = (A^h *b)
AhA = zeros(4,4);
AhB = zeros(4,1);

[x y z] = ind2sub([rcxres rcyres rczres],idx);

for pos = 1:length(idx)
    val = VELX(idx(pos));
    store = [1 x(pos) y(pos) z(pos)];
    AhA = AhA + store'*store;
    AhB = AhB + store'*val; 
end

AhA
AhB
p = linsolve(AhA,AhB)