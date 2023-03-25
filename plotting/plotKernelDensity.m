function plotKernelDensity(rxSig,varargin)
    label=varargin;
    % rxSig is 1xN signal sequence where N is number of samples
    data = [real(rxSig) imag(rxSig)];
    [bandwidth, density, X, Y] = kde2d(data, 512);
    disp(size(X));
    disp(size(Y));
    disp(size(density));
    disp(size(data));
    figure;
    surf(X, Y, density, 'LineStyle', 'none');
    title(strcat('mods: ',label{1},' offsets: ', label{4},' powers: ',label{3}));
    % the following three lines remove the label text (optional)
    %set(gca, 'XTickLabel', []);
    %set(gca, 'YTickLabel', []);
    %set(gca, 'ZTickLabel', []);

end