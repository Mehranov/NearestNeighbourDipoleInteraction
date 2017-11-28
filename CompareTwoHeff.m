l=input('hm+hn=?');
Ms=input('magnetization=?');
P=.1073;
k_old=1:10;
heff_old=1:10;
for i=1:1:10;
    hn=l/i;
    hm=l-hn;
    k_old(i)=AniCons(Ms,hm,hn,P);
    heff_old(i)=2*k_old(i)/(4*pi*1e-07*Ms*1000);
end

    
    