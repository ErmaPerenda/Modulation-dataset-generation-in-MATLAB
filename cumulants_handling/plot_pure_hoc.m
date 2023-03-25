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
snrs=[18]
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

end



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
set(gca,'linewidth',6)
colormap(f_c42,jet(20))
bar(cumulants_42);
set(gca,'XTickLabel',{nsps})
legend(mods,'Location','NorthWest','NumColumns',5);
xlabel('Upsampling factor, L');
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
colormap(jet(20))
bar(cumulants_63);
set(gca,'XTickLabel',{nsps})
legend(mods,'Location','NorthWest','NumColumns',5);
xlabel('Upsampling factor, L');
ylabel('|C_{63}|');

f_80=figure;

bar(cumulants_80);
set(gca,'XTickLabel',{nsps})
legend(mods);
xlabel('Number samples per symbol, nsps');
ylabel('|C_{80}|');

f_84=figure;
colormap(jet(20))
bar(cumulants_84);
set(gca,'XTickLabel',{nsps})
legend(mods,'Location','NorthWest','NumColumns',5);
xlabel('Upsampling factor, L');
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
