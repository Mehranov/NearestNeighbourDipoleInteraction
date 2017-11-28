function  PlotUT(O,Thet)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global x
hold on
plot(Thet,O,'go')
ezplot(@(t)x(1)*sin(t)^2+x(2),[0 pi])
hold off

end

