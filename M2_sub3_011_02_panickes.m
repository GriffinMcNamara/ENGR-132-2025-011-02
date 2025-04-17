function [acc_start, time_const] = M2_sub3_SSS_TT_panickes (data_time, data_vel)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
%
% This program calculates the acceleration start time and the time constant
% from the data set inputtted from subfunction 2
%
% Function Call
%
% M2_sub3_SSS_TT_panickes
%
% Input Arguments
%
% 1. x_data: time-vector
% 2. y_data: velocity vector
%
% Output Arguments
%
% 1. acc_start: acceleration start time
% 2. time_const: time constant
%
% Assignment Information
%   Assignment:     M02, Problem #
%   Team member:    Shrey Panicker, panickes@purdue.edu
%   Team ID:        011-02
%   Academic Integrity:
%     [] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: Griffin , McNama36@purdue.edu 
%                           Aiden , apolicel@purdue.edu 
%                           John , catalan0@purdue.edu 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION

length = len(data_time); % length of time vector 
acc = zeros(1, length - 1); % establish zero acceleration vector

%% ____________________
%% CALCULATIONS

% Calculate acceleration vector (derivative of velocity)

for i = 1:length-1
    dv = data_vel(i+1) - data_vel(i);
    dt = data_time(i+1) - data_time(i);
    acc(i) = dv / dt;
end

threshold = max(acc) * 0.05; % Finds 5% of max acceleration

acc_coeffs = polyfit(data_time, acc, 1);

% Calculate accerlation start time at 5% of max acceleration
acc_start = (threshold - acc_coeffs(2)) / acc_coeffs(1); 

% Calculate time constance at 63.2% of max accelertation
time_const = (0.632 * max(acc) - acc_coeffs(2)) / acc_coeffs(1);


%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



