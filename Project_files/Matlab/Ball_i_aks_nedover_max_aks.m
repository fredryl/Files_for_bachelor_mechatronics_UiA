%% 
% Here I want to find the maximum angular acceleration of the ball downwards 
% in the worst case scenario. This is to set a limit in the system to make sure 
% we work within a safe limitation.
% 
% Not considering folowing: air resistance and rolling resistance.
% 
% Assume: No sliding ogly pure roll and no friction do to rooling.
% 
% Angle $\pm {20}^{\circ }$, working in area of 40 deg.
% 
% Picture on the force acting:
% 
% 

clc;close all; clear;
% defenition of variable:
m = 2.75 % grams
g = 9.81 % m/s^2
Length_of_beam = 0.71 % m
max_length_from_center = 0.3351 % m,The furthest distance from the center the ball can travel



% The worst cenario is when the ball is at the tip and the beam is
% accselerating down from horizontal.
a_max_tip = 9.81 % m/s^2

% % finding max angular acceleration from top 20 deg going down:
g_20_down = cosd(20)*g
alpha_20_down =  g_20_down/max_length_from_center% rad/s^2


% finding max angular acceleration from horizontal going down:
alpha_0_down =  a_max_tip/max_length_from_center% rad/s^2

% alpha max based on worst scenario at the top:
alpha_max =  g_20_down/max_length_from_center% rad/s^2

%% 
% The angular acceleration can not exid 29.2748$\frac{rad}{s^2}$ when the ball 
% have a negativ acceleration horizontal going down. If so the ball will be in 
% free fall and no contact.
% 
% 
% 
% The angular acceleration can not exid 27.5094$\frac{rad}{s^2}$ when the ball 
% have a negativ acceleration at 20 deg at top going down. If so the ball will 
% be in free fall and no contact.
% 
% 
% 
% Now we need to consider  that we dont want the ball to leave the beam at the 
% tip.
% 
% First plot the vertical acceleration  $\pm {20}^{\circ }$:

angle = linspace(-20,20,400);
rad = deg2rad(angle);
angle_rad = (cos(rad));
vertica_acceleration = (alpha_max*max_length_from_center)./angle_rad;
plot(angle,vertica_acceleration)
grid on
xlabel('angel')
ylabel('vertical acceleration')
title('Tangential acceleration limitation down')
%% 
% This means that if the ball stops at 20 then the accel is 9.21838 $\frac{m}{s^2 
% }$ vertical 
% 
% Finds the length of the arc it accelerates

arc_deg =linspace(0,2*pi/9,400); % Going from -20 deg to 20 deg.
arc_lengt_1 = max_length_from_center*arc_deg; % m lengt from -20 to 20 deg
%% 
% Finding the speed at the end vertically.

theta = arc_deg ; % -20 to 20 deg
t = sqrt((2*theta)/alpha_max); % s, time from -20 deg to 20 deg. 
omega_30 = alpha_max*t; % rot velocity from -20 to 20 deg over the arc lengt.
velocity_tang = omega_30*max_length_from_center; % m/s, tangential velosyty if alpha is constant and from min angel to max angel.

plot(theta,velocity_tang)
grid on
xlabel('Lengt of travell rad')
ylabel('Velocity m/s')
title('Velocity ball at tip of beam')
hold off
%% 
% Finding how high the ball will go if the speed and acceleration is known. 
% Stops at 20 deg at top after travel -20 to 20 deg..

%h = 1/100 %m
% energi_potensiell = m*g*h
% from -20 deg  stops at 20deg how high and fare will the ball go.
% This is only to show if the system have limits unvanted senarios can
% happen.
H_max =((velocity_tang).^2.*(sind(70)).^2)/(2*g) *10^3 % mm in the air
R_max =((velocity_tang).^2.*(sind(2*70)))/(g) *10^3 % mm in the air
plot(velocity_tang,H_max)
hold on
plot(velocity_tang,R_max)
grid on
xlabel('velocity m/s')
ylabel('Ball will go up (H) and away(R) if stoped, mm')
legend('Ball can go vertically (H)','Ball can go horizontally (R)', 'Location','best')
title('How far can the ball fly if the Beam stops at 20^o')