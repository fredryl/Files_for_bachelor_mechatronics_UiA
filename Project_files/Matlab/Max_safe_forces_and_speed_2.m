%% 
% Here, maximum speed and power must be calculated on the body part with the 
% lowest tolerance for injury/pain. Based on ISO 15066-2016

clc; close all; clear;
%  defenition of variable real system :
Beam_weigth = 0.30555769  % Kg, only beam. No ball.
m_ball = 0.00283 % kg Only the ball.
weigth_beam_with_ball = Beam_weigth+m_ball % Kg
beam_lengt_from_center =  0.4216 % m, Distance from center to the farest
%% Energy limit values based on the body region model.

max_juele_face = 0.11 % juele, Nm. page 28, tabel A.4. 
%% Biomechanical limits

Maximum_permissible_force = 65 % N, Face masticatory muscle. Tabel A.2 page 24.

mass_Head = 4.4 % kg, page 27, tabel A.3.

% finding max velocity relativ to hiting the object.
m_R = (Beam_weigth/2+m_ball) % kg, formula A.4 page 29.
my = (1/mass_Head+1/m_R)^-1 % kg, formula A.3 page 29.

V_relativ_m = sqrt((max_juele_face*2)/my) % m/s max velocity of the end of beam tip. formula A.2 page 28.
V_relativ_mm = V_relativ_m*10^3 % mm/s
omega = V_relativ_m/(beam_lengt_from_center) % Rad/s 

% finding the max safe torque of from servo
safe_t_off = Maximum_permissible_force*beam_lengt_from_center % Nm 


%%