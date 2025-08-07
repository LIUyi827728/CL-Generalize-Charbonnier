% figure;
% % 生成 x 值
% x = linspace(0, 20000, 1);
% % 生成 y 值
% y1 = sin(x);
% y2 = cos(x);
% y3 = tan(x);
% % 绘制曲线并指定颜色
% plot(x, y1, 'r', 'LineWidth', 1);     % 线条颜色为红色
% hold on;                             % 在同一个图上绘制其他曲线
% % plot(x, y2, 'g--', 'LineWidth', 2);   % 线条颜色为绿色，使用虚线
% % plot(x, y3, 'b:', 'LineWidth', 2);    % 线条颜色为蓝色，使用点线
% 
% plot(x, y2, 'g', 'LineWidth', 1);
% plot(x, y3, 'b', 'LineWidth', 1); 
% 
% % 添加标注
% legend('y = sin(x)', 'y = cos(x)', 'y = tan(x)');
% 
% % 添加标题和坐标轴标签
% title('多条曲线');
% xlabel('x');
% ylabel('y');
% 
% % 显示网格
% % grid on;
% % 调整图像边界
% axis tight;


RMSE=zeros(5,1000);
RMSE(1,:)=qualMeasOut(1,:);



figure;
% 绘制曲线并指定颜色
plot(RMSE(1,:), 'r', 'LineWidth', 1.5);     % 线条颜色为红色
hold on;                             % 在同一个图上绘制其他曲线
plot(RMSE(2,:), 'b', 'LineWidth', 1.5);
plot(RMSE(3,:), 'g', 'LineWidth', 1.5); 
plot(RMSE(4,:), 'c', 'LineWidth', 1.5);
plot(RMSE(5,:), 'k', 'LineWidth', 1.5); 
% plot(RMSE(6,:), 'y', 'LineWidth', 1); 

figure
plot(RMSE(1,1:500),'linewidth',2.5,'color',[0.03 0.26 0.02]);
% semilogy(1:8000,RMSE(1,:),'linewidth',2,'color',[0.89 0.26 0.52]);
hold on   % 使图形在一个界面上画
plot(RMSE(2,1:500),'linewidth',2.5,'color',[0.18 0.59 0.65]);
plot(RMSE(3,1:500),'linewidth',2.5,'color',[0.82 0.16 0.13]);
plot(RMSE(4,1:500),'linewidth',2.5,'color',[0.15 0.93 0.42]);
plot(RMSE(5,1:500),'linewidth',2.5,'color',[0.199 0.15 0.95]);

%延长线
x1=501:size(RMSE,2);
x2=601:size(RMSE,2);
plot(x1,RMSE(1,501:end),'--','linewidth',2.5,'color',[0.03 0.26 0.02]);
% semilogy(1:8000,RMSE(1,:),'linewidth',2,'color',[0.89 0.26 0.52]);
hold on   % 使图形在一个界面上画
plot(x1,RMSE(2,501:end),'--','linewidth',2.5,'color',[0.18 0.59 0.65]);
plot(x1,RMSE(3,501:end),'--','linewidth',2.5,'color',[0.82 0.16 0.13]);
plot(x2,RMSE(5,601:end),'--','linewidth',2.5,'color',[0.199 0.15 0.95]);

%画星号
plot(500,RMSE(1,500),'*','Markersize',10,'linewidth',2.5,'color',[0.03 0.26 0.02]);
% semilogy(1:8000,RMSE(1,:),'linewidth',2,'color',[0.89 0.26 0.52]);
hold on   % 使图形在一个界面上画
plot(500,RMSE(2,500),'*','Markersize',10,'linewidth',2.5,'color',[0.18 0.59 0.65]);
plot(500,RMSE(3,500),'*','Markersize',10,'linewidth',2.5,'color',[0.82 0.16 0.13]);
plot(600,RMSE(5,600),'*','Markersize',10,'linewidth',2.5,'color',[0.199 0.15 0.95]);


xlabel('Iterations','FontName','Times New Roman','fontsize',12);
ylabel('RMSE','FontName','Times New Roman','fontsize',12);

legend('SART','SART-TV', 'AAR','AAwTV-CP',...
    'Ours','FontName','Times New Roman','fontsize',14)

set(gca,'Box','on','FontName','Times New Roman','fontsize',14)
% set(gca,'xtick',[0 100 200 300 400 500],'fontsize',15);
set(gca,'ytick',[0.05 0.15 0.25 0.35 0.45 0.55]);
legend('boxoff')

% save('工件-噪声.mat','RMSE')

x=-3:0.1:3;
y1=(x.^2+0.000001).^0.5;
y2=(x.^2+0.000001).^0.4;
y3=(x.^2+0.000001).^0.3;
figure
plot(x,y1,'linewidth',2.5,'color',[0.03 0.46 0.02]);
% semilogy(1:8000,RMSE(1,:),'linewidth',2,'color',[0.89 0.26 0.52]);
hold on   % 使图形在一个界面上画
plot(x,y2,'linewidth',2.5,'color',[0.18 0.59 0.65]);
plot(x,y3,'linewidth',2.5,'color',[0.82 0.16 0.13]);
legend('p=1.0','p=0.8', 'p=0.6','FontName','Times New Roman','fontsize',18)
set(gca,'Box','on','FontName','Times New Roman','fontsize',18)
legend('boxoff')