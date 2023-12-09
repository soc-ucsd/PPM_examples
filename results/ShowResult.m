close all;clc; clear;

%description

%parameter setting 
width  = 9;     % Width in inches
height = 2.5;    % Height in inches
alw    = 0.75;    % AxesLineWidth
fsz    = 11;      % Fontsize
lw     = 2;      % LineWidth
msz    = 8;       % MarkerSize

%datapath = 'results/';
%name     = {'a1a','a2a','a3a','a4a'};
%'a1a','duke','breast-cancer_scale'
%name     = {'australian_scale','diabetes_scale','fourclass_scale'};
name      = {'diabetes_scale','heart_scale','ionosphere_scale','sonar_scale','iris_scale','german_numer_scale','a1a','australian_scale','fourclass_scale'};
%name      = {'diabetes_scale'};
range = 1:10;
colors = {[0 0.4470 0.7410],[0.8500 0.3250 0.0980],[0.4940 0.1840 0.5560],...
          [0.9290 0.6940 0.1250],[0.4660 0.6740 0.1880],[0.3010 0.7450 0.9330],...
          [1 0 0],[0 0 1],[0 1 0]}; 
svm_data        = {'diabetes_scale','heart_scale','ionosphere_scale'};
lasso_data      = {'n10m40s5','n20m50s10','n30m60s15'};
ElasticNet_data = {'n10m40s5','n20m50s10','n30m60s15'};
      
      
for i = 1:3
    Out_Truth = load(['GroundTrue/SVM/',name{i+6},'.mat']);
    Out_PPM   = load(['PPM/SVM/',name{i+6},'_result.mat']);
    trueobj   = Out_Truth.Out.obj;
    obj       = Out_PPM.Out.obj;
    subplot(1,3,1);
    semilogy(range,abs((obj(range)-trueobj)/trueobj),'-o','LineWidth',1,'Color',colors{i});
    hold on
end
xlabel('Iteration');
ylabel('$(f(x_k) - f^\star)/f^\star $','interpreter','latex');

for i = 1:3
    Out_Truth = load(['GroundTrue/Lasso/',lasso_data{i},'.mat']);
    Out_PPM   = load(['PPM/Lasso/',lasso_data{i},'_result.mat']);
    trueobj   = Out_Truth.Out.obj;
    obj       = Out_PPM.Out.obj;
    subplot(1,3,2);
    semilogy(range,abs((obj(range)-trueobj)/trueobj),'-o','LineWidth',1,'Color',colors{i});
    hold on
end
xlabel('Iteration');
ylabel('$(f(x_k) - f^\star)/f^\star $','interpreter','latex'); 


for i = 1:3
    Out_Truth = load(['GroundTrue/ElasticNet/',ElasticNet_data{i},'.mat']);
    Out_PPM   = load(['PPM/ElasticNet/',ElasticNet_data{i},'_result.mat']);
    trueobj   = Out_Truth.Out.obj;
    obj       = Out_PPM.Out.obj;
    subplot(1,3,3);
    semilogy(range,abs((obj(range)-trueobj)/trueobj),'-o','LineWidth',1,'Color',colors{i});
    hold on
end
xlabel('Iteration');
ylabel('$(f(x_k) - f^\star)/f^\star $','interpreter','latex');

% for i = 1:length(name)
%     if i >= 1 && i<=3 
%         
%     elseif i >= 4 && i<=6
%  
%     else 
%         Out_Truth = load(['GroundTrue/ElasticNet/',name{i},'.mat']);
%         Out_PPM   = load(['PPM/',name{i},'_result.mat']);
%         trueobj   = Out_Truth.Out.obj;
%         obj       = Out_PPM.Out.obj;
%         subplot(1,3,3);
%         semilogy(range,abs((obj(range)-trueobj)/trueobj),'-o','LineWidth',1,'Color',colors{i});
%     end
%     hold on
% end

subplot(1,3,1);
legend('SVM1','SVM2','SVM3','interpreter','latex');
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
set(gcf, 'Position', [300 100  width*100, height*100]); %<- Set size
set(gca, 'Position', [0.125 0.2 0.2 0.7]); %<- Set properties


subplot(1,3,2);
ax = gca;
ylim([ax.YLim(1),5*10^4]);
legend('LASSO1','LASSO2','LASSO3','interpreter','latex');
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
set(gca, 'Position', [0.425 0.2 0.2 0.7]); %<- Set properties


subplot(1,3,3);
ax = gca;
ylim([ax.YLim(1),5*10^4]);
legend('ELASTIC1','ELASTIC2','ELASTIC3','interpreter','latex');
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
set(gca, 'Position', [0.725 0.2 0.2 0.7]); %<- Set properties



hold off

%xlim([1,10]);

%hL = legend;
%hL.Layout.Tile = 'East';
% hL = legend('data1','data2','data3',...
%            'data4','data5','data6',...
%            'data7','data8','data9','interpreter','latex');
% hL.Layout.Tile = 'East';


print("Figure\cost_gap",'-depsc','-tiff');
