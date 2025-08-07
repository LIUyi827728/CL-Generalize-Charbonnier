function L = power_method(proj,geo,angles,niter)

%% Deal with input parameters


gpuids = GpuIds();
sigma= 3.14159 / 2.0 / 360;
% sigma= 1;
tic;   

%%  计算L
x = Atb(proj,geo,angles,'gpuids',gpuids);
for k=1:niter
%     a=Dxt(x);
%     b=Dyt(x);
%     c=zt(x);
%     x=Atb(sigma*Ax(x,geo,angles,'gpuids',gpuids),geo,angles,'gpuids',gpuids)+a+b+c;
    
    x=Atb(sigma*Ax(x,geo,angles,'gpuids',gpuids),geo,angles,'gpuids',gpuids);
    s=im3Dnorm(x,'L2');
    x=x/s;
    %s=Ax(x,geo,angles,'gpuids',gpuids);
    s = sqrt(s);
end
L = s;
elapsedTime = toc;
% 输出执行时间
fprintf('计算L花费时间(不包含权重计算) %.4f 秒。\n', elapsedTime);
end


