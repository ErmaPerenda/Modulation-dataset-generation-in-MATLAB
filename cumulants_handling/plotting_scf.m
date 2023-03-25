function plotting_scf(alphao,fo,Sx,N,fs)
%Surface Plot 5
figure (1)
surfl(alphao, fo, Sx);
view(-37.5,60);
title ('SCD estimate using FAM');
xlabel (' alpha ' );
ylabel ( 'f' ) ;
zlabel ( 'Sx' );

%Contour Plot%
figure (2);
contour(alphao, fo, Sx);
xlabel('alpha (Hz)');
ylabel('f (Hz)');

%Cross-Section Plots%
figure(3);
alpha=0.000;
plot (fo,Sx(:,1+N*(alpha/fs+1))); % alpha is the desired cyclic
% frequency,
xlabel('f (Hz)');
ylabel('Sx (alpha)');
end