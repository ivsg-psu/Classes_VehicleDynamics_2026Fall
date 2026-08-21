function h = fcn_Laps_plotLapsXY(cellArrayOfPaths,varargin)
% fcn_Laps_plotLapsXY
% Plots the XY positions of all laps existing in a data structure. This is
% just a modified version of fcn_Path_plotTraversalsXY from the "Path"
% library of functions. The "laps" type and "tranversals" type are the same
% type, for consistency.
%
% FORMAT: 
%
%       h = fcn_Laps_plotLapsXY(cellArrayOfPaths,{figNum})
%
% INPUTS:
%
%      cellArrayOfPaths: a cell array of paths to be averaged with each
%      other. Each path is a N x 2 or N x 3 set of coordinates
%      representing the [X Y] or [X Y Z] coordinates, in sequence, of a
%      path. The averaging works best if each path starts and stops in
%      approximately the same area and with similar orientations.
%
%     (optional inputs)
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
%       See the script: script_test_fcn_Laps_plotLapsXY.m for a full test
%       suite. 
%
% This function was written on 2022_04_02 by S. Brennan
% Questions or comments? sbrennan@psu.edu 

% REVISION HISTORY:
%
% 2022_04_02 by Sean Brennan, sbrennan@psu.edu
% - wrote the code
% 
% 2025_04_25 by Sean Brennan, sbrennan@psu.edu
% - added global debugging options
% 
% 2025_07_02 by Sean Brennan, sbrennan@psu.edu
% - Removed traversal input type and replaced with cell array of paths
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
MAX_NARGIN = 2; % The largest Number of argument inputs to the function
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

        % Check the cellArrayOfPaths input
        if ~iscell(cellArrayOfPaths)
            error('cellArrayOfPaths input must be a cell type');
        end
        for ith_cell = 1:length(cellArrayOfPaths)
            if ~isempty(cellArrayOfPaths{ith_cell})
                fcn_DebugTools_checkInputsToFunctions(cellArrayOfPaths{ith_cell}, 'path2or3D');
            end
        end
    end
end

% Does user want to show the plots?
flag_do_plots = 1; % Default is to show plots
figNum = [];
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
else
    temp_h = figure(figNum);
end
flag_this_is_a_new_figure = 0;
if isempty(get(temp_h,'Children'))
    flag_this_is_a_new_figure = 1;
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
 
figure(figNum);
axis equal;

% Count number of non-empty entries
Nnotempty = 0;
for ith_cell = 1:length(cellArrayOfPaths)
    if ~isempty(cellArrayOfPaths{ith_cell})
        Nnotempty = ith_cell;
    end
end


goodCellArray = cell(Nnotempty,1);
for jth_entry = 1:Nnotempty
    goodCellArray{jth_entry,1} = cellArrayOfPaths{jth_entry,1};
end
cellArrayOfPaths = goodCellArray;

% Check to see if hold is already on. If it is not, set a flag to turn it
% off after this function is over so it doesn't affect future plotting
flag_shut_hold_off = 0;
if ~ishold
    flag_shut_hold_off = 1;
    hold on
end

NumPaths = length(cellArrayOfPaths);
h = zeros(NumPaths,1);
for ith_lap= 1:NumPaths
    if ~isempty(cellArrayOfPaths{ith_lap})
        h(ith_lap) = plot(cellArrayOfPaths{ith_lap}(:,1),cellArrayOfPaths{ith_lap}(:,2),'-o');
    else
        h(ith_lap) = plot(NaN,NaN,'-o');
    end
end

% Plot the start and end values as green and red respectively
for ith_lap= 1:NumPaths
    if ~isempty(cellArrayOfPaths{ith_lap})
        plot(...
            cellArrayOfPaths{ith_lap}(1,1),cellArrayOfPaths{ith_lap}(1,2),'go',...
            cellArrayOfPaths{ith_lap}(end,1),cellArrayOfPaths{ith_lap}(end,2),'ro');
    else
        plot(NaN,NaN,'go',NaN,NaN,'ro');
    end
end

% Shut the hold off?
if flag_shut_hold_off
    hold off;
end

% Add labels? 
if flag_this_is_a_new_figure == 1
    title('X vs Y')
    xlabel('X [m]')
    ylabel('Y [m]')

    % Make axis slightly larger?
    temp = axis;
    axis_range_x = temp(2)-temp(1);
    axis_range_y = temp(4)-temp(3);
    percent_larger = 0.3;
    axis([temp(1)-percent_larger*axis_range_x, temp(2)+percent_larger*axis_range_x,  temp(3)-percent_larger*axis_range_y, temp(4)+percent_larger*axis_range_y]);

end


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
    % Nothing in here yet
end

if flag_do_debug
    fprintf(1,'ENDING function: %s, in file: %s\n\n',st(1).name,st(1).file); 
end
end

