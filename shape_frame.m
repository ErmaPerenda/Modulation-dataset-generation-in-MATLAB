function shaped_frame=shape_frame(x,src_x,sequence_length,fs,snr_val)


%disp("here are ")
%energy=sum(abs(x).^2)/length(x);% freqency domain

energy=sum(abs(x).^2); %time domain


x=x./energy;


energy=sum(abs(src_x).^2);
src_x=src_x./energy;



%conventional SNR
N=sequence_length;
no_a=(1/N*sum(abs(x)))^2;
de_a=(1/N*sum(abs(x).^2));
SNR_c=no_a/(de_a-no_a);
SNR_c_db=10*log10(SNR_c);

%m2m4 snr estimator
M2 = mean(x .* conj(x));
M4 = mean(x.^2 .* conj(x).^2);
no_a=sqrt((2*M2^2)-M4);
SNR_M2M4=no_a/(M2-no_a);
SNR_M2M4_db=10*log10(SNR_M2M4);


x_unit=[SNR_c_db,SNR_M2M4_db];

shaped_frame=zeros(1,size(x,2)*14,size(x,1));

I=real(x);
Q=imag(x);
b=[I';Q'];
%disp(b(:,1:3))

I_src=real(src_x);
Q_src=imag(src_x);
b_src=[I_src';Q_src'];
%disp(b(:,1:3))


%I=abs(x);
%Q=angle(x)./pi;

psd=zeros(size(I));

I = permute(I,[2 1]);
Q = permute(Q,[2 1]);

I_src=permute(I_src, [2 1]);
Q_src=permute(Q_src, [2 1]);

nt=size(x,2);

%disp('nt' );
%disp(nt);

shaped_frame(1,1:nt,:)=I;
shaped_frame(1,nt+1:2*nt,:)=Q;


%for i=1:size(psd,2)
%    [S,F,T,P]=spectrogram(x(:,i),hanning(sequence_length), ...
%            0,sequence_length,fs,'centered');
%    psd(:,i)=10*log10(abs(fftshift(P)));

%end
     
psd=permute(psd,[2 1]);
   
shaped_frame(1,2*nt+1:3*nt,:)=psd;

cumulants_values=zeros(nt,sequence_length);
for i=1:nt
	[C20,C21,C40,C41,C42,C60,C61,C62,C63,C80,C84]=cumulant(x(:,i));
	cumulants_values(i,1)=abs(C20);
	cumulants_values(i,2)=abs(C21);
	cumulants_values(i,3)=abs(C40);
	cumulants_values(i,4)=abs(C41);
	cumulants_values(i,5)=abs(C42);
	cumulants_values(i,6)=abs(C60);
	cumulants_values(i,7)=abs(C61);
	cumulants_values(i,8)=abs(C62);
	cumulants_values(i,9)=abs(C63);
	cumulants_values(i,10)=abs(C80);
	cumulants_values(i,11)=abs(C84);
end

%cumulants_values(:,1)=SNR_c_db;
%cumulants_values(:,2)=SNR_M2M4_db;

%disp(cumulants_values(1,1:11));
shaped_frame(1,3*nt+1:4*nt,:)=cumulants_values;

shaped_frame(1, 4*nt+1:5*nt,:)=I_src;
shaped_frame(1,5*nt+1:6*nt,:)=Q_src;

%disp(size(shaped_frame));

%disp('weak augmentation');
%disp(size(I));
%disp(size(Q));
%disp(I(:,1:5));
%disp(Q(:,1:5));

if (snr_val>-18)
	disp("it is snr 18")
	%iq_imbalanced=iq_imbalance(I,Q);
	%exit()

	weak_augmented=weak_augmentation(I,Q);

	%g=figure('visible','off');
	weak_augmented_1=weak_augmentation(I,Q);
	%close(g);

	rician_1=[weak_augmented(1,:) weak_augmented_1(1,:)]+j*[weak_augmented(2,:) weak_augmented_1(2,:)];
	rician_1=downsample(rician_1,2);




	%disp('strong augmentation');
	strong_augmented=strong_augmentation(I,Q);

	rician_2=[weak_augmented_1(1,:) strong_augmented(1,:)]+j*[weak_augmented_1(2,:) strong_augmented(2,:)];
	rician_2=downsample(rician_2,2);


	shaped_frame(1, 6*nt+1:7*nt,:)=weak_augmented(1,:);
	shaped_frame(1,7*nt+1:8*nt,:)=weak_augmented(2,:);

	shaped_frame(1, 8*nt+1:9*nt,:)=strong_augmented(1,:);
	shaped_frame(1,9*nt+1:10*nt,:)=strong_augmented(2,:);

	shaped_frame(1, 10*nt+1:11*nt,:)=real(rician_1);
	shaped_frame(1,11*nt+1:12*nt,:)=imag(rician_1);

	shaped_frame(1, 12*nt+1:13*nt,:)=real(rician_2);
	shaped_frame(1,13*nt+1:14*nt,:)=imag(rician_2);
end

end