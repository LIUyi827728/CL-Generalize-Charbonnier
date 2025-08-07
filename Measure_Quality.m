function [qualMeasOut]=Measure_Quality(res_prev,res,iter,qualMeas)
% 'RMSE'
 a=RMSE(res_prev,res);
 qualMeas(1,iter)=a;
%%%%%%CC
 b=CC(res_prev,res); 
 qualMeas(2,iter)=b;
%%%%%%MSSIM
 c=mssim1(res_prev,res);
 qualMeas(3,iter)=c;
% 'UQI'
 d=UQI(res_prev,res);
 qualMeas(4,iter)=d;

qualMeasOut=qualMeas;




end