close all
clear all

pkg load symbolic;
format long;

%given data
f=50; %Hz
w=2*pi*f;
Vp = 230; %Hz

%chosen variables
Vs=13.25625; %V
Ca1=10e-6;   %F
Rb1=10e3;    %Ohm
nb_diodes = 23;

T=1/2/f; %meio periodo

t=linspace(0,T,100);
VS = Vs*cos(w*t);
Vbridge = abs(VS);

%calular dentinhos

Vripple=Vs*(1-exp(-T/Rb1/Ca1))
%vO = zeros(1, length(t));


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

vD = 12 /nb_diodes;

eta=1;
VT=0.025;
Is=1e-14;
rd= eta*VT/(Is* exp( vD/(eta*VT)) )
Req=nb_diodes*rd/(nb_diodes*rd+Rb1)
new_ripple=nb_diodes*rd/(nb_diodes*rd+Rb1)*Vripple

t=linspace(0,T,100);
vF = -new_ripple/T*t;

ripplef = zeros (1,2000);
VF = zeros (1,2000);
for i=1:20
  for j=1:100
    ripplef((i-1)*100+j)=vF(j);
    VF((i-1)*100+j)=vF(j)+12;
    endfor
endfor


figure
hold
t=linspace(3,3.2,2000);
plot(t,ripplef)
title=("Ripple final")
print ("final.eps", "-depsc");
