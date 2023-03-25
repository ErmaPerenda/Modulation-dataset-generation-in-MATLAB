function plotConstellation(frame,varargin)
   
    label=varargin;
    disp(size(label));
    sample_length=size(frame,1);
    disp(label{1});
    disp(label{4});
    disp(label{3});
    rx=frame;
    scatterplot(rx);
    title(strcat('mods: ',label{1},' offsets: ', label{4},' powers: ',label{3}));
    
    
end