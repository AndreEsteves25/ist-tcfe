%chosen components
R1=1*10^3
R2=1*10^3
R3=200*10^3
R4=1*10^3

C1=220*10^(-9)
C2=220*10^(-9)/2

%computing COST
costR=(R1+R2+R3+R4)/1000
costC=(C1+C2)*10^(6)

costR741=(1e3+50e3+1e3+5e3+50e3+50+50+25+7.5e3+4.5e5+39e3)/1000
costC741=(30*10^(-12))*10^(6)
cost741=costR741+costC741+22*0.1+1*0.1

COST=costR+costC+cost741

%computing input and output impedances
f=1000
w=2*pi*f
ZC1=1./(j*w*C1);
ZC2=1./(j*w*C2);
Zin=ZC1+R1;
Zout=1/(1/R2+1/ZC2);

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




%computing maximum gain
max=max(TdB)

%computing cut off frequencies (finding out the frequency 3dB bellow the max gain)
flag1=0; 
flag2=0;
for i=1:length(f)
  if(flag1==0 && TdB(i)>=(max-3))
  lowf=f(i-1)
  lowF=power(10,lowf)
  wL=2*pi*power(10,lowf)
  flag1=1;
endif
  if((flag1==1) && (flag2==0) && (TdB(i)<(max-3)))
   highf=f(i-1)
   highF=power(10,highf)
   wH=2*pi*power(10,highf)
   flag2=1;
 endif 
endfor

%central frequency + deviation
fc=sqrt(lowF*highF)
wc=sqrt(wL*wH)
fdev=abs(1000-fc)

%gain + deviation
%40dB <=> 100 amplification
a=log10(fc)
b=int32(10*log10(fc)-10) %finding out iteration corresponding to the central frequency
gain = T(b)
gaindB=TdB(b)%so para ver
gaindev=abs(100-gain)

MERIT=1/(COST*gaindev*fdev+10^(-6))

figure;
plot(f,TdB);
hold on;
plot(f,40.+0*f);
hold on;
line ([lowf lowf], [-60 60], "linestyle", "--", "color", "g");
hold on;
line ([highf highf], [-60 60], "linestyle", "--", "color", "k");
legend("gain dB","40 db","f_L","f_H");
xlabel ("log10(f) [Hz]");
ylabel ("gain [dB]");
print ("T.eps", "-depsc");

tab=fopen("impedances.tex", "w");
fprintf(tab, "Input Impedance & %f Ohm \\\\ \\hline \n", Zin);
fprintf(tab, "Output Impedance & %f Ohm \\\\ \\hline \n", Zout);
fclose(tab);

tab=fopen("final.tex", "w");
fprintf(tab, "Gain DB & %f dB \\\\ \\hline \n", gaindB);
fprintf(tab, "Gain & %f \\\\ \\hline \n", gain);
fprintf(tab, "Bandwidth & %f Hz \\\\ \\hline \n", highF-lowF);
fprintf(tab, "Central Frequency & %f Hz \\\\ \\hline \n", fc);
fprintf(tab, "Frequency Deviation & %f Hz \\\\ \\hline \n", fdev);
fprintf(tab, "Gain Deviation & %f Hz\\\\ \\hline \n", gaindev);
fprintf(tab, "Cost & %f MU\\\\ \\hline \n", COST);
fprintf(tab, "Merit & %f\\\\ \\hline \n", MERIT);
fclose(tab);	