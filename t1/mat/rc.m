close all
clear all

pkg load symbolic

syms I1
syms I2
syms I3
syms I4
R1=vpa(1.02738610688*1000)
R2=vpa(2.03394761163*1000)
R3 = vpa(3.13880655715*1000)
R4 = vpa(4.00338881943*1000)
R5 = vpa(3.07163426496*1000)
R6 = vpa(2.05278260557*1000)
R7 = vpa(1.01283324471*1000)
Va = vpa(5.18937402699)
Id = vpa(1.00970251859/1000)
Kb=vpa(7.32338601881/1000) %mS
Kc=vpa(8.32372114868*1000) %KOhm
Z = vpa(0.0)
O=vpa(1.0)

A=[R1+R3+R4 , R3 , Z , R4 ; R4 , Z, Z , R6+R7-Kc+R4 ; Z ,Z , O, Z ; Kb*R3, Kb*R3-O,Z,Z]
B=[Va;Z;Id;Z]
V=A\B
filename = 'tabela1.tex'
fid=fopen(filename,'w')
fid2=fopen('data.tex','w')


I1 = double(V(1)) *1000
I2 = double(V(2))*1000
I3 = double(V(3))*1000
I4 = double(V(4))*1000


fprintf(fid,'I1 & %f\\\\ \\hline \n',I1);
fprintf(fid,'I2 & %f\\\\ \\hline \n',I2);
fprintf(fid,'I3 & %f\\\\ \\hline \n',I3);
fprintf(fid,'I4 & %f\\\\ \\hline \n',I4);

IVa = I1
IR1 = I1
IR2 = I2
IR3 = I1+I2
IR4 = I1+I4
IR5 = I3-I2
IR6 = I4
IR7 = I4
IVc = I4-I3 
IId = I3
IIb = I2

fprintf(fid2,'Va & %f\\\\ \\hline \n',IVa);
fprintf(fid2,'R1 & %f\\\\ \\hline \n',IR1);
fprintf(fid2,'R2 & %f\\\\ \\hline \n',IR2);
fprintf(fid2,'R3 & %f\\\\ \\hline \n',IR3);
fprintf(fid2,'R4 & %f\\\\ \\hline \n',IR4);
fprintf(fid2,'R5 & %f\\\\ \\hline \n',IR5);
fprintf(fid2,'R6 & %f\\\\ \\hline \n',IR6);
fprintf(fid2,'R7 & %f\\\\ \\hline \n',IR7);
fprintf(fid2,'Vc & %f\\\\ \\hline \n',IVc);
fprintf(fid2,'Id & %f\\\\ \\hline \n',IId);
fprintf(fid2,'Ib & %f\\\\ \\hline \n',IIb);

fclose(fid)
fclose(fid2)

