function [res,qualMeasOut] = chambolle_pock_ILS_waituiZaiwai(real,proj,geo,angles,L,maxiter,return_energy)

gpuids = GpuIds();
tau=1.0/L;
sigma=1.0/L;

x=zeros(size(Atb(proj,geo,angles,'gpuids',gpuids)),'single');

p=zeros(size(proj),'single');

f=single(zeros(size(x)));
theta=1.0;
lambda=0.05;
lambdaz=0.00001;
ILS_iter = 4;
ILS_p = 0.6;
eps = 0.00001; 

sigma1= 3.14159 / 2.0 / 360;
% sigma1= 1;

qualMeasOut=zeros(4,maxiter);
k=5;
lambda1=0.00001;
for ii=1:maxiter
    tic;
    for i=1:k
        x_old=x;
        p=(p+sigma1*sigma*Ax(x,geo,angles,'gpuids',gpuids)-sigma*proj)./(1.0+sigma);
        x=(x-tau*Atb(p,geo,angles,'gpuids',gpuids)+lambda1*f)./(1+lambda1);       
        x_tilde = x + theta * (x - x_old);
        x=x_tilde;
        fprintf('[%d] :RMSE %.4f\t',i, RMSE(real,x));
        if(ii>15 && RMSE(real,x)> RMSE(real,x_old))
            k=1;
        end
    end
    f = ILS_LNorm_3D(x, lambda, lambdaz,ILS_p, eps, ILS_iter);
    f(f<0)=0;
%     x_tilde = x + theta * (x - x_old);
    x=f;
    time=toc;
%     fprintf('\n迭代次数[%d] :RMSE %.4f\t',ii, RMSE(real,f));
    fprintf('\n迭代次数[%d] :RMSE %.4f\t  迭代一次时间 %.4f\t'  ,ii, RMSE(real,f),time);

%     if return_energy==true
%         fidelity=im3Dnorm(sigma1*Ax(x,geo,angles,'gpuids',gpuids)-proj,'L2')*0.5;
%         tvx = im3Dnorm(Dx(x),'L1');
%         tvy = im3Dnorm(Dy(x),'L1');
%         tvz = im3Dnorm(Dz(x),'L1');
%         tv=tvx+tvy+tvz;
%         energy = 1.0 * fidelity + lambda * tvx+lambda*tvy+lambda*tvz;
% %         en(ii) = energy;
% %         if mod(ii,3)==0
% %             fprintf('\n 迭代次数[%d] : energy %.4f\t fidelity %.4f\t TV %.4f\t TVx %.4f\t TVy %.4f\t TVz %.4f\t',ii, energy, fidelity, tv,tvx,tvy,tvz);
% %         end
%     end
    res=x;
    qualMeasOut=Measure_Quality(real,res,ii,qualMeasOut);
%     fprintf('\n 迭代次数[%d] :energy %.4f\t fidelity %.4f\t RMSE %.4f\t 迭代一次时间 %.4f\t',ii, energy, fidelity, qualMeasOut(1,ii),time);
    if (ii==1)
        expected_time=toc*maxiter;
        disp('ADS-chambolle_pock_3Dz_DT_W');
        disp(['Expected duration   :    ',secs2hms(expected_time)]);
        disp(['Expected finish time:    ',datestr(datetime('now')+seconds(expected_time))]);
        disp('');
    end

   if mod(ii,2000)==0
        save(strcat('E:\CP-ILS-result\PCB\p=0.6\',num2str(ii)),'res');
   end
   if mod(ii,5000)==0
        save('E:\CP-ILS-result\PCB\p=0.6\qualMeasOut.mat','qualMeasOut');
   end
end
    