function AdjustData( Uorig )
%AdjustData will rearrange the data in a long series of one file into a 2D
%matrice and seperate the values corresponig to different layer thickness
%   Detail: in order to compare the effect of contribution of nearest
%   neighbor calculation we performed the code "numeric4" for a range of
%   different hm/hn ratioes from 0 to 5 (hn was fixed at 10nm and hm goes
%   from 2.5nm to 100nm)However, the output data in this code is a one long
%   file including all the results for 0-pi/2 for hm=2.5-100 respectively.
%   so we need to rearrange it in a way that we can have the data for
%   different hm seperately and add the next half (from pi/2-pi) which is
%   symmetric to 0-pi/2 for fitting purposes.
% in this code we import the original data (text file) from numeric4 into
% workspace and then call this function to rearrange it for us in a desired way.
U(1:40,1:13)=0;
global Uenergy
k=0;
for i=1:40;
    for j=1:7;
        k=k+1;
        U(i,j)=Uorig(k);
    end
end
U(1:40,8:13)=U(1:40,6:-1:1);
Uenergy=U;
end

