function M4_benchmark_011_02_McNama36(real_data, bench_data, data_time, ...
    Num_cars, Num_tyres, Num_tests)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132
% Program Description
%
% Function Call
% the function call is: M4_benchmark_011_02_McNama36()
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
SSE_total = 0;

% Estimate yL and yH from velocity data
yL_guess = [-0.09, -0.22, 0.19];
yH_guess = [25.08, 24.72, 24.18];

% Rough guess of when the velocity starts increasing
ts_guess = [6.21, 9.39, 6.85];

% Initial guess for time constant
tau_guess = [1.51, 1.96, 2.80];

%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

% Loop through cars
for car = 1:Num_cars

    figure(car + 3)
    hold on
    set(figure(car + 3), 'Name', ['Vehicle Speed vs. Time: Benchmark ' ...
        'Data and First-Order Model Comparison'], 'NumberTitle', 'off');
    % Get screen size (in pixels)
    screen_size = get(0, 'ScreenSize');
    % Set figure position to cover the whole screen
    set(gcf, 'Position', screen_size);

    % for tyre = 1:Num_tyres
    % 
    %         % fill the matrix with values for use at the end of the outer
    %         % function
    %         single_car_data_ave(:, 1) = real_data(:, ...
    %             car + 1) + single_car_data_ave(:, 1);
    % end   
    model = M4_benchmark_sub_1_011_02_McNama36(bench_data, ...
         data_time, yL_guess(car), yH_guess(car), ts_guess(car) ...
         , tau_guess(car));
    % single_car_data_ave = mean(bench_data, 2);
    %plot the average of the test data
    plot(bench_data(:, 1), bench_data(:, car + 1), 'LineWidth', 1.5);
    %plot our model
    plot(data_time, model, 'LineWidth', 1.5)

    % plot formatting
    title(sprintf('Car %d', car))
    xlabel('Time Index')
    ylabel('Speed (or Output)')
    legend("average of the test data", "model",'Location', 'best')
    grid on

    %% SSE CALCULATIONS

    SSE_total = sum((model - bench_data(2:end, car + 1))...
        .^ 2);

    %the error devided by the number of datapoints I have
    ave_error_per_point = SSE_total ./ size(bench_data, 1);
    
    annotation('textbox', [0.35, 0.08, 1, 0.1], ...
    'String', sprintf('Average SSE per point: %.4f', ave_error_per_point), ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center', ...
    'FontSize', 12, ...
    'FontWeight', 'bold');

    % set the index for the tempuary matrix to 1 for the next loop
    single_car_data_ave = zeros(size(real_data, 1), 1);
    SSE_total = 0;
    hold off
end


