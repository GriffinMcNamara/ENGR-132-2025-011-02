function [avg_speed_data] = M3_sub2_011_02_catalan0(speed_data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This subfunction cleans noisy data using a moving average filter.
% It preserves all data points and handles NaN values gracefully.
%
% Function Call
% M3_sub2_011_02_catalan0
%
% Input Arguments
% speed_data
%
% Output Arguments
% avg_speed_data
%
% Assignment Information
%   Assignment:     M03, Problem 2
%   Team member:    catalan0, catalan0@purdue.edu 
%   Team ID:        011-02
%   Academic Integrity:
%     [] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION
[rows_size, column_size] = size(speed_data); 
avg_speed_data = nan(rows_size, column_size); 

%% ____________________
%% CALCULATIONS

% Moving average with window = 3, ignoring NaNs
window_size = 3;
half_window = floor(window_size / 2);

for col = 1:column_size
    for row = 1:rows_size
        % Define the window boundaries
        lower = max(1, row - half_window);
        upper = min(rows_size, row + half_window);
        
        window_vals = speed_data(lower:upper, col);
        window_vals = window_vals(~isnan(window_vals)); % exclude NaNs
        
        if ~isempty(window_vals)
            avg_speed_data(row, col) = mean(window_vals); 
        else
            avg_speed_data(row, col) = NaN;
        end
    end
end

% Additional optional smoothing (repeat pass)
repeat_passes = 1;

for pass = 1:repeat_passes
    for col = 1:column_size
        col_data = avg_speed_data(:, col);
        valid_idx = ~isnan(col_data);
        valid_data = col_data(valid_idx);

        smoothed = movmean(valid_data, 5, 'Endpoints', 'shrink');

        new_col = avg_speed_data(:, col); % Start with current data
        new_col(valid_idx) = smoothed;
        avg_speed_data(:, col) = new_col;
    end
end

% Final median filter to reduce spikes
median_window = 3;
half_window = floor(median_window / 2);

for col = 1:column_size
    col_data = avg_speed_data(:, col);
    new_col = nan(rows_size, 1);

    for i = 1:rows_size
        start_idx = max(1, i - half_window);
        end_idx = min(rows_size, i + half_window);

        window_data = col_data(start_idx:end_idx);
        window_data = window_data(~isnan(window_data));

        if ~isempty(window_data)
            new_col(i) = median(window_data);
        end
    end

    avg_speed_data(:, col) = new_col;
end

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.

