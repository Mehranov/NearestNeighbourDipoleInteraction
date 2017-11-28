function [ Heff_orig,K_orig,H_oe ] = hkmodel( Ms,hm,hn,P )
%AniCons Calculates the Anisotropy Constant
%   K=AniCons(Ms,hm,hn,P)
%   Ms(emu/cm^3) hm,hn(nano meter) P(constant)
%   In this function, we want to calculate K based on the known parameters
%   Ms(magnetization) hm(magnetic layer thickness) hn(non-magnetic layer
%   thickness) and P(the porosit)
% *The porosity itself should be calculated separately 
%Ms=Ms.*4.*pi;
Ms=Ms*1000;
hm=hm.*1e-09;
hn=hn.*1e-09;
Heff_orig=Ms/2.*(1-3.*(1-(hm/(hm+hn)).*(1-P)));
K_orig=Heff_orig*4.*pi.*1e-07.*Ms/2;
H_oe=Heff_orig/1000.*4.*pi;
end

