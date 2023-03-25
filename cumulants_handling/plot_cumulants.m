clc;
clear;
close all;
dataset_name='dataset1024_cumulants.mat';
%myVars = {'values','labels'};
a=load(dataset_name);
ds=getfield(a,'ds');
keys=fieldnames(ds);
values=struct2cell(ds);

num_cumulants=11;
global mods snrs nsps;

mods={};
snrs=[];
nsps=[];
cumulants_values=struct();



for i=1:length(keys)
	key=keys{i};
    value=values{i};
    pom(1:size(value,1),1:11)=value(:,4,1:11);
    
    labels=split(key,'rer');
    mod=labels{1};

    if contains(char(mod), {'APSK','QAM'})
       lela=1;
   else
   	continue;
   end

    cumulants_key=mean(pom);
    cumulants_values=setfield(cumulants_values,key,cumulants_key);

    snr_a=labels{2};
    if(contains(snr_a,'neg')==true)
        snr_a=replace(snr_a,'neg','-');
    end
    snr=str2num(snr_a);

    L_a=labels{3};
    L=str2num(L_a);

    M_a=labels{5};
    M=str2num(M_a);

    nsp=L/M;

	if ismember(mod,mods)==false
		mods=[mods mod];
	end

	if ismember(snr,snrs) == false
		snrs=[snrs snr];
	end

	if ismember(nsp,nsps) == false
		nsps=[nsps nsp];
	end

end

mods=sort(mods);
snrs=sort(snrs);
nsps=sort(nsps);
disp(mods);
disp(snrs);
disp(nsps);

mods={'QAM128'}

cumulants_20=zeros(length(nsps),length(mods));
cumulants_21=zeros(length(nsps),length(mods));

cumulants_40=zeros(length(nsps),length(mods));
cumulants_41=zeros(length(nsps),length(mods));
cumulants_42=zeros(length(nsps),length(mods));

cumulants_60=zeros(length(nsps),length(mods));
cumulants_61=zeros(length(nsps),length(mods));
cumulants_62=zeros(length(nsps),length(mods));
cumulants_63=zeros(length(nsps),length(mods));

cumulants_80=zeros(length(nsps),length(mods));
cumulants_84=zeros(length(nsps),length(mods));

keys=fieldnames(cumulants_values);
values=struct2cell(cumulants_values);

f_c20=figure;
snrs=[4]
for snr=1:length(snrs)
	snr_val=snrs(snr);

	for i=1:length(keys)
		key=keys{i};
    	value=values{i};
    
    	labels=split(key,'rer');
    	mod_k=labels{1};

    	snr_a=labels{2};
    	if(contains(snr_a,'neg')==true)
        	snr_a=replace(snr_a,'neg','-');
    	end
    	snr_k=str2num(snr_a);

    	L_a=labels{3};
    	L=str2num(L_a);

    	M_a=labels{5};
    	M=str2num(M_a);

    	nsp=L/M;
    	if(snr_k==snr_val)
    		index_y=find(strcmp(mods, mod_k));
    		if(length(index_y)==0)
    			%disp('none');
    			continue;
    		end
			index_x=find(nsps==nsp);

			cumulants_20(index_x,index_y)=value(1);
			cumulants_21(index_x,index_y)=value(2);

			cumulants_40(index_x,index_y)=value(3);
			cumulants_41(index_x,index_y)=value(4);
			cumulants_42(index_x,index_y)=value(5);

			cumulants_60(index_x,index_y)=value(6);
			cumulants_61(index_x,index_y)=value(7);
			cumulants_62(index_x,index_y)=value(8);
			cumulants_63(index_x,index_y)=value(9);

			cumulants_80(index_x,index_y)=value(10);
			cumulants_84(index_x,index_y)=value(11);

    	end		
	end

	for j=1:length(mods)
		
		plot(nsps,cumulants_84(:,j),'LineWidth',2);
		title(mods{j})
		hold on;
	end

end



f_c20;
set(gca,'XTickLabel',{nsps});
xlabel('Number samples per symbol, nsps');
ylabel('|C_{84}|');
legend(string(snrs));
axis([0 33 0 10]);

c20_fit=cumulants_62(:,1);
x_fit=nsps;

p = polyfit(c20_fit,x_fit,2);
figure;
plot(c20_fit,x_fit,'o');
hold on;
p1 = polyval(p,c20_fit);
plot(c20_fit,p1,'r--');
hold off;
error()


for i=1:length(keys)
	key=keys{i};
    value=values{i};
    
    labels=split(key,'rer');
    mod=labels{1};

    snr_a=labels{2};
    if(contains(snr_a,'neg')==true)
        snr_a=replace(snr_a,'neg','-');
    end
    snr=str2num(snr_a);

    L_a=labels{3};
    L=str2num(L_a);

    M_a=labels{5};
    M=str2num(M_a);

    nsp=L/M;

	index_y=find(strcmp(mods, mod));
	index_x=find(nsps==nsp);

	cumulants_20(index_x,index_y)=value(1);
	cumulants_21(index_x,index_y)=value(2);

	cumulants_40(index_x,index_y)=value(3);
	cumulants_41(index_x,index_y)=value(4);
	cumulants_42(index_x,index_y)=value(5);

	cumulants_60(index_x,index_y)=value(6);
	cumulants_61(index_x,index_y)=value(7);
	cumulants_62(index_x,index_y)=value(8);
	cumulants_63(index_x,index_y)=value(9);

	cumulants_80(index_x,index_y)=value(10);
	cumulants_84(index_x,index_y)=value(11);

end

c20_increase=zeros(length(nsps),length(mods));
c21_increase=zeros(length(nsps),length(mods));

c40_increase=zeros(length(nsps),length(mods));
c41_increase=zeros(length(nsps),length(mods));
c42_increase=zeros(length(nsps),length(mods));

c60_increase=zeros(length(nsps),length(mods));
c61_increase=zeros(length(nsps),length(mods));
c62_increase=zeros(length(nsps),length(mods));
c63_increase=zeros(length(nsps),length(mods));

c80_increase=zeros(length(nsps),length(mods));
c84_increase=zeros(length(nsps),length(mods));

ref_index=find(strcmp(mods, 'QAM16'));
reference_values=[cumulants_20(1,ref_index); cumulants_41(1,ref_index);cumulants_62(1,ref_index)];

for i=1:length(nsps)
	factor_22=zeros(11,length(mods));
	factor_22(1,:)=cumulants_20(i,:)./cumulants_20(1,ref_index);
	c20_increase(i,:)=factor_22(1,:);
	factor_22(2,:)=cumulants_21(i,:)./cumulants_21(1,ref_index);
	c21_increase(i,:)=factor_22(2,:);

	factor_22(3,:)=cumulants_40(i,:)./cumulants_40(1,ref_index);
	factor_22(4,:)=cumulants_41(i,:)./cumulants_41(1,ref_index);
	factor_22(5,:)=cumulants_42(i,:)./cumulants_42(1,ref_index);

	c40_increase(i,:)=factor_22(3,:);
	c41_increase(i,:)=factor_22(4,:);
	c42_increase(i,:)=factor_22(5,:);

	factor_22(6,:)=cumulants_60(i,:)./cumulants_60(1,ref_index);
	factor_22(7,:)=cumulants_61(i,:)./cumulants_61(1,ref_index);
	factor_22(8,:)=cumulants_62(i,:)./cumulants_62(1,ref_index);
	factor_22(9,:)=cumulants_63(i,:)./cumulants_63(1,ref_index);

	c60_increase(i,:)=factor_22(6,:);
	c61_increase(i,:)=factor_22(7,:);
	c62_increase(i,:)=factor_22(8,:);
	c63_increase(i,:)=factor_22(9,:);

	factor_22(10,:)=cumulants_80(i,:)./cumulants_80(1,ref_index);
	factor_22(11,:)=cumulants_84(i,:)./cumulants_84(1,ref_index);

	c80_increase(i,:)=factor_22(10,:);
	c84_increase(i,:)=factor_22(11,:);
	
	figure;
	bar(factor_22);
	ticks_mods={'C20', 'C21', 'C40', 'C41', 'C42', 'C60','C61', 'C62','C63','C80','C84' };
	set(gca,'XTickLabel',ticks_mods)
	legend(mods);
	xlabel('Cumulants');
	ylabel('Factor');
	title(num2str(nsps(i)));	
end

figure;
x_fit=[];
c20_fit=[];
for i=1:length(mods)
	x_fit=[x_fit nsps];
	c20_fit=[c20_fit c20_increase(:,i)'];
	plot(nsps,c20_increase(:,i),'LineWidth',2);
	hold on;

end
legend(mods);
set(gca,'XTickLabel',{nsps})
title('C20');

p = polyfit(c20_fit,x_fit,2);
figure;
plot(c20_fit,x_fit,'o');
hold on;
p1 = polyval(p,c20_fit);
plot(c20_fit,p1,'r--');
hold off;

figure;
for i=1:length(mods)
	plot(nsps,c21_increase(:,i),'LineWidth',2);
	hold on;

end
legend(mods);
set(gca,'XTickLabel',{nsps})
title('C21');


figure;
for i=1:length(mods)
	plot(nsps,c40_increase(:,i),'LineWidth',2);
	hold on;

end
legend(mods);
set(gca,'XTickLabel',{nsps})
title('C40');

figure;
x_fit=[];
c41_fit=[];
for i=1:length(mods)
	x_fit=[x_fit nsps];
	c41_fit=[c41_fit c41_increase(:,i)'];
	plot(nsps,c41_increase(:,i),'LineWidth',2);
	hold on;

end
legend(mods);
set(gca,'XTickLabel',{nsps})
title('C41');

p_41 = polyfit(c41_fit,x_fit,2);
figure;
plot(c41_fit,x_fit,'o');
hold on;
p1 = polyval(p_41,c41_fit);
plot(c41_fit,p1,'r--');
hold off;

figure;
for i=1:length(mods)
	plot(nsps,c42_increase(:,i),'LineWidth',2);
	hold on;

end
legend(mods);
set(gca,'XTickLabel',{nsps})
title('C42');

figure;
for i=1:length(mods)
	plot(nsps,c60_increase(:,i),'LineWidth',2);
	hold on;

end
legend(mods);
set(gca,'XTickLabel',{nsps})
title('C60');


figure;
for i=1:length(mods)
	plot(nsps,c61_increase(:,i),'LineWidth',2);
	hold on;

end
legend(mods);
set(gca,'XTickLabel',{nsps})
title('C61');

figure;
x_fit=[];
c62_fit=[];
for i=1:length(mods)
	x_fit=[x_fit nsps];
	c62_fit=[c62_fit c62_increase(:,i)'];
	plot(nsps,c62_increase(:,i),'LineWidth',2);
	hold on;

end
legend(mods);
set(gca,'XTickLabel',{nsps})
title('C62');

p_62 = polyfit(c62_fit,x_fit,2);
figure;
plot(c62_fit,x_fit,'o');
hold on;
p1 = polyval(p_62,c62_fit);
plot(c62_fit,p1,'r--');
hold off;

figure;
for i=1:length(mods)
	plot(nsps,c63_increase(:,i),'LineWidth',2);
	hold on;

end
legend(mods);
set(gca,'XTickLabel',{nsps})
title('C63');

figure;
for i=1:length(mods)
	plot(nsps,c80_increase(:,i),'LineWidth',2);
	hold on;

end
legend(mods);
set(gca,'XTickLabel',{nsps})
title('C80');

figure;
for i=1:length(mods)
	plot(nsps,c84_increase(:,i),'LineWidth',2);
	hold on;

end
legend(mods);
set(gca,'XTickLabel',{nsps})
title('C84');



error()

for i=1:length(nsps)
	factor_22=zeros(11,length(mods));
	factor_22(1,:)=cumulants_20(i,:)./cumulants_20(i,:);
	factor_22(2,:)=cumulants_21(i,:)./cumulants_20(i,:);

	factor_22(3,:)=cumulants_40(i,:)./cumulants_40(i,:);
	factor_22(4,:)=cumulants_41(i,:)./cumulants_40(i,:);
	factor_22(5,:)=cumulants_42(i,:)./cumulants_40(i,:);

	factor_22(6,:)=cumulants_60(i,:)./cumulants_60(i,:);
	factor_22(7,:)=cumulants_61(i,:)./cumulants_60(i,:);
	factor_22(8,:)=cumulants_62(i,:)./cumulants_60(i,:);
	factor_22(9,:)=cumulants_63(i,:)./cumulants_60(i,:);

	factor_22(10,:)=cumulants_80(i,:)./cumulants_80(i,:);
	factor_22(11,:)=cumulants_84(i,:)./cumulants_80(i,:);
	

	figure;
	bar(factor_22);
	ticks_mods={'C20', 'C21', 'C40', 'C41', 'C42', 'C60','C61', 'C62','C63','C80','C84' };
	set(gca,'XTickLabel',ticks_mods)
	legend(mods);
	xlabel('Cumulants');
	ylabel('Factor');
	title(num2str(nsps(i)));	
end




f_c20=figure;
bar(cumulants_20);
set(gca,'XTickLabel',{nsps})
legend(mods);
xlabel('Number samples per symbol, nsps');
ylabel('|C_{20}|');

f_c21=figure;
bar(cumulants_21);
set(gca,'XTickLabel',{nsps})
legend(mods);
xlabel('Number samples per symbol, nsps');
ylabel('|C_{21}|');


f_c40=figure;
bar(cumulants_40);
set(gca,'XTickLabel',{nsps})
legend(mods);
xlabel('Number samples per symbol, nsps');
ylabel('|C_{40}|');

f_c41=figure;
bar(cumulants_41);
set(gca,'XTickLabel',{nsps})
legend(mods);
xlabel('Number samples per symbol, nsps');
ylabel('|C_{41}|');

f_c42=figure;
bar(cumulants_42);
set(gca,'XTickLabel',{nsps})
legend(mods);
xlabel('Number samples per symbol, nsps');
ylabel('|C_{42}|');

f_60=figure;
bar(cumulants_60);
set(gca,'XTickLabel',{nsps})
legend(mods);
xlabel('Number samples per symbol, nsps');
ylabel('|C_{60}|');

f_62=figure;
bar(cumulants_62);
set(gca,'XTickLabel',{nsps})
legend(mods);
xlabel('Number samples per symbol, nsps');
ylabel('|C_{62}|');

f_63=figure;
bar(cumulants_63);
set(gca,'XTickLabel',{nsps})
legend(mods);
xlabel('Number samples per symbol, nsps');
ylabel('|C_{63}|');

f_80=figure;
bar(cumulants_80);
set(gca,'XTickLabel',{nsps})
legend(mods);
xlabel('Number samples per symbol, nsps');
ylabel('|C_{80}|');

f_84=figure;
bar(cumulants_84);
set(gca,'XTickLabel',{nsps})
legend(mods);
xlabel('Number samples per symbol, nsps');
ylabel('|C_{84}|');

sc=figure;
c=[1:length(mods)];
scatter(c,cumulants_20(1,:),'LineWidth', 2);
hold on;
scatter(c,cumulants_21(1,:),'LineWidth', 2);
scatter(c,cumulants_40(1,:),'LineWidth', 2);
scatter(c,cumulants_41(1,:),'LineWidth', 2);
scatter(c,cumulants_42(1,:),'LineWidth', 2);

scatter(c,cumulants_60(1,:),'LineWidth', 2);

scatter(c,cumulants_61(1,:),'LineWidth', 2);

scatter(c,cumulants_62(1,:),'LineWidth', 2);

scatter(c,cumulants_63(1,:),'LineWidth', 2);

scatter(c,cumulants_80(1,:),'LineWidth', 2);

scatter(c,cumulants_84(1,:),'LineWidth', 2);
hold off;
hlegend=legend('C20', 'C21', 'C40', 'C41', 'C42', 'C60', 'C61', 'C62', 'C63', 'C80','C84');
hlegend.NumColumns=4;
title('Cumulants Values')
xlabel('Modulations');
xticks([1:length(mods)]);
ticks_mods={mods{1},mods{2},mods{3},mods{4},mods{5},mods{6},mods{7},mods{8},mods{9},mods{10}, ...
mods{11},mods{12},mods{13},mods{14},mods{15},mods{16},mods{17},mods{18},mods{19},mods{20}};
set(gca,'XTickLabel',ticks_mods);
xtickangle(45);
