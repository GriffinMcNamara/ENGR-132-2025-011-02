function [clean_avg_speed_data] = M3_sub2_011_02_catalan0(speed_data)
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
%     Peers we worked with: Griffin McNama, McNama36@purdue.edu
%                           Shrey Panicker, panickes@purdue.edu
%                           Aidan Policelli, apolicel@purdue.ed
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
            avg_speed_data(jj,ii) = ((speed_data(jj,ii) + ...
                speed_data(jj+1,ii)) / 2); 
            % Average of the two becomes new data point. We also use 
            % ~isnan because this actually returns a 1 or 0 that we can use
            % in our conditional statement
 
        else
            avg_speed_data(jj,ii) = (nan); 
            % If the value we are observing is nan then it just stays nan

        end 
    end 
end 

%% POST-PROCESSING: Replace remaining NaNs with column average
for ii = 1:column_size
    % Calculate the average of non-NaN values for the column
    nonNanVals = avg_speed_data(:,ii);
    nonNanVals = nonNanVals(~isnan(nonNanVals));
    if ~isempty(nonNanVals)
        colAvg = mean(nonNanVals);
        % Replace NaNs in that column with the computed column average
        nanIndices = isnan(avg_speed_data(:,ii));
        avg_speed_data(nanIndices, ii) = colAvg;
    end
end

% Adjust the polynomial order and frame length as needed.
polyOrder = 3; 
frameLength = 121;  % Must be an odd number
clean_avg_speed_data = sgolayfilt(avg_speed_data, polyOrder, frameLength);

% 'rloess' uses a robust version to minimize the influence of outliers.
clean_avg_speed_data = smooth(clean_avg_speed_data, frameLength, 'rloess');  

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.
