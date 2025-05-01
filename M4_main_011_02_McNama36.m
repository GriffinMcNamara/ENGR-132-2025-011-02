function M4_main_011_02_McNama36()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132
% Program Description
% Function to process data files using subfunctions for data management.
% The processed data will then be displayed in professionally formatted
% figures and plots.
%
% Function Call
% the function call is: M4_main_011_02_McNama36
%
% Input Arguments
%
% Output Arguments
%
% Assignment Information
%   Assignment:     M4, Problem 1
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
bench_mark_data = readmatrix("Sp25_cruiseAuto_M4benchmark_data.csv");

speed_data = data(2:end, 2:end);
time_data = data(2:end , 1);

clean_data_loops = 12;%number of times to redo the clean data function

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

% given values provided 
yL_given = [-0.09, -0.22, 0.19];
yH_given = [25.08, 24.72, 24.18];
ts_given = [6.21, 9.39, 6.85];
tau_given = [1.51, 1.96, 2.80];

%% ____________________
%% CALCULATIONS

[bench_mark_data_cln] = M2_sub2_011_02_catalan0(bench_mark_data);
%loop the cleaning data
for counter_1 = 1:clean_data_loops
    bench_mark_data_cln = M2_sub2_011_02_catalan0(bench_mark_data_cln);
end

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

    average_car_data = sum(single_car_data, 2) ./ car * tyre;

    % Do opporations to find needed values 
    %Call a function to find the initial and final volocities
    %for the car being evaluated
    [vI, vF]  = M4_sub4_011_02_apolicel(time_data, single_car_data);
    %Call a function to find the acceleration start time and time constant
    %for the car being evaluated
    [acc_start, time_const] = M4_sub3_011_02_panickes(time_data, ...
        average_car_data, vI, vF);

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

    %ERROR STUFF
    model = M4_benchmark_sub_1_011_02_McNama36(speed_data, ...
         time_data, yL_given(car), yH_given(car), ts_given(car) ...
         , tau_given(car));

    SSE_total = sum((model - clean_data( : , car + 1))...
        .^ 2);
    %the error devided by the number of datapoints I have
    ave_error_per_point = SSE_total ./ size(clean_data, 1);
    fprintf("the SSE total %d \n", ave_error_per_point)

    %start time
    error_percent_start = (abs(ts_given(car) - acc_start)) / ts_given(car);
    fprintf("the percetn error for the start time for car %d " + ...
        "is %d\n", car, error_percent_start);
    %time constant
    error_percent_time_const = (abs(tau_given(car) - time_const)) / ...
        tau_given(car);
    fprintf("the percetn error for the time constant for car %d " + ...
        "is %d\n", car, error_percent_time_const);
     %start volocity
    error_percent_start_V = (abs(yL_given(car) - vI)) / ...
        yL_given(car);
    fprintf("the percetn error for the start volocity for car %d " + ...
        "is %d\n", car, error_percent_start_V);
     %end volocity
    error_percent_end_V = (abs(yH_given(car) - vF)) / ...
        yH_given(car);
    fprintf("the percetn error for the end volocity for car %d " + ...
        "is %d\n\n", car, error_percent_end_V);

    % set the index for the tempuary matrix to 1 for the next loop
    i_single_car = 1;
    single_car_data = [];

    M4_performance_011_02(bench_mark_data_cln(2:end, car + 1), ...
        bench_mark_data_cln(2:end, 1), yL_given(car), yH_given(car), ...
        ts_given(car), tau_given(car), car);

    fprintf("\n----- Car %d Parameters -----\n", car);
    fprintf("Acceleration start time: %.4f s\n", acc_start);
    fprintf("Time constant: %.4f s\n", time_const);
    fprintf("Initial speed: %.4f m/s\n", vI);
    fprintf("Final speed: %.4f m/s\n", vF);

    figure(20 + car);
    plot(time_data, model, 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Velocity (m/s)');
    title(sprintf('Velocity Model for Car %d', car));
    grid on;
    legend('Velocity Model');
end

%% ____________________
%% RESULTS

M4_benchmark_011_02_McNama36(speed_data, bench_mark_data_cln, time_data, ...
    Num_cars, Num_tyres, Num_tests)

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.

