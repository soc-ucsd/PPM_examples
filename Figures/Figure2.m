close all; clc; clear;

%An example of a nonconvex but weakly convex funciton
%This example shows that the equivalency between EB, PL, and QG still hold



%parameter setting 
width  = 9;     % Width in inches
height = 3.5;    % Height in inches
alw    = 0.75;    % AxesLineWidth
fsz    = 12;      % Fontsize
lw     = 2;      % LineWidth
msz    = 8;       % MarkerSize



start = 1.5;
x = linspace(-start,0,10000);

Interval_1 =  x<=-1;
Interval_2 =  (x>-1)&(x<-1/2);
Interval_3 =  x>=-1/2;

%function value
f(Interval_1) = 3*(x(Interval_1)+1).^2;
f(Interval_2) = -(x(Interval_2)).^2+1;
f(Interval_3) = 3*(x(Interval_3)+1).^2;


subplot(1,3,1);
plot(x,f);
hold on

%QG
QG = 2.5*(x+1).^2;
plot(x,QG);



%2 weakly convex
g = f + 1*x.^2;
plot(x,g,'color','#77AC30');
ylim([0,3]);
xlim([-start,0]);
xlabel('$x$','interpreter','latex');

legend('$f(x)$','$ 2.5 \cdot \mathrm{Dist}^2(x,S)$','$f(x) + x^2$'...
       ,'interpreter','latex','location','north','FontSize',fsz,'NumColumns',1,'Box','off');

set(gca, 'FontSize', fsz, 'LineWidth', alw,'TickLabelInterpreter','latex'); %<- Set properties
set(gcf, 'Position', [300 100  width*100, height*100]); %<- Set size
set(gca, 'Position', [0.1 0.2 0.225 0.7]); %<- Set properties



%%
subplot(1,3,2);

%Dist 
Dist = abs(x+1);
plot(x,Dist,'color','#7E2F8E');  
%xlim([-start,0]);

hold on
%Grad
Grad_1(Interval_1) = abs(3*2*(x(Interval_1)+1));
plot(x(Interval_1),Grad_1,'color','#EDB120');

%solid circle
temp  = find(Interval_1);
temp = temp(end);
plot(x(temp),Grad_1(end),'o','MarkerSize',6,'color',...
       '#EDB120','MarkerEdgeColor','#EDB120',...
       'MarkerFaceColor','#EDB120');


Grad_2 = abs(2*(x(Interval_2)));
plot(x(Interval_2),Grad_2,'color','#EDB120');

%hollow circle
temp  = find(Interval_2);
temp1 = temp(1);
temp2 = temp(end);
plot(x(temp1),Grad_2(1),'o','MarkerSize',6,'color','#EDB120');
plot(x(temp2),Grad_2(end),'o','MarkerSize',6,'color',...
       '#EDB120','MarkerEdgeColor','#EDB120',...
       'MarkerFaceColor','#EDB120');

Grad_3 = abs(3*2*(x(Interval_3)+1));
plot(x(Interval_3),Grad_3,'color','#EDB120');

temp  = find(Interval_3);
temp = temp(1);
plot(x(temp),Grad_3(1),'o','MarkerSize',6,'color','#EDB120');


ylim([0,6]);
box on

xlabel('$x$','interpreter','latex');
legend('$\mathrm{Dist}(x,S)$','$\mathrm{Dist}(0,\hat{\partial} f(x))$',...
    'interpreter','latex','location','north','FontSize',fsz,'NumColumns',1,'Box','off');

set(gca, 'FontSize', fsz, 'LineWidth', alw,'TickLabelInterpreter','latex'); %<- Set properties
set(gca, 'Position', [0.405 0.2 0.225 0.7]); %<- Set properties

%%
subplot(1,3,3);
plot(x,f);
hold on

plot(x(Interval_1),Grad_1.^2,'color',"#D95319");


%solid circle
temp = find(Interval_1);
temp = temp(end);
plot(x(temp),Grad_1(end),'o','MarkerSize',6,'color',...
       "#D95319",'MarkerEdgeColor',"#D95319",...
       'MarkerFaceColor',"#D95319");

plot(x(Interval_2),Grad_2.^2,'color',"#D95319");

%hollow circle
temp  = find(Interval_2);
temp1 = temp(1);
temp2 = temp(end);
plot(x(temp1),Grad_2(1)^2,'o','MarkerSize',6,'color',"#D95319");
plot(x(temp2),Grad_2(end)^2,'o','MarkerSize',6,'color',...
      "#D95319",'MarkerEdgeColor',"#D95319",...
       'MarkerFaceColor',"#D95319");

plot(x(Interval_3),Grad_3.^2,'color',"#D95319");
temp = find(Interval_3);
temp = temp(1);
plot(x(temp),Grad_3(1)^2,'o','MarkerSize',6,'color',"#D95319");


xlabel('$x$','interpreter','latex');
ylim([0,36]);
legend('$f(x)$','$\mathrm{Dist}^2(0,\hat{\partial} f(x))$'...
       ,'interpreter','latex','location','north','FontSize',fsz,'NumColumns',1,'Box','off');

set(gca, 'FontSize', fsz, 'LineWidth', alw,'TickLabelInterpreter','latex'); %<- Set properties
set(gca, 'Position', [0.71 0.2 0.225 0.7]); %<- Set properties


%print("Figure\Example-weaklyconvex-Equivalence",'-depsc','-tiff');



