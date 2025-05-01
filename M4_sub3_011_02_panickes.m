function [acc_start, time_const] = M4_sub3_011_02_panickes...
    (data_time, data_vel, yL, yH)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
%
% This program calculates the acceleration start time and the time constant
% from the data set inputtted from subfunction 2
%
% Function Call
%
% M4_sub3_011_02_panickes
%
% Input Arguments
%
% 1. data_time
% 2. data_vel
% 3. yL
% 4. yH
%
% Output Arguments
%
% 1. acc_start: acceleration start time
% 2. time_const: time constant
%
% Assignment Information
%   Assignment:     M03, Problem #
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

% Apply smoothing
data_vel = movmean(data_vel, 10);

%% ____________________
%% CALCULATIONS

% Step 1: Calculate derivative of velocity with respect to time
derivative = diff(data_vel) ./ diff(data_time);

% Step 2: Find first positive derivative to mark acceleration start
for k = 1:length(derivative)
    if derivative(k) > 0
        pos_der = k;
        break;
    end
end

acc_start = data_time(pos_der);  % Start of acceleration

% Step 3: Compute 63.2% of velocity change
target_velocity = yL + 0.632 * (yH - yL);

% Step 4: Find time when velocity crosses the target velocity
for m = pos_der+1:length(data_vel)
    if data_vel(m) >= target_velocity
        index_target = m;
        break;
    end
end

% Step 5: Calculate time constant
time_const = data_time(index_target) - acc_start;

end

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.
