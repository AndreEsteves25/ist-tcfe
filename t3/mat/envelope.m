close all
clear all

pkg load symbolic;
format long;

%given data
f=50; %Hz
w=2*pi*f;
Vp = 230; %Hz

%chosen variables
Vs=13.11611; %V
Ca1=1e-6;   %F
Rb1=1e3;    %Ohm
nb_diodes = 25;


T=1/2/f; %meio periodo

t=linspace(0,T,100);
VS = Vs*cos(w*t);
Vbridge = abs(VS);

%calular dentinhos
vD = 12 /nb_diodes;
eta=1;
VT=0.025;
Is=1e-14;
rd= eta*VT/(Is* exp( vD/(eta*VT)) )
Req=nb_diodes*rd + Rb1
Req*Ca1
Vripple=Vs*(1-exp(-T/Req/Ca1))




m = Vripple/T;
figure
plot(t,Vbridge);
hold;
vO=-m*t+Vs;
plot(t,vO);
title("Envelope Detector");

vENV = zeros(1,2000);
bridge = zeros (1,2000);
for i=1:20
  for j=1:100
    vENV((i-1)*100+j)=vO(j);
    bridge((i-1)*100+j)=Vbridge(j);
    endfor
endfor

xlabel("t[s]");
%legend("bridge","envelope")
print ("envelope.eps", "-depsc");

figure
t=linspace(3,3.2,2000);
plot(t,bridge)
hold
plot(t,vENV)
print ("envelope2.eps", "-depsc");


new_ripple=nb_diodes*rd/(nb_diodes*rd+Rb1)*Vripple

t=linspace(0,T,100);
vF = -new_ripple/T*t;



ripplef = zeros (1,2000);
VF = zeros (1,2000);
for i=1:20
  for j=1:100
    ripplef((i-1)*100+j)=vF(j)+new_ripple/2;
    VF((i-1)*100+j)=vF(j)+12+new_ripple/2;
    endfor
endfor


figure;
hold;
t=linspace(3,3.2,2000);
plot(t,ripplef)
title=("Ripple final")
print ("final.eps", "-depsc");

cost=Ca1*10^6+Rb1/1000+(nb_diodes+4)*0.1
merit=1/(cost* (new_ripple+10^(-6) )) %it was assumed that the voltage oscillates around 12V


filename = 'tabela2.tex';
fid=fopen(filename,'w');
fprintf(fid,'cost & %f\\\\ \\hline \n',cost);
fprintf(fid,'cost & 12\\\\ \\hline \n');
fprintf(fid,'deviation & 0\\\\ \\hline \n');
fprintf(fid,'merit & %f\\\\ \\hline \n',merit);
fprintf(fid,'ripple & %f\\\\ \\hline \n',ripplef);
fclose(fid)
