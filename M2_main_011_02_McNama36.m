function M2_main_011_02_McNama36()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132
% Program Description
% Function to process data files using subfunctions for data management.
% The processed data will then be displayed in professionally formatted
% figures and plots.
%
% Function Call
% the function call is: M2_main_011_02_McNama36
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

speed_data = data(2:end, 2:end);
time_data = data(2:end , 1);

clean_data_loops = 5;%number of times to redo the clean data function

% Initialize placeholder variables for each subfunction's output
clean_data = []; % Output from subfunction 2

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

% A matrix that will hold temparary values for use in calculating stuff for
% subsets of the full data set
single_car_data = [];
% a counter to use when indexing the single_car_data
i_single_car = 1;

%% ____________________
%% CALCULATIONS

% move the data from one subfunction to the other
[clean_data] = M2_sub2_011_02_catalan0(speed_data);

for counter_1 = 1:clean_data_loops
    clean_data = M2_sub2_011_02_catalan0(clean_data);
end

%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

% Loop through cars
for car = 1:Num_cars

    figure(car)
    % Get screen size (in pixels)
    screen_size = get(0, 'ScreenSize');
    % Set figure position to cover the whole screen
    set(gcf, 'Position', screen_size);
    
    for tyre = 1:Num_tyres
        subplot(2, 2, tyre) % Move to the next subplot tile
        hold on  % Allow multiple lines on the same subplot
        
        % Overlay each test run for the current tyre
        for test = 1:Num_tests
            % Calculate the column index
            col_idx = (tyre - 1) * Num_tyres + (car - 1) * Num_cars...
                + test;
            
            % Plot using predefined color
            p(test) = plot(time_data, clean_data(:, col_idx), ...
            'Color', test_colors(test, :), 'LineWidth', 1.5);

            % fill the matrix with values for use at the end of the outer
            % function
            single_car_data(:, i_single_car) = clean_data(:, col_idx);
            i_single_car = i_single_car + 1;
        end
        
        legend(p, {'Test 1', 'Test 2', 'Test 3', 'Test 4', ...
            'Test 5'}, 'Location', 'best');


        % Subplot formatting
        title(sprintf('Car %d - Tyre %d', car, tyre))
        xlabel('Time Index')
        ylabel('Speed (or Output)')
        legend('Location', 'best')
        grid on
        hold off
    end

    % Do opporations to find needed values 
    %Call a function to find the acceleration start time and time constant
    %for the car being evaluated
    [acc_start, time_const] = M2_sub3_011_02_panickes(time_data, ...
        single_car_data);
    %Call a function to find the initial and final volocities
    %for the car being evaluated
    [vI, vF]  = M2_sub4_011_02_apolicel(time_data, single_car_data, ...
        acc_start);

    sgtitle(sprintf('Performance Summary for Car %d', car))

    subplot(2, 2, 4)
    %display the Acceleration start time, Time constant, 
    % Initial velocity, and Final velocity.
    text(0.1, 0.8, ['Acceleration start time: ', num2str(acc_start, ...
        '%.3f'), ' s'], 'FontSize', 12);
    text(0.1, 0.7, ['Time constant (τ): ', num2str(time_const, ...
       '%.3f'),  ' s'], 'FontSize', 12);
    text(0.1, 0.6, ['Initial velocity (vI): ', num2str(vI, '%.3f'), ...
        ' m/s'], 'FontSize', 12);
    text(0.1, 0.5, ['Final velocity (vF): ', num2str(vF, '%.3f'), ...
        ' m/s'], 'FontSize', 12);

    title('CruiseAuto Parameter Summary', 'FontSize', 14);

    % set the index for the tempuary matrix to 1 for the next loop
    i_single_car = 1;
    single_car_data = [];
end

%% ____________________
%% RESULTS


%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.

