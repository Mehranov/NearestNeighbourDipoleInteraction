function PlotFit(Theta,Energy)
global x 
global U
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
 hold on
 plot(Theta,Energy,'ro')
 plot(Theta,U(x,Theta))
 hold off

end

