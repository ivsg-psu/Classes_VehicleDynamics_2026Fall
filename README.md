# FeatureExtraction_DataClean_BreakDataIntoLaps

<!--
The following template is based on:
Best-README-Template
Search for this, and you will find!
>
<!-- PROJECT LOGO -->
<br />
<p align="center">
  <!-- <a href="https://github.com/ivsg-psu/FeatureExtraction_Association_PointToPointAssociation">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a> -->

  <h2 align="center"> FeatureExtraction_DataClean_BreakDataIntoLaps
  </h2>

  <pre align="center">
    <img src=".\Images\RaceTrack.jpg" alt="main laps picture" width="960" height="540">
    <!--figcaption>Fig.1 - The typical progression of map generation.</figcaption -->
    <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font -->
</pre>

  <p align="center">
    The purpose of this code is to break data into "laps", e.g. segments of data that are defined by a clear start condition and end condition. The code finds when a given path meets the "start" condition, then meets the "end" condition, and returns every portion of the path that is inside both conditions. Advanced features of the code include the ability to return the row indices defining each lap's data, as well as the path portions prior and after the lap area in case the "run in" or "run out" areas are needed. Yay! (I think)
    <br />
    <!-- a href="https://github.com/ivsg-psu/FeatureExtraction_Association_PointToPointAssociation"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/ivsg-psu/FeatureExtraction_Association_PointToPointAssociation/tree/main/Documents">View Demo</a>
    <a href="https://github.com/ivsg-psu/FeatureExtraction_Association_PointToPointAssociation/issues">Report Bug</a>
    <a href="https://github.com/ivsg-psu/FeatureExtraction_Association_PointToPointAssociation/issues">Request Feature</a -->
  </p>
</p>

***

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About the Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="structure">Repo Structure</a>
      <ul>
        <li><a href="#directories">Top-Level Directories</li>
        <li><a href="#dependencies">Dependencies</li>
      </ul>
    </li>
    <li><a href="#functions">Functions</li>
      <ul>
        <li><a href="#basic-support-functions">Basic Support Functions</li>
        <ul>
          <li><a href="#fcn_laps_plotlapsxy">fcn_Laps_plotLapsXY - Plotting utility for lap outputs</li>
          <li><a href="#fcn_laps_fillsamplelaps">fcn_Laps_fillSampleLaps - Creates test datasets</li>
          <li><a href="#fcn_laps_plotzonedefinition">fcn_Laps_plotZoneDefinition - Plots zone definitions</li>
          <li><a href="#fcn_laps_fillsamplelaps">fcn_Laps_fillSampleLaps - Creates test datasets</li>
        </ul>
        <li><a href="#core-functions">Core Functions</li>
        <ul>
          <li><a href="#fcn_laps_breakdataintolaps">fcn_Laps_breakDataIntoLaps - Core function of the repo, breaks data into laps</li>
          <li><a href="#fcn_laps_checkzonetype">fcn_Laps_checkZoneType - Checks inputs to determine if zone is a point or line segment type</li>
          <li><a href="#fcn_laps_breakdataintolapindices">fcn_Laps_breakDataIntoLapIndices - A more advanced version of fcn_Laps_breakDataIntoLaps, where the outputs are the indices that apply to each lap.</li>
          <li><a href="#fcn_laps_findsegmentzonestartstop">fcn_Laps_findSegmentZoneStartStop - Supporting function that finds the portions of a path that meet a segment zone criteria</li>
          <li><a href="#fcn_laps_findpointzonestartstopandminimum">fcn_Laps_findPointZoneStartStopAndMinimum - Supporting function that finds the portions of a path that meet a point zone criteria</li>
        </ul>
      </ul>
    <li><a href="#usage">Usage</a></li>
     <ul>
     <li><a href="#general-usage">General Usage</li>
     <li><a href="#examples">Examples</li>
     <li><a href="#definition-of-endpoints">Definition of Endpoints</li>
     </ul>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

***

<!-- ABOUT THE PROJECT -->
## About The Project

<!--[![Product Name Screen Shot][product-screenshot]](https://example.com)-->

The most common location of our testing is the Larson Test Track, and we regularly use “laps around the track” as replicates, hence the name of the library. And when not on the test track and on public roads, data often needs to be segmented from one keypoint to another. For example, it is a common task to seek a subset of path data that resides only from one intersection to the next. While one could segment this data during data collection by simply stopping the vehicle recordings at each segment, it is impractical and dangerous to stop data collection at each and every possible intersection or feature point. Rather, vehicle or robot data is often collected by repeated driving of an area over/over without stopping. So, the final data set may contain many replicates of the area of interest.

This "Laps" code assists in breaking recorded path data into paths by defining specific start and end locations, for example from intersection "A" to stop sign "B". Specifically, the purpose of this code is to break data into "laps", e.g. segments of data that are defined by a clear start condition and end condition. The code finds when a given path meets the "start" condition, then meets the "end" condition, and returns every portion of the path that is inside both conditions. There are many advanced features as well including the ability to define excursion points, the number of points that must be within a condition for it to activate, and the ability to extract the portions of the paths before and after each lap, in addition to the data for each lap.

* Inputs:
  * either a "traversals" type, as explained in the Path library, or a path of XY points in N x 2 format
  * the start, end, and optional excursions can be entered as either a line segment or a point and radius.  
* Outputs
  * Separate arrays of XY points, or of indices for the lap, with one array for each lap
  * The function also can return the points that were not used for laps, e.g. the points before the first start and after the last end

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Installation

1. Make sure to run MATLAB 2020b or higher. Why? The "digitspattern" command used in the DebugTools utilities was released late 2020 and this is used heavily in the Debug routines. If debugging is shut off, then earlier MATLAB versions will likely work, and this has been tested back to 2018 releases.

2. Clone the repo

   ```sh
   git clone https://github.com/ivsg-psu/FeatureExtraction_DataClean_BreakDataIntoLaps
   ```

3. Run the main code in the root of the folder (script_demo_Laps.m), this will download the required utilities for this code, unzip the zip files into a Utilities folder (.\Utilities), and update the MATLAB path to include the Utility locations. This install process will only occur the first time. Note: to force the install to occur again, delete the Utilities directory and clear all global variables in MATLAB (type: "clear global *").
4. Confirm it works! Run script_demo_Laps. If the code works, the script should run without errors. This script produces numerous example images such as those in this README file.

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

<!-- STRUCTURE OF THE REPO -->
### Directories

The following are the top level directories within the repository:
<ul>
 <li>/Documents folder: Descriptions of the functionality and usage of the various MATLAB functions and scripts in the repository.</li>
 <li>/Functions folder: The majority of the code for the point and patch association functionalities are implemented in this directory. All functions as well as test scripts are provided.</li>
 <li>/Utilities folder: Dependencies that are utilized but not implemented in this repository are placed in the Utilities directory. These can be single files but are most often folders containing other cloned repositories.</li>
</ul>

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

### Dependencies

* [Errata_Tutorials_DebugTools](https://github.com/ivsg-psu/Errata_Tutorials_DebugTools) - The DebugTools repo is used for the initial automated folder setup, and for input checking and general debugging calls within subfunctions. The repo can be found at: <https://github.com/ivsg-psu/Errata_Tutorials_DebugTools>

* [PathPlanning_PathTools_PathClassLibrary](https://github.com/ivsg-psu/PathPlanning_PathTools_PathClassLibrary) - the PathClassLibrary contains tools used to find intersections of the data with particular line segments, which is used to find start/end/excursion locations in the functions. The repo can be found at: <https://github.com/ivsg-psu/PathPlanning_PathTools_PathClassLibrary>

    Each should be installed in a folder called "Utilities" under the root folder, namely ./Utilities/DebugTools/ , ./Utilities/PathClassLibrary/ . If you wish to put these codes in different directories, the main call stack in script_demo_(reponame) can be easily modified with strings specifying the different location, but the user will have to make these edits directly.

    For ease of getting started, the zip files of the directories used - without the .git repo information, to keep them small - are included in this repo.

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

<!-- FUNCTION DEFINITIONS -->
## Functions

### Basic Support Functions

#### fcn_Laps_plotLapsXY

The function fcn_Laps_plotLapsXY plots the laps. For example, the function was used to make the plot below of the last Sample laps.
<pre align="center">
  <img src=".\Images\fcn_Laps_plotLapsXY.png" alt="fcn_Laps_plotLapsXY picture" width="400" height="300">
  <figcaption>Fig.1 - The function fcn_Laps_plotLapsXY plots the lap outputs.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font -->
</pre>

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

#### fcn_Laps_fillSampleLaps

The function fcn_Laps_fillSampleLaps creates dummy data to test lap functions. The test laps are in general difficult situations, including scenarios where laps loop back onto themself and/or with separate looping structures. These challenges show that the library can work on varying and complicated data sets. NOTE: within this function, commented out typically, there is code to allow users to draw their own lap test cases.

<pre align="center">
  <img src=".\Images\fcn_Laps_fillSampleLaps.png" alt="fcn_Laps_fillSampleLaps picture" width="400" height="300">
  <figcaption>Fig.2 - The function fcn_Laps_fillSampleLaps creates test data sets for exercising lap functions.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font -->
</pre>

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

#### fcn_Laps_plotZoneDefinition

The function fcn_Laps_plotZoneDefinition plots any type of zone, allowing user-defined colors. For example, the figure below shows a radial zone for the start, and a line segment for the end. For the line segment, an arrow is given that indicates which direction the segment must be crossed in order for the condition to be counted.

<pre align="center">
  <img src=".\Images\fcn_Laps_plotZoneDefinition.png" alt="fcn_Laps_plotZoneDefinition picture" width="400" height="300">
  <figcaption>Fig.3 - The function fcn_Laps_plotZoneDefinition plots the zone definitions.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font -->
</pre>

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

#### fcn_Laps_plotSegmentZoneDefinition

The function fcn_Laps_plotSegmentZoneDefinition plots a segment zone, allowing user-defined colors. This function is mostly used to support fcn_Laps_plotZoneDefinition.m.

<!--pre align="center">
  <img src=".\Images\fcn_Laps_plotZoneDefinition.png" alt="fcn_Laps_plotZoneDefinition picture" width="400" height="300">
  <figcaption>Fig.3 - The function fcn_Laps_plotZoneDefinition plots the zone definitions.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font>
</pre -->

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

### Core Functions

#### fcn_Laps_breakDataIntoLaps

The function fcn_Laps_breakDataIntoLaps is the core function for this repo that breaks data into laps. Note: the example shown below uses radial zone definitions, and the results illustrate how a lap, when it is within a start zone, starts at the FIRST point within a start zone. Similarly, each lap ends at the LAST point before exiting the end zone definition. The input data is a traversal type for this particular function.

<pre align="center">
  <img src=".\Images\fcn_Laps_breakDataIntoLaps.png" alt="fcn_Laps_breakDataIntoLaps picture" width="400" height="300">
  <figcaption>Fig.4 - The function fcn_Laps_breakDataIntoLaps is the core function in the repo, and breaks data into laps.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font -->
</pre>

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

#### fcn_Laps_checkZoneType

The function fcn_Laps_checkZoneType supports fcn_Laps_breakDataIntoLaps by checking if the zone definition inputs are either a point or line segment zone specification.

<!--pre align="center">
  <img src=".\Images\fcn_Laps_breakDataIntoLaps.png" alt="fcn_Laps_breakDataIntoLaps picture" width="400" height="300">
  <figcaption>Fig.5 - The function fcn_Laps_checkZoneType checks inputs to determine if zones are point or line segment type.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font>
</pre-->

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

#### fcn_Laps_breakDataIntoLapIndices

The function fcn_Laps_breakDataIntoLapIndices is a more advanced version of fcn_Laps_breakDataIntoLaps, where the outputs are the indices that apply to each lap. The input type is also easier to use, a "path" type which is just an array of [X Y]. The example here shows the use of a segment type zone for the start zone, a point-radius type zone for the end zone. The results of this function are the row indices of the data. The plot below illustrates that the function returns 3 laps in this example, and as well returns the pre-lap and post-lap data. One can observe that it is common that the prelap data for one lap (Lap 2) consists of the post-lap data for the prior lap (Lap 1).

<pre align="center">
  <img src=".\Images\fcn_Laps_breakDataIntoLapIndices.png" alt="fcn_Laps_breakDataIntoLapIndices picture" width="600" height="300">
  <figcaption>Fig.5 - The function fcn_Laps_breakDataIntoLapIndices is a more advanced version of fcn_Laps_breakDataIntoLaps, where the outputs are the indices that apply to each lap.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font -->
</pre>

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

#### fcn_Laps_findSegmentZoneStartStop

The function fcn_Laps_findSegmentZoneStartStop is a supporting function that finds the portions of a path that meet a segment zone criteria, returning the starting/ending indices for every crossing of a segment zone. The crossing must cross in the correct direction, and a segment is considered crossed if either the start or end of segment lie on the segment line. This is illustrated in the challenging example shown below, where the input path (thin blue) starts at the top, and then zig-zags repeatedly over a segment definition (green). For each time the blue line crosses the line segment, that portion of the path is saved as a separate possible crossing and thus, for this example, there are 5 possible crossings.

<pre align="center">
  <img src=".\Images\fcn_Laps_findSegmentZoneStartStop.png" alt="fcn_Laps_findSegmentZoneStartStop picture" width="400" height="300">
  <figcaption>Fig.5 - The function fcn_Laps_findSegmentZoneStartStop is a supporting function that finds the portions of a path that meet a segment zone criteria, returning the starting/ending indices for every crossing of a segment zone.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font -->
</pre>

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

#### fcn_Laps_findPointZoneStartStopAndMinimum

The function fcn_Laps_findPointZoneStartStopAndMinimum is a supporting function that finds the portions of a path that meet a point zone criteria, returning the starting/ending indices for every crossing of a point zone. Note that a minimum number of points must be within the zone for it to be considered activated, which is useful for real-world data (such as GPS recordings) where noise may randomly push one point of a path randomly into a zone, and then jump out. This number of points threshold can be user-defined. In the example below, the threshold is 4 points and one can see that, for a path that crosses over the zone three times, that two of the crossings are found to meet the 4-point criteria.

<pre align="center">
  <img src=".\Images\fcn_Laps_findPointZoneStartStopAndMinimum.png" alt="fcn_Laps_findPointZoneStartStopAndMinimum picture" width="400" height="300">
  <figcaption>Fig.6 - The function fcn_Laps_findPointZoneStartStopAndMinimum is a supporting function that finds the portions of a path that meet a point zone criteria, returning the starting/ending indices for every crossing of a point zone.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font -->
</pre>

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

<!-- USAGE EXAMPLES -->
## Usage
<!-- Use this space to show useful examples of how a project can be used.
Additional screenshots, code examples and demos work well in this space. You may
also link to more resources. -->

### General Usage

Each of the functions has an associated test script, using the convention

```sh
script_test_fcn_fcnname
```

where fcnname is the function name as listed above.

As well, each of the functions includes a well-documented header that explains inputs and outputs. These are supported by MATLAB's help style so that one can type:

```sh
help fcn_fcnname
```

for any function to view function details.

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

### Examples

1. Run the main script to set up the workspace and demonstrate main outputs, including the figures included here:

   ```sh
   script_demo_Laps
   ```

    This exercises the main function of this code.

2. After running the main script to define the included directories for utility functions, one can then navigate to the Functions directory and run any of the functions or scripts there as well. All functions for this library are found in the Functions sub-folder, and each has an associated test script. Run any of the various test scripts; each can work as a stand-alone script.

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

### Definition of Endpoints

The codeset uses two types of zone definitions:

1. A point location defined by the center and radius of the zone, and number of points that must be within this zone. An example of this would be "travel from home" or "to grandma's house". The point "zone" specification is given by an X,Y center location and a radius in the form of [X Y radius], as a 3x1 matrix. Whenever the path passes within the radius with a specified number of points within that radius, the minimum distance point then "triggers" the zone.

    <img src=".\Images\point_zone_definition.png" alt="point_zone_definition picture" width="200" height="200">

2. A line segment. An example is the start line or finish line of a race. A runner has not started or ended the race without crossing these lines. For line segment conditions, the inputs are condition formatted as: [X_start Y_start; X_end Y_end] wherein start denotes the starting coordinate of the line segment, end denotes the ending coordinate of the line segment. The direction of start/end lines of the segment are defined such that a correct crossing of the line is in the positive cross-product direction defined from the vector from start to end of the segment.

    <img src=".\Images\linesegment_zone_definition.png" alt="linesegment_zone_definition picture" width="200" height="200">

These two conditions can be mixed and matched, so that one could, for example, find every lap of data where someone went from a race start line (defined by a line segment) to a specific mountain peak defined by a point and radius.

The two zone types above can be used to define three types of conditions:

1. A start condition - where a lap starts. The lap does not end until and end condition is met.
2. An end condition - where a lap ends. The lap cannot end until this condition is met.
3. An excursion condition (optional) - a condition that must be met after the start point, and before the end point. The excursion condition must be met before the end point is counted.

Why is an excursion point needed? Consider an example: it is common for the start line of a marathon to be quite close to the start line, sometimes even just a few hundred feet after the start line. This setup is for the practical reason that runners do not want to make long walks to/from starting locations to finish location either before, and definitely not after, such a race. As a consequence, it is common that, immediately after the start of the race, a runner will cross the finish line before actually finishing the race. This happens in field data collection when one accidentally passes a start/end station, and then backs up the vehicle to reset. In using these data recordings, we would not want these small segment to count as a complete laps, for example the 100-ish meter distance to be counted as a marathon run. Rather, one would require that the recorded data enter some excursion zone far away from the starting line for such a "lap" to count. Thus, this laps code allows one to define an excursion point as a location far out into the course that one must "hit" before the finish line is counted as the actual "finish" of the lap.

* For each lap when there are repeats, the resulting laps of data include the lead-in and fade-out data, namely the datapoint immediately before the start condition was met, and the datapoint after the end condition is met. THIS CREATES REPLICATE DATA. However, this allows better merging of data for repeated laps, for example averaging data exactly from start to finish, or to more exactly calculate velocities on entry and exit of a lap by using windowed averages or filters.

* Points inside the lap can be set for the point-type zones. These occur as optional input arguments in fcn_Laps_findPointZoneStartStopAndMinimum and in the core definition of a point zone as the 2nd argument. For example, the following code:

  ```Matlab
  start_definition = [10 3 0 0]; % Radius 10, 3 points must pass near [0 0]
  ```

  requires 3 points to occur within the start zone area.

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

## Major release versions

This code is still in development (alpha testing)

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

<!-- CONTACT -->
## Contact

Sean Brennan - [sbrennan@psu.edu](sbrennan@psu.edu)

Project Link: [hhttps://github.com/ivsg-psu/FeatureExtraction_DataClean_BreakDataIntoLaps](https://github.com/ivsg-psu/FeatureExtraction_DataClean_BreakDataIntoLaps)

<a href="#featureextraction_dataclean_breakdataintolaps">Back to top</a>

***

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
