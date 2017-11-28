function [ H_new ] = Hnn( K,Ms )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Ms=460
s=size(K);
s=s(2);
n=s/1;
H=zeros(1,s);
for i=1:1:n; 
    %for j=1:1:1;
        %ii=(i-1)*10+j;
        KK=K(i);
        H(i)=(2.*KK)/(4*pi*1e-07*Ms);
    %end
end
H_new=H;
end

