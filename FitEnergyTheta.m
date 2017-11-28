function [K]=FitEnergyTheta(U)
% by having the magnetic density energy vs theta we can fit this set of
% data to the formula U=K.*sin(theta).^2+C and then find the K constant


U_size=size(U);
K=zeros(1,U_size(2)-1);
t1=99;t2=99;
F = @(x,t)x(1)*sin(t).^2+x(2);
x(1)=-1;x(2)=-1;

for i=1:1:U_size(2)-1;
    %if (i~=1) && (i~=11) && (i~=21) && (i~=31) && (i~=41) && (i~=51) && (i~=61) && (i~=71) && (i~=81) && (i~=91)
        while (abs(t1-x(1))>.01 && abs(t2-x(2))>0.01)
            x0= [t1 t2];
            t1=x(1);
            t2=x(2);
            [x,~,~,~,~] = lsqcurvefit(F,x0,U(:,U_size(2)),U(:,i));
        end
      K(i)=x(1);
      t1=99;t2=99;x(1)=-1;x(2)=-1;
    end
end





    
    








% clear x
% global x U
% t1=99;
% t2=99;
% i=0;
% U = @(x,t)x(1)*sin(t).^2+x(2);
% x(1)=-1;x(2)=-1;
% 
% while (abs(t1-x(1))>.01 || abs(t2-x(2))>0.01)
% 
% i=i+1;
% x0 = [t1 t2];
% t1=x(1);
% t2=x(2);
% [x,resnorm,~,exitflag,output] = lsqcurvefit(U,x0,Theta,Energy);
% 
% end
% end



