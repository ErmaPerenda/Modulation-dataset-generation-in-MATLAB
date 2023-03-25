figure;
subplot(2,2,1);
a=load('qam16_rici200.mat');
rxSig=a.x;

% rxSig is 1xN signal sequence where N is number of samples
data = [real(rxSig) imag(rxSig)];
[bandwidth, density, X, Y] = kde2d(data, 512);
surf(X, Y, density, 'LineStyle', 'none');
%set(gcf,'Position',[100 100 300 300])
colormap('gray');
title('1/T_s=200k, L=1');
set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
set(gca, 'ZTickLabel', []);
set(gca,'FontSize',12);
subplot(2,2,3);
a=load('qam16_rici1000.mat');
rxSig=a.x;

% rxSig is 1xN signal sequence where N is number of samples
data = [real(rxSig) imag(rxSig)];
[bandwidth, density, X, Y] = kde2d(data, 512);
surf(X, Y, density, 'LineStyle', 'none');
%set(gcf,'Position',[100 100 300 300])
colormap('gray');
title('1/T_s=1000k, L=1');
set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
set(gca, 'ZTickLabel', []);

set(gca,'FontSize',12);

subplot(2,2,2);
a=load('qam16_rici200_sps8.mat');
rxSig=a.x;

% rxSig is 1xN signal sequence where N is number of samples
data = [real(rxSig) imag(rxSig)];
[bandwidth, density, X, Y] = kde2d(data, 512);
surf(X, Y, density, 'LineStyle', 'none');
%set(gcf,'Position',[100 100 300 300])
colormap('gray');
title('1/T_s=200k, L=8');
set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
set(gca, 'ZTickLabel', []);

set(gca,'FontSize',12);
subplot(2,2,4);
a=load('qam16_rici1000_sps8.mat');
rxSig=a.x;

% rxSig is 1xN signal sequence where N is number of samples
data = [real(rxSig) imag(rxSig)];
[bandwidth, density, X, Y] = kde2d(data, 512);
surf(X, Y, density, 'LineStyle', 'none');
%set(gcf,'Position',[100 100 300 300])
colormap('gray');
title('1/T_s=1000k, L=8');
set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
set(gca, 'ZTickLabel', []);
set(gca,'FontSize',12);
