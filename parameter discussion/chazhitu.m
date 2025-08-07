S1=reshape(SART(:,9,:),350,350)-reshape(I(:,9,:),350,350);
S2=reshape(SART-TV(:,9,:),350,350)-reshape(I(:,9,:),350,350);
S3=reshape(AAR(:,9,:),350,350)-reshape(I(:,9,:),350,350);
S4=reshape(CP(:,9,:),350,350)-reshape(I(:,9,:),350,350);
S5=reshape(Ours(:,9,:),350,350)-reshape(I(:,9,:),350,350);

max(S1(:))
max(S2(:))
max(S3(:))
max(S4(:))
max(S5(:))
figure
imshow(S1,[ ]);
figure
imshow(S2,[ ]);colorbar;colormap jet
figure
imshow(S3,[ ]);colorbar;colormap jet
figure
imshow(S4,[ ]);colorbar;colormap jet
figure
imshow(S5,[ ]);colorbar;colormap jet



I=permute(I,[1 3 2]);
res=permute(res,[1 3 2]);
A=reshape(res(:,9,:),350,350);
E=reshape(res(:,:,175),350,50);
F=reshape(res(175,:,:),50,350);

figure
imshow(A,[0 1])
figure     
imshow(E,[0 1])
figure
imshow(F,[0 1])


I=permute(I,[1 3 2]);
res=permute(res,[1 3 2]);
res=abs(res-I);
F=reshape(res(175,:,:),50,350);
figure
imshow(F,[0 0.2])
