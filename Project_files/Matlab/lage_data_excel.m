clc; close all;

tid2 = struct(ball_5Deg.signals);
tid3 = tid2(1);
tid4 = tid3.values;

posisjon = tid2(3).values;
posisjon2 = posisjon(1:152);



% Data fra måling
%fileName='time.xlsx'
%writematrix(tid4,fileName)
%fileName1='posisjon.xlsx'
%writematrix(posisjon2,fileName1)
ff = readtable("time.xlsx");
entabell = struct2table(tid3,"AsArray",true);
%entabell1 = struct2table(posisjon2,"AsArray",true)
pp = readtable("posisjon.xlsx");

posisjon10 = posisjon1(1,:);
rr = rows2vars(posisjon10);
rr2 = rr.Var1'
plot(tid4,rr2);
