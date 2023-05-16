clc; close all; clear
% Roling ball and rotattation dynamics
% 
% Testing omega, velocity, ball pos on beam is changing.
g = 9810; %[mm/s^2]
R_ball = 40.1*1/2; % mm
d_beam_17 = 16.667; % mm
V_relativ_mm = 1.221443493793749e+03 ; % mm/s
r = 421.6; % radius beam mm

deg = linspace(-20,20,200); % deg, max min angel
ball_aks =(g*sind(deg))/(1+(2*R_ball^2)/(3*(R_ball^2-d_beam_17^2/4))); % mm/s^2, acceleration based on angel
figure
plot(ball_aks,deg)
ylabel('Deg^o')
xlabel('Ball acceleration [mm/s^2]')
legend('Ball acceleration based on angle')
grid on



ball_aks_1deg =(g*sind(1))/(1+(2*R_ball^2)/(3*(R_ball^2-d_beam_17^2/4))) % mm/s^2, acceleration 
ball_aks_5deg =(g*sind(5))/(1+(2*R_ball^2)/(3*(R_ball^2-d_beam_17^2/4))) % mm/s^2, acceleration 
ball_aks_10deg =(g*sind(10))/(1+(2*R_ball^2)/(3*(R_ball^2-d_beam_17^2/4))) % mm/s^2, acceleration 
ball_aks_15deg =(g*sind(15))/(1+(2*R_ball^2)/(3*(R_ball^2-d_beam_17^2/4))) % mm/s^2, acceleration 




roling_length = linspace(0,335.1,200); % mm From center to tip.


v = linspace(-1221.4,1221.4,200); % mm/s, tangential velocity at tip.
omega = v/r; % rad/s 

figure
plot(omega,v)
grid on
xlabel('Omega [rad/s]')
ylabel('Angular velocity [m/s]')
legend('Rotation vel at tip and omega')


a_N_1221 = (V_relativ_mm/r).^2.*roling_length; % mm/^2, centripetal acceleration v=1221.4 [mm/s^2] (max)
a_N_1000 = (1000/r).^2.*roling_length; % mm/^2, centripetal acceleration v=1000 [mm/s^2]
a_N_500 = (500/r).^2.*roling_length; % mm/^2, centripetal acceleration v=500 [mm/s^2]
a_N_100 = (100/r).^2.*roling_length; % mm/^2, centripetal acceleration v=100 [mm/s^2]

figure
plot(roling_length,a_N_1221)
grid on
hold on
plot(roling_length,a_N_1000)
hold on
plot(roling_length,a_N_500)
hold on
plot(roling_length,a_N_100)
ylabel('centripetal acceleration [mm/s^2]')
xlabel('Rolling from center to tip [mm]')
legend('1221.4mm/s','1000mm/s','500mm/s','100mm/s', 'Location','best')
title(['Centripetal acceleration based on angular velocity (tip) ' ...
    'and ball position on the beam'])



% The beam rotates towards the ball:

accel_1_V_1221 = ball_aks_1deg  - a_N_1221;% exampel 1 senario 1 deg and tangential velocity (max):
accel_5_V_1221  = ball_aks_5deg  - a_N_1221;% exampel 2 senario 5 deg and tangential velocity (max):
accel_10_V_1221 = ball_aks_10deg - a_N_1221;% exampel 3 senario 10 deg and tangential velocity (max):
accel_15_V_1221 = ball_aks_15deg - a_N_1221;% exampel 4 senario 15 deg and tangential velocity (max):


figure
plot(roling_length,accel_1_V_1221)
hold on
grid on
plot(roling_length,accel_5_V_1221)
hold on
plot(roling_length,accel_10_V_1221)
hold on
plot(roling_length,accel_15_V_1221)
hold on
ylabel('Acceleration based on angle [mm/s^2]')
xlabel('The position of the ball on the beam')
legend('Acceleration 1 deg','Acceleration 5 deg','Acceleration 10 deg', 'Acceleration 15 deg')
title(['Acceleration is Possitiv if ball rolls towards the ' ...
    'center of the beam (1221.4 mm/s at tip rotation up)'])



%%%%%%%%%%%%%%%%%%%%%

accel_1_V_500  = ball_aks_1deg  - a_N_500;% exampel 1 senario 1  deg and tangential velocity (500):
accel_5_V_500  = ball_aks_5deg  - a_N_500;% exampel 2 senario 5  deg and tangential velocity (500):
accel_10_V_500 = ball_aks_10deg - a_N_500;% exampel 3 senario 10 deg and tangential velocity (500):
accel_15_V_500 = ball_aks_15deg - a_N_500;% exampel 4 senario 15 deg and tangential velocity (500):


figure
plot(roling_length,accel_1_V_500)
hold on
grid on
plot(roling_length,accel_5_V_500)
hold on
plot(roling_length,accel_10_V_500)
hold on
plot(roling_length,accel_15_V_500)
hold on
ylabel('Acceleration based on angle [mm/s^2]')
xlabel('The position of the ball on the beam')
legend('Acceleration 1 deg','Acceleration 5 deg','Acceleration 10 deg', 'Acceleration 15 deg')
title(['Acceleration is Possitiv if ball rolls towards the ' ...
    'center of the beam (v=500 mm/s at tip rotation up)'])

% 
% The beam rotates away from the ball:

accel_1_V_1221  = ball_aks_1deg  + a_N_1221;% exampel 1 senario 1 deg and tangential velocity (max):
accel_5_V_1221  = ball_aks_5deg  + a_N_1221;% exampel 2 senario 5 deg and tangential velocity (max):
accel_10_V_1221 = ball_aks_10deg + a_N_1221;% exampel 3 senario 10 deg and tangential velocity (max):
accel_15_V_1221 = ball_aks_15deg + a_N_1221;% exampel 4 senario 15 deg and tangential velocity (max):


figure
plot(roling_length,accel_1_V_1221)
hold on
grid on
plot(roling_length,accel_5_V_1221)
hold on
plot(roling_length,accel_10_V_1221)
hold on
plot(roling_length,accel_15_V_1221)
hold on
ylabel('Acceleration based on angle [mm/s^2]')
xlabel('The position of the ball on the beam')
legend('Acceleration 1 deg','Acceleration 5 deg','Acceleration 10 deg', 'Acceleration 15 deg')
title(['Acceleration is Possitiv if ball rolls away ' ...
    'from the center of the beam (v=1221.4 mm/s at tip rotation down)'])



%%%%%%%%%%%%%%%%%%%%%

accel_1_V_500  = ball_aks_1deg  + a_N_500;% exampel 1 senario 1  deg and tangential velocity (500):
accel_5_V_500  = ball_aks_5deg  + a_N_500;% exampel 2 senario 5  deg and tangential velocity (500):
accel_10_V_500 = ball_aks_10deg + a_N_500;% exampel 3 senario 10 deg and tangential velocity (500):
accel_15_V_500 = ball_aks_15deg + a_N_500;% exampel 4 senario 15 deg and tangential velocity (500):


figure
plot(roling_length,accel_1_V_500)
hold on
grid on
plot(roling_length,accel_5_V_500)
hold on
plot(roling_length,accel_10_V_500)
hold on
plot(roling_length,accel_15_V_500)
hold on
ylabel('Acceleration based on angle [mm/s^2]')
xlabel('The position of the ball on the beam')
legend('Acceleration 1 deg','Acceleration 5 deg','Acceleration 10 deg', 'Acceleration 15 deg')
title(['Acceleration is Possitiv if ball rolls away ' ...
    'from the center of the beam (v=500 mm/s at tip rotation down)'])
