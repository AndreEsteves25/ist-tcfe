%gain stage

%valores a mudar
RE_1=80
RC1=1000
RB1=240E3
RB2=60E3
C1=0.3E-3
C2=0.6E-3
C3=1E-3
RE2=30

VT=25e-3 %termal voltage
BFN=178.7
VAFN=69.7
VBEON=0.7
VCC=12
RE1=RE_1
RS=100

%gain stage - operating point   
RB=1/(1/RB1+1/RB2)
VEQ=RB2/(RB1+RB2)*VCC
IB1=(VEQ-VBEON)/(RB+(1+BFN)*RE1)
IC1=BFN*IB1
IE1=(1+BFN)*IB1
VE1=RE1*IE1
VO1=VCC-RC1*IC1
VCE=VO1-VE1


gm1=IC1/VT
rpi1=BFN/gm1
ro1=VAFN/IC1

RSB=RB*RS/(RB+RS)

AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)
AVI_DB = 20*log10(abs(AV1))
AV1simple = RB/(RB+RS) * gm1*RC1/(1+gm1*RE1)
AVIsimple_DB = 20*log10(abs(AV1simple))

RE1=0
AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)
AVI_DB = 20*log10(abs(AV1))
AV1simple =  - RSB/RS * gm1*RC1/(1+gm1*RE1)
AVIsimple_DB = 20*log10(abs(AV1simple))

RE1=RE_1
ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)))
ZX = ro1*((RSB+rpi1)*RE1/(RSB+rpi1+RE1))/(1/(1/ro1+1/(rpi1+RSB)+1/RE1+gm1*rpi1/(rpi1+RSB)))
ZX = ro1*(   1/RE1+1/(rpi1+RSB)+1/ro1+gm1*rpi1/(rpi1+RSB)  )/(   1/RE1+1/(rpi1+RSB) ) 
ZO1 = 1/(1/ZX+1/RC1)

RE1=0
ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)))
ZO1 = 1/(1/ro1+1/RC1)


tab=fopen("gainstage.tex","w");
fprintf(tab, "Gain & %fdB \\\\ \\hline \n", AVI_DB);
fprintf(tab, "Input Impedance & %f \\\\ \\hline \n", ZI1); %must be compatible w/ RS=100 ohm Zi>>Rs=100
fprintf(tab, "Output Impedance & %f \\\\ \\hline \n", ZO1);
fclose(tab);

%ouput stage
BFP = 227.3
VAFP = 37.2
VEBON = 0.7
VI2 = VO1
IE2 = (VCC-VEBON-VI2)/RE2
IC2 = BFP/(BFP+1)*IE2
VO2 = VCC - RE2*IE2

gm2 = IC2/VT
go2 = IC2/VAFP
gpi2 = gm2/BFP
ge2 = 1/RE2

rpi2=1/gpi2
ro2=1/go2

AV2 = gm2/(gm2+gpi2+go2+ge2)
AV2_DB = 20*log10(abs(AV2))
ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2)
ZO2 = 1/(gm2+gpi2+go2+ge2)


tab=fopen("outputstage.tex","w");

fprintf(tab, "Gain & %fdB \\\\ \\hline \n", AV2_DB);
fprintf(tab, "Input Impedance & %f \\\\ \\hline \n", ZI2);%must be compatible w/gain stage Zo, Z1 output>>Zo gain
fprintf(tab, "Output Impedance & %f \\\\ \\hline \n", ZO2); %must be lower than 8ohm

fclose(tab);

%total
gB = 1/(1/gpi2+ZO1)
AV = (gB+gm2/gpi2*gB)/(gB+ge2+go2+gm2/gpi2*gB)*AV1
AV_DB = 20*log10(abs(AV))
ZI=ZI1
ZO=1/(go2+gm2/gpi2*gB+ge2+gB)

tab=fopen("total.tex","w"); %speak about overall impedances and compare w/ spice model
fprintf(tab, "Gain & %fdB \\\\ \\hline \n", AV_DB);
fprintf(tab, "Input Impedance & %f \\\\ \\hline \n", ZI);
fprintf(tab, "Output Impedance & %f \\\\ \\hline \n", ZO);
fclose(tab);

%%%%%%%frequency response

f = logspace(1,8,80);

RE1=RE_1
Load=8%ohm
vin=0.01

gain=zeros(1,80);
gainDB=zeros(1,80);
for i=1:1:80
 
w=2*pi*f(i)

ZC1=1./j/w/C1 %input capacitor
ZC2=1./j/w/C2 %RE capacitor
ZC3=1./j/w/C3 %final coupling capacitor 

ZE=1/(1/ZC2+1/RE1)
Zeqf=1/(1/RE2+1/(ZC3+Load))


Cpi1=1.61E-11;
Cmu1=4.388E-12;
Cpi2=1.4E-11;
Cmu2=1.113E-11;

ZCpi1=1/j/w/Cpi1;
ZCmu1=1/j/w/Cmu1;
ZCpi2=1/j/w/Cpi2;
ZCmu2=1/j/w/Cmu2;


A=[
RS+ZC1+RB,-RB,0,0,0,0,0,0,0,0,0;
-RB,RB+rpi1+ZE,0,0,0,-ZE,0,0,0,0,0;
0,-rpi1,rpi1+ZCpi1,-ZCpi1,0,0,0,0,0,0,0;
0,0,-ZCpi1,ZCpi1+ZCmu1,ro1,-ro1,0,0,0,0,0;
0,gm1*rpi1,-gm1*rpi1,1,-1,0,0,0,0,0,0;
0,-ZE,0,0,-ro1,ZE+ro1+RC1,-RC1,0,0,0,0;
0,0,0,0,0,-RC1,RC1+rpi2+Zeqf,-rpi2,0,0,-Zeqf;
0,0,0,0,0,0,-rpi2,rpi2+ZCpi2,-ZCpi2,0,0;
0,0,0,0,0,0,0,-ZCpi2,ZCpi2+ZCmu2,ro2,-ro2;
0,0,0,0,0,0,gm2*rpi2,-gm2*rpi2,1,-1,0;
0,0,0,0,0,0,-Zeqf,0,0,-ro2,Zeqf+ro2;
]; 

B=[vin;0;0;0;0;0;0;0;0;0;0];

I=A\B

Vout=(I(7)-I(11))*Zeqf

gain(i)=Vout*Load/(Load+ZC3)/vin;
gainDB(i)=20*log10(gain(i));
  endfor

a=figure();
F=log10(f);
plot(F,gainDB,"");
legend("Gain");
xlabel("log(f) [Hz]");
ylabel("Gain (dB)");
print(a,"frequencyresponse.eps","-depsc");
  