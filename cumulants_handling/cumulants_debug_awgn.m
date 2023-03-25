%awgn and 200k

qam16_sps1_mean_84=6.8989;
qam16_sps1_std_84=3.8328;

qam16_sps1_mean_63= 1.2422;
qam16_sps1_std_63= 0.5684;

qam16_sps1_mean_42=0.4684;
qam16_sps1_std_42=0.1579;


qam16_sps2_mean_84=3.0517;
qam16_sps2_std_84=1.8395;

qam16_sps2_mean_63= 0.7121;
qam16_sps2_std_63=0.3450;

qam16_sps2_mean_42= 0.3469;
qam16_sps2_std_42=0.1225;

qam16_sps8_mean_84=4.6037;
qam16_sps8_std_84=2.8865;

qam16_sps8_mean_63=0.9237;
qam16_sps8_std_63=0.4555;

qam16_sps8_mean_42=0.3888;
qam16_sps8_std_42=0.1394;


qam16_sps32_mean_84=5.9742;
qam16_sps32_std_84=4.6925;

qam16_sps32_mean_63=1.0913;
qam16_sps32_std_63=0.6254;

qam16_sps32_mean_42=0.4150
qam16_sps32_std_42=0.1603;

%apsk16
apsk16_sps1_mean_84=8.1995;
apsk16_sps1_std_84= 4.5631;

apsk16_sps1_mean_63=1.3909;
apsk16_sps1_std_63=0.6418;

apsk16_sps1_mean_42= 0.5125;
apsk16_sps1_std_42=0.1758;


apsk16_sps2_mean_84=3.6943;
apsk16_sps2_std_84=2.1745;

apsk16_sps2_mean_63= 0.8041;
apsk16_sps2_std_63=0.3874;

apsk16_sps2_mean_42=0.3858;
apsk16_sps2_std_42=0.1359;

apsk16_sps8_mean_84= 5.4182;
apsk16_sps8_std_84=3.3453;

apsk16_sps8_mean_63= 1.0270;
apsk16_sps8_std_63=0.5016;

apsk16_sps8_mean_42=0.4265;
apsk16_sps8_std_42=0.1507;

apsk16_sps32_mean_84=6.9835;
apsk16_sps32_std_84=5.4504;

apsk16_sps32_mean_63=1.1957;
apsk16_sps32_std_63=0.6996;

apsk16_sps32_mean_42=0.4494;
apsk16_sps32_std_42=0.1728;

col1=[0.3333    0.3333    0.3333];
col2=[0.6667    0.6667    0.6667]; 

figure;
%subplot(2,2,1);
x = 1:3:11;
x=[x;x]';

y=[qam16_sps1_mean_42,qam16_sps2_mean_42,qam16_sps8_mean_42,qam16_sps32_mean_42;
	apsk16_sps1_mean_42,apsk16_sps2_mean_42,apsk16_sps8_mean_42,apsk16_sps32_mean_42 ]';

error=[qam16_sps1_std_42,qam16_sps2_std_42,qam16_sps8_std_42,qam16_sps32_std_42; 
	apsk16_sps1_std_42,apsk16_sps2_std_42,apsk16_sps8_std_42,apsk16_sps32_std_42 ];

errlow  =[];

h=bar(x,y);                
set(h(1),'facecolor',col1);             
set(h(2),'facecolor',col2); 
hold on
nsps=[1,2,8,32];

% Get bar centers
xCnt =  h(1).XData.' + [h.XOffset]; 
% Alternative: xCnt = get(h(1),'XData').' + cell2mat(get(h,'XOffset')).'; % XOffset is undocumented
errorbar(xCnt(:),y(:),error(:),'k*')  % <--- If you want 1 errorbar object
% errorbar(xCnt,y,error,'*')         % <--- If you want separate errorbar objects, 1 for each bar-group
% errorbar(...,'k*') to make the errorbars black (which is better than yellow)
%er = errorbar(x,data,errlow,errhigh);    

%ylim([-0.05 0.55]);
hlegend=legend('16-QAM','16-APSK','Location','north');
hlegend.NumColumns=2;

xlabel('Upsampling factor, L');
ylabel('|C_{42}|')
set(gca,'XTickLabel',{nsps})
set(gca,'FontSize',14)
grid on
grid minor
set(gcf,'Position',[100 100 500 350])
hold off

%subplot(2,2,2);
figure;

y=[qam16_sps1_mean_63,qam16_sps2_mean_63,qam16_sps8_mean_63,qam16_sps32_mean_63;
	apsk16_sps1_mean_63,apsk16_sps2_mean_63,apsk16_sps8_mean_63,apsk16_sps32_mean_63 ]';

error=[qam16_sps1_std_63,qam16_sps2_std_63,qam16_sps8_std_63,qam16_sps32_std_63; 
apsk16_sps1_std_63,apsk16_sps2_std_63,apsk16_sps8_std_63,apsk16_sps32_std_63 ];

errlow  =[];

h=bar(x,y);                
set(h(1),'facecolor',col1);             
set(h(2),'facecolor',col2); 
hold on

% Get bar centers
xCnt =  h(1).XData.' + [h.XOffset]; 
% Alternative: xCnt = get(h(1),'XData').' + cell2mat(get(h,'XOffset')).'; % XOffset is undocumented
errorbar(xCnt(:),y(:),error(:),'k*')  % <--- If you want 1 errorbar object
% errorbar(xCnt,y,error,'*')         % <--- If you want separate errorbar objects, 1 for each bar-group
% errorbar(...,'k*') to make the errorbars black (which is better than yellow)
%er = errorbar(x,data,errlow,errhigh);    

%ylim([-0.05 0.55]);
hlegend=legend('16-QAM','16-APSK','Location','north');
hlegend.NumColumns=2;

xlabel('Upsampling factor, L');
ylabel('|C_{63}|')
set(gca,'XTickLabel',{nsps})
set(gca,'FontSize',14)
grid on
grid minor
set(gcf,'Position',[100 100 500 350])
hold off

%subplot(2,2,3);
figure;

y=[qam16_sps1_mean_84,qam16_sps2_mean_84,qam16_sps8_mean_84,qam16_sps32_mean_84;
	apsk16_sps1_mean_84,apsk16_sps2_mean_84,apsk16_sps8_mean_84,apsk16_sps32_mean_84 ]';

error=[qam16_sps1_std_84,qam16_sps2_std_84,qam16_sps8_std_84,qam16_sps32_std_84; 
apsk16_sps1_std_84,apsk16_sps2_std_84,apsk16_sps8_std_84,apsk16_sps32_std_84 ];

errlow  =[];
colormap('gray');
h=bar(x,y);                
set(h(1),'facecolor',col1);             
set(h(2),'facecolor',col2); 
hold on

% Get bar centers
xCnt =  h(1).XData.' + [h.XOffset]; 
% Alternative: xCnt = get(h(1),'XData').' + cell2mat(get(h,'XOffset')).'; % XOffset is undocumented
errorbar(xCnt(:),y(:),error(:),'k*')  % <--- If you want 1 errorbar object
% errorbar(xCnt,y,error,'*')         % <--- If you want separate errorbar objects, 1 for each bar-group
% errorbar(...,'k*') to make the errorbars black (which is better than yellow)
%er = errorbar(x,data,errlow,errhigh);    

%ylim([-0.05 0.55]);
hlegend=legend('16-QAM','16-APSK','Location','north');
hlegend.NumColumns=2;

xlabel('Upsampling factor, L');
ylabel('|C_{84}|')
set(gca,'XTickLabel',{nsps})
set(gca,'FontSize',14)
grid on
grid minor
set(gcf,'Position',[100 100 500 350])
hold off