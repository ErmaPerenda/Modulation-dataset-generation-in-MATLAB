function plotTimeDomain(frame,fs,varargin)
    figure;
    label=varargin;
    sample_length=size(frame,1);
    t=1000*(0:sample_length-1)/fs;
    rxI=real(frame);
    rxQ=imag(frame);
    
    plot(t,squeeze(rxI),'-');
    grid on; axis equal; axis square;
    hold on;
    
    plot(t,squeeze(rxQ),'-');
    grid on; axis equal; axis square;
    hold off;
    
    title(label{1});
    xlabel('Time(ms)');
    ylabel('Amplitude');
    

end