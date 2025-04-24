function M3_performance_011_02(benchmark_data, time_data, yL, yH, ...
    ts, tau, car_id)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 - M3_performance_SSS_tt
%
% Function to visualize benchmark data and performance boundaries
% adjusted for CruiseAuto's expected acceleration start time of 5.0 sec.
%
% Inputs:
%   benchmark_data - raw benchmark velocity data (vector)
%   time_data      - corresponding time vector (same length)
%   yL, yH         - initial and final velocity values
%   ts             - original acceleration start time
%   tau            - original time constant
%   car_id         - vehicle ID for labeling purposes
%
% Outputs:
%   None (generates a plot)
%
% Author: [Your Name], [Your Email]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[num_rows, num_col] = size(benchmark_data);

% Adjust time vector to match CruiseAuto's expected t_s = 5.0s
time_shift = 5.0 - ts;
adjusted_time = time_data + time_shift;

% Generate benchmark model (first-order response)
model_data = yL + (yH - yL) * (1 - exp(-(adjusted_time - 5.0) ./ tau));
model_data(adjusted_time < 5.0) = yL;  % Hold initial value before
% acceleration starts

% Define performance boundaries (±10% of tau)
tau_upper = tau * 1.1;
tau_lower = tau * 0.9;
upper_bound = yL + (yH - yL) * (1 - exp(-(adjusted_time - 5.0) ...
    ./ tau_lower));
lower_bound = yL + (yH - yL) * (1 - exp(-(adjusted_time - 5.0) ...
    ./ tau_upper));
upper_bound(adjusted_time < 5.0) = yL;
lower_bound(adjusted_time < 5.0) = yL;

% Plotting
figure(7 + car_id);
plot(adjusted_time, benchmark_data, 'b', 'LineWidth', 1.5);
hold on;
plot(adjusted_time, model_data, 'k--', 'LineWidth', 2);
plot(adjusted_time, upper_bound, 'r:', 'LineWidth', 1.5);
plot(adjusted_time, lower_bound, 'r:', 'LineWidth', 1.5);
grid on;

title(sprintf('Performance Boundaries - Car %d', car_id), 'FontSize', 14);
xlabel('Time (s)');
ylabel('Velocity (m/s)');
legend({'Benchmark Data', 'Adjusted Model', 'Performance Bounds'}, ...
    'Location', 'best');
xlim([0, max(adjusted_time)]);
ylim([min(benchmark_data)-1, max(benchmark_data)+1]);

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
