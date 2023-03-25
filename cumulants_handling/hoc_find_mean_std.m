function [hoc_mean,hoc_std]=hoc_find_mean_std(dataset_name)

%myVars = {'values','labels'};
a=load(dataset_name);
ds=getfield(a,'ds');
keys=fieldnames(ds);
values=struct2cell(ds);

num_cumulants=11;
global mods snrs nsps;

cumulants_values=struct();
target_hoc_index=5; %42 is 5, 63 is 9, 84 is 11
hoc_values=[];
for i=1:length(keys)
	key=keys{i};
	disp(key);
    value=values{i};

    hoc_values=[hoc_values value(:,4,target_hoc_index)'];	
    disp('hocccc ')
    disp(size(hoc_values));
   
end

hoc_mean=mean(hoc_values);
hoc_std=std(hoc_values);

end