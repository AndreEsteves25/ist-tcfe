close all
clear all

pkg load symbolic
pkg load miscellaneous
syms I1
syms I2
syms I3
syms I4
R1=vpa(1.02738610688)
R2=vpa(2.03394761163)
R3 = vpa(3.13880655715)
R4 = vpa(4.00338881943)
R5 = vpa(3.0716342649600000000000000000000)
R6 = vpa(2.05278260557)
R7 = vpa(1.01283324471)
Va = vpa(5.18937402699)
Id = vpa(1.00970251859)
Kb=vpa(7.32338601881)
Kc=vpa(8.32372114868)
Z = vpa(0.0)
O=vpa(1.0)

A=[R1+R3+R4 , R3 , Z , R4 ; R4 , Z, Z , R6+R7-Kc+R4 ; Z ,Z , O, Z ; Kb*R3, Kb*R3-O,Z,Z]
B=[Va;Z;Id;Z]
V=A\B
filename = 'tabela1.txt'
fid=fopen(filename,'w')
fprintf(fid,'I1 & %f ',double(V(1)));
fprintf(fid,'\n\n \')
fprintf(fid,'I2 & %f ',double(V(2)));
fprintf(fid,'\n\n \')
fprintf(fid,'hline\n')
fprintf(fid,'I3 & %f ',double(V(3)));
fprintf(fid,'\n\n \')
fprintf(fid,'hline\n')
fprintf(fid,'I4 & %f ',double(V(4)));
fprintf(fid,'\n\n \')
fprintf(fid,'hline\n')
fclose(fid)