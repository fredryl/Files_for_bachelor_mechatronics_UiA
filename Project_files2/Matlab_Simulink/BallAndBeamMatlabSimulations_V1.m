%% Ball and beam filter and velocity controller calculations

clc; clear; close all;
s =tf('s');
%% Requirements
% Velocity loop
Tr_vel = 0.3; %[s] Rise time
OS_vel = 5;%[%] Overshoot
Ts_vel = 1.5; %[s] Settling time
e_ss_vel = 0.1; % Steady state error

%% Low pass filter at 2 times the -3db frequency for the system response


Ts = 0.002; % [s] Cycle time/discrete sample time
Sys_resp_freq = 4.4;%[rad/s] System frequency at -3db magnitude
omega_zero = 2*Sys_resp_freq; %[rad/s] low pass filter cut off frequency


LF_s = (omega_zero)/(s+omega_zero) % normal frequency
 % Convert from continous time to discrete time
LF_z_d = c2d(LF_s,Ts); 

% Get the coefficients
% den is the feed forward coefficients b0, b1, b2...
% num is the feed backward coefficients a1, a2, a3...
[num_fw_b, den_bw_a] = tfdata(LF_z_d,'v')
%% Model of ball motion



mb = 3e-3; % [kg] mass of ball
r_b = 0.02; % [m] ball radius
g = -9.81; % [m/s^2] gravity
J_b = (2/3)*mb*r_b^2; % [kgm^2] ball inertia


P_bb = -(mb*(r_b^2)*g)/((mb*(r_b^2))+J_b)/s^2%[m]%Ball transfer function

%% 2nd order transfer function from step response of drive and motor



% Values found from step response plot of beam motion
s =tf('s');
start_value = 0;
U = 1; % Step input magnitude
y_ss = 1; % steady state
y_max = 1.0114; % overshoot
Tr_90 = 81.525; %[s] time to 90% of y_ss
Tr_10 = 81.435; %[s] time to 10% of y_ss
Tp_max = 81.657; %[s] time to peak
T_step = 81.373; %[s] start step
pstOS = ((y_max-y_ss)/y_ss)*100; %[%] percent overshoot
% Calculation
zeta = (-log(pstOS/100))/(sqrt(pi^2+log(pstOS/100)^2));% Damping ratio
T_p = Tp_max-T_step; %[s] Peak time
omega_n = pi/(T_p*sqrt(1-zeta^2)); %[rad/s] Natural frequency 
K_a = y_ss/U; % Amplification gain
% Resulting transfer function
P_s = K_a/((s^2/(omega_n^2))+((2*zeta)/omega_n)*s+1)%[rad] transfer function drive/motor

%% step response of ball on beam



G_s = P_s*P_bb*s; %[m/s]TF drive/motor/beam and ball, velocity output
G_s_LF = P_s*P_bb*LF_s*s;%[m/s]TF drive/motor/beam and ball, velocity output and LowPass filter

figure
h = bodeplot(G_s); % open  loop bodeplot of drive/motor/beam and ball
legend('G(s)')
title('Bodeplot, base system G(s)')

figure
h = bodeplot(G_s); % open  loop bodeplot of drive/motor/beam and ball
hold on
h_LF = bodeplot(G_s_LF);%open loop bodeplot of drive/motor/beam and ball with LPfilter
legend('G(s)','Single low pass filter G(s)LF')
title('Bodeplot, base system G(s), G(s) w/low pass filter at 8.8 [rad/s]')

% Lead controller, velocity
phi_desired = 70-OS_vel; %[deg] the desired phase margin
omega_bw = 1.8/Tr_vel; %[rad/s] the desired bandwidth

% Gain from final value theorem
K = 370.6/(e_ss_vel*2181); %[-] Gain to reach e_ss_vel

% Gain K from final value theorem is added to G_s
Gk_s= K*G_s;
figure
h = bodeplot(G_s);
hold on
gk = bodeplot(Gk_s);
legend('G(s)','Gk(s)')
title('Bodeplot without and with k gain')
%margin(Gk_s); % bodeplot with gain and phase margins for Gk_s
[Gm_Gk_s,Pm_Gk_s,Wcg_Gk_s,Wcp_Gk_s] = margin(Gk_s);


%% Results from velocity closed loop step response bodeplot



% Values from bodeplot for Gk_s and G_s
phi_new = Pm_Gk_s;%[deg] phase margin for Gk_s
pm_add = 12;%[deg] + 5-15 deg added phase margin to counteract shift
phi_m = (phi_desired-phi_new)+pm_add;%[deg] the required addition of phase margin


%% lead compensator



% Finding s, T and omega_m for H(s)
a= (1+sind(phi_m))/(1-sind(phi_m));%[-]
KH_Lead = 20*log10(1/sqrt(a));

% From Gk_s bodeplot, omega_m at KH_Lead magnitude
omega_m = 14;%[rad/s]

T = 1/(omega_m*sqrt(a));

% Final lead compensator H(s)


H_s = ((a*T*s+1)/(T*s+1)) % Lead compensator without gain
HK_s =K*H_s; % Lead compensator with K gain 
%H_G_s = H_s*G_s;% Lead compensated system, no gain
H_Gk_s = HK_s*G_s;% Lead compensated system, with K gain

% Bodeplot
figure
h = bodeplot(G_s);
hold on
gk = bodeplot(Gk_s);
%h_s = bodeplot(H_s); % bodeplot of lead compensator
%h_g_s = bodeplot(H_G_s); %Bodeplot of lead compensated system
h_gk_s = bodeplot(H_Gk_s); %Bodeplot of lead compensated system with gain
legend('G(s)','Gk(s)','HGk(s)')
title('Bodeplot system, system with gain and lead compensated system')




