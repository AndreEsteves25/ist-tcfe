%chosen components
R1=1000
R2=1/(1/(1000)+1/(20000))
R3=2*100*10^3+10000
R4=1000

C1=220*10^(-9)
C2=220*10^(-9)


%computing capacitor's impedances
f=1:0.1:8;;
w=2*pi*power(10,f);
%s=j*w;

ZC1=1./(j*w*C1);
ZC2=1./(j*w*C2);

%computing transfer function
fator1=R1./(R1+ZC1);
fator12=(1+R3/R4).*fator1;
T=abs(ZC2./(ZC2+R2).*fator12);
%converting gain (directly from transfer function to dB)
TdB=20*log10(T);

figure;
plot(f,TdB);
hold on;
plot(f,40.+0*f)
legend("gain dB","40 db");
xlabel ("log10(f) [Hz]");
ylabel ("gain [dB]");
print ("T.eps", "-depsc");


%computing maximum gain
A=max(TdB)

%computing cut off frequencies
