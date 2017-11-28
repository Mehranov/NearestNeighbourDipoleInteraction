%This is the Main code.
H_model=zeros(1,1); K_model=zeros(1,1);
H_NN=zeros(1,9);
[U_tot,NNnumb,Ms,l,P,Resol,hm,hn,a,thet_resol]=numeric_Aref;
[U]=AdjustData2(U_tot,NNnumb);
[K_NN]=FitEnergyTheta(U);

%for i=1:1;
    
    %hm=20*1e-09;
    %hn=10*1e-09;
    [H_model(1),K_model(1)]=hkmodel(Ms,hm,hn,P);

%end
H_model_Oe=H_model/(1000/4/pi);

H_NN(1:length(K_NN))=Hnn(K_NN,Ms);
H_NN_Oe=H_NN/(1000/4/pi);
%clearvars -except H_model K_model H_model_Oe H_NN K_NN H_NN_Oe
Resolution=num2str(Resol);
L=l.*1e9;L=num2str(L);HM=hm*1e9;HN=hn*1e9;HM=num2str(HM);HN=num2str(HN);A=num2str(a*1e9);thet_resol=num2str(thet_resol);Por=num2str(P);
MS=Ms/1000;MS=num2str(MS);
Res=strcat('C:\Users\Lab Magnétisme\Dropbox\PhD\MatlabProjects\DipoleFieldOverDisk2\Results\rad2\','Ms',MS,'_hm',HM,'_hn',HN,'_Resol',Resolution,'_a',A,'_ThetRes',thet_resol,'_Por',Por,'.txt');
Res2=strcat('C:\Users\Lab Magnétisme\Dropbox\PhD\MatlabProjects\DipoleFieldOverDisk2\Results\rad2\','Ms',MS,'_hm',HM,'_hn',HN,'_Resol',Resolution,'_a',A,'_ThetRes',thet_resol,'_Por',Por,'.mat');
fid1=fopen(Res,'w');
fprintf(fid1,'% 20s %10.5f\r\n','Ellapsed Time',toc);
fprintf(fid1,'%20s %20s %20s %20s %20s %20s %20s %20s %20s %20s\r\n','H_model_Oe','H_1NN_Oe','H_2NN_Oe','H_3NN_Oe','H_4NN_Oe','H_5NN_Oe','H_6NN_Oe','H_7NN_Oe','H_8NN_Oe','H_9NN_Oe');
A=[H_model_Oe; H_NN_Oe(1); H_NN_Oe(2); H_NN_Oe(3); H_NN_Oe(4); H_NN_Oe(5); H_NN_Oe(6); H_NN_Oe(7); H_NN_Oe(8); H_NN_Oe(9);];
fprintf(fid1,'%20.5e %20.5e %20.5e %20.5e %20.5e %20.5e %20.5e %20.5e %20.5e %20.5e\r\n',A);
save(Res2)
fclose('all');
clear A



