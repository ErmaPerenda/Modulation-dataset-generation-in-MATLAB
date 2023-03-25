%rician and 1000k

qam16_sps1_mean_84=0.4255;
qam16_sps1_std_84=0.4889;

qam16_sps1_mean_63= 0.1424;
qam16_sps1_std_63=0.1380;

qam16_sps1_mean_42=0.1064;
qam16_sps1_std_42=0.0976;


qam16_sps2_mean_84=0.8243;
qam16_sps2_std_84=0.8182;

qam16_sps2_mean_63= 0.2362;
qam16_sps2_std_63=0.1891;

qam16_sps2_mean_42=0.1393;
qam16_sps2_std_42=0.1038;



qam16_sps8_mean_84=1.3471;
qam16_sps8_std_84=1.5324;

qam16_sps8_mean_63=0.3292;
qam16_sps8_std_63=0.3056;

qam16_sps8_mean_42=0.1684;
qam16_sps8_std_42= 0.1385;



qam16_sps32_mean_84=3.3013;
qam16_sps32_std_84=4.1697;

qam16_sps32_mean_63=0.6276 ;
qam16_sps32_std_63=0.6484;

qam16_sps32_mean_42= 0.2461;
qam16_sps32_std_42=0.2130;

%apsk16
apsk16_sps2_mean_84=0.9276;
apsk16_sps2_std_84=0.8406;

apsk16_sps2_mean_63=0.2593;
apsk16_sps2_std_63=0.2040;

apsk16_sps2_mean_42=0.1511;
apsk16_sps2_std_42=0.1150;

apsk16_sps8_mean_84=1.5352;
apsk16_sps8_std_84=1.7433;

apsk16_sps8_mean_63= 0.3606;
apsk16_sps8_std_63=0.3384;

apsk16_sps8_mean_42=0.1817;
apsk16_sps8_std_42=0.1513;

apsk16_sps32_mean_84=3.8834;
apsk16_sps32_std_84= 5.0117;

apsk16_sps32_mean_63=0.6941;
apsk16_sps32_std_63=0.7272;

apsk16_sps32_mean_42=0.2639;
apsk16_sps32_std_42=0.2332;


figure;
subplot(2,2,1);
x = 1:3:7;
x=[x;x]';

y=[qam16_sps2_mean_42,qam16_sps8_mean_42,qam16_sps32_mean_42;apsk16_sps2_mean_42,apsk16_sps8_mean_42,apsk16_sps32_mean_42 ]';

error=[qam16_sps2_std_42,qam16_sps8_std_42,qam16_sps32_std_42; apsk16_sps2_std_42,apsk16_sps8_std_42,apsk16_sps32_std_42 ];

errlow  =[];

h=bar(x,y);                

hold on

% Get bar centers
xCnt =  h(1).XData.' + [h.XOffset]; 
% Alternative: xCnt = get(h(1),'XData').' + cell2mat(get(h,'XOffset')).'; % XOffset is undocumented
errorbar(xCnt(:),y(:),error(:),'k*')  % <--- If you want 1 errorbar object
% errorbar(xCnt,y,error,'*')         % <--- If you want separate errorbar objects, 1 for each bar-group
% errorbar(...,'k*') to make the errorbars black (which is better than yellow)
%er = errorbar(x,data,errlow,errhigh);    

ylim([-0.05 0.55]);
hlegend=legend('16-QAM','16-APSK');
hlegend.NumColumns=2;
nsps=[2,8,32];
xlabel('Upsampling factor, L');
ylabel('|C_{42}|')
set(gca,'XTickLabel',{nsps})
hold off

subplot(2,2,2);
x = 1:3:7;
x=[x;x]';

y=[qam16_sps2_mean_63,qam16_sps8_mean_63,qam16_sps32_mean_63;
	apsk16_sps2_mean_63,apsk16_sps8_mean_63,apsk16_sps32_mean_63 ]';

error=[qam16_sps2_std_63,qam16_sps8_std_63,qam16_sps32_std_63; 
apsk16_sps2_std_63,apsk16_sps8_std_63,apsk16_sps32_std_63 ];

errlow  =[];

h=bar(x,y);                

hold on

% Get bar centers
xCnt =  h(1).XData.' + [h.XOffset]; 
% Alternative: xCnt = get(h(1),'XData').' + cell2mat(get(h,'XOffset')).'; % XOffset is undocumented
errorbar(xCnt(:),y(:),error(:),'k*')  % <--- If you want 1 errorbar object
% errorbar(xCnt,y,error,'*')         % <--- If you want separate errorbar objects, 1 for each bar-group
% errorbar(...,'k*') to make the errorbars black (which is better than yellow)
%er = errorbar(x,data,errlow,errhigh);    

%ylim([-0.05 0.55]);
hlegend=legend('16-QAM','16-APSK');
hlegend.NumColumns=2;
nsps=[2,8,32];
xlabel('Upsampling factor, L');
ylabel('|C_{63}|')
set(gca,'XTickLabel',{nsps})
hold off

subplot(2,2,3);
x = 1:3:7;
x=[x;x]';

y=[qam16_sps2_mean_84,qam16_sps8_mean_84,qam16_sps32_mean_84;
	apsk16_sps2_mean_84,apsk16_sps8_mean_84,apsk16_sps32_mean_84 ]';

error=[qam16_sps2_std_84,qam16_sps8_std_84,qam16_sps32_std_84; 
apsk16_sps2_std_84,apsk16_sps8_std_84,apsk16_sps32_std_84 ];

errlow  =[];

h=bar(x,y);                

hold on

% Get bar centers
xCnt =  h(1).XData.' + [h.XOffset]; 
% Alternative: xCnt = get(h(1),'XData').' + cell2mat(get(h,'XOffset')).'; % XOffset is undocumented
errorbar(xCnt(:),y(:),error(:),'k*')  % <--- If you want 1 errorbar object
% errorbar(xCnt,y,error,'*')         % <--- If you want separate errorbar objects, 1 for each bar-group
% errorbar(...,'k*') to make the errorbars black (which is better than yellow)
%er = errorbar(x,data,errlow,errhigh);    

%ylim([-0.05 0.55]);
hlegend=legend('16-QAM','16-APSK');
hlegend.NumColumns=2;
nsps=[2,8,32];
xlabel('Upsampling factor, L');
ylabel('|C_{84}|')
set(gca,'XTickLabel',{nsps})
hold off