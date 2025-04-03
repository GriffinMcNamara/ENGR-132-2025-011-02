function M1A_main_011_02_McNama36
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% Function to process data files using subfunctions for data management.
% The processed data will then be displayed in professionally formatted 
% figures and plots.
%
% Function Call
% the function call is: M1A_main_011_02_McNama36
%
% Input Arguments
%
% Output Arguments
%
% Assignment Information
%   Assignment:     M1, Problem 4
%   Team member:   Griffin McNamara, McNama36@purdue.edu
%   Team ID:        011-02
%   Academic Integrit
% y:
%     [] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: John Catalan, catalan0@purdue.edu
%                           Shrey Panicker, panickes@purdue.edu
%                           Aidan Policelli, apolicel@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION
data = 0;

%% ____________________
%% CALCULATIONS

% move the data from one subfunction to the other
[data_to_3] = M1A_sub2_011_02_apolicel(data);
[data_to_4] = M1A_sub3_001_02_panickes(data_to_3);
[data_out] = M1A_sub4_011_02_catalan0 (data_to_4);

%testing
%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS


%% ____________________
%% RESULTS


%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



