%rician and l=8

qam16_bw200_mean_84=4.3471;
qam16_bw200_std_84=2.7773;

qam16_bw200_mean_63= 0.8847;
qam16_bw200_std_63=0.4411;

qam16_bw200_mean_42= 0.3763;
qam16_bw200_std_42=0.1378;

qam16_bw600_mean_84=4.1147;
qam16_bw600_std_84= 2.6736;

qam16_bw600_mean_63=0.8395;
qam16_bw600_std_63=0.4223;

qam16_bw600_mean_42=0.3633;
qam16_bw600_std_42=0.1329;

qam16_bw1000_mean_84=2.1936;
qam16_bw1000_std_84=1.8159;

qam16_bw1000_mean_63=0.5225;
qam16_bw1000_std_63=0.3203;

qam16_bw1000_mean_42=0.2752;
qam16_bw1000_std_42= 0.1117;

qam16_bw2000_mean_84=1.0888;
qam16_bw2000_std_84=0.9255;

qam16_bw2000_mean_63=0.2941;
qam16_bw2000_std_63=0.2038;

qam16_bw2000_mean_42=0.1805;
qam16_bw2000_std_42=0.0852;



%apsk16
apsk16_bw200_mean_84=5.1007;
apsk16_bw200_std_84=3.2593;

apsk16_bw200_mean_63=0.9765;
apsk16_bw200_std_63=0.4999;

apsk16_bw200_mean_42=0.4123;
apsk16_bw200_std_42=0.1509;

apsk16_bw600_mean_84= 4.7484;
apsk16_bw600_std_84= 3.0612;

apsk16_bw600_mean_63=0.9227;
apsk16_bw600_std_63=0.4734;

apsk16_bw600_mean_42=0.3949;
apsk16_bw600_std_42=0.1441;

apsk16_bw1000_mean_84= 2.4671;
apsk16_bw1000_std_84= 1.9409;

apsk16_bw1000_mean_63= 0.5700;
apsk16_bw1000_std_63=0.3371;

apsk16_bw1000_mean_42=0.2980;
apsk16_bw1000_std_42=0.1185;

apsk16_bw2000_mean_84=1.1377;
apsk16_bw2000_std_84= 0.9984;

apsk16_bw2000_mean_63=0.3104;
apsk16_bw2000_std_63=0.2136;

apsk16_bw2000_mean_42=0.2010;
apsk16_bw2000_std_42=0.0892;


col1=[0.3333    0.3333    0.3333];
col2=[0.6667    0.6667    0.6667]; 


figure;

%subplot(2,2,1);
x = 1:3:11;
x=[x;x]';

y=[qam16_bw200_mean_42,qam16_bw600_mean_42,qam16_bw1000_mean_42,qam16_bw2000_mean_42;
	apsk16_bw200_mean_42,apsk16_bw600_mean_42,apsk16_bw1000_mean_42,apsk16_bw2000_mean_42 ]';

error=[qam16_bw200_std_42,qam16_bw600_std_42,qam16_bw1000_std_42,qam16_bw2000_std_42; 
	apsk16_bw200_std_42,apsk16_bw600_std_42,apsk16_bw1000_std_42,apsk16_bw2000_std_42 ];

errlow  =[];

h=bar(x,y);
  
set(h(1),'facecolor',col1);             
set(h(2),'facecolor',col2);    
hold on
nsps=[200,600,1000,2000];

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

xlabel('Sampling Frequency, f_s');
ylabel('|C_{42}|')
set(gca,'XTickLabel',{nsps})
set(gca,'FontSize',14)
grid on
grid minor
set(gcf,'Position',[100 100 500 350])

hold off

%subplot(2,2,2);

figure;
y=[qam16_bw200_mean_63,qam16_bw600_mean_63,qam16_bw1000_mean_63,qam16_bw2000_mean_63;
	apsk16_bw200_mean_63,apsk16_bw600_mean_63,apsk16_bw1000_mean_63,apsk16_bw2000_mean_63 ]';

error=[qam16_bw200_std_63,qam16_bw600_std_63,qam16_bw1000_std_63,qam16_bw2000_std_63; 
apsk16_bw200_std_63,apsk16_bw600_std_63,apsk16_bw1000_std_63,apsk16_bw2000_std_63 ];

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


ylim([-0.4 2]);
hlegend=legend('16-QAM','16-APSK','Location','north');
hlegend.NumColumns=2;

xlabel('Sampling Frequency, f_s (kHz)');
ylabel('|C_{63}|')
set(gca,'XTickLabel',{nsps})
set(gca,'FontSize',14)
grid on
grid minor
set(gcf,'Position',[100 100 500 350])
hold off

%subplot(2,2,3);

figure;
y=[qam16_bw200_mean_84,qam16_bw600_mean_84,qam16_bw1000_mean_84,qam16_bw2000_mean_84;
	apsk16_bw200_mean_84,apsk16_bw600_mean_84,apsk16_bw1000_mean_84,apsk16_bw2000_mean_84 ]';

error=[qam16_bw200_std_84,qam16_bw600_std_84,qam16_bw1000_std_84,qam16_bw2000_std_84; 
apsk16_bw200_std_84,apsk16_bw600_std_84,apsk16_bw1000_std_84,apsk16_bw2000_std_84 ];

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

ylim([-2.2 9.5]);
hlegend=legend('16-QAM','16-APSK','Location','north');
hlegend.NumColumns=2;

xlabel('Sampling Frequency, f_s (kHz)');
ylabel('|C_{84}|')
set(gca,'XTickLabel',{nsps})
set(gca,'FontSize',14)
grid on
grid minor
set(gcf,'Position',[100 100 500 350])
hold off