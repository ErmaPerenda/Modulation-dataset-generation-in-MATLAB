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

cumulants_20_sum=zeros(length(nsps),length(mods));
cumulants_21_sum=zeros(length(nsps),length(mods));

cumulants_40_sum=zeros(length(nsps),length(mods));
cumulants_41_sum=zeros(length(nsps),length(mods));
cumulants_42_sum=zeros(length(nsps),length(mods));

cumulants_60_sum=zeros(length(nsps),length(mods));
cumulants_61_sum=zeros(length(nsps),length(mods));
cumulants_62_sum=zeros(length(nsps),length(mods));
cumulants_63_sum=zeros(length(nsps),length(mods));

cumulants_80_sum=zeros(length(nsps),length(mods));
cumulants_84_sum=zeros(length(nsps),length(mods));

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

			cumulants_20(index_x,index_y)=cumulants_20(index_x,index_y)+value(1);
            cumulants_20_sum(index_x,index_y)=cumulants_20_sum(index_x,index_y)+1;

			cumulants_21(index_x,index_y)=cumulants_21(index_x,index_y)+value(2);
            cumulants_21_sum(index_x,index_y)=cumulants_21_sum(index_x,index_y)+1;

			cumulants_40(index_x,index_y)=cumulants_40(index_x,index_y)+value(3);
            cumulants_40_sum(index_x,index_y)=cumulants_40_sum(index_x,index_y)+1;

			cumulants_41(index_x,index_y)=cumulants_41(index_x,index_y)+value(4);
            cumulants_41_sum(index_x,index_y)=cumulants_41_sum(index_x,index_y)+1;

			cumulants_42(index_x,index_y)=cumulants_42(index_x,index_y)+value(5);
            cumulants_42_sum(index_x,index_y)=cumulants_42_sum(index_x,index_y)+1;

			cumulants_60(index_x,index_y)=cumulants_60(index_x,index_y)+value(6);
            cumulants_60_sum(index_x,index_y)=cumulants_60_sum(index_x,index_y)+1;

			cumulants_61(index_x,index_y)=cumulants_61(index_x,index_y)+value(7);
            cumulants_61_sum(index_x,index_y)=cumulants_61_sum(index_x,index_y)+1;

			cumulants_62(index_x,index_y)=cumulants_62(index_x,index_y)+value(8);
            cumulants_62_sum(index_x,index_y)=cumulants_62_sum(index_x,index_y)+1;

			cumulants_63(index_x,index_y)=cumulants_63(index_x,index_y)+value(9);
            cumulants_63_sum(index_x,index_y)=cumulants_63_sum(index_x,index_y)+1;

			cumulants_80(index_x,index_y)=cumulants_80(index_x,index_y)+value(10);
            cumulants_80_sum(index_x,index_y)=cumulants_80_sum(index_x,index_y)+1;

			cumulants_84(index_x,index_y)=cumulants_84(index_x,index_y)+value(11);
            cumulants_84_sum(index_x,index_y)=cumulants_84_sum(index_x,index_y)+1;

    	end		
	end

end


cumulants_20=cumulants_20./cumulants_20_sum;
cumulants_21=cumulants_21./cumulants_21_sum;

cumulants_40=cumulants_40./cumulants_40_sum;
cumulants_41=cumulants_41./cumulants_41_sum;
cumulants_42=cumulants_42./cumulants_42_sum;

cumulants_60=cumulants_60./cumulants_60_sum;
cumulants_61=cumulants_61./cumulants_61_sum;
cumulants_62=cumulants_62./cumulants_62_sum;
cumulants_63=cumulants_63./cumulants_63_sum;

cumulants_80=cumulants_80./cumulants_80_sum;
cumulants_84=cumulants_84./cumulants_84_sum;

for i=1:length(mods)
    mod_k=mods(i);
    disp('mod is ');
    disp(mod_k);
    index_y=find(strcmp(mods, mod_k));
    figure;
    plot(nsps,cumulants_20(:,index_y),'-s','LineWidth', 2);
    hold on;
    plot(nsps,cumulants_21(:,index_y),'-d','LineWidth', 2);
    hold on;
    plot(nsps,cumulants_40(:,index_y),'-*','LineWidth', 2);
    hold on;
    plot(nsps,cumulants_41(:,index_y),'--','LineWidth', 2);
    hold on;
    plot(nsps,cumulants_42(:,index_y),'.-','LineWidth', 2);
    hold on;
    plot(nsps,cumulants_60(:,index_y),'-*','LineWidth', 2);
    hold on;
    plot(nsps,cumulants_61(:,index_y),'-d','LineWidth', 2);
    hold on;
    plot(nsps,cumulants_62(:,index_y),'-s','LineWidth', 2);
    hold on;
    plot(nsps,cumulants_63(:,index_y),'-s','LineWidth', 2);
    hold on;
    plot(nsps,cumulants_80(:,index_y),'-s','LineWidth', 2);
    hold on;
    plot(nsps,cumulants_84(:,index_y),'-s','LineWidth', 2);
    hold off;
    hlegend=legend('C20', 'C21', 'C40', 'C41', 'C42', 'C60', 'C61', 'C62', 'C63', 'C80','C84');
    hlegend.NumColumns=4;
    title_l=strcat("Cumulant Values for ", mod_k);
    title(title_l);
    xlabel('Upsampling Factor, L');


end

