function d = Dz(u)
[rows,cols,height] = size(u);
d = zeros(rows,cols,height);
d(:,:,2:height) = u(:,:,2:height)-u(:,:,1:height-1);
d(:,:,1) = u(:,:,1)-u(:,:,height);
return