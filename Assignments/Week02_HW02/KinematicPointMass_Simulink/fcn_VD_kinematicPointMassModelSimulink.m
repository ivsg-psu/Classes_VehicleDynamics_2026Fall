function [stateTrajectory, t, steeringUsed] = fcn_VD_kinematicPointMassModelSimulink(initialStates, deltaT, timeInterval, steeringAndTimeInputs, U, varargin)

%% fcn_VD_kinematicPointMassModelSimulink
%   Simulates the point-mass kinematic model using Simulink
%
% FORMAT:
%
%      [stateTrajectory, t, steeringUsed] =
%      fcn_VD_kinematicPointMassModelSimulink(initialStates, deltaT,
%      timeInterval, steeringAndTimeInputs, U, (figNum))
%
% INPUTS:
%
%      initialStates: A 1x3 vector of inital global pose in form of
%         [X Y Phi], which stand for:
% 
%         X: Global X position in meters
%
%         Y: Global Y position in meters
%
%         phi: Global yaw angle in radians, measured positive from X axis
%         to Y axis
%
%      deltaT: a 1x1 positive number denoting the time step to use, in
%      seconds
%
%      timeInterval: a 1x2 vector denoting [startTime endTime] in seconds
%
%      steeringAndTimeInputs: a Mx2 vector denoting 
%      [steeringTime steeringValues] 
%      in units of [sec rad] respectively. This is interpolated using
%      linear interpolation at the sampling times. For times outside the
%      given interval, zero values are used.
%
%      U: A 1x1 positive numeric value representing the longitudinal
%      velocity, in [m/s]
%
%      (OPTIONAL INPUTS)
%
%      figNum: a FID number to print results. If set to -1, skips any
%      input checking or debugging, no prints will be generated, and sets
%      up code to maximize speed.
%
% OUTPUTS:
%
%      stateTrajectory: An Nx3 vector of the state trajectory, with the
%      columns as [X Y Phi] in units of [m],[m],[rad]
%
%      t: An Nx1 vector of the simulation times, in seconds
%
%      steeringUsed: An Nx1 vector of the steering values used in the sim,
%      in units of [rad]
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%      fcn_VD_kinematicPointMassModel
%
% EXAMPLES:
%
%     See the script: script_test_fcn_VD_kinematicPointMassModelSimulink
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
% As: fcn_VD_kinematicPointMassModelSimulink
%
% 2026_01_31 by Sean Brennan, sbrennan@psu.edu
% - In fcn_VD_kinematicPointMassModelSimulink
%   % * Renamed function to indicate that it is for derivatives only
%   % * Improved header comments
%   % * Fixed input checking to use DebugTools
%
% 2026_02_01 by Sean Brennan, sbrennan@psu.edu
% - In fcn_VD_kinematicPointMassModelSimulink
%   % * Added a Simulink-based interface and multiple release-specific
%   %   % model files, plus a test script, and a small MATLAB plot fix.
%   % * Added fcn_VD_kinematicPointMassModelSimulink.m: Simulink-based
%   %   % simulation wrapper that runs the appropriate release SLX, extracts
%   %   % outputs, and plots results.
%   % * Added many versioned SLX files (R2018b through R2025b) under
%   %   % KinematicPointMass_Simulink and a top-level
%   %   % mdl_VD_KinematicPointMassModel_2024b.slx.

% TO-DO:
% - 2026_01_26 by Sean Brennan, sbrennan@psu.edu
%   % (add items here)

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 6; % The largest Number of argument inputs to the function
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

        % Validate that the initialStates input has 3 column, 1 row
        fcn_DebugTools_checkInputsToFunctions(initialStates, '3column_of_numbers',[1 1]);

        % Validate that the deltaT input has 1 column, 1 row
        fcn_DebugTools_checkInputsToFunctions(deltaT, '1column_of_numbers',[1 1]);

        % Validate that the timeInterval input has 2 columns, 1 row
        fcn_DebugTools_checkInputsToFunctions(timeInterval, '2column_of_numbers',[1 1]);

        % Validate that the steeringAndTimeInputs input has 2 columns, 2+
		% rows
        fcn_DebugTools_checkInputsToFunctions(steeringAndTimeInputs, '2column_of_numbers',[2 3]);

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
%% RK4 in MATLAB Script
startTime = timeInterval(1);
endTime = timeInterval(2);
simulationTimes = (startTime:deltaT:endTime)';
N_timeSteps = length(simulationTimes); % This is the number of time steps we should have


% Which model to use? Depends on the version
currentMATLABversion = version('-release');

% ONLY for saving (used by Dr. B). Set 1==0 to 1==1 to convert into all
% possible earlier versions 
if 1==0
	nameRootString = 'mdl_VD_KinematicPointMassModel';
	thisVersionName = cat(2,nameRootString,'_R2025b_SLX');
	thisVersionNameWithExtension = cat(2,thisVersionName,'.slx');
	load_system(thisVersionNameWithExtension);
	simulinkFileInfo = Simulink.MDLInfo(thisVersionNameWithExtension);

	% Confirm that this is 2025b
	if ~strcmpi(simulinkFileInfo.ReleaseName,'R2025b')
		error('Expected release version 2025b, but found %s instead. Exiting!',info.ReleaseName);
	end


	thisVersionFullPath = which(thisVersionName);
	folderPath = fileparts(thisVersionFullPath);
	exportVersionList = {
		'R2025a_SLX';
		'R2024b_SLX';
		'R2024a_SLX';
		'R2023b_SLX';
		'R2023a_SLX';
		'R2022b_SLX';
		'R2022a_SLX';
		'R2021b_SLX';
		'R2021a_SLX';
		'R2020b_SLX';
		'R2020a_SLX';
		'R2019b_SLX';
		'R2019a_SLX';
		'R2018b_SLX';
		};
	for ith_version = 1:length(exportVersionList)
		olderVersion = exportVersionList{ith_version};
		olderVersionName = cat(2,nameRootString,'_',olderVersion,'.slx');
		olderVersionFullPath = fullfile(folderPath,olderVersionName);
		fprintf(1,'Converting:\n\tFrom: %s\n\tTo: %s\n',thisVersionName,olderVersionName);

		% Call a special command to convert from current version to older
		% version
		exportResult = Simulink.exportToVersion(thisVersionName,olderVersionFullPath,olderVersion,'AllowPrompt',true,'BreakUserLinks',true);

		% Make sure export worked
		if ~strcmp(exportResult,olderVersionFullPath)
			error('Export failed!');
		end
	end
end
modelToUse = cat(2,'mdl_VD_KinematicPointMassModel_R',currentMATLABversion,'_SLX.slx');


% Run the simulation in SIMULINK
simout = sim(modelToUse);

% Save the results in a big array (for plotting in next part)
% Before saving, we need to check if the full vector is shorter than
% expected length of N_timeSteps
N_simSteps = length(simout.simTime);
if  N_simSteps~= N_timeSteps
	warning('More time was spent (N=%.0f time steps) than expected (expected %.0f time steps) in the simulation. Keeping only the expected time portion.', N_simSteps,N_timeSteps);
end

% Keep the shorter of either the actual length, or expected length:
shorter_index = min(N_timeSteps,N_simSteps);

% Initialize variables
stateTrajectory = nan(shorter_index,3);
t = nan(shorter_index,1);

% Fill in the results to save
t(:,1)                 = simout.simTime(1:shorter_index,1); % Update time
steeringUsed           = simout.steeringUsed(1:shorter_index,1);
stateTrajectory(:,1)   = simout.X(1:shorter_index,1);
stateTrajectory(:,2)   = simout.Y(1:shorter_index,1);
stateTrajectory(:,3)   = simout.phi(1:shorter_index,1);



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
    
    % plot the outputs
    h_plot = fcn_VD_plotTrajectory(stateTrajectory(:,1:2),(figNum));
	set(h_plot,'DisplayName','XY Trajectory (Simulink RK4)')

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

