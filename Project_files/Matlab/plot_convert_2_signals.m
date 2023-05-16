clear; close all; clc;
% Specify the file name and location
filename = 'BallPos_5deg_beam_angle_roll_calib.trace.csv';

% Read the data from the CSV file
data = readmatrix(filename);

% Convert time values from milliseconds to seconds
data(:,3) = data(:,3) / 1000;



% Plot the data
plot(data(:,3), data(:,4),data(:,3), data(:,8));

hold on

plot(data(:,3), data(:,10));

legend('AxisInterface.rBallFeedback','GVL.rActualBeamPos')
xlabel('Seconds');
ylabel('Millimeter/ degrees');


