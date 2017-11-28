function [ heff_new,heff_old,K_new,K_old ] = H_effective_new( U )
%Just Enter the energy (array of one row) and get heff with and without the
%effect of NN. the input should be Only the row of energy (10 number for
%each layer thickness correspond with ten different values of Theta from 0 to 90 in steps of pi/18). the format of Energy which is placed as input is
%showing the U for magnetic layer neighbors (could be 1st neighbor or any)
%which the thickness ratio of hm over hn (hm/hn) is changing from 0 to 10
%so the U should include 10 set of numbers, each set hast usually 10 other
%numbers in it which is the U for different angles (usually I take pi/10 so
%theta will go 18 up every cycle and we will have 10 different U for 10
%different dipole angles, right now in this program U should be 90*1
%numbers only
U_temp=(1:9*19)*0;
k_nn=(1:10)*0;
theta=(1:19)*0;
l=input('hm+hn=?');
Ms=input('magnetization=?');
P=.1073;
k_old=(1:10)*0;
heff_old=(1:10)*0;
heff_new=(1:10)*0;
K_new=(1:10)*0;
K_old=(1:10)*0;


global x
%%
% in this section we buil up the theta with the same nukber of our U data
% to plot (and then fit) U vs Theta
for t=1:1:19;
    theta(t)=pi/18*(t-1);
end
% theta=theta';

%%
% in this section we adjust the data form of U. The original output of U
% data is from theta=0 to 90 which is only the half of the required data so
% here we add the other hald to it since it is symmetrtic
for j=1:1:9;
for i=1:1:19;
    if (i<11)
        U_temp((j-1)*19+i)=U((j-1)*10+i);
    else
        U_temp((j-1)*19+i)=U(10*j-i+10);
    end
end
end
%%
% in this section we Fit U and theta for all the U datas. The function
% FitEnergyTheta will fit these two data for us and give the K (anisotropy
% constant) based on the contribution of the specific neighbor which is
% considered in calculation of U. 
for i=1:1:9;
 FitEnergyTheta(U_temp((i-1)*19+1:i*19),theta(1:19));
 k_nn(i+1)=x(1);
 K_new(i)=k_nn(i+1);
end
for i=1:1:10;
    hn=l/i;
    hm=l-hn;
    k_old(i)=AniCons(Ms,hm,hn,P);
    heff_old(i)=2*k_old(i)/(4*pi*1e-07*Ms*1000);
    K_old(i)=k_old(i);
end
for i=1:1:10;
    heff_new(i)=2*(k_nn(i)+k_old(i))/(4*pi*1e-07*Ms*1000);
end

    


end

