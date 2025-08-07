%   Distribution code Version 1.0 -- 02/31/2020 by Wei Liu Copyright 2020
%
%   The code is created based on the method described in the following paper 
%   [1] "Real-time Image Smoothing via Iterative Least Squares", Wei Liu, Pingping Zhang, 
%        Xiaolin Huang, Jie Yang, Chunhua Shen and Ian Reid, ACM Transactions on Graphics, 
%        presented at SIGGRAPH 2020. 
%  
%   The code and the algorithm are for non-comercial use only.


%  ---------------------- Input------------------------
%  F:              input image, can be gray image or RGB color image
%  lambda:     \lambda in Eq.(1), control smoothing strength
%  p:              the power norm in the Charbonnier penalty in Eq. (2)
%  eps:          the small constant number in the Charbonnier penalty in Eq. (2)
%  iter:           iteration number of the ILS in Eq. (8)

%  ---------------------- Output------------------------
%  U:             smoothed image

function U =ILS_LNorm_3D(F, lambda,lambdaz, p, eps, iter)

F = single(F); % 'single' precision is very important to reduce the computational cost

gamma = 0.5 * p - 1;
c =  p * eps^gamma;

[N, M, D] = size(F);

sizeI3D = [N,M,D];

fx = [1, -1];
fy = [1; -1];
fz = permute([1, -1], [3, 1, 2]);%z方向的差分算子
otfFx = psf2otf(fx,sizeI3D);
otfFy = psf2otf(fy,sizeI3D);
otfFz = psf2otf(fz,sizeI3D);

%sizeI2D = [N, M];
% otfFx = psf2otf_Dx(sizeI2D); % equal to otfFx = psf2otf(fx, sizeI2D) where fx = [1, -1];
% otfFy = psf2otf_Dy(sizeI2D); % equal to otfFy = psf2otf(fy, sizeI2D) where fy = [1; -1];

Denormin1 = abs(otfFx).^2 + abs(otfFy ).^2;
Denormin2 = abs(otfFz).^2;
Denormin = 1 + 0.5 * c * lambda * Denormin1 + 0.5  * c * lambdaz *Denormin2;

U = F; % smoothed image

Normin1 = fftn(U);

for k = 1: iter
    
    % Intermediate variables \mu update, in x-axis and y-axis direction
    u_h = [diff(U,1,2), U(:,1,:) - U(:,end,:)];
    u_v = [diff(U,1,1); U(1,:,:) - U(end,:,:)];
    u_d = cat(3,diff(U,1,3),U(:,:,1) - U(:,:,end));
        
    mu_h = c .* u_h - p .* u_h .* (u_h .* u_h + eps) .^ gamma;
    mu_v = c .* u_v - p .* u_v .* (u_v .* u_v + eps) .^ gamma;
    mu_d = c .* u_d - p .* u_d .* (u_d .* u_d + eps) .^ gamma;
    
    % Update the smoothed image U
    Normin2_h = [mu_h(:,end,:) - mu_h(:, 1,:), - diff(mu_h,1,2)];
    Normin2_v = [mu_v(end,:,:) - mu_v(1, :,:); - diff(mu_v,1,1)];
    Normin2_d = cat(3,mu_d(:,:,end) - mu_d(:,:,1),-diff(mu_d,1,3));
    
    FU = (Normin1 + 0.5 * lambda * (fftn(Normin2_h + Normin2_v))+0.5 * lambdaz*fftn(Normin2_d)) ./ Denormin;
    U = real(ifftn(FU));
    
    Normin1 = FU;  % This helps to further enlarge the smoothing strength
    
end
