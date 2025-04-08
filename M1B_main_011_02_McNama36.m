function M1B_main_011_02_McNama36()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132
% Program Description
% Function to process data files using subfunctions for data management.
% The processed data will then be displayed in professionally formatted
% figures and plots.
%
% Function Call
% the function call is: M1B_main_011_02_McNama36
%
% Input Arguments
%
% Output Arguments
%
% Assignment Information
%   Assignment:     M1B, Problem 1
%   Team member:   Griffin McNamara, McNama36@purdue.edu
%   Team ID:        011-02
%   Academic Integrity:
%
%     [] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: John Catalan, catalan0@purdue.edu
%                           Shrey Panicker, panickes@purdue.edu
%                           Aidan Policelli, apolicel@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION
%this gets the data from the file and imports it to a usable formate for
%MATLAB analysis
data = readmatrix("Sp25_cruiseAuto_experimental_data.csv");
% finds the size of the created matrix
[num_rows, num_col] = size(data);

% This holds the column being printed and starts at 2 because the fist
% column with testing data is 2
line_per_plot = 2;
% Initialize processed data variables for subfunctions
data_to_3 = []; % Holds output from M1A_sub2_011_02_apolicel
data_to_4 = []; % Holds output from M1A_sub3_001_02_panickes
data_out = [];  % Holds final output after processing
color = [0, 0, 0]; % Placeholder initialization before dynamic assignment
num_plotted = 1; % start value that increases every loop it controls



%% ____________________
%% CALCULATIONS

% move the data from one subfunction to the other
[data_to_3] = M1A_sub2_011_02_apolicel(data);
[data_to_4] = M1A_sub3_001_02_panickes(data_to_3);
[data_out] = M1A_sub4_011_02_catalan0 (data_to_4);

%testin
%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

% initalize the figure and do the things needed only once
figure(1)
hold on

% This will loop untill all the
while (num_plotted <= floor((num_col - .01) / 15) + 1)
    
    % this sets how amny subplots and which are used when
    subplot(floor(num_col / 30) + 1, floor(num_col / 30) + 1, ...
        num_plotted)
    % Formating for all plots
    hold on
    grid on
    title('CruiseAuto ACC Test Data Visualization')
    xlabel('Time (s)')
    ylabel('Speed (m/s)')

    % loop to print the figure with every dataset
    while (line_per_plot <= 15 * num_plotted && line_per_plot <= num_col)

        % set a variable for the colour that changes with every ittoration
        color = mod([0.2 + line_per_plot * 0.0666, 0.1 + line_per_plot ...
            * 0.0666, 0.6 + line_per_plot * 0.0666], 1);

        % plot each testing dataset
        plot(data_out(:, line_per_plot), 'Color', ...
            color, 'LineWidth', 0.5);

        line_per_plot = line_per_plot + 1; %incraments for each loop

    end
    hold off
    num_plotted = num_plotted + 1; % incrament for every outer loop

end

%% ____________________
%% RESULTS


%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



=======
function M1B_main_011_02_McNama36()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132
% Program Description
% Function to process data files using subfunctions for data management.
% The processed data will then be displayed in professionally formatted
% figures and plots.
%
% Function Call
% the function call is: M1B_main_011_02_McNama36
%
% Input Arguments
%
% Output Arguments
%
% Assignment Information
%   Assignment:     M1B, Problem 1
%   Team member:   Griffin McNamara, McNama36@purdue.edu
%   Team ID:        011-02
%   Academic Integrity:
%
%     [] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: John Catalan, catalan0@purdue.edu
%                           Shrey Panicker, panickes@purdue.edu
%                           Aidan Policelli, apolicel@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION
%this gets the data from the file and imports it to a usable formate for
%MATLAB analysis
data = readmatrix("Sp25_cruiseAuto_experimental_data.csv");
% finds the size of the created matrix
[num_rows, num_col] = size(data);

% This holds the column being printed and starts at 2 because the fist
% column with testing data is 2
line_per_plot = 2;
% Initialize processed data variables for subfunctions
data_to_3 = []; % Holds output from M1A_sub2_011_02_apolicel
data_to_4 = []; % Holds output from M1A_sub3_001_02_panickes
data_out = [];  % Holds final output after processing
color = [0, 0, 0]; % Placeholder initialization before dynamic assignment
num_plotted = 1; % start value that increases every loop it controls



%% ____________________
%% CALCULATIONS

% move the data from one subfunction to the other
[data_to_3] = M1A_sub2_011_02_apolicel(data);
[data_to_4] = M1A_sub3_001_02_panickes(data_to_3);
[data_out] = M1A_sub4_011_02_catalan0 (data_to_4);

%testin
%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

% initalize the figure and do the things needed only once
figure(1)
hold on

% This will loop untill all the
while (num_plotted <= floor((num_col - .01) / 15) + 1)
    
    % this sets how amny subplots and which are used when
    subplot(floor(num_col / 30) + 1, floor(num_col / 30) + 1, ...
        num_plotted)
    % Formating for all plots
    hold on
    grid on
    title('CruiseAuto ACC Test Data Visualization')
    xlabel('Time (s)')
    ylabel('Speed (m/s)')

    % loop to print the figure with every dataset
    while (line_per_plot <= 15 * num_plotted && line_per_plot <= num_col)

        % set a variable for the colour that changes with every ittoration
        color = mod([0.2 + line_per_plot * 0.0666, 0.1 + line_per_plot ...
            * 0.0666, 0.6 + line_per_plot * 0.0666], 1);

        % plot each testing dataset
        plot(data_out(:, line_per_plot), 'Color', ...
            color, 'LineWidth', 0.5);

        line_per_plot = line_per_plot + 1; %incraments for each loop

    end
    hold off
    num_plotted = num_plotted + 1; % incrament for every outer loop

end

%% ____________________
%% RESULTS


%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



>>>>>>> 2d6530c24404590a77e33eca688b58ec30c54f65
