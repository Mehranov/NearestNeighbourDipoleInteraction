syms w real;
a=sym('a','real');
x=sym('x','real');
y=sym('y','real');
z=sym('z','real');
u0=sym('u0','real');
%u0=4*pi*10^(-7);
m=sym('m','real');
t0=sym('t0','real');
hm=sym('hm','real');
hn=sym('hn','real');
%----------------------------------------------------------------------------------
%In the foloowing two lines I tried to resolve the problem of having two
%answers when we integrate. It does not work and need to be modified more
%but the key point I believe is the command "assume and assumeAlso"
%assumeAlso(a>0);
%assume((-x^2-z^2)^(1/2)>(a^2-w^2)^(1/2)| (-x^2-z^2)^(1/2)<-((a^2-w^2)^(1/2)));
%-----------------------------------------------------------------------------------
% t0 is the angle which the magnetization dipole makes with the z axis
% which is the same as the wire axis 
z1=hm+hn;
A=u0*m/(4*pi*(x^2+y^2+z^2)^(5/2));
C1=z*cos(t0)-y*sin(t0);
C2=z*sin(t0)+y*cos(t0);
Bx=A*(3*x*C1);
By=A*(3*cos(t0)*C1*C2-sin(t0)*((2*(C1)^2)-x^2-C2^2));
Bz=A*(3*sin(t0)*C1*C2+cos(t0)*((2*(C1)^2)-x^2-C2^2));

%%

%In the rest of the code, instead of integrating Bx, By, Bz in three
%dimensions at the same time, we first integrate form y, then pick the
%correct answer (since matlab gives couple of answers with different
%conditions which only one of them is our interested answer) and integrate
%from x and then integrate from z. the first integral is called IntBx1, the
%second is IntBx2 and the last and final answer is IntBx3. This is the same
%for IntBy and IntBz. 

IntByt=int(By,y,-sqrt(a^2-w^2),sqrt(a^2-w^2));
% here we will get two answers and we pick the second one as it is true in
% our case and attribute it to IntBy1 by hand
%%
IntBy1=(m*u0*sin(t0)*((a^2-x^2)^(1/2)))/(2*pi*(a^2+z^2)^(3/2));
%this expression defined for IntBy1 is the second answer of previous step
%which we put it by hand into IntBy1 and we changed w to x (we inegrtaed
%using w instead of x to avoid conflict and make sure everything is good
%and then replace w with x)
IntBy2=int(IntBy1,x,-a,a,'IgnoreAnalyticConstraints',true,'IgnoreSpecialCases',true);
IntBy3=int(IntBy2,z,z1-hm/2,z1+hm/2,'IgnoreAnalyticConstraints',true,'IgnoreSpecialCases',true);
%IntBy3 is our final answer for Y coordinate
%%

%Now we repeat the procedure for Bx
IntBx=int(Bx,y,-sqrt(a^2-w^2),sqrt(a^2-w^2));
IntBx1=(3*m*u0*x*((2*z*(2*cos(t0)*(a^2 - w^2)^(1/2)*(a^2 - w^2 + x^2) + x^2*cos(t0)*(a^2 - w^2)^(1/2)))/(3*(x^2 + z^2)^2*(a^2 - w^2 + x^2 + z^2)^(3/2)) + (2*z^3*cos(t0)*(a^2 - w^2)^(1/2))/((x^2 + z^2)^2*(a^2 - w^2 + x^2 + z^2)^(3/2))))/(4*pi);
IntBx1=subs(IntBx1,{w},{x});
IntBx2=int(IntBx1,x,-a,a,'IgnoreAnalyticConstraints',true,'IgnoreSpecialCases',true);
% Here we got 0 for IntBx2 as we expected because Bx is symmetric with
% respect to y axis, so whatever is in the area of x>0 would be cancelled
% by the x<0 area.
IntBx3=0;
%%
% for Bz, it turns out that we get the correct answer if we first take the
% integral over x and then over y and z. So we integrate over x (using w
% instead of y) and then replace w with y
IntBz=int(Bz,x,-sqrt(a^2-w^2),sqrt(a^2-w^2),'IgnoreAnalyticConstraints',true,'IgnoreSpecialCases',true);
IntBz1=-(m*u0*(y*z^3*sin(t0)*(a^2 - w^2)^(1/2) - z^4*cos(t0)*(a^2 - w^2)^(1/2) + y^3*z*sin(t0)*(a^2 - w^2)^(1/2) - y^2*z^2*cos(t0)*(a^2 - w^2)^(1/2) + y^2*cos(t0)*(a^2 - w^2)^(1/2)*(a^2 - w^2 + y^2 + z^2) - z^2*cos(t0)*(a^2 - w^2)^(1/2)*(a^2 - w^2 + y^2 + z^2) + 2*y*z*sin(t0)*(a^2 - w^2)^(1/2)*(a^2 - w^2 + y^2 + z^2)))/(2*pi*(y^2 + z^2)^2*(a^2 - w^2 + y^2 + z^2)^(3/2));
IntBz1=subs(IntBz1,{w},{y});
IntBz2=int(IntBz1,y,-a,a,'IgnoreAnalyticConstraints',true,'IgnoreSpecialCases',true);
IntBz3=int(IntBz2,z,z1-hm/2,z1+hm/2,'IgnoreAnalyticConstraints',true,'IgnoreSpecialCases',true);

