function M2_main_011_02_McNama36()
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
%   Assignment:     M2, Problem 1
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

speed_data = data(2:end, :);
time_data = data(1, :);

clean_data_loops = 10000;%number of times to redo the clean data function

% Initialize placeholder variables for each subfunction's output
clean_data = []; % Output from subfunction 2
data_to_4 = []; % Output from subfunction 3
data_out  = []; % Final processed data from subfunction 4

% Configuration settings
Num_cars  = 3;  % Number of vehicles tested
Num_tyres = 3;  % Number of tyre types tested per vehicle
Num_tests = 5;  % Number of repeated tests per tyre

% Define consistent color mapping for the 5 test runs
test_colors = [
    0.00 0.45 0.74;
    0.85 0.33 0.10;
    0.93 0.69 0.13;
    0.49 0.18 0.56;
    0.47 0.67 0.19
];
%% ____________________
%% CALCULATIONS

% move the data from one subfunction to the other
[clean_data] = M2_sub2_011_02_catalan0(speed_data);

for i = 1:clean_data_loops  % however many times you want to loop
    data_out = clean_data(data_out);
end
% Second processing stage
[acc_start, time_const] = M2_sub3_011_02_panickes(time_data, speed_data);
%Final processing
[vI, vF]  = M2_sub4_011_02_apolicel(time_data, clean_data, acc_start);

%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

% Loop through cars
for car = 1:Num_cars
    figure(car)
    tiledlayout(1, 3, 'TileSpacing', 'Compact') %1 row, 3 columns for tyres
    % Get screen size (in pixels)
    screen_size = get(0, 'ScreenSize');
    % Set figure position to cover the whole screen
    set(gcf, 'Position', screen_size);
    
    for tyre = 1:Num_tyres
        nexttile % Move to the next subplot tile
        hold on  % Allow multiple lines on the same subplot
        
        % Overlay each test run for the current tyre
        for test = 1:Num_tests
            % Calculate the column index
            col_idx = 1 + (car - 1) * Num_tyres * Num_tests + ...
                           (tyre - 1) * Num_tests + test;
            
            % Plot using predefined color
            plot(clean_data(:, col_idx), 'Color', test_colors(test, :), ...
                'LineWidth', 1.5, 'DisplayName', sprintf('Test %d', test));
        end
        
        % Subplot formatting
        title(sprintf('Car %d - Tyre %d', car, tyre))
        xlabel('Time Index')
        ylabel('Speed (or Output)')
        legend('Location', 'best')
        grid on
        hold off
    end
    
    sgtitle(sprintf('Performance Summary for Car %d', car))
end

%% ____________________
%% PARAMETER SUMMARY FIGURE
figure;
axis off;                                       % turn off axes

% Build each line of text using the variables you already have
text(0.1, 0.8, ['Acceleration start time: ', num2str(acc_start, '%.3f'), ' s'], 'FontSize', 12);
text(0.1, 0.7, ['Time constant (τ): ',       num2str(time_const, '%.3f'),  ' s'], 'FontSize', 12);
text(0.1, 0.6, ['Initial velocity (vI): ',    num2str(vI,          '%.3f'),  ' m/s'], 'FontSize', 12);
text(0.1, 0.5, ['Final velocity (vF): ',      num2str(vF,          '%.3f'),  ' m/s'], 'FontSize', 12);

title('CruiseAuto Parameter Summary', 'FontSize', 14);
%% ____________________
%% RESULTS


%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.

