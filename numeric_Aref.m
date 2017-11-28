function [U_tot,NNnumb,Ms,l,P,Resol,hm,hn,a,thet_resol]=numeric_Aref
% in this code we will calculate the magnetic field produced by a
% distribution of dipoles inside a disk over the volume of the adjacen disk
% located above the origin. the geomrtry is explained in proposla
%%
clear all
cc=0;
a=input('enter the radius of the disk "a" in nano meter: ');
%l=input('enter the thickness of hm+hn in nano meter: ');
hm=input('enter the hm thickness: ');
hn=input('enter the hn thickness: ');
Ms=input('eneter the value of saturation magnetization "Ms" in emu/cm3: ');
NNnumb=input('enter the number of nearest neighbors you wish to include:');
Resol=input('enter the desired resolution for this calculation, a typical resolution is 10 nm');
thet_resol=input('enter the resolution of diople angles, for example if you enter 18 that means the calculation will be done for evry pi/18 i.e. dipoles will rotate 10 degree in each step. It should be an even number');
P=input('enter the porosity factor, in our test model it is 0.1073');
%%
hm=hm*1e-09;
hn=hn*1e-09;
l=hm+hn;
a=a*1e-09;
%l=l*1e-09;
Ms=Ms*1000;
IntBx=0;
IntBy=0;
IntBz=0;
dz = Resol *1e-09;
dx = Resol*1e-09;
dy = Resol*1e-09;
u0=pi*4*1e-07;
V_diple=dx.*dy.*dz;
U_size=((thet_resol/2)+1);
U_tot=zeros(U_size*NNnumb,2);
%%
tic
for j=1:1:NNnumb;
    %for i=1:1:10;
        %%%%%%%%%%%%%
        
        %%%%%%%%%%%%%
        fprintf('Neighbor = %0.1f',j)
        %hn=l/i;
        %hm=l-hn;
        %if you wish to manually enter the hm and hn thickness simply type
        %them in the following two lines otherwise comment them
        %hn=10*1e-09;
        %hm=20*1e-09;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        V_total=pi*a*a*hm;
            for theta=0:pi/thet_resol:pi/2;
                cc=cc+1;
                    for zD=-hm/2:dz:hm/2   
                        for xD=-a:dx:0
                            for yD=-a:dy:0
                                if ((sqrt(xD.^2+yD.^2)< a ))               
                                    Bx=@(x,y,z) (((x-xD).^2+(y-yD).^2+(z-zD).^2).^(-5/2)).*(3.*(x-xD).*((z-zD).*cos(theta)-(y-yD).*sin(theta)));
                                    By=@(x,y,z) (((x-xD).^2+(y-yD).^2+(z-zD).^2).^(-5/2)).*((3.*cos(theta).*((z-zD).*cos(theta)-(y-yD).*sin(theta)).*((z-zD).*sin(theta)+(y-yD).*cos(theta)))-((sin(theta)).*((2.*((z-zD).*cos(theta)-(y-yD).*sin(theta)).^2)-(x-xD).^2-((z-zD).*sin(theta)+(y-yD).*cos(theta)).^2)));
                                    Bz=@(x,y,z) (((x-xD).^2+(y-yD).^2+(z-zD).^2).^(-5/2)).*((3.*sin(theta).*((z-zD).*cos(theta)-(y-yD).*sin(theta)).*((z-zD).*sin(theta)+(y-yD).*cos(theta)))+((cos(theta)).*((2.*((z-zD).*cos(theta)-(y-yD).*sin(theta)).^2)-(x-xD).^2-((z-zD).*sin(theta)+(y-yD).*cos(theta)).^2)));
                                    xmin = -a;
                                    xmax = a;
                                    ymin = @(x) -sqrt(a.^2 - x.^2);
                                    ymax = @(x) sqrt(a.^2 - x.^2);
                                    zmin = l*j-hm/2;
                                    zmax = l*j+hm/2;
                                    %IntBx=IntBx + integral3(Bx,xmin,xmax,ymin,ymax,zmin,zmax);
                                    IntBy=IntBy + integral3(By,xmin,xmax,ymin,ymax,zmin,zmax);
                                    IntBz=IntBz + integral3(Bz,xmin,xmax,ymin,ymax,zmin,zmax);
                                end
                            end 
                        end
                    end


                M=[0,Ms.*sin(theta),Ms.*cos(theta)];
                IntBx=IntBx.*(u0.*Ms.*V_diple/4/pi)/V_total;
                IntBy=IntBy.*(u0.*Ms.*V_diple/4/pi)/V_total;
                IntBz=IntBz.*(u0.*Ms.*V_diple/4/pi)/V_total;
                B=[IntBx;IntBy;IntBz];
                U=-(M*B)/2;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                U_tot(cc,1)=4.*U; U_tot(cc,2)=theta;
                
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                IntBx=0;
                IntBy=0;
                IntBz=0;
            end
    toc   
    %%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%
end
%end
%fclose(fid);
end
