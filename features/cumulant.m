%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function will calculate the Cumulant as defined by
% equation 2 in the paper "Hierarchical Digital Modulation Classification Using Cumulants
% by Swami, Sadler
% Checked for proper operation with Octave Version 3.0.0
% Author	: Youssef Bagoulla
% Email		: sayguh@gmail.com
% Version	: 1.0
% Date		: 15 April 2012
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [C20,C21,C40,C41,C42,C60,C61,C62,C63,C80,C84] = cumulant(y)



N = length(y);

% C20 = 1/N * sum(y.^2);
% C21 = 1/N * sum(abs(y).^2);
% C40 = 1/N * sum(y.^4) - 3 * C20^2;
% C41 = 1/N * sum(y.^3 .* conj(y)) - 3*C20*C21;
% C42 = 1/N * sum(abs(y).^4) - abs(C20)^2 - 2*(C21^2);

% Automatic Modulation Classification Using Combination of Genetic Programming and KNN
% http://ieeexplore.ieee.org/abstract/document/6213036/

% M_pq = E[y(k)^(p−q) * (y∗(k))^(q)]

M20 = mean(y.^2);
M21 = mean(y .* conj(y));
M22 = mean(conj(y).^2);
M40 = mean(y.^4);
M41 = mean(y.^3 .* conj(y));
M42 = mean(y.^2 .* conj(y).^2);
M43 = mean(y .* conj(y).^3);
M60 = mean(y.^6);
M61 = mean(y.^5 .* conj(y));
M62 = mean(y.^4 .* conj(y).^2);
M63 = mean(y.^3 .* conj(y).^3);
M80=mean(y.^8);
%M82=mean(y.^6 .*conj(y).^2);
%M83=mean(y.^5 .*conj(y).^3);
M84=mean(y.^4 .*conj(y).^4);



C20 = M20;
C21 = M21;
C40 = M40 - 3*M20^2;
C41 = M41 - 3*M20*M21;
C42 = M42 - abs(M20)^2 - 2*(M21^2);


C60 = M60 - 15*M20*M40 + 30*M20^3;
C61 = M61 - 5*M21*M40 - 10*M20*M41 + 30*M20^2 * M21;
C62 = M62 - 6*M20*M42 - 8*M21*M41 - M22*M40 + 6*M20^2*M22 + 24*M21^2*M20;
% [lu2017modulation] Modulation Recognition for Incomplete Signals through Dictionary Learning
% C63_ = M63 - 9*C42*C21 - 6*C21^3;
% [aslam2012automatic] Automatic Modulation Classification Using Combination of Genetic Programming and KNN
C63 = M63 - 9*M21*M42 + 12*M21^3 - 3*M20*M43 - 3*M22*M41 + 18*M20*M21*M22;


C80=M80 - 35*M40^2 - 28*M60*M20 + 420*M40*M20^2 - 630*M20^4;
C84=M84 - 16*C63*C21 + abs(C40)^2 - 18*C42^2 - 72*C42*C21^2 - 24*C21^4;


C40 = C40/C21^2;
C41 = C41/C21^2;
C42 = C42/C21^2;

C60 = C60/C21^3;
C61 = C61/C21^3;
C62 = C62/C21^3;
C63 = C63/C21^3;

C80=C80/C21^4;
C84=C84/C21^4;