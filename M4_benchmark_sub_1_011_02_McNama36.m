function y = M4_benchmark_sub_1_011_02_McNama36(real_data, data_time, ...
    yL, yH, ts, tau)
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
%     [] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: John Catalan, catalan0@purdue.edu
%                           Shrey Panicker, panickes@purdue.edu
%                           Aidan Policelli, apolicel@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION
n = numel(data_time);

%% INITIAL GUESS SETUP

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
