function [acc_start, time_const] = M3_sub3_011_02_panickes...
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
% M3_sub3_011_02_panickes
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

    % Calculate the 63.2% target velocity level
    targetVel = yL + 0.632 * (yH - yL);

    data_vel = movmean(data_vel, 10);

    % Find first time velocity reaches or exceeds 63.2% of total change
    index_target = find(data_vel >= targetVel, 1);

    if isempty(index_target)
        error('Target velocity not reached in dataset.');
    end

    % Interpolate for more accurate t_target
    if index_target > 1
        t1 = data_time(index_target - 1);
        t2 = data_time(index_target);
        v1 = data_vel(index_target - 1);
        v2 = data_vel(index_target);
        % Linear interpolation to solve for time at target velocity
        t_target = t1 + (targetVel - v1) * (t2 - t1) / (v2 - v1);
    else
        t_target = data_time(index_target);
    end

    % Now estimate t_s (start time) as the first point velocity rises above yL
    start_time_range = 100;
    index_start = find(data_vel(start_time_range:end) > yL + 0.05 * (yH - yL), 1);  % 1% threshold
    if isempty(index_start)
        error('Could not determine start of acceleration.');
    end
    acc_start = data_time(index_start);

    % Estimate tau = t_target - t_s
    time_const = t_target - acc_start;
end

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.
