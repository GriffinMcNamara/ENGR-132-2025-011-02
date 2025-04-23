function M3_benchmark_011_02_McNama36(real_data, bench_data, data_time, ...
    Num_cars, Num_tyres, Num_tests)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132
% Program Description
%
% Function Call
% the function call is: M3_benchmark_011_02_McNama36()
%
% Input Arguments
%
% Output Arguments
%
% Assignment Information
%   Assignment:     M3, Problem 1
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
single_car_data_ave = zeros(size(bench_data, 1), 1);
i_single_car = 1;



%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

% Loop through cars
for car = 1:Num_cars

    figure(car + 3)
    set(figure(car + 3), 'Name', ['Vehicle Speed vs. Time: Benchmark ' ...
        'Data and First-Order Model Comparison'], 'NumberTitle', 'off');
    % Get screen size (in pixels)
    screen_size = get(0, 'ScreenSize');
    % Set figure position to cover the whole screen
    set(gcf, 'Position', screen_size);

    for tyre = 1:Num_tyres
        subplot(2, 2, tyre) % Move to the next subplot tile
        hold on  % Allow multiple lines on the same subplot



            % fill the matrix with values for use at the end of the outer
            % function
            single_car_data_ave(:, 1) = bench_data(:, ...
                car + 1) + single_car_data_ave(:, 1);
         
        model = M3_benchmark_sub_1_011_02_McNama36(single_car_data_ave, ...
             data_time);
        % single_car_data_ave = mean(bench_data, 2);
        %plot the average of the test data
        plot(bench_data(:, 1), bench_data(:, car + 1), 'LineWidth', 1.5);
        %plot our model
        plot(data_time, model, 'LineWidth', 1.5)

        %% SSE CALCULATIONS
        for control = 1 : (length(bench_data) - 1)
            SSE_total = (model(control) - bench_data(control + 1))...
                .^ 2 + SSE_total;
        end
        
        %the error devided by the number of datapoints I have
        ave_error_per_point = SSE_total ./ size(bench_data, 1);

        % Subplot formatting
        title(sprintf('Car %d - Tyre %d', car, tyre))
        xlabel('Time Index')
        ylabel('Speed (or Output)')
        legend("average of the test data", "model",'Location', 'best')
        grid on
        hold off
    end

    % set the index for the tempuary matrix to 1 for the next loop
    i_single_car = 1;
    single_car_data = [];
end




