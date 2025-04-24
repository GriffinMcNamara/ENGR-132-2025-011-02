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
figure;
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

end
