% script_test_fcn_Laps_findSegmentZoneStartStop.m
% tests fcn_Laps_findSegmentZoneStartStop.m

% REVISION HISTORY:
%
% 2022_07_12 by Sean Brennan, sbrennan@psu.edu
% - first write of the code
% 
% 2025_07_03 by Sean Brennan, sbrennan@psu.edu
% - standardized headers on all test scripts

% TO-DO:
%
% 2025_11_21 by Sean Brennan, sbrennan@psu.edu
% - (fill in items here)


%% Set up the workspace
close all

%% Code demos start here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   _____                              ____   __    _____          _
%  |  __ \                            / __ \ / _|  / ____|        | |
%  | |  | | ___ _ __ ___   ___  ___  | |  | | |_  | |     ___   __| | ___
%  | |  | |/ _ \ '_ ` _ \ / _ \/ __| | |  | |  _| | |    / _ \ / _` |/ _ \
%  | |__| |  __/ | | | | | (_) \__ \ | |__| | |   | |___| (_) | (_| |  __/
%  |_____/ \___|_| |_| |_|\___/|___/  \____/|_|    \_____\___/ \__,_|\___|
%
%
% See: https://patorjk.com/software/taag/#p=display&f=Big&t=Demos%20Of%20Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figures start with 1

close all;
fprintf(1,'Figure: 1XXXXXX: DEMO cases\n');

%% DEMO case: Basic demo
figNum = 10001;
titleString = sprintf('DEMO case: Basic demo');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;


% Create some data to plot
full_steps = (-1:0.1:1)';
% zero_full_steps = 0*full_steps; 
ones_full_steps = ones(length(full_steps(:,1)),1);
% half_steps = (-1:0.1:0)';
% zero_half_steps = 0*half_steps;
% ones_half_steps = ones(length(half_steps(:,1)),1); 

% Create the query path
query_path = ...
    [full_steps 0.4*ones_full_steps];

segment_definition = [0 0; 0 1]; % Starts at [0,0], ends at [0 1]
[zone_start_indices, zone_end_indices] = ...
    fcn_Laps_findSegmentZoneStartStop(...
    query_path,...
    segment_definition,...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));

% Check variable sizes
Nlaps = length(zone_start_indices(:,1));
assert(isequal(size(zone_start_indices),[Nlaps 1]));
assert(isequal(size(zone_end_indices),[Nlaps 1]));

% Check variable values
for ith_lap = 1:Nlaps
    % Start comes before end
    assert(zone_start_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
end
assert(isequal(zone_start_indices,10));
assert(isequal(zone_end_indices,11));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));



%% DEMO case: Returns nothing since there is no portion of the path in the criteria even though the path goes right over the criteria
figNum = 10002;
titleString = sprintf('DEMO case: Returns nothing since there is no portion of the path in the criteria even though the path goes right over the criteria');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

% Create some data to plot
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps; 
ones_full_steps = ones(length(full_steps(:,1)),1);
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;
ones_half_steps = ones(length(half_steps(:,1)),1); 

% Create the query path
query_path = ...
    [full_steps 0.4*ones_full_steps];

segment_definition = [0 0; 1 0]; % Starts at [0,0], ends at [1 0]
[zone_start_indices, zone_end_indices] = ...
    fcn_Laps_findSegmentZoneStartStop(...
    query_path,...
    segment_definition,...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isempty(zone_start_indices));
assert(isempty(zone_end_indices));

% Check variable sizes
% (no sizes because is empty)

% Check variable values
% (no values because is empty)

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));


%% DEMO case: Returns one hit, right on start of path
figNum = 10003;
titleString = sprintf('DEMO case: Returns one hit, right on start of path');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

% Create some data to plot
full_steps = (-1:0.1:1)';
% zero_full_steps = 0*full_steps; 
ones_full_steps = ones(length(full_steps(:,1)),1);
% half_steps = (-1:0.1:0)';
% zero_half_steps = 0*half_steps;
% ones_half_steps = ones(length(half_steps(:,1)),1); 

% Create the query path
query_path = ...
    [full_steps 0.4*ones_full_steps];

segment_definition = [-1 0; -1 1]; % Starts at [-1,0], ends at [-1 1]
[zone_start_indices, zone_end_indices] = ...
    fcn_Laps_findSegmentZoneStartStop(...
    query_path,...
    segment_definition,...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));

% Check variable sizes
Nlaps = length(zone_start_indices(:,1));
assert(isequal(size(zone_start_indices),[Nlaps 1]));
assert(isequal(size(zone_end_indices),[Nlaps 1]));

% Check variable values
for ith_lap = 1:Nlaps
    % Start comes before end
    assert(zone_start_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
end
assert(isequal(zone_start_indices,1));
assert(isequal(zone_end_indices,2));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));


%% DEMO case: Returns no hit, crossed wrong way
figNum = 10004;
titleString = sprintf('DEMO case: Returns no hit, crossed wrong way');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

% Create some data to plot
full_steps = (-1:0.1:1)';
% zero_full_steps = 0*full_steps; 
ones_full_steps = ones(length(full_steps(:,1)),1);
% half_steps = (-1:0.1:0)';
% zero_half_steps = 0*half_steps;
% ones_half_steps = ones(length(half_steps(:,1)),1); 

% Create the query path
query_path = ...
    [flipud(full_steps) 0.4*ones_full_steps];

segment_definition = [0 0; 0 1]; % Starts at [0,0], ends at [0 1]
[zone_start_indices, zone_end_indices] = ...
    fcn_Laps_findSegmentZoneStartStop(...
    query_path,...
    segment_definition,...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isempty(zone_start_indices));
assert(isempty(zone_end_indices));

% Check variable sizes
% (no sizes because is empty)

% Check variable values
% (no values because is empty)

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

%% DEMO case: Returns no hit, also crossed wrong way
figNum = 10005;
titleString = sprintf('DEMO case: Returns no hit, also crossed wrong way');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

% Create some data to plot
full_steps = (-1:0.1:1)';
% zero_full_steps = 0*full_steps; 
ones_full_steps = ones(length(full_steps(:,1)),1);
% half_steps = (-1:0.1:0)';
% zero_half_steps = 0*half_steps;
% ones_half_steps = ones(length(half_steps(:,1)),1); 

% Create the query path
query_path = ...
    [full_steps 0.4*ones_full_steps];

segment_definition = [0 1; 0 0]; % Starts at [0,1], ends at [0 0]
[zone_start_indices, zone_end_indices] = ...
    fcn_Laps_findSegmentZoneStartStop(...
    query_path,...
    segment_definition,...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isempty(zone_start_indices));
assert(isempty(zone_end_indices));

% Check variable sizes
% (no sizes because is empty)

% Check variable values
% (no values because is empty)

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

%% DEMO case: Returns two hits, even though crossed three times since only 2 crossings in correct direction
% One crossing is in the wrong direction!
figNum = 10006;
titleString = sprintf('DEMO case: Returns two hits, even though crossed three times since only 2 crossings in correct direction');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

% Create some data to plot
full_steps = (-1:0.1:1)';
% zero_full_steps = 0*full_steps; 
ones_full_steps = ones(length(full_steps(:,1)),1);
half_steps = (-1:0.1:0)';
% zero_half_steps = 0*half_steps;
% ones_half_steps = ones(length(half_steps(:,1)),1); 

% Create the query path
query_path = ...
    [full_steps 0.4*ones_full_steps; 
    flipud(full_steps) 0.6*ones_full_steps;
    full_steps 0.8*ones_full_steps];

segment_definition = [0 0; 0 1]; % Starts at [0,0], ends at [0 1]
[zone_start_indices, zone_end_indices] = ...
    fcn_Laps_findSegmentZoneStartStop(...
    query_path,...
    segment_definition,...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));

% Check variable sizes
Nlaps = length(zone_start_indices(:,1));
assert(isequal(size(zone_start_indices),[Nlaps 1]));
assert(isequal(size(zone_end_indices),[Nlaps 1]));

% Check variable values
for ith_lap = 1:Nlaps
    % Start comes before end
    assert(zone_start_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
end
assert(isequal(zone_start_indices,[10; 52]));
assert(isequal(zone_end_indices,[11; 53]));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));


%% DEMO case: Multiple crossings
figNum = 10007;
titleString = sprintf('DEMO case: Multiple crossings');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

% Create the query path
query_path = ...
    [-1 2; 1 2; -1 1; 0 1; -1 0; 0 0; 1 0; 0 -1; 1 -1; -1 -2; 0 -2];

segment_definition = [0 -2; 0 2]; % Starts at [0,0], ends at [0 1]
[zone_start_indices, zone_end_indices] = ...
    fcn_Laps_findSegmentZoneStartStop(...
    query_path,...
    segment_definition,...
    figNum);
sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));

% Check variable sizes
Nlaps = length(zone_start_indices(:,1));
assert(isequal(size(zone_start_indices),[Nlaps 1]));
assert(isequal(size(zone_end_indices),[Nlaps 1]));

% Check variable values
for ith_lap = 1:Nlaps
    % Start comes before end
    assert(zone_start_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
end
assert(isequal(zone_start_indices,[1; 3; 5; 8; 10]));
assert(isequal(zone_end_indices,[2; 4; 6; 9; 11]));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));


%% Fast Mode Tests
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ______        _     __  __           _        _______        _
% |  ____|      | |   |  \/  |         | |      |__   __|      | |
% | |__ __ _ ___| |_  | \  / | ___   __| | ___     | | ___  ___| |_ ___
% |  __/ _` / __| __| | |\/| |/ _ \ / _` |/ _ \    | |/ _ \/ __| __/ __|
% | | | (_| \__ \ |_  | |  | | (_) | (_| |  __/    | |  __/\__ \ |_\__ \
% |_|  \__,_|___/\__| |_|  |_|\___/ \__,_|\___|    |_|\___||___/\__|___/
%
%
% See: http://patorjk.com/software/taag/#p=display&f=Big&t=Fast%20Mode%20Tests
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figures start with 8

close all;
fprintf(1,'Figure: 8XXXXXX: FAST mode cases (there are no fast modes for plotting functions) \n');

%% Basic example - NO FIGURE
figNum = 80001;
fprintf(1,'Figure: %.0f: FAST mode, empty figNum\n',figNum);
figure(figNum); close(figNum);

% Create the query path
query_path = ...
    [-1 2; 1 2; -1 1; 0 1; -1 0; 0 0; 1 0; 0 -1; 1 -1; -1 -2; 0 -2];

segment_definition = [0 -2; 0 2]; % Starts at [0,0], ends at [0 1]
[zone_start_indices, zone_end_indices] = ...
    fcn_Laps_findSegmentZoneStartStop(...
    query_path,...
    segment_definition,...
    ([]));

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));

% Check variable sizes
Nlaps = length(zone_start_indices(:,1));
assert(isequal(size(zone_start_indices),[Nlaps 1]));
assert(isequal(size(zone_end_indices),[Nlaps 1]));

% Check variable values
for ith_lap = 1:Nlaps
    % Start comes before end
    assert(zone_start_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
end
assert(isequal(zone_start_indices,[1; 3; 5; 8; 10]));
assert(isequal(zone_end_indices,[2; 4; 6; 9; 11]));

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% Basic fast mode - NO FIGURE, FAST MODE
figNum = 80002;
fprintf(1,'Figure: %.0f: FAST mode, figNum=-1\n',figNum);
figure(figNum); close(figNum);

% Create the query path
query_path = ...
    [-1 2; 1 2; -1 1; 0 1; -1 0; 0 0; 1 0; 0 -1; 1 -1; -1 -2; 0 -2];

segment_definition = [0 -2; 0 2]; % Starts at [0,0], ends at [0 1]
[zone_start_indices, zone_end_indices] = ...
    fcn_Laps_findSegmentZoneStartStop(...
    query_path,...
    segment_definition,...
    (-1));

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));

% Check variable sizes
Nlaps = length(zone_start_indices(:,1));
assert(isequal(size(zone_start_indices),[Nlaps 1]));
assert(isequal(size(zone_end_indices),[Nlaps 1]));

% Check variable values
for ith_lap = 1:Nlaps
    % Start comes before end
    assert(zone_start_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
end
assert(isequal(zone_start_indices,[1; 3; 5; 8; 10]));
assert(isequal(zone_end_indices,[2; 4; 6; 9; 11]));

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% Compare speeds of pre-calculation versus post-calculation versus a fast variant
figNum = 80003;
fprintf(1,'Figure: %.0f: FAST mode comparisons\n',figNum);
figure(figNum);
close(figNum);

% Create the query path
query_path = ...
    [-1 2; 1 2; -1 1; 0 1; -1 0; 0 0; 1 0; 0 -1; 1 -1; -1 -2; 0 -2];

segment_definition = [0 -2; 0 2]; % Starts at [0,0], ends at [0 1]

Niterations = 50;

% Do calculation without pre-calculation
tic;
for ith_test = 1:Niterations
    % Call the function
    [zone_start_indices, zone_end_indices] = ...
        fcn_Laps_findSegmentZoneStartStop(...
        query_path,...
        segment_definition,...
        ([]));

end
slow_method = toc;

% Do calculation with pre-calculation, FAST_MODE on
tic;
for ith_test = 1:Niterations
    % Call the function
    [zone_start_indices, zone_end_indices] = ...
        fcn_Laps_findSegmentZoneStartStop(...
        query_path,...
        segment_definition,...
        (-1));
end
fast_method = toc;

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));

% Plot results as bar chart
figure(373737);
clf;
hold on;

X = categorical({'Normal mode','Fast mode'});
X = reordercats(X,{'Normal mode','Fast mode'}); % Forces bars to appear in this exact order, not alphabetized
Y = [slow_method fast_method ]*1000/Niterations;
bar(X,Y)
ylabel('Execution time (Milliseconds)')


% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% BUG cases
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  ____  _    _  _____
% |  _ \| |  | |/ ____|
% | |_) | |  | | |  __    ___ __ _ ___  ___  ___
% |  _ <| |  | | | |_ |  / __/ _` / __|/ _ \/ __|
% | |_) | |__| | |__| | | (_| (_| \__ \  __/\__ \
% |____/ \____/ \_____|  \___\__,_|___/\___||___/
%
% See: http://patorjk.com/software/taag/#p=display&v=0&f=Big&t=BUG%20cases
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% All bug case figures start with the number 9

% close all;

%% BUG 

%% Fail conditions
if 1==0
    
    %% Fails because segment_definition is not correct type
    segment_definition = [0; 1]; % Starts at ?, ends at ?
    [~, ~] = ...
        fcn_Laps_findSegmentZoneStartStop(...
        query_path,...
        segment_definition,...
        []);
    
    %% Warns because segment_definition is 3D
    segment_definition = [0 0 0; 1 0 0]; % Starts at [0 0 0], ends at [1 0 0]
    [~, ~] = ...
        fcn_Laps_findSegmentZoneStartStop(...
        query_path,...
        segment_definition,...
        []);
   
end

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

