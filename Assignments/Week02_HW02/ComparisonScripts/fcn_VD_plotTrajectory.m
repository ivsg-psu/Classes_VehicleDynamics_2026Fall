function h_plot = fcn_VD_plotTrajectory(trajectory, varargin)
%% fcn_VD_plotTrajectory
%   h_plot = fcn_VD_plotTrajectory plots XY trajectory.
%
% FORMAT:
%
%       h_plot = fcn_VD_plotTrajectory(trajectory, (figNum))
%
% INPUTS:
%
%     trajectory: an Nx2 vector representing [X Y] position
%
%     (OPTIONAL INPUTS)
%
%     figNum: a figure number to plot results.
%
% OUTPUTS:
%
%     h_plot: the plot handle
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
%     See the script: script_test_fcn_VD_plotTrajectory
%     for a full test suite.
%
% This function was written on 2021_08_13 by Satya Prasad and is maintained
% by Sean Brennan. Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
%
% 2021_08_13 by Satya Prasad, szm888@psu.edu
% - Wrote the code originally
% 
% 2026_01_27 by Sean Brennan, sbrennan@psu.edu
% - Fixed header formatting to standard form
% - Added plot handle output
% - Changed default color and linewidths to something more readable

% TO-DO:
%
% 2026_01_07 by Sean Brennan, sbrennan@psu.edu
% - Add items here

%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 2; % The largest Number of argument inputs to the function
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

        % Check the trajectory input to be sure it has 1 column and 1 row, positive
        fcn_DebugTools_checkInputsToFunctions(trajectory, '2column_of_mixed',[1 2]);

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
flag_do_plots = 1; % Default is to NOT show plots
figNum = [];
if (0==flag_max_speed) && (MAX_NARGIN == nargin) 
    temp = varargin{end};
    if ~isempty(temp) % Did the user NOT give an empty figure number?
        figNum = temp; 
        flag_do_plots = 1;
    end
end

if isempty(figNum)
    fig = figure;
    figNum = fig.Number;
end

%% Differential equation for 5-DOF model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _       
%  |  \/  |     (_)      
%  | \  / | __ _ _ _ __  
%  | |\/| |/ _` | | '_ \ 
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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

    h_fig = figure(figNum);
    set(h_fig, 'Name', 'fcn_VD_plotTrajectory');


    max_value = max(trajectory, [], 'all');
    min_value = min(trajectory, [], 'all');
    offset    = 0.1*(max_value-min_value);
    if 0 == offset
        offset = 0.5;
    end

    hold on

    h_plot = plot(trajectory(:,1),trajectory(:,2),'-','Linewidth',3, 'DisplayName','XY Trajectory');
    axis equal
    set(gca,'Fontsize',13)
    xlabel('East [m]','Interpreter','Latex','Fontsize',18)
    ylabel('North [m]','Interpreter','Latex','Fontsize',18)
    grid on
    legend('Interpreter','latex','Fontsize',13,...
        'NumColumns',1,'Location','best')

    ylim([min_value-offset max_value+offset])
    xlim([min_value-offset max_value+offset])


    
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



