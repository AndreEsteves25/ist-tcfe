%chosen components
R1=1*10^3
R2=1*10^3
R3= 100*10^3 + (100*10^3*100*10^3)/(200*10^3)
R4=(1*10^3*30*10^3)/(31*10^3)

C1=220*10^(-9)
C2=220*10^(-9)/2

%computing COST
costR=333             %all resistors
costC=220*3*10^(-3)   %3 capacitors

%costR741=(1e3+50e3+1e3+5e3+50e3+50+50+25+7.5e3+4.5e5+39e3)/1000
%costC741=(30*10^(-12))*10^(6)
cost741=13223.09204

COST= costR+costC+cost741

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
Tphase=arg(ZC2./(ZC2+R2).*fator12);
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

MERIT=1/(COST*(gaindev+fdev+10^(-6)))

figure;
plot(f,TdB);
hold on;
plot(f,40.+0*f);
hold on;
line ([lowf lowf], [-60 60], "linestyle", "--", "color", "g");
hold on;
line ([highf highf], [-60 60], "linestyle", "--", "color", "k");
hold on;
line ([log10(fc) log10(fc)], [-60 60], "linestyle", "--", "color", "m");
legend("gain dB","40 db","f_L","f_H","f_c");
xlabel ("log10(f) [Hz]");
ylabel ("gain [dB]");
print ("T.eps", "-depsc");

figure;
plot(f,Tphase*180/pi);
hold on;
plot(f,0*f);
hold on;
line ([lowf lowf], [-100 100], "linestyle", "--", "color", "g");
hold on;
line ([highf highf], [-100 100], "linestyle", "--", "color", "k");
hold on;
line ([log10(fc) log10(fc)], [-100 100], "linestyle", "--", "color", "m");
legend("phase response (degrees)","0 degrees","f_L","f_H","f_c");
xlabel("log10(f) [Hz]");
ylabel("phase response (degrees)");
print ("Tphase.eps", "-depsc");

tab=fopen("max.tex", "w");
fprintf(tab, "%f", max);
fclose(tab);

tab=fopen("frequencies.tex", "w");
fprintf(tab, "f\\textsubscript{L} & %f Hz\\\\ \\hline \n", lowF);
fprintf(tab, "f\\textsubscript{H} & %f Hz\\\\ \\hline \n", highF);
fprintf(tab, "Bandwidth & %f Hz \\\\ \\hline \n", highF-lowF);
fprintf(tab, "f\\textsubscript{c} & %f Hz\\\\ \\hline \n", fc);
fprintf(tab, "Frequency Deviation & %.14f Hz \\\\ \\hline \n", fdev);
fclose(tab);

tab=fopen("gain.tex", "w");
fprintf(tab, "Gain dB & %f dB\\\\ \\hline \n", gaindB);
fprintf(tab, "Gain & %f \\\\ \\hline \n", gain);
fprintf(tab, "Gain Deviation & %f \\\\ \\hline \n", gaindev); %linear units
fclose(tab);


%computing input and output impedances
f=fc
w=2*pi*f
ZC1=1./(j*w*C1);
ZC2=1./(j*w*C2);
Zin=ZC1+R1
Zout=1/(1/R2+1/ZC2)

tab=fopen("final.tex", "w");
fprintf(tab, "Gain & %f dB\\\\ \\hline \n", gaindB);
fprintf(tab, "f\\textsubscript{L} & %f Hz\\\\ \\hline \n", lowF);
fprintf(tab, "f\\textsubscript{H} & %f Hz\\\\ \\hline \n", highF);
fprintf(tab, "f\\textsubscript{c} & %f Hz\\\\ \\hline \n", fc);

%fprintf(tab, "Bandwidth & %f Hz \\\\ \\hline \n", highF-lowF);
%fprintf(tab, "Central Frequency & %f Hz \\\\ \\hline \n", fc);
%fprintf(tab, "Frequency Deviation & %f Hz \\\\ \\hline \n", fdev);
%fprintf(tab, "Gain Deviation & %f Hz\\\\ \\hline \n", gaindev);
%fprintf(tab, "Cost & %f MU\\\\ \\hline \n", COST);
fprintf(tab, "Merit & %f\\\\ \\hline \n", MERIT);
fprintf(tab, "Input Impedance & %f + %f i\\\\ \\hline \n", real(Zin),imag(Zin));
fprintf(tab, "Output Impedance & %f+ %f i\\\\ \\hline \n", real(Zout),imag(Zout));

fclose(tab);

tab=fopen("cost.tex", "w");
fprintf(tab, "Cost & %f MU\\\\ \\hline \n", COST);
fclose(tab);

tab=fopen("impedances.tex", "w");
fprintf(tab, "Input Impedance & %f + %f i\\\\ \\hline \n", real(Zin),imag(Zin));
fprintf(tab, "Output Impedance & %f+ %f i\\\\ \\hline \n", real(Zout),imag(Zout));
fclose(tab);

%componentes tabel
tab=fopen("components.tex", "w");
fprintf(tab, "\\bf Component  & \\bf Value\\\\ \\hline \n");
fprintf(tab, "R1  & %f k$\\Omega$ \\\\ \\hline \n",R1/1000);
fprintf(tab, "R2  & %f k$\\Omega$ \\\\ \\hline \n",R2/1000);
fprintf(tab, "R3  & %f k$\\Omega$ \\\\ \\hline \n",R3/1000);
fprintf(tab, "R4  & %f k$\\Omega$ \\\\ \\hline \n",R4/1000);
fprintf(tab, "C1  & %f nF \\\\ \\hline \n",C1*10^(9));
fprintf(tab, "C2  & %f nF \\\\ \\hline \n",C2*10^(9));
fclose(tab);

%k=1+R3/R4

%wl=1/(R1*C1)
%wF=1/(R2*C2)