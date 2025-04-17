function [avg_speed_data] = M2_sub2_011_02_catalan0(speed_data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This subfunction is in charge of cleaning the noisy data by using moving
% averages and can handle any data point including points that are nan
%
% Function Call
% M2_sub2_011_02_catalan0
%
% Input Arguments
% speed_data
%
% Output Arguments
% avg_speed_data
%
% Assignment Information
%   Assignment:     M02, Problem 2
%   Team member:    catalan0, catalan0@purdue.edu 
%   Team ID:        011-02
%   Academic Integrity:
%     [] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ____________________
%% INITIALIZATION
[rows_size, column_size] = size(speed_data); %Assigns values to each 
                                             %variable which is the size of
                                             %the row or column.
avg_speed_data = nan(rows_size - 1, column_size); % We're only getting
                                                  % "size - 1" averages
%% ____________________
%% CALCULATIONS
for ii = 1:column_size
    for jj = 1:rows_size - 1 % Stops at second-to-last point so it stays in
                             % bounds, same reason as stated earlier
        if ~isnan(speed_data(jj,ii)) && ~isnan(speed_data(jj+1, ii))
            avg_speed_data(jj,ii) = ((speed_data(jj,ii) + speed_data(jj+1,ii)) / 2); 
            % Average of the two becomes new data point. We also use 
            % ~isnan because this actually returns a 1 or 0 that we can use
            % in our conditional statement
 
        else
            avg_speed_data(jj,ii) = (nan); 
            % If the value we are observing is nan then it just stays nan

        end 
    end 
end 

% Additional cleaning after initial moving average
repeat_passes = 2;          % Number of additional smoothing passes
median_window = 3;          % Median filter window size

for pass = 1:repeat_passes
    for col = 1:column_size
        col_data = avg_speed_data(:, col);
        valid_idx = ~isnan(col_data);
        valid_data = col_data(valid_idx);

        % Additional moving average smoothing
        smoothed = movmean(valid_data, 5, 'Endpoints', 'shrink');

        % Put the smoothed data back in place
        new_col = nan(rows_size - 1, 1);
        new_col(valid_idx) = smoothed;
        avg_speed_data(:, col) = new_col;
    end
end

% Custom median filtering to clean out remaining spikes
median_window = 3; % must be odd (3, 5, 7, etc.)
half_window = floor(median_window / 2);

for col = 1:column_size
    col_data = avg_speed_data(:, col);
    new_col = nan(size(col_data));

    for i = 1:length(col_data)
        % Define window boundaries
        start_idx = max(1, i - half_window);
        end_idx = min(length(col_data), i + half_window);

        % Extract window and remove NaNs
        window_data = col_data(start_idx:end_idx);
        window_data = window_data(~isnan(window_data));

        % Apply median if window isn't empty
        if ~isempty(window_data)
            new_col(i) = median(window_data);
        else
            new_col(i) = nan;
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



