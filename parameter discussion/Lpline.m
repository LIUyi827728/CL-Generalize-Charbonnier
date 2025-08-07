clear, clc
close all
x=-3:0.1:3;
y0=abs(x);                  % L1
y1=(x.^2+0.000001).^0.5;    % p=1
y2=(x.^2+0.000001).^0.4;    % p=0.8
y3=(x.^2+0.000001).^0.3;    % p=0.6
deta=1;
y4=zeros(1,61);             % huber
count=0;
for x=-3:0.1:3
    count=count+1;
    if abs(x)<=deta
        y4(count)=x^2/2;
    else
        y4(count)=deta*abs(x)-deta*deta/2;
    end
end
x=-3:0.1:3;
figure
% plot(x,y0,'linewidth',2.5,'color',[0.701 0.364 0.807]);% 紫
% hold on   % 使图形在一个界面上画
% plot(x,y1,'linewidth',2.5,'color',[0.015 0.007 0.921]);% 蓝
% plot(x,y2,'linewidth',2.5,'color',[0.749 0.117 0.180]);% 红
% plot(x,y3,'linewidth',2.5,'color',[0.941 0.396 0.054]);% 橙
% plot(x,y4,'linewidth',2.5,'color',[0.035 0.658 0.035]);% 绿


plot(x, y0, '-', 'LineWidth', 3.5,'color',[0.984 0.518 0.008]);     % L1：
hold on
plot(x, y1, '--', 'LineWidth', 2.5,'color',[1.000 0.918 0.132]);    % p=1
plot(x, y2, '-', 'LineWidth', 2.5,'color',[0.701 0.364 0.807]);     % p=0.8
plot(x, y3, '-', 'LineWidth', 2.5,'color',[0.015 0.007 0.921]);     % p=0.6
plot(x, y4, '-', 'LineWidth', 2.5,'color',[0.035 0.658 0.035]);     % Huber

xlabel('$x$', 'Interpreter','latex', 'FontSize', 20);
ylabel('$\phi(x)$', 'Interpreter','latex', 'FontSize', 20);

legend('L1','p=1.0','p=0.8', 'p=0.6', 'Huber','FontName','Times New Roman','fontsize',18)
set(gca,'Box','on','FontName','Times New Roman','fontsize',18)
legend('boxoff')
% ylim([0 3]);

% ylim([0 4]);

axis tight;