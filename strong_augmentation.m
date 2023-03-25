function strong_augmented=strong_augmentation(I,Q,f)


snr_rng=[26:2:38]; %0.02, 0.05
theta_rng=[-90:30:90];

index=randi(length(snr_rng));
snr_db=snr_rng(index)


%disp('strong augmentation snr');
%disp(snr_db);
snr_wat=10^(snr_db/10);
std_val=sqrt(1/snr_wat);

mean_val=0.0;
gnoise_I=std_val.*randn(size(I));
gnoise_Q=std_val.*randn(size(Q));

I_noisy=I;
Q_noisy=Q;
noising=false;
if rand()<0.7
	noising=true;
	I_noisy=I+gnoise_I;
	Q_noisy=Q+gnoise_Q;
end
	

%disp('adding noise');
%disp(I(:,1:5));
%disp(gnoise_I(:,1:5));
%disp(I_noisy(:,1:5));

%disp(Q(:,1:5));
%disp(gnoise_Q(:,1:5));
%disp(Q_noisy(:,1:5));


index=randi(length(theta_rng));
disp('rotation');

theta=theta_rng(index);



rotation=[cosd(theta), -sind(theta); sind(theta),cosd(theta)];

%disp(rotation);
%disp('IQ matr');
%disp([I(:,1:5);Q(:,1:5)]);
strong_augmented=rotation*[I_noisy;Q_noisy];
%disp(strong_augmented(:,1:5));

x=strong_augmented(1,:)+j*strong_augmented(2,:);
%disp('x');
%disp(x(1:10));
energy=sum(abs(x).^2); %parseval correct one - it is alread unit energy

x=x./energy;

strong_augmented(1,:)=real(x);
strong_augmented(2,:)=imag(x);
%disp(strong_augmented(:,1:5));

%f = figure('visible','off');
%scatter_fig=scatterplot(x);
%title('Strong 1');
%xlim([-0.05 0.05]);
%ylim([-0.05 0.05]);
%set(gca,'xtick',[],'ytick',[]);
%set(gca, 'fontsize', 10,'FontWeight', 'bold','FontName','Times','Color','black');
%h=gca;                %Axis handle
%h.Title.Color='k'     %Color of title
%h.Children.Color='b'; %Color of points
%h.YColor='k';         %Y-axis color including ylabel
%h.XColor='k';         %X-axis color including xlabel
%h.Color ='w';         %inside-axis color
%h.Parent.Color='w'    %outside-axis color
%xlabel('');ylabel('');
%copyobj(get(scatter_fig,'Children'),f); % copy everything from scatterplot figure to f
%delete(scatter_fig); % delete scatterplot figure

%saveas(gcf,'constelation_strong.png')
%close(f);

%f=figure('visible','off');
%sample_length=size(x,2);
%disp('length');
%disp(sample_length);
%fs=200e3;
%t=1000*(0:sample_length-1)/fs;
%rxI=real(x);
%rxQ=imag(x);
    
%plot(t(1:50),squeeze(rxI(1:50)),'-','LineWidth',2);
%grid on; 
%hold on;
    
%plot(t(1:50),squeeze(rxQ(1:50)),'-','LineWidth',2);
%grid on;
%hold off;
%xlabel('Time(ms)');
%ylabel('Amplitude');
%set(gca,'XTick',[]);
%set(gca,'YTick',[]);
%legend('I','Q','NumColumns',1,'Location','southeast');
%set(gcf,'Position',[100 100 140 120])
%saveas(gcf,'time_strong_ssbam.png')
%close(f);


end