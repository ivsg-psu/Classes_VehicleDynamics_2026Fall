function h_plot = fcn_Laps_plotPointZoneDefinition(zone_definition,varargin)
% fcn_Laps_plotPointZoneDefinition
% Plots the point zone definition given by the input variable, zone_definition.
%
% Accepts as an optional second input standard plot style specifications,
% for example 'r-' for a red line.
%
% As optional third input, plots this in a user-specified figure. Returns
% the plot handle as the output.
%
% FORMAT:
%
%       h_plot = fcn_Laps_plotPointZoneDefinition(zone_definition, (plot_style), (figNum))
%
% INPUTS:
%
%      zone_definition: the definition of the zone as given in a point zone
%      style, namely:
%           [radius num_points X Y],
%      where X,Y denote the coordinates of the zone center, and radius is
%      the radius.
%
%      (OPTIONAL INPUTS)
%
%      plot_style: the standard plot pecification style allowing line and
%      color, for example 'r-'. Type "help plot" for a listing of options.
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed.
%
% OUTPUTS:
%
%      h: a handle to the resulting figure
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%
% EXAMPLES:
%
%       See the script: script_test_fcn_Laps_plotPointZoneDefinition.m for
%       a full test suite.
%
% This function was written on 2022_04_10 by S. Brennan
% Questions or comments? sbrennan@psu.edu

% REVISION HISTORY:
%
% 2022_04_10 by Sean Brennan, sbrennan@psu.edu
% - wrote the code
% 
% 2022_04_12 by Sean Brennan, sbrennan@psu.edu
% - fixed minor bug with showing the arrowhead
% 
% 2022_07_23 by Sean Brennan, sbrennan@psu.edu
% - made argument list consistent with segment zone
% - allow zone to be 2D or 3D
% - fixed minor bug with arrow being different color than line segment
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
        narginchk(1,MAX_NARGIN);

        % Check the zone_definition input, 4 or 5 columns, 1 row
        fcn_DebugTools_checkInputsToFunctions(zone_definition, '4or5column_of_numbers',[1 1]);

    end
end

% Check for plot style input
flag_plot_style_is_specified = 0; % Set default flag value
if 2 <= nargin
    temp = varargin{1};
    if ~isempty(temp)
        plot_style = temp;
        flag_plot_style_is_specified = 1;
    end
end

% Does user want to show the plots?
figNum = [];
flag_do_plots = 1; % Default is to show plots
if (0==flag_max_speed) && (MAX_NARGIN == nargin)
    temp = varargin{end};
    if ~isempty(temp) % Did the user NOT give an empty figure number?
        figNum = temp;
        flag_do_plots = 1;
    end
end

if isempty(figNum)
    temp_h = figure;
    figNum = temp_h.Number;
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

% Do the plot
radius  = zone_definition(1,1);
Xcenter = zone_definition(1,3);
Ycenter = zone_definition(1,4);

angles = (0:0.01:2*pi)';
x_circle = Xcenter + radius * cos(angles);
y_circle = Ycenter + radius * sin(angles);

%% Any debugging?
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

    % Prep the figure for plotting
    temp_h = figure(figNum);
    flag_rescale_axis = 0;
    if isempty(get(temp_h,'Children'))
        flag_rescale_axis = 1;
    end

    % Is this 2D or 3D?
    dimension_of_points = 2;

    % Find size of plotting domain
    allPoints = [Xcenter Ycenter; x_circle y_circle];
    max_plotValues = max(allPoints);
    min_plotValues = min(allPoints);
    sizePlot = max(max_plotValues) - min(min_plotValues);
    nudge = sizePlot*0.006; %#ok<NASGU>


    % Find size of plotting domain
    if flag_rescale_axis
        percent_larger = 0.1;
        axis_range = max_plotValues - min_plotValues;
        if (0==axis_range(1,1))
            axis_range(1,1) = 1/percent_larger;
        end
        if (0==axis_range(1,2))
            axis_range(1,2) = 1/percent_larger;
        end
        if dimension_of_points==3 && (0==axis_range(1,3))
            axis_range(1,3) = 1/percent_larger;
        end


        % Force the axis to be equal?
        if 1==0
            min_valuesInPlot = min(min_plotValues);
            max_valuesInPlot = max(max_plotValues);
        else
            min_valuesInPlot = min_plotValues;
            max_valuesInPlot = max_plotValues;

        end

        % Stretch the axes
        stretched_min_vertexValues = min_valuesInPlot - percent_larger.*axis_range;
        stretched_max_vertexValues = max_valuesInPlot + percent_larger.*axis_range;
        axesTogether = [stretched_min_vertexValues; stretched_max_vertexValues];
        newAxis = reshape(axesTogether, 1, []);
        axis(newAxis);

    end
    goodAxis = axis;

    % Check to see if hold is already on. If it is not, set a flag to turn it
    % off after this function is over so it doesn't affect future plotting
    flag_shut_hold_off = 0;
    if ~ishold
        flag_shut_hold_off = 1;
        hold on
    end

    axis equal

    % Plot the center point
    if flag_plot_style_is_specified
        h_plot{1} = plot(Xcenter,Ycenter,plot_style,'Markersize',20);
        set(h_plot{1},'Marker','+');
    else
        h_plot{1} = plot(Xcenter,Ycenter,'+','Markersize',20);
        main_color = get(h_plot{1},'Color');
    end

    % Plot circle in green
    if flag_plot_style_is_specified
        h_plot{2} = plot(x_circle,y_circle,plot_style,'Linewidth',2,'Markersize',20);
    else
        h_plot{2} = plot(x_circle,y_circle,'-','color',main_color,'Linewidth',2);
    end

    % Plot the radius arrow?
    if 1==0
        U = radius*cos(45*pi/180);
        V = radius*sin(45*pi/180);
        if flag_plot_style_is_specified
            h_plot{3} = quiver(Xcenter,Ycenter,U,V,0,plot_style,'Linewidth',2,'Markersize',20,'ShowArrowHead','on','MaxHeadSize',2);
        else
            h_plot{3} = quiver(Xcenter,Ycenter,U,V,0,'color',main_color,'Linewidth',2,'ShowArrowHead','on','MaxHeadSize',2);
        end
    end

    axis(goodAxis);

    % Shut the hold off?
    if flag_shut_hold_off
        hold off;
    end
end

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file);
end
end

