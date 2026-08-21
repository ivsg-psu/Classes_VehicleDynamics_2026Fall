function dydt = fcn_VD_derivativesKinematicPointMassModel( y, inputOmega, U, varargin)

%% fcn_VD_derivativesKinematicPointMassModel
%   Fill in the state derivatives for the point-mass kinematic model
%
% FORMAT:
%
%      dydt = fcn_VD_derivativesKinematicPointMassModel( y, inputOmega, U, (figNum))
%
% INPUTS:
%
%      y: A 3x1 vector of velocities and global pose in the form of 
%         [X; Y; Phi], which stand for:
% 
%         X: Global X position in meters
%
%         Y: Global Y position in meters
%
%         phi: Global yaw angle in radians, measured positive from X axis
%         to Y axis
%
%      inputOmega: the rate of change of the yaw angle of the vehicle (input: rad/sec)
%
%      U: Longitudinal velocity [m/s]
%
%      (OPTIONAL INPUTS)
%
%      figNum: a FID number to print results. If set to -1, skips any
%      input checking or debugging, no prints will be generated, and sets
%      up code to maximize speed.
%
% OUTPUTS:
%
%   dydt: A 3x1 vector of linear velocities and rotational velocities
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
%     See the script: script_test_fcn_VD_derivativesKinematicPointMassModel
%     for a full test suite.
%
% This function was written on 2026_01_26 
% by Sean Brennan. Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
%
% As: fcn_VD_kinematicPointMassModel
%
% 2026_01_26 by Sean Brennan, sbrennan@psu.edu
% - First write of function, using fcn_VD_bicycle2dofModel as starter
%
% As: fcn_VD_derivativesKinematicPointMassModel
%
% 2026_01_31 by Sean Brennan, sbrennan@psu.edu
% - In fcn_VD_derivativesKinematicPointMassModel
%   % * Renamed function to indicate that it is for derivatives only
%   % * Improved header comments


% TO-DO:
% - 2026_01_26 by Sean Brennan, sbrennan@psu.edu
%   % (add items here)

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 4; % The largest Number of argument inputs to the function
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

        % Check the y input to be sure it has 1 column, 3 rows
        fcn_DebugTools_checkInputsToFunctions(y, '1column_of_numbers',[3 3]);

        % Check the inputOmega input to be sure it has 1 column and 1 row
        fcn_DebugTools_checkInputsToFunctions(inputOmega, '1column_of_numbers',[1 1]);

        % Check the U input to be sure it has 1 col, 1 row, positive
        fcn_DebugTools_checkInputsToFunctions(U, 'positive_1column_of_numbers',[1 1]);

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
        figNum = temp; 
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
X = y(1);
Y = y(2);
theta = y(3); % Yaw angle of the vehicle

%% Newtonian Dynamics of CG
DvelDt = [U*cos(theta); U*sin(theta)];

%% Pose dynamics
DposeDt = inputOmega;

%% Output
dydt = [DvelDt; DposeDt];

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
    
    % plot the derivative outputs as a vector
    figure(figNum);

	quiver(X,Y,DvelDt(1), DvelDt(2), 0);
	hold on;
	axis equal;
	axis padded;

	% Plot the rotation. this is done by putting a small, grey vector at
	% the end that points in the direction and magnitude of the rotation.
	rotationAngle = inputOmega;
	changeVector = [DvelDt(1) DvelDt(2)];
	newChange = changeVector*[cos(rotationAngle) sin(rotationAngle); -sin(rotationAngle) cos(rotationAngle)];
	rotationStartPoint = [X Y]+changeVector;
	rotationEndPoint = [X Y]+newChange;
	differenceVector = rotationEndPoint - rotationStartPoint;
	quiver(rotationStartPoint(1),rotationStartPoint(2), differenceVector(1), differenceVector(2),0,'Color',0.8*[1 1 1]);


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

