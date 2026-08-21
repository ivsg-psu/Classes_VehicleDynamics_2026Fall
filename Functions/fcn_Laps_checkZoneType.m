function [flag_is_a_point_zone_type, new_zone_definition] = fcn_Laps_checkZoneType(zone_definition, string_label, varargin)
% fcn_Laps_checkZoneType
% Checks the type of zone, returns flag of 1 if a point zone, 0 if a
% segment zone, and in case of a 3D zone, returns the 2D zone equivalent
% (dropping the z-dimension)
%
% FORMAT:
%
%      [flag_is_a_point_zone_type, new_zone_definition] = ...
%      fcn_Laps_checkZoneType(zone_definition, string_label)
%
% INPUTS:
%
%      zone_definition: the zone being checked. See
%      fcn_Laps_breakDataIntoLapIndices for details.
%
%      string_label: a string naming the variable, used for reporting
%      mistakes
% 
%     (optional inputs)
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. 
%
% OUTPUTS:
%
%      flag_is_a_point_zone_type: 1 if it is a point zone, 0 otherwise.
%
%      new_zone_definition: the zone type in 2D (standard), in case user
%      gives it in 3D.
%
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
%     See the script: script_test_fcn_Laps_checkZoneType
%     for a full test suite.
%
% This function was written on 2022_07_23 by S. Brennan
% Questions or comments? sbrennan@psu.edu 

% REVISION HISTORY:
%
% 2022_07_23 by Sean Brennan, sbrennan@psu.edu
% - wrote the code originally
% 
% 2025_04_25 by Sean Brennan, sbrennan@psu.edu
% - added global debugging options
% 
% 2025_07_03 by Sean Brennan, sbrennan@psu.edu
% - cleanup of Debugging area codes
% - turn on fast mode for Path calls

% TO-DO:
%
% 2025_11_21 by Sean Brennan, sbrennan@psu.edu
% - (fill in items here)



%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 3; % The largest Number of argument inputs to the function
flag_max_speed = 0; % The default. This runs code with all error checking
if (nargin==MAX_NARGIN && isequal(varargin{end},-1))
    flag_do_debug = 0; % % % % Flag to plot the results for debugging
    flag_check_inputs = 0; % Flag to perform input checking
    flag_max_speed = 1;
else
    % Check to see if we are externally setting debug mode to be "on"
    flag_do_debug = 0; % % % % Flag to plot the results for debugging
    flag_check_inputs = 1; % Flag to perform input checking
    MATLABFLAG_LAPS_FLAG_CHECK_INPUTS = getenv("MATLABFLAG_LAPS_FLAG_CHECK_INPUTS");
    MATLABFLAG_LAPS_FLAG_DO_DEBUG = getenv("MATLABFLAG_LAPS_FLAG_DO_DEBUG");
    if ~isempty(MATLABFLAG_LAPS_FLAG_CHECK_INPUTS) && ~isempty(MATLABFLAG_LAPS_FLAG_DO_DEBUG)
        flag_do_debug = str2double(MATLABFLAG_LAPS_FLAG_DO_DEBUG);
        flag_check_inputs  = str2double(MATLABFLAG_LAPS_FLAG_CHECK_INPUTS);
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
        narginchk(2,MAX_NARGIN);

        % NOTE: zone types are checked below
    end
end

% Does user want to show the plots?
flag_do_plots = 0; % Default is to NOT show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
    temp = varargin{end};
    if ~isempty(temp) % Did the user NOT give an empty figure number?
        figNum = temp;
        flag_do_plots = 1;
    end
end

%% Main code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _
%  |  \/  |     (_)
%  | \  / | __ _ _ _ __
%  | |\/| |/ _` | | '_ \
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check if it is a point zone by seeing if it is a 4x1 or 5x1
try
    % Check if it is 4 or 5 columns with exactly 1 row?
    fcn_DebugTools_checkInputsToFunctions(zone_definition, '4or5column_of_numbers',[1 1]);
    
    % Check the zone_radius input is positive
    fcn_DebugTools_checkInputsToFunctions(zone_definition(1,1), 'positive_1column_of_numbers',[1 1]);
    
    % Check that the num_points field is an integer
    fcn_DebugTools_checkInputsToFunctions(zone_definition(1,2), 'positive_1column_of_integers',1);
    
    % If got here - it should be a point_zone!
    flag_is_a_point_zone_type = 1;
    
    % Set the zone values to limits of 2D
    new_zone_definition = zone_definition; % default case
    if isequal(size(zone_definition),[1 5])
        warning('backtrace','on');
        warning('The Laps code zone types do not yet support 3D zone definitions. The %s zone, specified as a 3D point, is being flattened into 2D by ignoring the z-axis value.', string_label);
        new_zone_definition = zone_definition(1,1:4);
    end
    
    
catch
    % Check that the zone_definition is in the segment format
    % [X_start Y_start; X_end Y_end],
    % or 3D version of same:
    % [X_start Y_start Z_start; X_end Y_end Z_end],
    
    try
        % Check that the input has either 2 or 3 columns with exactly 2
        % rows?
        fcn_DebugTools_checkInputsToFunctions(zone_definition, '2or3column_of_numbers',[2 2]);
        
    catch
        error('The %s input must be a zone type: either a 4x1 or 5x1 variable in the case of a point zone, or a 2x2 or 3x2 variable in the case of a segment zone. Type ''help fcn_Laps_breakDataIntoLapIndices'' for more details.', string_label);
    end
    
    % If got here - it should be a segment_zone!
    flag_is_a_point_zone_type = 0;
    
    % Set the zone values to limits of 2D
    new_zone_definition = zone_definition; % default case
    if isequal(size(zone_definition),[2 3])
        warning('backtrace','on');
        warning('The Laps code zone types do not yet support 3D zone definitions. The input zone, specified as a 3D point, is being flattened into 2D by ignoring the z-axis value.');
        new_zone_definition = zone_definition(1:2,1:2);
    end
    
    
end



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
    
    % Nothing to plot        
    
end

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
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
