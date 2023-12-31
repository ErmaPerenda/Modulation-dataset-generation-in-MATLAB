clc; 
clear all;
%close all;
addpath('helpers','modulators','plotting', 'channeling','features','cumulants_handling');
rng(10000);
%generate mixture of modulated signals
%configuration parameters settings

%supported Modulation Formats
%modulationTypes=categorical(["BPSK","QPSK","OQPSK","PSK8","QAM16","QAM32",...
%                    "APSK16","APSK32","APSK64","APSK128", "APSK256"...
%                 "QAM64","QAM128","QAM256","PAM4","GFSK","CPFSK","BFM","DSBAM", "SSBAM"]);

modulationTypes=categorical(["BPSK","QPSK","PSK8","QAM16",...
                 "QAM64","PAM4","GFSK","CPFSK","BFM","DSBAM", "SSBAM"]);



%modulationTypes=categorical(["BPSK"]);
          
%supported Maximum number of signals within band of interest
maxNumberSignals=1;

%channel configuration settings
applyRayleigh=false;
applyRicean=false;
applyClockOffset=false;
allowOverlapping=false;

%number of time samples
Nts=1;
Nt=3;

ds=struct();

%for each signal in mixture power attenuation is chosen uniform-randomly
%from the given range
powerRatiosDb=[-10:2:10]; 

%supported SNR values range
snrsDb=[-6:2:20];
snrsDb=[18];

%Number Samples Per Symbol
%higher number samples per symbol the bw of signal is narrower
nsps=[4,8,16,32];
Ls=[2,4,8,16,16, 32, 32 ,32]; %32
Ms=[1,1,1, 1, 5,  1,  5,3]; %3
%Ls=[12:2:30];
%Ms=ones(1,size(Ls,2));
Ls=[1];
Ms=[1];
sps=1;

%Length of each frame
sample_length=1024;

%Default sampling frequency
fs=200e3;
maxBwSignal=fs/min(nsps);
maxOffset=0.5*(fs-maxBwSignal);

%for each signal in mixture frequency offset is chosen uniform-randomly
%from the given range
freqOffsetNegative=(-maxOffset)./[1 2 4 6 10];
frequencyOffsets=[freqOffsetNegative 0 -freqOffsetNegative]; 
frequencyOffsets=sort(frequencyOffsets);
frequencyOffsets=[0]; 

%Initial center frequency
fc=902e6;

%Number of frames for each combined signal mixture
Ns=1;

%Number of iterations to choose random config parameters
Nrandom=1;

rng(1235);
tic
numModulationTypes=size(modulationTypes,2);

numSignals=20;
mm=1;       
transDelay=50;

maxNumberSignals=1;

make_it_tight=true;
subplot=@(m,n,p) subtightplot(m,n,p,[0.01 0.01],[0.05 0.01], [0.05 0.01]);
for i=1:maxNumberSignals
    fprintf('%s - Generating frames for number of signals %d\n',...
            datestr(toc/86400,'HH:MM:SS'),i);
        
    %generate only noise
    if i==0
        for snrVal=1:size(snrsDb,2)
            snr=snrsDb(snrVal);
            snr_amp=10^(-snr/10);
            sps=1;
            label={'Noise',snr,"None","None","None",0};
            key=join(string(label),'rer');
            key=strrep(key,'-','neg');
            value=zeros(Ns,14*Nts,sample_length);    
            for j=1:Ns
                noiseSignal=randn(sample_length*(Nts+1),1)+1i*randn(sample_length*(Nts+1),1);
                noiseSignal=snr_amp*noiseSignal;
                frame=helperModClassFrameGenerator(rxSamples,source_signal, sample_length,sample_length, transDelay_r,min(Ls(sps_i),Ms(sps_i)));
                frame_shaped=shape_frame(frame,sample_length,fs,snrsDb(snrVal));
                value(j,:,:)=frame_shaped;
                
            end
            ds=setfield(ds,key,value);
            
        end
    end
    
    %generate samples for each modulation type
    

    if i==1
        %figure;
        %set(gcf,'Position',[0 0 500 1100]);
        for modType=1:numModulationTypes
            fprintf('%s generating %s frames \n',...
                datestr(toc/86400,'HH:MM:SS'),modulationTypes(modType));
            for sps_i=1:size(Ls,2)
                l_sps=Ls(sps_i)/Ms(sps_i);
                sps=Ls(sps_i);
                fprintf('L is %d and M is %d \n',Ls(sps_i),Ms(sps_i)); 
                %sps=nsps(randi([1 (length(nsps))],1));
                bwc=fs/sps;
                numSymbols=(Ns/sps);
                disp('here 1')
                dataSource=getDataSource(modulationTypes(modType),sps,Ms(sps_i)*Nt*sample_length,fs);
                disp('here 2')
                modulator=getModulator(modulationTypes(modType),sps,fs);
                disp('here 3')

            
            if contains(char(modulationTypes(modType)),...
                    {'BFM','DSBAM','SSBAM'})
                fcI=100e6;
                dataSource=getDataSource(modulationTypes(modType),sps,Nt*sample_length,fs);
            
            else
                fcI=902e6;
            end
            for j=1:Nrandom
                freqOffset=0;

                for snrVal=1:size(snrsDb,2)
                    disp('snr');
                    disp(snrsDb(snrVal));
                    label={string(modulationTypes(modType)),snrsDb(snrVal),num2str(Ls(sps_i)),num2str(freqOffset),num2str(Ms(sps_i)),1};
                    key=join(string(label),'rer');
                    key=strrep(key,'-','neg');
                    value=zeros(Ns,14*Nts,sample_length);        
                    
                    for k=1:Ns
                        %disp(k);
                        x=dataSource();
                        
                        y=modulator(x);
                        source_signal=y;
                        

                        if(Ms(sps_i)>1)
                            if contains(char(modulationTypes(modType)),...
                                {'BFM','DSBAM','SSBAM'})
                                lela=1;
                            else
                                y=Ls(sps_i).*y; % add gain since due to 
                                %downsampling the signal amplitude changes
                              
                                rrcFilter=rcosdesign(0.35,4,Ms(sps_i));
                                y=upfirdn(y,rrcFilter,1,Ms(sps_i));
                        
                             end
                         end
                      
                        %plotConstellation(y(50:end,1),label{:});
                        disp(modulationTypes(modType));
                        %continue;


                        for o=1:5
                            switch o
                            case 1
                                disp('Awgn')
                                rxSamples=awgn(y,snrsDb(snrVal),'measured');

                            case 2
                                disp('Fading')
                                rx=rayleighMultipath(y,fs,4);
                                rxSamples=awgn(rx,snrsDb(snrVal),'measured');
                            case 3
                                disp('SCO')
                                rx=addClockOffset(y,fs,fc,10);
                                rx=rx(1:end-1);
                                rxSamples=awgn(rx,snrsDb(snrVal),'measured');
                            case 4
                                disp('CFO')
                                pfo = comm.PhaseFrequencyOffset('SampleRate',fs,'FrequencyOffset',5*1e3);
                                y_f=pfo(y);
                                rx=y_f;
                                rx=rx(1:end-1);
                                rxSamples=awgn(rx,snrsDb(snrVal),'measured');

                            case 5
                                disp('iq imbalance')
                                rx=addIQImbalance(y,5,5,0,0);
                                rxSamples=awgn(rx,snrsDb(snrVal),'measured');
                            end 
                        
                      
                        other_r_td=length(rxSamples)-sample_length-50;
                        transDelay_r=randi([50 other_r_td],1);
                         
                        [frame,source_frame]=helperModClassFrameGenerator(rxSamples,source_signal,sample_length, sample_length, transDelay_r,min(Ls(sps_i),Ms(sps_i)));
                        
                        l=frame(:,1:Nts);
                        energy=sum(abs(l).^2); %time domain
                        l=l./energy;
                        ii=real(l);
                        qq=imag(l);
                        max_i=max(ii);
                        max_q=max(qq);
                        if max_i>max_q
                            ii=ii./max_i;
                            qq=qq./max_i;
                        else
                            ii=ii./max_q;
                            qq=qq./max_q;

                        end
                        sb1=subplot(5,11,(o-1)*11+modType);
                        %sb1.Position=[modType*0.068,(6-o)*0.145,0.0647,0.1443];
                        scatter(ii,qq,'k.');
                        xlim([-1.05,1.05]);
                        ylim([-1.05,1.05]);
                        set(gca,'xtick',[]);
                        set(gca,'xticklabel',[]);
                        set(gca,'ytick',[]);
                        set(gca,'yticklabel',[]);
                        set(gca,'FontSize',12);
                        set(gca,'FontName','Arial');
                        set(gca,'FontWeight','Bold');

                        
                        if(o==5)
                            xlabel(modulationTypes(modType));
                        end
                        if(modType==1)
                            switch o
                            case 1
                                ylabel('AWGN');
                            case 2
                                ylabel('Rayleigh');
                            case 3
                                ylabel('SCO');
                            case 4
                                ylabel('CFO');
                            case 5
                                ylabel('IQ imbalance');
                            end
                        end
                        
                        end
                        


                    end
                   
                end
            end
            end
                
        end
                
    end
    
    %random generation of modulation types, power ratios, offsets
    if i>1
        fprintf('%s generating frames for number ttransmissions %d \n',...
                        datestr(toc/86400,'HH:MM:SS'),i);
        for j=1:Nrandom
            ran_mod_types=randi([1 size(modulationTypes,2)],1,i);
            ran_power_ratios=randi([1 size(powerRatiosDb,2)],1,i);
            if allowOverlapping==true
                ran_freq_offsets=randi([1 size(frequencyOffsets,2)],1,i);
                ran_sps=randi([1 size(nsps,2)],1,i);
            else
                 ran_freq_offsets=zeros(1,i);
                ran_sps=zeros(1,i);
                ran_freq_offsets(1,1)=randi([1 length(frequencyOffsets)]);
                ran_sps(1,1)=randi([1 length(nsps)]);
                %fprintf('first freq offset %.3f sps %d\n',...
                 %   frequencyOffsets(ran_freq_offsets(1,1)),nsps(ran_sps(1,1)));
                minBorder=floor(frequencyOffsets(ran_freq_offsets(1,1)) ...
                    -(0.5*fs)/nsps(ran_sps(1,1)));
                maxBorder=ceil(frequencyOffsets(ran_freq_offsets(1,1)) ...
                    +(0.5*fs)/nsps(ran_sps(1,1)));
                forbiddenRangeMins=zeros(1,i);
                forbiddenRangeMaxs=zeros(1,i);
                forbiddenRangeMins(1,1)=minBorder;
                forbiddenRangeMaxs(1,1)=maxBorder;
               
                
                for ranI=2:i
                    validCombination=false;
                    while validCombination==false
                        ran_freq_offsets(1,ranI)=randi([1 length(frequencyOffsets)]);
                        ran_sps(1,ranI)=randi([1 length(nsps)]);
                        minBorder=floor(frequencyOffsets(ran_freq_offsets(1,ranI)) ...
                            -(0.5*fs)/nsps(ran_sps(1,ranI)));
                        maxBorder=ceil(frequencyOffsets(ran_freq_offsets(1,ranI)) ...
                            +(0.5*fs)/nsps(ran_sps(1,ranI)));
                        overlapp=false;
                        %fprintf('new rand for i= %d freq offset %.3f sps %d \n',ranI,...
                        %    frequencyOffsets(ran_freq_offsets(1,ranI)),nsps(ran_sps(1,ranI)));
                        %fprintf('min border %d max border %d\n',minBorder, maxBorder);
                       % disp(forbiddenRangeMins);
                        %disp(forbiddenRangeMaxs);
                        for elem=1:length(forbiddenRangeMins)
                           
                            if((forbiddenRangeMaxs(elem)>minBorder && ...
                                    forbiddenRangeMins(elem)<minBorder) || ...
                                    (forbiddenRangeMaxs(elem)>maxBorder && ...
                                    forbiddenRangeMins(elem)<maxBorder) || ...
                                    (forbiddenRangeMins(elem)>minBorder && ...
                                    forbiddenRangeMaxs(elem)<maxBorder))
                                overlapp=true;
                               % disp('overlapping true');
                                break;
                            end
                        end
                        if overlapp==false
                            forbiddenRangeMins(1,ranI)=minBorder;
                            forbiddenRangeMaxs(1,ranI)=maxBorder;
                            validCombination=true;
                            %disp('valid combination\n');
                            
                        end
                       
                        
                    end
                end
            end
           
            for snrVal=1:length(snrsDb)
               
                
                value=zeros(Ns,14*Nts,sample_length);
                for k=1:Ns
            
                    modulationTypesLabel='';
                    frequencyOffsetsLabel='';
                    powerRatiosLabel='';
                    bwcLabel='';
                    y=zeros(Nt*sample_length,1);
                    for m=1:i
                        modulationTypesLabel=strcat(modulationTypesLabel, ...
                            string(modulationTypes(ran_mod_types(m))),'_');
                        frequencyOffsetsLabel=strcat(frequencyOffsetsLabel, ...
                            num2str(frequencyOffsets(ran_freq_offsets(m))),'_');
                        powerRatiosLabel=strcat(powerRatiosLabel, ...
                            num2str(powerRatiosDb(ran_power_ratios(m))),'_');
                         bwcLabel=strcat(bwcLabel, ...
                            num2str(fs/nsps(ran_sps(m))),'_');
                        sps=nsps(ran_sps(m));
                        dataSource=getDataSource(modulationTypes(ran_mod_types(m)), ...
                            sps,Nt*sample_length,fs);
                        modulator=getModulator(modulationTypes(ran_mod_types(m)),...
                            sps,fs);
                        x=dataSource();
                        x_mod=modulator(x);
                        pfo=comm.PhaseFrequencyOffset('SampleRate',fs, ...
                          'FrequencyOffset',frequencyOffsets(ran_freq_offsets(m)));
                        x_mod=pfo(x_mod);
                        x_mod=x_mod.*10^(powerRatiosDb(ran_power_ratios(m))/10);
                        y=y+x_mod;
                    end

                    fprintf('%s generating frames with labels: mods: %s, freq: %s, power: %s  \n',...
                        datestr(toc/86400,'HH:MM:SS'),modulationTypesLabel, ...
                        frequencyOffsetsLabel,powerRatiosLabel);
                    
                    
                   %add multipath fading
                   if applyRicean==true
                       y=riceanMultipath(y,fs);
                   elseif applyRayleigh==true
                            y=rayleighMultipath(y,fs);
                   end
                   
                   if applyClockOffset==true
                       y=addClockOffset(y,fs,fc);
                   end
                    %add AWGN    
                    rxSamples=awgn(y,snrsDb(snrVal),'measured');
                    %rxSamples=channel(y);

                   frame=helperModClassFrameGenerator(rxSamples,sample_length,sample_length, transDelay,sps);
                   frame_shaped=shape_frame(frame(:,1:Nts),sample_length,fs,snrsDb(snrVal));
                   value(k,:,:)=frame_shaped;

                   %plotTimeDomain(frame(:,1),fs,label{:});
                   %plotSpectogram(frame(:,1),fs,sps,label{:});
                   %plotConstellation(frame(:,1),label{:});
                   %plotKernelDensity(frame(:,1),label{:});
                end
                
                label={modulationTypesLabel,snrsDb(snrVal),powerRatiosLabel, ...
                       frequencyOffsetsLabel,'None',i};
                key=join(string(label),'rer');
                key=strrep(key,'-','neg');
                ds=setfield(ds,key,value);
            end
        end
        
    end
end



