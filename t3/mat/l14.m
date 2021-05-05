close all 
clear all
f=1e3;
w=2*pi*f;
R=1e3
C=1e-6


t=linspace(0, 5e-3, 1000);
A = 5;
vS=A*cos(w*t);
vO = abs(vS);

figure
plot(t*1000, vO)
title("Output voltage v_o(t)")
xlabel ("t[ms]")
ylabel ("v_o[V]")
print ("vo.eps", "-depsc");


%lpf response
t=linspace(0, 50e-3, 1000);

VON=0.7
vlim =3*VON

f=400;
w=2*pi*f;
vO = A/sqrt(1+w^2*R^2*C^2) * cos(w*t - atan(w*R*C));
figure;
plot(t*1000, vO)
title("Output voltage v_o(t)")
xlabel ("t[ms]")
ylabel ("v_{lpf}[V]")

f=100
w=2*pi*f;
vO = A/sqrt(1+w^2*R^2*C^2) * cos(w*t - atan(w*R*C));

%limit
for i=1:length(t)
  if vO(i) > vlim
    vO(i) = vlim;
  elseif vO(i) < -vlim
    vO(i) = -vlim;
  endif
endfor

hold on;
plot(t*1000, vO, "r")
legend("f=200Hz","f=100Hz")
print ("vlpf.eps", "-depsc");

%envelope detector
A=5
t=linspace(0, 1e-3, 100);
f=1000;
w=2*pi*f;
vS = A * cos(w*t);
vOhr = zeros(1, length(t));
vO = zeros(1, length(t));

tOFF = 1/w * atan(1/w/R/C);

vOnexp = A*cos(w*tOFF)*exp(-(t-tOFF)/R/C);

figure
for i=1:length(t)
  if (vS(i) > 0)
    vOhr(i) = vS(i);
  else
    vOhr(i) = 0;
  endif
endfor

plot(t*1000, vOhr)
hold

for i=1:length(t)
  if t(i) < tOFF
    vO(i) = vS(i);
  elseif vOnexp(i) > vOhr(i)
    vO(i) = vOnexp(i);
  else 
    vO(i) = vS(i);
  endif
endfor

plot(t*1000, vO)
title("Output voltage v_o(t)")
xlabel ("t[ms]")
legend("rectified","envelope")
print ("venvlope.eps", "-depsc");
