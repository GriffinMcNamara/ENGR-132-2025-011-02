function y = M3_benchmark_sub_1_011_02_McNama36(real_data, data_time)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 - Exponential Model Function
%
% Function Description:
%   This function evaluates a piecewise exponential model:
%     y(t) = yL                         for t < ts
%          = yL + (yH - yL)(1 - exp(-(t - ts)/tau))  for t >= ts
%
% Function Call:
%   y = exp_model_eval(params, t)
%
% Input Arguments:
%   params - A 1x4 vector of parameters:
%            params(1) = yL   (low value)
%            params(2) = yH   (high value)
%            params(3) = ts   (acceleration start time)
%            params(4) = tau  (time constant)
%   t      - Time vector (can be scalar or array)
%
% Output Arguments:
%   y      - Vector of y-values evaluated at each time t
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION
n = numel(data_time);

%% INITIAL GUESS SETUP

% Estimate yL and yH from velocity data
yL_guess = min(real_data);
yH_guess = max(real_data);

% Rough guess of when the velocity starts increasing
[~, idx_start] = max(diff(real_data));
ts_guess = data_time(idx_start);

% Initial guess for time constant
tau_guess = 1;

% Extract parameters for clarity
yL = yL_guess;
yH = yH_guess;
ts = ts_guess;
tau = tau_guess;

% Preallocate output
y = zeros(size(data_time));

for i = 1:n
    if data_time(i) < ts
        % Region 1: before start time, hold at yL
        y(i) = yL;
    else
        % Region 2: after start time, exponential rise toward yH
        y(i) = yL + (yH - yL) * (1 - exp(-(data_time(i) - ts) / tau));
    end
end
