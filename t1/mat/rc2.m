close all
clear all

pkg load symbolic
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
O = vpa(0.0)
Z=vpa(1.0)
A=[Z,O,O,O,O,O,O; Z/R1,-Z/R1-Z/R2-Z/R3,Z/R2,Z/R3,O,O,O; O,Kb,-Z/R2,Z/R2-Kb,O,O,O; O,O,O,Z,O,-Kc/R6,-Z; O,-Kb,O,Z/R5+Kb,-Z/R5,O,O; O,O,O,O,O,Z/R6-Z/R7,Z; O,Z/R3,O,-Z/R3-Z/R4-Z/R5,Z/R5,Z/R7,-Z/R7]
B=[Va;O;O;O;-Id;O;Id]
V=A\B

