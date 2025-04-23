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
%% INITIAL GUESS SETUP

% Estimate yL and yH from velocity data
yL_guess = min(real_data);
yH_guess = max(real_data);

% Rough guess of when the velocity starts increasing
[~, idx_start] = max(diff(real_data));
ts_guess = data_time(idx_start);

% Initial guess for time constant
tau_guess = 1;

% Parameter vector: [yL, yH, t_s, tau]
params = [yL_guess, yH_guess, ts_guess, tau_guess];

% Extract parameters for clarity
yL = params(1);
yH = params(2);
ts = params(3);
tau = params(4);

% Preallocate output
y = zeros(size(data_time));

% Region 1: t < ts → constant yL
region1 = data_time < ts;
y(region1) = yL;

% Region 2: t >= ts → exponential approach to yH
region2 = ~region1;
y(region2) = yL + (yH - yL) * (1 - exp(-(data_time(region2) - ts) / tau));
