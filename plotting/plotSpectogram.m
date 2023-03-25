function plotSpectogram(frame,fs,sps,varargin)
    figure;
    label=varargin;
    sample_length=size(frame,1);
    rx=frame;
    spectrogram(rx,hanning(sample_length),0,sample_length,fs,'centered');
    [S,F,T,P]=spectrogram(rx,hanning(sample_length),0,sample_length,fs,'centered');
    disp(size(S));
    disp(size(P));
%     
%      disp(size(F));
%      disp("time");
%     disp(size(T));
%     disp(size(S));
%     surf(T,F,10*log10((abs(S))), 'EdgeColor', 'none');
%    axis xy; 
%  axis tight; 
%  colormap(jet); view(0,90);
%  xlabel('Time (secs)');
%  colorbar;
%  ylabel('Frequency(HZ)');

    % title(strcat(label{1},';offset:',label{4}));
    title(strcat('mods: ',label{1},' offsets: ', label{4},' powers: ',label{3}));
    figure;
    plot(fftshift(F),fftshift(P));
    %title(label{1});
%     
    h=gcf;
    delete(findall(h.Children,'Type','ColorBar'));
    
    
end