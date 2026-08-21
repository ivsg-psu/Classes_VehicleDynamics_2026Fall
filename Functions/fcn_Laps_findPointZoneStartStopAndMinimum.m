function [zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...    
    varargin)

% fcn_Laps_findPointZoneStartStopAndMinimum
% Given a path and a point zone definition defined by a point center and
% radius, finds the indices in the path for each crossing of the zone,
% noting where in the path the zone starts, where it ends, and the minimum
% index for the zone definition.  A zone is the region meeting a
% user-defined distance criteria wherein the path enters the zone
% sufficiently to consider that the path has crossed through the zone.
%
% A point zone is defined by the center of the zone specified as a point,
% typically [X Y] wherein X and Y specify the XY coordinates for the point,
% and a zone radius specifies the radius from the point that the path must
% pass for the condition to be met. A zone condition is met if the path
% crosses within the zone with enough points STRICTLY within the zone (e.g.
% not on the boundary, but within). The default number of points is 3; this
% can be changed per the options below.
% 
% For each time a path goes through the zone definition, the start, end,
% and minimum-distance indices of the path are determined and are returned
% by this function. These are defined as follows:
%    * The start of the zone is the index of the first point strictly
%    within the zone.
%    * The end of the zone is the index of the last point strictly still
%    within the zone immediately after the previous start
%    * The minimum-distance is the index that, of the part of the path
%    within the zone after the most previous start, is the minimum distance
%    to the center point of the zone.
% 
% As an option, the user can specify the num_points for a zone definition.
% The variable num_points forces the path to have at least num_points
% points inside the given area for the zone condition to be met. The
% default is 3. The purpose of this input is to prevent situations
% where noisy data, from GPS jumps for example, to cause a path to
% suddenly jump into and then out of a zone definition, accidentally
% registering as a zone entry. By requriing a minimum number of points, the
% accidentally triggering of a zone by random noise can be avoided.
%
% If a path crosses through a zone repeatedly, the start/end/minimum is
% recorded for each path through the zone as another row. Thus, if a path
% crosses through the zone M times (and each time meets the criteria), the
% start, end, and minimum indices will be an M x 1 column.
%
% FORMAT:
%
%      [zone_start_indices, zone_end_indices, zone_min_indices] = ...
%      fcn_Laps_findPointZoneStartStopAndMinimum(...
%      query_path,...
%      zone_center,...
%      zone_radius,...  
%      (minimum_number_of_indices_in_zone),...
%      (figNum))
%
% INPUTS:
%
%      query_path: the path, in format [X Y] where the matrix is [N by 2].
%      The path definition here is consistent with the Paths library of
%      functions. Note: the function does not yet support 3D paths but can
%      easily be modified for this.
%
%      zone_center: the condition, defined as a point/radius defining
%      the zone. The format is zone_center = [X Y] or [X Y Z], and is
%      expected to be a [1 x 2] or a [1 x 3] matrix, 
%
%      zone_radius: a scalar specifying the radius of the zone. 
% 
%      (OPTIONAL INPUTS)
%
%      minimum_number_of_indices_in_zone: the number of points in a path
%      that must consecutively be within a zone, for the zone condition to
%      be met.
%
%      figNum: a figure number to plot results. If set to -1, skips any
%      input checking or debugging, no figures will be generated, and sets
%      up code to maximize speed. 
%
% OUTPUTS:
%
%      zone_start_indices: an array of [M x 1] of the indices where each of
%      the M zones starts. If no zones are detected, the array is empty.
%
%      zone_end_indices: an array of [M x 1] of the indices where each of
%      the M zones ends. If no zones are detected, the array is empty.
%
%      zone_min_indices: an array of [M x 1] of the indices where each of
%      the M zones has a minimum distance to the point criteria. If no
%      zones are detected, the array is empty.
%
% DEPENDENCIES:
%
%      fcn_DebugTools_checkInputsToFunctions
%      fcn_Laps_plotPointZoneDefinition
%
% EXAMPLES:
%
%     See the script: script_test_fcn_Laps_findPointZoneStartStopAndMinimum
%     for a full test suite.
%
% This function was written on 2022_04_08 by S. Brennan
% Questions or comments? sbrennan@psu.edu 

% REVISION HISTORY:
%
% 2022_04_08 by Sean Brennan, sbrennan@psu.edu
% - Wrote the code originally
% 
% 2022_07_10 by Sean Brennan, sbrennan@psu.edu
% - Improved the comments
% - Changed zone definition to allow num_points in the zone
%   % definition, separating out radius, and allowing 3-D paths
% 
% 2025_04_25 by Sean Brennan, sbrennan@psu.edu
% - Added global debugging options
% 
% 2025_07_03 by Sean Brennan, sbrennan@psu.edu
% - Cleanup of Debugging area codes
% - Turn on fast mode for Path calls

% TO-DO:
%
% 2025_11_21 by Sean Brennan, sbrennan@psu.edu
% - (fill in items here)



%% Debugging and Input checks

% Check if flag_max_speed set. This occurs if the figNum variable input
% argument (varargin) is given a number of -1, which is not a valid figure
% number.
MAX_NARGIN = 5; % The largest Number of argument inputs to the function
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
        narginchk(3,MAX_NARGIN);

        % Check the query_path input, 2 or 3 columns, 1 or more rows
        fcn_DebugTools_checkInputsToFunctions(query_path, '2or3column_of_numbers',[1 2]);

        % Check the zone_center input, 2 or 3 columns, 1 row
        fcn_DebugTools_checkInputsToFunctions(zone_center, '2or3column_of_numbers',[1 1]);

        % Check the zone_radius input, 1 column, 1 row
        fcn_DebugTools_checkInputsToFunctions(zone_radius, 'positive_1column_of_numbers',[1 1]);

    end
end
       
% Check for variable argument inputs (varargin)
minimum_number_of_indices_in_zone = 3; % Set default value
if 4 <= nargin
    temp = varargin{1};
    if ~isempty(temp)
        minimum_number_of_indices_in_zone = temp;
        if flag_check_inputs
            fcn_DebugTools_checkInputsToFunctions(minimum_number_of_indices_in_zone, 'positive_1column_of_integers',1);
        end
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

%% Main code starts here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   __  __       _
%  |  \/  |     (_)
%  | \  / | __ _ _ _ __
%  | |\/| |/ _` | | '_ \
%  | |  | | (_| | | | | |
%  |_|  |_|\__,_|_|_| |_|
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set default values
zone_min_indices = [];
zone_start_indices = [];
zone_end_indices = [];

% Among these points, find the minimum distance index. The minimum cannot
% be the first or last point.
distances_to_zone = sum((query_path - zone_center(1,1:2)).^2,2).^0.5;
in_zone = distances_to_zone<zone_radius;

% For debugging:
if flag_do_debug
    fprintf('\nIndex\tIn_zone\n');
    for ith_index = 1:length(in_zone)
        fprintf(1,' %d\t\t %d\n',ith_index, in_zone(ith_index));
    end
end


% Take the diff of the in_zone indices to find transitions in and out of
% zones. 
transitions_into_zone = find(diff([0; in_zone])>0);
transitions_outof_zone = find(diff([in_zone;0])<0);

% Check each of the zones to see if they are empty, and if not, whether
% they are of correct length
num_zones = length(transitions_into_zone);

% Are zones empty?
if num_zones ~= 0  % empty
    % Due to the construciton of zones, we expect the number of entries
    % into the zones to match the number of exits. There shouldn't be any
    % situations where they don't match, but check for this just in case.
    if length(transitions_into_zone)~=length(transitions_outof_zone)
        error('Unexpected mismatch in zone sizes!');
    else
        zone_widths = transitions_outof_zone - transitions_into_zone + 1;
        good_zones = find(zone_widths>=minimum_number_of_indices_in_zone);
                
        % For each good zone, fill in start and stop indices
        num_good_zones = length(good_zones);
        zone_start_indices = zeros(num_good_zones,1); % Set defaults
        zone_end_indices   = zeros(num_good_zones,1); % Set defaults
        for ith_zone = 1:num_good_zones
            good_index = good_zones(ith_zone);
            zone_start_indices(ith_zone,:) = transitions_into_zone(good_index,1); 
            zone_end_indices(ith_zone,:) = transitions_outof_zone(good_index,1);            
        end
    end % Ends if check that the zone starts and ends match

    if num_good_zones~=0
       
        % Find the minimum in the zones
        zone_min_indices = zeros(num_good_zones,1); % Set defaults
        for ith_zone = 1:num_good_zones
            distances_inside = distances_to_zone(zone_start_indices(ith_zone,1):zone_end_indices(ith_zone,1));
            [~,min_index] = min(distances_inside);
            zone_min_indices(ith_zone,1) = min_index+(zone_start_indices(ith_zone,1)-1);
        end
        
        % For debugging:
        if flag_do_debug
            fprintf(1,'\nStart, end, and minimum indices for good zones: \nIstart \t Iend \t Imin\n');
            for ith_index = 1:num_good_zones
                fprintf(1,'%d\t\t %d\t\t %d\n',zone_start_indices(ith_index,1), zone_end_indices(ith_index,1),zone_min_indices(ith_index,1));
            end
        end
    end
        
end % Ends if check to see if zones are empty



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

    % Prep the figure for plotting
    temp_h = figure(figNum);
    flag_rescale_axis = 0;
    if isempty(get(temp_h,'Children'))
        flag_rescale_axis = 1;
    end      
    
    % Is this 2D or 3D?
    dimension_of_points = length(query_path(1,:));

    % Find size of plotting domain
    allPoints = [query_path; zone_center(1,1:2); 
        zone_center(1,1)+zone_radius zone_center(1,2);...
        zone_center(1,1)-zone_radius zone_center(1,2);...
        zone_center(1,1) zone_center(1,2)+zone_radius;...
        zone_center(1,1) zone_center(1,2)-zone_radius;...
        ];

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
    
    grid on;
    axis equal;
    
    % Plot the query path in blue dots
    plot(query_path(:,1),query_path(:,2),'b.-','Markersize',10,'LineWidth',3,'MarkerSize',20, 'DisplayName','Path');
    
    % Plot the zone definition in green
    h_plot = fcn_Laps_plotPointZoneDefinition([zone_radius 3 zone_center],'g',figNum);
    set(h_plot{1},'DisplayName','Zone center');
    set(h_plot{2},'DisplayName','Zone boundary');
    
    % Plot the results
    if num_zones ~= 0  % empty
        for ith_zone = 1:num_good_zones
            % Plot the zone
            data_to_plot = query_path(...
                zone_start_indices(ith_zone,1):zone_end_indices(ith_zone,1),:);
            h_fig = plot(data_to_plot(:,1),data_to_plot(:,2),'o-','Markersize',15,'Linewidth',3,'DisplayName',sprintf('Points in Zone, lap %.0f',ith_zone));
            color_value = get(h_fig,'Color');
            
            % Plot the minimum
            plot(...
                query_path(zone_min_indices(ith_zone,1),1),...
                query_path(zone_min_indices(ith_zone,1),2),...
                'x','Markersize',10,...            
                'Color',color_value,'Linewidth',3,'DisplayName',sprintf('Point of min distance, lap %.0f',ith_zone));
            
        end
    end

    axis(goodAxis);
    axis equal

    % Shut the hold off?
    if flag_shut_hold_off
        hold off;
    end

    legend('Location','northeast');

    
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
