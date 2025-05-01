function M4_performance_011_02(benchmark_data, time_data, yL, yH, ...
    ts, tau, car_id)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 - M4_performance_011_02
%
% Function to visualize benchmark data and performance boundaries
% adjusted for CruiseAuto's expected acceleration start time of 5.0 sec.
%
% Inputs:
%   benchmark_data - raw benchmark velocity data (vector)
%   time_data      - corresponding time vector (same length)
%   yL, yH         - initial and final velocity values (from parameter ID)
%   ts             - original acceleration start time (from parameter ID)
%   tau            - original time constant (from parameter ID)
%   car_id         - vehicle ID for labeling purposes
%
% Outputs:
%   None (generates a plot)
%
% Author: [Your Name], [Your Email]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CruiseAuto benchmark ts value
cruiseauto_ts = 5.0;

% Time adjustment to align ACC start time to CruiseAuto ts
adjusted_time = time_data + (cruiseauto_ts - ts);

% Adjusted model prediction using first-order step response
adjusted_model = yL + (yH - yL) .* (1 - exp(-(adjusted_time - ...
    cruiseauto_ts) ./ tau));

% Clip model before acceleration start
adjusted_model(adjusted_time < cruiseauto_ts) = yL;

% Define CruiseAuto performance bounds
% Left bound (most aggressive acceptable response)
ts_left = 4.50;
tau_left = 1.26;
yL_left = 1.10;
yH_left = 25.82;

% Right bound (most conservative acceptable response)
ts_right = 6.00;
tau_right = 3.89;
yL_right = -0.90;
yH_right = 23.36;

% Generate time vector aligned to CruiseAuto ts for bounds
bound_time = time_data + (cruiseauto_ts - ts);

% Calculate left and right bounds
left_bound = yL_left + (yH_left - yL_left) .* ...
    (1 - exp(-(bound_time - cruiseauto_ts) ./ tau_left));
right_bound = yL_right + (yH_right - yL_right) .* ...
    (1 - exp(-(bound_time - cruiseauto_ts) ./ tau_right));

% Clip bounds before ACC start
left_bound(bound_time < cruiseauto_ts) = yL_left;
right_bound(bound_time < cruiseauto_ts) = yL_right;

% Plot everything
figure;
hold on;
plot(bound_time, benchmark_data, 'k', 'LineWidth', 1.5); % Benchmark data
plot(adjusted_time, adjusted_model, 'b--', 'LineWidth', 2);% Adjusted model
plot(bound_time, left_bound, 'r:', 'LineWidth', 1.5);  % Left bound
plot(bound_time, right_bound, 'r:', 'LineWidth', 1.5);    % Right bound

xlabel('Time (s)');
ylabel('Speed (m/s)');
title(sprintf('Car %d: Model vs. CruiseAuto Bounds', car_id));
legend({'Benchmark Data', 'Adjusted Model', 'Left Bound', 'Right Bound'}, ...
       'Location', 'best');
grid on;

