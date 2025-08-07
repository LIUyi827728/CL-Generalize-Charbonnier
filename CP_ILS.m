clc;
clear;
close all;

%%  
gpuids = GpuIds();
% a=ones(2,3,3);
% 
% data = reshape(1:9, 3, 3)';
% a(1,:,:)=data;
% a(2,:,:)=data;
% res=div_2D(a);
%% Define Geometry
geo=defaultGeometry();                     
geo.DSD = 815;                             % Distance Source Detector      (mm)
geo.DSO = 217;                             % Distance Source Origin        (mm)
% Detector parameters
geo.nDetector=[600; 600];					% number of pixels          (px)
geo.dDetector=[1; 1]; 					% size of each pixel            (mm)
geo.sDetector=geo.nDetector.*geo.dDetector; % total size of the detector    (mm)
% Image parameters
geo.nVoxel=[256;256;75];                   % number of voxels              (vx)
geo.sVoxel=[128;128;37.5];                   % total size of the image       (mm)
geo.dVoxel=geo.sVoxel./geo.nVoxel;          % size of each voxel            (mm)
%% Load data and generate projections 
gamma=pi*45/180;%斜入射的夹角
numProjs = 360;
anglesY=linspace(0,2*pi,numProjs);
angles=repmat(anglesY,[3 1]);
angles(2,:)=-(pi/2-gamma);
angles(3,:)=0;

load('PCB2.mat')
I=permute(I,[1 3 2]);
I=single(I);

% image_data = imread('lena.bmp');
% I=single(image_data);
% figure;
% imshow(I,[]);
sigma= 3.14159 / 2.0 / 360;
% sigma= 1;

% B=load('result.mat');
% imshow(B.res,[]);
% 
projections=sigma*Ax(I,geo,angles);
% 
% projections=Ax(I,geo,angles);
% noise_projections=addCTnoise(projections,'Poisson',30000,'Gaussian',[0,1.5]);
% noise_projections=sigma*noise_projections;
% load('30000-1.5.mat')

L = power_method(projections,geo,angles,20);
% L=9.052;

[res,qualMeasOut] = chambolle_pock_ILS_waituiZaiwai(I,projections,geo,angles,L,1000,true);

A=reshape(res(:,128,:),256,75);
E=reshape(res(:,:,30),256,256);
F=reshape(res(128,:,:),256,75);

figure
imshow(A,[0 1])
figure     
imshow(E,[0 1])
figure
imshow(F,[0 1])
%save('全W-x-y-0.05-z-0.0005-Dx(x)-facxy=1-facz=1-10000.mat','qualMeasOut')

% figure 
% A=reshape(res(:,:,30),256,256);
% imshow(A,[])

% A=gradient(S);
% [gx,gy,gz] = gradient(S,1,1,1);
% 
% L = power_method(projections,geo,angles,10);
% 
% 
% beta = 5e-2;  %weight of TV regularization
% n_it = 1000;  %number of iterations

% 
% data = reshape(1:9, [3,3])';  % 填充1到9的矩阵
% layer1 = cat(3, data, data,data);
% img =zeros([3,3,3,2]);
% I=permute(I,[1 3 2]);

figure
plot(qualMeasOut(1,:));
title('Evolution of RMSE per iteration')

figure
plot(qualMeasOut(2,:));
title('Evolution of CC per iteration')

figure
plot(qualMeasOut(3,:));
title('Evolution of MSSIM per iteration')

figure
plot(qualMeasOut(4,:));
title('Evolution of UQI per iteration')

disp(['RMSE:',num2str(RMSE(I,res)),...
     ',CC:',num2str(CC(I,res)),...
     ',MSSIM:',num2str(mssim1(I,res)),...
     ',UQI:',num2str(UQI(I,res))]);
% 
% file_path=['E:\811\CLprojection\CP\result\0.05-0.0005-fac=1\_RMSE_SaveFile.bin'];
% fid = fopen(file_path,'r'); %默认是小端存储
% % data = fread(fid,[256*256*75],'float');%大小是2048*12294，取第一个通道
% % res=reshape(data,256,256,75);
% qualMeasOut = fread(fid,[10000],'double');%大小是2048*12294，取第一个通道
% fclose(fid);
% 
% imshow(data,[])



