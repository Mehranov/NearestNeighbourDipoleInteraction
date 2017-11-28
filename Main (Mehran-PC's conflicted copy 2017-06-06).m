%This is the Main code.
H_model=zeros(1,10); K_model=zeros(1,10);
H_NN=zeros(1,90);
[U_tot,NNnumb,Ms,l,P]=numeric_Aref;
[U]=AdjustData2(U_tot,NNnumb);
[K_NN]=FitEnergyTheta(U);
for i=1:10;
    hm=l-l/i;
    hn=l-hm;
    [H_model(i),K_model(i)]=hkmodel(Ms,hm,hn,P);
end
H_model_Oe=H_model/(1000/4/pi);

H_NN(1:length(K_NN))=Hnn(K_NN,Ms);
H_NN_Oe=H_NN/(1000/4/pi);
%clearvars -except H_model K_model H_model_Oe H_NN K_NN H_NN_Oe
fid1=fopen('c:\H_K_model_NN.txt','w');
fprintf(fid1,'%20s %20s %20s %20s %20s %20s %20s %20s %20s %20s\r\n','H_model_Oe','H_1NN_Oe','H_2NN_Oe','H_3NN_Oe','H_4NN_Oe','H_5NN_Oe','H_6NN_Oe','H_7NN_Oe','H_8NN_Oe','H_9NN_Oe');
A=[H_model_Oe; H_NN_Oe(1:10); H_NN_Oe(11:20); H_NN_Oe(21:30); H_NN_Oe(31:40); H_NN_Oe(41:50); H_NN_Oe(51:60); H_NN_Oe(61:70); H_NN_Oe(71:80); H_NN_Oe(81:90);];
fprintf(fid1,'%20.5e %20.5e %20.5e %20.5e %20.5e %20.5e %20.5e %20.5e %20.5e %20.5e\r\n',A);
clear A



