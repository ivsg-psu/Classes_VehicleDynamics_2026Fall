% script_test_fcn_Laps_findPointZoneStartStopAndMinimum.m
% tests fcn_Laps_findPointZoneStartStopAndMinimum.m

% REVISION HISTORY:
%
% 2022_04_08 by Sean Brennan, sbrennan@psu.edu
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

%% DEMO case: Returns the last three points
figNum = 10001;
titleString = sprintf('DEMO case: Returns the last three points');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;


% Create some data to plot
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps; %#ok<*NASGU>
ones_full_steps = ones(length(full_steps(:,1)),1);
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;
ones_half_steps = ones(length(half_steps(:,1)),1); %#ok<*PREALL>

query_path = ...
    [half_steps zero_half_steps];

zone_center = [-0.02 0]; % Located at [0.02,0]
zone_radius = 0.2;

[zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...
    [],...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));
assert(isnumeric(zone_min_indices));

% Check variable sizes
Nlaps = length(zone_start_indices(:,1));
assert(isequal(size(zone_start_indices),[Nlaps 1]));
assert(isequal(size(zone_end_indices),[Nlaps 1]));
assert(isequal(size(zone_min_indices),[Nlaps 1]));

% Check variable values
for ith_lap = 1:Nlaps
    % Start comes before end
    assert(zone_start_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
    % Min comes before end
    assert(zone_min_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
    % Min comes after start
    assert(zone_min_indices(ith_lap,1)>=zone_start_indices(ith_lap,1));
end
assert(isequal(zone_start_indices,9));
assert(isequal(zone_end_indices,11));
assert(isequal(zone_min_indices,11));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));


%% DEMO case: Returns nothing since there is no portion of the path in the
% criteria, even though the path goes right over the criteria
figNum = 10002;
titleString = sprintf('DEMO case: Returns nothing since there is no portion of the path in the');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

% Create some data to plot
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps; %#ok<*NASGU>
ones_full_steps = ones(length(full_steps(:,1)),1);
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;
ones_half_steps = ones(length(half_steps(:,1)),1); %#ok<*PREALL>

query_path = ...
    [full_steps 0.4*ones_full_steps];

zone_center = [0 0]; % Located at [0,0]
zone_radius = 0.2;   % Radius is 0.2
[zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...
    [],...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));
assert(isnumeric(zone_min_indices));

% Check variable sizes
assert(isempty(zone_start_indices));
assert(isempty(zone_end_indices));
assert(isempty(zone_min_indices));

% Check variable values
% (all are empty)

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));



%% DEMO case: returns nothing since there is one portion of the path in the criteria
figNum = 10003;
titleString = sprintf('DEMO case: returns nothing since there is one portion of the path in the criteria');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

% Create some data to plot
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps; %#ok<*NASGU>
ones_full_steps = ones(length(full_steps(:,1)),1);
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;
ones_half_steps = ones(length(half_steps(:,1)),1); %#ok<*PREALL>

query_path = ...
    [full_steps 0.2*ones_full_steps];

zone_center = [0 0]; % Located at [0,0]
zone_radius = 0.2;   % Radius is 0.2
[zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...
    [],...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));
assert(isnumeric(zone_min_indices));

% Check variable sizes
assert(isempty(zone_start_indices));
assert(isempty(zone_end_indices));
assert(isempty(zone_min_indices));

% Check variable values
% (all are empty)

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

%% DEMO case: returns nothing since there are only two points only within boundary, the default requires 3
figNum = 10004;
titleString = sprintf('DEMO case: returns nothing since there are only two points only within boundary, the default requires 3');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

% Create some data to plot
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps; %#ok<*NASGU>
ones_full_steps = ones(length(full_steps(:,1)),1);
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;
ones_half_steps = ones(length(half_steps(:,1)),1); %#ok<*PREALL>


query_path = ...
    [full_steps 0.2*ones_full_steps];

zone_center = [0.05 0]; % Located at [0.05,0]
zone_radius = 0.23;

[zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...
    [],...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));
assert(isnumeric(zone_min_indices));

% Check variable sizes
assert(isempty(zone_start_indices));
assert(isempty(zone_end_indices));
assert(isempty(zone_min_indices));

% Check variable values
% (all are empty)

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));



%% DEMO case: Returns nothing since there is only two points the path in the criteria. The third point is not strictly within the radius
figNum = 10004;
titleString = sprintf('DEMO case: Returns nothing since there is only two points the path in the criteria. The third point is not strictly within the radius');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

% Create some data to plot
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps; %#ok<*NASGU>
ones_full_steps = ones(length(full_steps(:,1)),1);
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;
ones_half_steps = ones(length(half_steps(:,1)),1); %#ok<*PREALL>

query_path = ...
    [half_steps zero_half_steps];

zone_center = [0 0]; % Located at [0,0]
zone_radius = 0.2;

[zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...
    [],...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));
assert(isnumeric(zone_min_indices));

% Check variable sizes
assert(isempty(zone_start_indices));
assert(isempty(zone_end_indices));
assert(isempty(zone_min_indices));

% Check variable values
% (all are empty)

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));



%% DEMO case: Show effect of minimum_number_of_indices_in_zone

% Show that the previous one that failed now works if lower number to 2
% points in the zone
figNum = 10005;
titleString = sprintf('DEMO case: Show effect of minimum_number_of_indices_in_zone');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;


% Create some data to plot
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps; %#ok<*NASGU>
ones_full_steps = ones(length(full_steps(:,1)),1);
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;
ones_half_steps = ones(length(half_steps(:,1)),1); %#ok<*PREALL>

query_path = ...
    [full_steps 0.2*ones_full_steps];


zone_center = [0.05 0]; % Located at [0.05,0]
zone_radius = 0.23;

zone_num_points = 2;

[zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...
    zone_num_points,...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));
assert(isnumeric(zone_min_indices));

% Check variable sizes
Nlaps = length(zone_start_indices(:,1));
assert(isequal(size(zone_start_indices),[Nlaps 1]));
assert(isequal(size(zone_end_indices),[Nlaps 1]));
assert(isequal(size(zone_min_indices),[Nlaps 1]));

% Check variable values
for ith_lap = 1:Nlaps
    % Start comes before end
    assert(zone_start_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
    % Min comes before end
    assert(zone_min_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
    % Min comes after start
    assert(zone_min_indices(ith_lap,1)>=zone_start_indices(ith_lap,1));
end
assert(isequal(zone_start_indices,11));
assert(isequal(zone_end_indices,12));
assert(isequal(zone_min_indices,12));

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));

%% DEMO case: the previous one that worked now fails if raise number to 4 points in the zone
figNum = 10006;
titleString = sprintf('DEMO case: the previous one that worked now fails if raise number to 4 points in the zone');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;


% Create some data to plot
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps; %#ok<*NASGU>
ones_full_steps = ones(length(full_steps(:,1)),1);
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;
ones_half_steps = ones(length(half_steps(:,1)),1); %#ok<*PREALL>


query_path = ...
    [half_steps zero_half_steps];

zone_center = [-0.02 0]; % Located at [0.02,0]
zone_radius = 0.2;
zone_num_points = 4;


[zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...
    zone_num_points,...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));
assert(isnumeric(zone_min_indices));

% Check variable sizes
assert(isempty(zone_start_indices));
assert(isempty(zone_end_indices));
assert(isempty(zone_min_indices));

% Check variable values
% (all are empty)

% Make sure plot opened up
assert(isequal(get(gcf,'Number'),figNum));


%% DEMO case: Multiple laps
figNum = 10007;
titleString = sprintf('DEMO case: Multiple laps');
fprintf(1,'Figure %.0f: %s\n',figNum, titleString);
figure(figNum); clf;

% Create some data to plot
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps;
ones_full_steps = ones(length(full_steps(:,1)),1);
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;
ones_half_steps = ones(length(half_steps(:,1)),1);

query_path = ...
    [full_steps 0*ones_full_steps; -full_steps 0.1*ones_full_steps; full_steps 0.2*ones_full_steps ];


zone_center = [0.05 0]; % Located at [0.05,0]
zone_radius = 0.23;
zone_num_points = 3;

[zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...
    zone_num_points,...
    figNum);

sgtitle(titleString, 'Interpreter','none');

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));
assert(isnumeric(zone_min_indices));

% Check variable sizes
Nlaps = length(zone_start_indices(:,1));
assert(isequal(size(zone_start_indices),[Nlaps 1]));
assert(isequal(size(zone_end_indices),[Nlaps 1]));
assert(isequal(size(zone_min_indices),[Nlaps 1]));

% Check variable values
for ith_lap = 1:Nlaps
    % Start comes before end
    assert(zone_start_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
    % Min comes before end
    assert(zone_min_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
    % Min comes after start
    assert(zone_min_indices(ith_lap,1)>=zone_start_indices(ith_lap,1));
end
assert(isequal(zone_start_indices,[10; 30]));
assert(isequal(zone_end_indices,  [13; 33]));
assert(isequal(zone_min_indices,  [12; 31]));

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
fprintf(1,'Figure: 8XXXXXX: FAST mode cases\n');

%% Basic example - NO FIGURE
figNum = 80001;
fprintf(1,'Figure: %.0f: FAST mode, empty figNum\n',figNum);
figure(figNum); close(figNum);

% Create some data to plot
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps;
ones_full_steps = ones(length(full_steps(:,1)),1);
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;
ones_half_steps = ones(length(half_steps(:,1)),1);


query_path = ...
    [full_steps 0*ones_full_steps; -full_steps 0.1*ones_full_steps; full_steps 0.2*ones_full_steps ];


zone_center = [0.05 0]; % Located at [0.05,0]
zone_radius = 0.23;
zone_num_points = 3;

[zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...
    zone_num_points,...
    ([]));

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));
assert(isnumeric(zone_min_indices));

% Check variable sizes
Nlaps = length(zone_start_indices(:,1));
assert(isequal(size(zone_start_indices),[Nlaps 1]));
assert(isequal(size(zone_end_indices),[Nlaps 1]));
assert(isequal(size(zone_min_indices),[Nlaps 1]));

% Check variable values
for ith_lap = 1:Nlaps
    % Start comes before end
    assert(zone_start_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
    % Min comes before end
    assert(zone_min_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
    % Min comes after start
    assert(zone_min_indices(ith_lap,1)>=zone_start_indices(ith_lap,1));
end
assert(isequal(zone_start_indices,[10; 30]));
assert(isequal(zone_end_indices,  [13; 33]));
assert(isequal(zone_min_indices,  [12; 31]));

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% Basic fast mode - NO FIGURE, FAST MODE
figNum = 80002;
fprintf(1,'Figure: %.0f: FAST mode, figNum=-1\n',figNum);
figure(figNum); close(figNum);

% Create some data to plot
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps;
ones_full_steps = ones(length(full_steps(:,1)),1);
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;
ones_half_steps = ones(length(half_steps(:,1)),1);


query_path = ...
    [full_steps 0*ones_full_steps; -full_steps 0.1*ones_full_steps; full_steps 0.2*ones_full_steps ];


zone_center = [0.05 0]; % Located at [0.05,0]
zone_radius = 0.23;
zone_num_points = 3;

[zone_start_indices, zone_end_indices, zone_min_indices] = ...
    fcn_Laps_findPointZoneStartStopAndMinimum(...
    query_path,...
    zone_center,...
    zone_radius,...
    zone_num_points,...
    (-1));

% Check variable types
assert(isnumeric(zone_start_indices));
assert(isnumeric(zone_end_indices));
assert(isnumeric(zone_min_indices));

% Check variable sizes
Nlaps = length(zone_start_indices(:,1));
assert(isequal(size(zone_start_indices),[Nlaps 1]));
assert(isequal(size(zone_end_indices),[Nlaps 1]));
assert(isequal(size(zone_min_indices),[Nlaps 1]));

% Check variable values
for ith_lap = 1:Nlaps
    % Start comes before end
    assert(zone_start_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
    % Min comes before end
    assert(zone_min_indices(ith_lap,1)<=zone_end_indices(ith_lap,1));
    % Min comes after start
    assert(zone_min_indices(ith_lap,1)>=zone_start_indices(ith_lap,1));
end
assert(isequal(zone_start_indices,[10; 30]));
assert(isequal(zone_end_indices,  [13; 33]));
assert(isequal(zone_min_indices,  [12; 31]));

% Make sure plot did NOT open up
figHandles = get(groot, 'Children');
assert(~any(figHandles==figNum));


%% Compare speeds of pre-calculation versus post-calculation versus a fast variant
figNum = 80003;
fprintf(1,'Figure: %.0f: FAST mode comparisons\n',figNum);
figure(figNum);
close(figNum);

% Create some data to plot
full_steps = (-1:0.1:1)';
zero_full_steps = 0*full_steps;
ones_full_steps = ones(length(full_steps(:,1)),1);
half_steps = (-1:0.1:0)';
zero_half_steps = 0*half_steps;
ones_half_steps = ones(length(half_steps(:,1)),1);


query_path = ...
    [full_steps 0*ones_full_steps; -full_steps 0.1*ones_full_steps; full_steps 0.2*ones_full_steps ];

zone_center = [0.05 0]; % Located at [0.05,0]
zone_radius = 0.23;
zone_num_points = 3;

Niterations = 50;

% Do calculation without pre-calculation
tic;
for ith_test = 1:Niterations
    % Call the function
    [zone_start_indices, zone_end_indices, zone_min_indices] = ...
        fcn_Laps_findPointZoneStartStopAndMinimum(...
        query_path,...
        zone_center,...
        zone_radius,...
        zone_num_points,...
        ([]));

end
slow_method = toc;

% Do calculation with pre-calculation, FAST_MODE on
tic;
for ith_test = 1:Niterations
    % Call the function
    [zone_start_indices, zone_end_indices, zone_min_indices] = ...
        fcn_Laps_findPointZoneStartStopAndMinimum(...
        query_path,...
        zone_center,...
        zone_radius,...
        zone_num_points,...
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

    %% Fails because zone_center is not correct type
    zone_center = 0.05; % Located at ????
    zone_radius = 0.23;
    zone_num_points = 3;

    [~, ~, ~] = ...
        fcn_Laps_findPointZoneStartStopAndMinimum(...
        query_path,...
        zone_center,...
        zone_radius,...
        zone_num_points,...
        figNum);


    %% Fails because zone_center is not correct type
    zone_center = [0.05 0 0 2]; % Located at ????
    zone_radius = 0.23;
    zone_num_points = 3;

    [~, ~, ~] = ...
        fcn_Laps_findPointZoneStartStopAndMinimum(...
        query_path,...
        zone_center,...
        zone_radius,...
        zone_num_points,...
        figNum);


    %% Fails because radius is negative
    zone_center = [0.05 0]; % Located at [0.05,0]
    zone_radius = -0.23;
    zone_num_points = 3;

    [~, ~, ~] = ...
        fcn_Laps_findPointZoneStartStopAndMinimum(...
        query_path,...
        zone_center,...
        zone_radius,...
        zone_num_points,...
        figNum);

    %% Fails because zone_num_points is negative
    zone_center = [0.05 0]; % Located at [0.05,0]
    zone_radius = 0.23;
    zone_num_points = -3;

    [~, ~, ~] = ...
        fcn_Laps_findPointZoneStartStopAndMinimum(...
        query_path,...
        zone_center,...
        zone_radius,...
        zone_num_points,...
        figNum);

    %% Fails because zone_num_points is not an integer
    zone_center = [0.05 0]; % Located at [0.05,0]
    zone_radius = 0.23;
    zone_num_points = 3.2;

    [~, ~, ~] = ...
        fcn_Laps_findPointZoneStartStopAndMinimum(...
        query_path,...
        zone_center,...
        zone_radius,...
        zone_num_points,...
        figNum);


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

