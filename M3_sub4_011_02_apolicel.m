function [vI, vF] = M3_sub4_011_02_apolicel(data_time, data_vel, accel_start)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This function uses the velocity data set, acceleration start time, 
% and the time data set to accuratly predict the initial and final velocitys.
%
% Function Call
% M3_sub4_011_02_apolicel(data)
%
% Input Arguments
%  data_time    - time data set
%  data_vel     - the data set for velocity
%  accel_start  - start time for acceleration
%
% Output Arguments
% vI   - aproximate initial speed after acceleration starts
% Vf   - approximate final speed
%
% Assignment Information
%   Assignment:     M03, Problem 2
%   Team member:    Aidan Policelli, apolicel@purdue.edu 
%   Team ID:        011-02
%   Academic Integrity:
%     [] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: John Catalan, catalan0@purdue.edu
%                           Shrey Panicker, panickes@purdue.edu 
%                           Griffin Mcnamara, McNama36@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION
sum5f = 0;   %sum of last five velocites
sum5i = 0;   %sum of first five velocities

length_data = length(data_time);   %length of data sets

%% ____________________
%% CALCULATIONS


%Finds the sum of first five velocities after acceleration begins
for i = 1:5
    sum5i = sum5i + data_vel(+ i);
end


%Finds the sum of the last five velocities
for i = 0:4
    sum5f = sum5f + data_vel(length_data - 4 + i);
end

%final calculations
vI = sum5i / 5;
vF = sum5f / 5;
%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS
%% ____________________
%% RESULTS

end
%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



