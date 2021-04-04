close all
clear all

pkg load symbolic
format short g
R1=1.02738610688*1000
R2=(2.03394761163*1000)
R3 =(3.13880655715*1000)
R4 = (4.00338881943*1000)
R5 =(3.07163426496*1000)
R6 = (2.05278260557*1000)
R7 = (1.01283324471*1000)
Vs = (5.18937402699)
Id = (1.00970251859/1000)
C  = (1.00970251859*10^-6) %uF
Kb=(7.32338601881/1000) %mS
Kd=(8.32372114868*1000) %KOhm
O = (0.0)
Z=(1.0)

G1 = Z/R1
G2 = Z/R2
G3 = Z/R3
G4 = Z/R4
G5 = Z/R5
G6 = Z/R6
G7 = Z/R7

A=[Z,O,O,O,O,O,O,O;
-G1,G1+G2+G3,-G2,O,-G3,O,O,O;
O,-G2-Kb,G2,O,Kb,O,O,O;
O,O,O,Z,O,O,O,O;
O,O,O,O,Z,O,Kd*G6,-Z;
O,-G3,O,O,G3+G4+G5,-G5,-G7,G7;
O,Kb,O,O,-Kb-G5,G5,O,O;
O,O,O,O,O,O,G6+G7, -G7];
B=[Vs;O;O;O;O;O;O;O];
V=A\B

Id=-double(V(7))*G6
Vb= double(V(2)) - double(V(5))
Vd= Kd*Id
Vx= V(6) - V(8)

filename = 'tabelaNodes1.tex'
fid=fopen(filename,'w')

fprintf(fid,'V1 & %f\\\\ \\hline \n',double(V(1)));
fprintf(fid,'V2 & %f\\\\ \\hline \n',double(V(2)));
fprintf(fid,'V3 & %f\\\\ \\hline \n',double(V(3)));
fprintf(fid,'V4 & %f\\\\ \\hline \n',double(V(4)));
fprintf(fid,'V5 & %f\\\\ \\hline \n',double(V(5)));
fprintf(fid,'V6 & %f\\\\ \\hline \n',double(V(6)));
fprintf(fid,'V7 & %f\\\\ \\hline \n',double(V(7)));
fprintf(fid,'V8 & %f\\\\ \\hline \n',double(V(8)));
fprintf(fid,'Vb & %f\\\\ \\hline \n',Vb);
fprintf(fid,'Vd & %f\\\\ \\hline \n',double(Vd));


V6init = double(V(6))
fclose(fid)

I1=(double(V(2))-double(V(1)))*G1
I2=(double(V(2))-double(V(3)))*G2
I3=(double(V(2))-double(V(5)))*G3
I4=double(V(5))*G4
I5=(double(V(5))-double(V(6)))*G5
I6=Id
I7=I6
Ib=(double(V(2))-double(V(5)))*Kb


filename = 'tabelaIbranches1.tex'
fid=fopen(filename,'w')

fprintf(fid,'I(R1) & %e\\\\ \\hline \n',double(I1));
fprintf(fid,'I(R2) & %e\\\\ \\hline \n',double(I2));
fprintf(fid,'I(R3) & %e\\\\ \\hline \n',double(I3));
fprintf(fid,'I(R4) & %e\\\\ \\hline \n',double(I4));
fprintf(fid,'I(R5) & %e\\\\ \\hline \n',double(I5));
fprintf(fid,'I(R6) & %e\\\\ \\hline \n',double(I6));
fprintf(fid,'I(R7) & %e\\\\ \\hline \n',double(I7));
fprintf(fid,'Ib & %e\\\\ \\hline \n',double(Ib));


fclose(fid)

A=[Z,O,O,O,O,O,O,O; O,G1+G2+G3,-G2,O,-G3,O,O,O; O,-G2-Kb,G2,O,Kb,O,O,O; O,O,O,Z,O,O,O,O; O,O,O,O,Z,O,Kd*G6,-Z; O,O,O,O,O,Z,O,-Z; O,Kb-G3,O,O,G3+G4-Kb,O,-G7,G7; O,O,O,O,O,O,G6+G7, -G7];
B=[O;O;O;O;O;Vx;O;O];
V=A\B

Id=-double(V(7))*G6
Vb= double(V(2)) - double(V(5))
Vd= Kd*Id

filename = 'tabelaNodes2.tex'
fid=fopen(filename,'w')

fprintf(fid,'V1 & %f\\\\ \\hline \n',double(V(1)));
fprintf(fid,'V2 & %f\\\\ \\hline \n',double(V(2)));
fprintf(fid,'V3 & %f\\\\ \\hline \n',double(V(3)));
fprintf(fid,'V4 & %f\\\\ \\hline \n',double(V(4)));
fprintf(fid,'V5 & %f\\\\ \\hline \n',double(V(5)));
fprintf(fid,'V6 & %f\\\\ \\hline \n',double(V(6)));
fprintf(fid,'V7 & %f\\\\ \\hline \n',double(V(7)));
fprintf(fid,'V8 & %f\\\\ \\hline \n',double(V(8)));
fprintf(fid,'Vb & %f\\\\ \\hline \n',Vb);
fprintf(fid,'Vd & %f\\\\ \\hline \n',double(Vd));



fclose(fid)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%alinea 3
Ix = (double(V(6)) - double(V(5)))/ double(R5)+ double(Kb)*(double(V(2)) - double(V(5)))
Req= double(Vx/Ix)
C=double(C)
V6=double(V(6))
%time vector
t = 0.: 1.e-6: 20.e-3;
a=Req*C
%natural solution
v6n =( exp(-t./(Req*C)))*V6 ;

hf=figure()

plot(t,v6n);

grid on

axis([0, 20e-3, 0, 9]);
xlabel("t[s]");
ylabel("v6n[V]");
%print(hf, "t2-3.pdf");
print (hf,"t2-3.eps", "-depsc");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%alinea4


%capacitor impedance
f=1e3 %Hz
w=2*pi*f
Zc=1/(j*w*C)

%running nodal analysis to discover the phasor voltages in all nodes

% V1  V2  V3  V5  V6  V7  V8
A=[Z,O,O,O,O,O,O;
-G1, G1+G2+G3,-G2,-G3,O,O,O;
O,-G2-Kb,G2,Kb,O,O,O;
O,O,O,Z,O,Kd*G6,-Z;
O,-G3,O,G3+G4+G5,-(G5+j*w*C),-G7,j*w*C+G7;
O,Kb,O,-(Kb+G5),G5+j*w*C,O,-j*w*C;
O,O,O,O,O,G6+G7,-G7];

B=[Z;O;O;O;O;O;O];
V=A\B

%printing out table w/ the complex amplitudes in the nodes
filename = 'amplitudes.tex'
fid=fopen(filename,'w')

fprintf(fid,'V1 & %f\\\\ \\hline \n',abs(double(V(1))));
fprintf(fid,'V2 & %f\\\\ \\hline \n',abs(double(V(2))));
fprintf(fid,'V3 & %f\\\\ \\hline \n',abs(double(V(3))));
fprintf(fid,'V5 & %f\\\\ \\hline \n',abs(double(V(4))));
fprintf(fid,'V6 & %f\\\\ \\hline \n',abs(double(V(5))));
fprintf(fid,'V7 & %f\\\\ \\hline \n',abs(double(V(6))));
fprintf(fid,'V8 & %f\\\\ \\hline \n',abs(double(V(7))));

fclose(fid)

%printing out table w/ the phase in each node
%(fase relativa a V1)
%acho que nao e preciso mas so para ver
filename = 'phases.tex'
fid=fopen(filename,'w')

fprintf(fid,'V1 & %f\\\\ \\hline \n',arg(double(V(1))));
fprintf(fid,'V2 & %f\\\\ \\hline \n',arg(double(V(2))));
fprintf(fid,'V3 & %f\\\\ \\hline \n',arg(double(V(3))));
fprintf(fid,'V5 & %f\\\\ \\hline \n',arg(double(V(4))));
fprintf(fid,'V6 & %f\\\\ \\hline \n',arg(double(V(5))));
fprintf(fid,'V7 & %f\\\\ \\hline \n',arg(double(V(6))));
fprintf(fid,'V8 & %f\\\\ \\hline \n',arg(double(V(7))));

Amp = abs(double(V(5)))
fase = arg(double(V(5)))
fclose(fid)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%alinea 5


%%%VS
t = -5.e-3: 1.e-6: 0;
vs = double(Vs)+0.*t;
hf2=figure();
plot(t,vs,"color","b");
hold on;

v6 = V6init +0*t;
plot(t,v6,"color","r");

hold on

t = 0.: 1.e-6: 20e-3;
vs = sin(w*t);
plot(t,vs,"color","b");


%%%V6


hold on
legend("Vs(t)","V6(t)")
%v6f = imag(double(V(5))*exp(j*w*t));
v6f = Amp*sin(w*t+fase);
v6 = v6n+v6f;
plot(t,v6,"color","r");
grid on

axis([-5e-3, 20e-3, -1.5, 10]);
xlabel("t[s]");
ylabel("v6n[V]");
%print(hf, "t2-3.pdf");
print (hf2,"t2-5.eps", "-depsc");


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%alinea6
clear f
f=logspace(-2,6,100)
for i = 1 : 100
  w = 2*pi*f(i)
  A=[Z,O,O,O,O,O,O;
-G1, G1+G2+G3,-G2,-G3,O,O,O;
O,-G2-Kb,G2,Kb,O,O,O;
O,O,O,Z,O,Kd*G6,-Z;
O,-G3,O,G3+G4+G5,-(G5+j*w*C),-G7,j*w*C+G7;
O,Kb,O,-(Kb+G5),G5+j*w*C,O,-j*w*C;
O,O,O,O,O,G6+G7,-G7];


B=[Z;O;O;O;O;O;O];
V=A\B;

magn6(i) = abs(double(V(5)));
phase6(i) = arg(V(5));

Vc = V(5) - V(7);
magnc(i)= abs(Vc);
phasec(i)=arg(Vc);

endfor

hf3=figure()
plot(log10(f),20*log10(magn6),"color","r");
hold on;
plot(log10(f),20*log10(magnc),"color","b");
hold on;
plot(log10(f),20*log10(1)+0*f,"color","g");

grid on;
legend("V6(t)","Vc(t)","Vs(t)");
%axis([-5e-3, 20e-3, -1.5, 10]);
xlabel("log(f)");
ylabel("magnitude dB");
%print(hf, "t2-3.pdf");
print (hf3,"t2-6.eps", "-depsc");

%EM FALTA : FAZER PLOT DAS FASES MAS TOU A ESPERA QUE O STOR ME RESPONDA
%EM GRUAS!
