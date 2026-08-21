function [finalTime, finalStates] = fcn_VD_RungeKutta(inputFunction, ...
                                      initialStates, initialTime, ...
                                      timeInterval, varargin)
%% fcn_VD_RungeKutta
%   This function calculates 'finalStates' by integrating the
%   'inputFunction' using Runge-Kutta 4th Order and using
%   'initialStates', 'initialTime', and 'timeInterval'.
%
% FORMAT:
%
%   [finalTime, finalStates] = fcn_VD_RungeKutta(inputFunction, ...
%                                initialStates, initialTime, ...
%                                timeInterval, (figNum))
%
% INPUTS:
%
%      inputFunction: A function handle.
%
%      initialStates: The initial value of the states. The size of output
%      states will be same as the input states.
%
%      initialTime: Time related to 'initialStates'.
%
%      timeInterval: Time interval.
%
% OUTPUTS:
%
%      finalTime: Final time is sum of initial time and time interval.
%
%      finalStates: Output states.
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
%     See the script: script_test_fcn_VD_RungeKutta
%     for a full test suite.
%
% This function was written on 2021_05_16 by Satya Prasad and maintained by
% Sean Brennan
% Questions or comments? sbrennan@psu.edu


% REVISION HISTORY:
%
% 2021_05_16 by Satya Prasad, szm888@psu.edu
% - First write of function
%
% 2026_01_31 by Sean Brennan, sbrennan@psu.edu
% - In fcn_VD_RungeKutta
%   % * Fixed function header to match standard format
%   % * Fixed debugging and input checking
%   % * Fixed variable names to match standard form
%   % * Changed input checking to avoid use of checkInputsToFunctions


% TO-DO:
% - 2026_01_31 by Sean Brennan, sbrennan@psu.edu
%   % (add items here)

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 5; % The largest Number of argument inputs to the function
flag_max_speed = 0; % The default. This runs code with all error checking
if (nargin==MAX_NARGIN && isequal(varargin{end},-1))
    flag_do_debug = 0; % Flag to plot the results for debugging
    flag_check_inputs = 0; % Flag to perform input checking
    flag_max_speed = 1;
else
    % Check to see if we are externally setting debug mode to be "on"
    flag_do_debug = 0; % Flag to plot the results for debugging
    flag_check_inputs = 1; % Flag to perform input checking
    MATLABFLAG_VD_FLAG_CHECK_INPUTS = getenv("MATLABFLAG_VD_FLAG_CHECK_INPUTS");
    MATLABFLAG_VD_FLAG_DO_DEBUG = getenv("MATLABFLAG_VD_FLAG_DO_DEBUG");
    if ~isempty(MATLABFLAG_VD_FLAG_CHECK_INPUTS) && ~isempty(MATLABFLAG_VD_FLAG_DO_DEBUG)
        flag_do_debug = str2double(MATLABFLAG_VD_FLAG_DO_DEBUG);
        flag_check_inputs  = str2double(MATLABFLAG_VD_FLAG_CHECK_INPUTS);
    end
end

% flag_do_debug = 1;

if flag_do_debug % If debugging is on, print on entry/exit to the function
    st = dbstack; %#ok<*UNRCH>
    fprintf(1,'STARTING function: %s, in file: %s\n',st(1).name,st(1).file);
    debug_figNum = 999978; %#ok<NASGU>
else
    debug_figNum = []; %#ok<NASGU>
end

%% check input arguments?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____                   _
%  |_   _|                 | |
%    | |  _ __  _ __  _   _| |_ ___
%    | | | '_ \| '_ \| | | | __/ __|
%   _| |_| | | | |_) | |_| | |_\__ \
%  |_____|_| |_| .__/ \__,_|\__|___/
%              | |
%              |_|
% See: http://patorjk.com/software/taag/#p=display&f=Big&t=Inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0==flag_max_speed
	if flag_check_inputs
		% Are there the right number of inputs?
		narginchk(MAX_NARGIN-1,MAX_NARGIN);

		% Validate that the inputFunction input is a function handle
		if ~isa(inputFunction,'function_handle')
			error('The %s input must be function handle', variable_name);
		end

		 % Validate that the initialStates input has 1 column, 1+ rows
        fcn_DebugTools_checkInputsToFunctions(initialStates, '1column_of_numbers',[1 2]);

		% Check the initialTime input to be sure it has 1 col, 1 row
        fcn_DebugTools_checkInputsToFunctions(initialTime, '1column_of_numbers',[1 1]);

		% Check the timeInterval input to be sure it has 1 col, 1 row, positive
		fcn_DebugTools_checkInputsToFunctions(timeInterval, 'positive_1column_of_numbers',[1 1]);

	end
end


% 
%   Set the start values
% [flag_start_is_a_point_type, start_zone_definition] = fcn_Laps_checkZoneType(start_zone_definition, 'start_definition', -1);
% 
% 
%   The following area checks for variable argument inputs (varargin)
% 
%   Does the user want to specify the end_definition?
%   Set defaults first:
% end_zone_definition = start_zone_definition; % Default case
% flag_end_is_a_point_type = flag_start_is_a_point_type; % Inheret the start case
%   Check for user input
% if 3 <= nargin
%     temp = varargin{1};
%     if ~isempty(temp)
%         % Set the end values
%         [flag_end_is_a_point_type, end_zone_definition] = fcn_Laps_checkZoneType(temp, 'end_definition', -1);
%     end
% end
% 
%   Does the user want to specify excursion_definition?
% flag_use_excursion_definition = 0; % Default case
% flag_excursion_is_a_point_type = 1; % Default case
% if 4 <= nargin
%     temp = varargin{2};
%     if ~isempty(temp)
%         % Set the excursion values
%         [flag_excursion_is_a_point_type, excursion_definition] = fcn_Laps_checkZoneType(temp, 'excursion_definition',-1);
%         flag_use_excursion_definition = 1;
%     end
% end

% Does user want to show the plots?
flag_do_plots = 0; % Default is to NOT show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
    temp = varargin{end};
    if ~isempty(temp) % Did the user NOT give an empty figure number?
        figNum = temp; %#ok<NASGU>
        flag_do_plots = 1;
    end
end


%% Implements Bicycle Model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _       
%  |  \/  |     (_)      
%  | \  / | __ _ _ _ __  
%  | |\/| |/ _` | | '_ \ 
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
finalTime = initialTime+timeInterval;  % find the final time

k1 = inputFunction(initialTime, initialStates);
k2 = inputFunction(initialTime+timeInterval/2, ...
                    initialStates+(timeInterval/2)*k1);
k3 = inputFunction(initialTime+timeInterval/2, ...
                    initialStates+(timeInterval/2)*k2);
k4 = inputFunction(finalTime, initialStates+timeInterval*k3);
finalStates = initialStates + (timeInterval/6)*(k1 + 2*k2 +2*k3 + k4);


%% Plot the results (for debugging)?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   _____       _
%  |  __ \     | |
%  | |  | | ___| |__  _   _  __ _
%  | |  | |/ _ \ '_ \| | | |/ _` |
%  | |__| |  __/ |_) | |_| | (_| |
%  |_____/ \___|_.__/ \__,_|\__, |
%                            __/ |
%                           |___/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if flag_do_plots
    % Add items here

end

if flag_do_debug
    fprintf(1, 'ENDING function: %s, in file: %s\n\n', st(1).name, st(1).file);
end

end % Ends main function

%% Functions follow
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   ______                _   _
%  |  ____|              | | (_)
%  | |__ _   _ _ __   ___| |_ _  ___  _ __  ___
%  |  __| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
%  | |  | |_| | | | | (__| |_| | (_) | | | \__ \
%  |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
%
% See: https://patorjk.com/software/taag/#p=display&f=Big&t=Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%§

