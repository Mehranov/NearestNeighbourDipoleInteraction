function  [O]=AdjustData2 (I,NNnumb)
%UNTITLED2 Summary of this function goes here
%   here the data for each thickness will be adjusted to be symmetric. yani
%   age masalan az 0 ta 90 darajeh hesab kardim (ke kardim) az 90 ta 180 ro
%   khodesh be surate motegharen michineh

N1=length(I);
N2=N1/(NNnumb);
U_new=zeros(N2,NNnumb+1);
for i=1:1:NNnumb;
    for j=1:1:N2;
        U_new(j,i)=I(((i-1)*N2+j),1);
    end
end
for i=1:1:N2;
    U_new(i,NNnumb+1)=I(i,2);
end
O=U_new;