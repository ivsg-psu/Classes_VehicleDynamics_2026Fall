# Classes_VehicleDynamics_2026Fall

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

  <h2 align="center"> Classes_VehicleDynamics_2026Fall
  </h2>

  <pre align="center">
    <img src=".\Images\2026Fall_Audi.jpg" alt="main canvas picture" width="364" height="547">
    <!--figcaption>Fig.1 - The typical progression of map generation.</figcaption -->
    <font size="-2">Photo by <a href="https://unsplash.com/@rpnickson?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Roberto Nickson</a> on <a href="https://unsplash.com/photos/black-vehicle-on-road-between-trees-during-daytime-Yp9FdEqaCdk?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>
      </font>
</pre>

  <p align="center">
    The purpose of this code repo is to house the code, documents, assignments, etc. for vehicle dynamics. Each semester's materials are copied from the "core" material, with passwords added to documents that contain copyright material that should not be shared to the public. Passwords are shared on Canvas.
    <br />
  </p>
</p>

***

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">Syllabus</a>
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
    <!--li><a href="#functions">Functions</li>
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
      </ul-->
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

<!-- Syllabus -->
## Syllabus

M E 452 – VEHICLE DYNAMICS

Fall 2026
MWF 2:30-3:20 pm
Earth and Eng Sciences 121
Aug 24, 2026 - Dec 11, 2026

### Instructor Content Information

Dr. Sean Brennan
Office:  227 Reber Building
157 N. Burrowes Rd.
Penn State University
University Park, PA 16802
Phone: (814) 863-2430

Email:  <sbrennan@psu.edu>

* NOTE: this is the same address as <snb10@psu.edu>, just easier to remember and less likely to confuse zeros and ones with letters
* NOTE: Please do NOT send urgent messages to the professor or the TA via Canvas. Canvas maintains its own internal email capability that does not support basic email operations - forwarding, CC other students, keyword search, automatic rules, etc. This makes it very difficult to reply quickly. In our main email, we look for the keyword "452" so please be sure this is in the subject line.

Office hours are Thursdays on Zoom from 3pm to 5pm

### Course TA

There is typically no TA for this course

### Course Description

This course conducts investigations of one-dimensional, two-dimensional, and three-dimensional dynamics, kinematics, and design - each integrated into the study of vehicle dynamics. Topics include body kinematics, steady state body dynamics, transient stability, tire forces, suspension, automatic control, and driver interaction. The emphasis is on the analysis of a vehicle as a complex system, recognizing how to abstract observed behaviors into appropriate mathematical models, how to decompose behaviors into subsystems, how to construct and perform numerical simulations, and how to design and analyze experiments to test models and simulations to gain insights into design goals and tradeoffs.  

### Prerequisites  

ME 370 (required), Co-requisite:  ME 450 (required)

The content of this course requires students to demonstrate a familiarity with basic tools used for systems and signals analysis including: Laplace transforms, eigenvalues, bode plots, and frequency response. Students should be sufficiently familiar with differential equations such that basic solution methods - forced response versus initial response - can be distinguished. Students should have a firm understanding of mass-spring-damper systems along with detailed knowledge characteristic responses of these systems in underdamped, critically damped, over-damped conditions. We will be analyzing the differential equations for systems in transfer-function, state-space, and frequency domains and will often switch representations suddenly to gain insight. This analysis will strongly complement ME450, hence why this class is listed as a co-requisite.

Nearly all assignments will require the use of MATLAB and deep knowledge of this software is beneficial but not expected. For students who are not familiar with this software, tutorials are provided. However, a memory of structured programming as well as some willingness to learn this material is expected.

And one final note on prerequisites: students are NOT expected to be “gearheads” to both enjoy this course and be very successful academically! Indeed, one observation is that hobby-level knowledge is often wrong or situationally specific, and some students may have trouble with “unlearning” material that is incorrect or that is only valid for racecars, not passenger vehicles.

### Course Goals and Measurable Objectives 

Upon completion of the course, students should be able to:

1. Associate observed vehicle behavior with the vehicle dynamic model causing the motion.
2. Identify and mathematically characterize linear and nonlinear behavior in a vehicle or vehicle subsystem including characteristics of the dynamic models, experimental responses, and simulation outcomes.
3. Code, implement and critically analyze the results of numerical simulations and other computational models of vehicle system behavior, specifically focusing on lumped-parameter models and methods of decomposing behaviors into simpler interconnected subsystems, and error-checking subsystems and their interactions.
4. Predict the influence of subsystem behavior on entire vehicle system performance using a variety of tools including but not limited to simulation models, steady-state analysis of equations of motion, solving differential equations, graphical analysis, and frequency-domain analysis.
5. Evaluate the primary design constraints that govern vehicle and subsystem design. Using these principles, should be able to evaluate and justify existing vehicle system designs and formulate improved designs for new vehicle subsystems.
6. Calculate the limits of vehicle designs including acceleration and braking, cornering ability, suspension and ride handling, roll stability, etc.
7. Explain how common changes in vehicle setup – weight distribution, wheel usage, etc. – affects vehicle stability and braking performance in both low and high-speed driving, in both steady-state and transient maneuvers.
8. Justify existing tradeoffs in model simplicity or complexity in representing an actual system. By examination of the vehicle system behavior, students are expected to form and justify mathematical model representations of suitable complexity, even extending this to new systems and situations.
9. Understand and characterize how automated subsystems such as ABS, rear-wheel steering, and active suspension will change vehicle performance and vehicle/roadway interaction.

### Attendance and Make-up Policy

In accordance with University policy, all students are encouraged to attend every class period.  While the lecture content will nominally follow the assigned texts and PowerPoint slides, students are responsible for information disseminated in the lectures, though not necessarily covered in the text.

If there are a large number of students missing in class, it is common that an in-class quiz will be given.

If a student is going to miss class, please tell Dr. Brennan via E-mail at least 24 hours in advance. The first 2 are usually excused as long as the reason is something your employer would allow as "professional development" if you had a job. So job interviews, grad school visits, senior project trips are valid excuses; getting a better flight on Thanksgiving is not a valid reason to miss the Friday before Thanksgiving week or the Monday afterwards. After 2 absences, students will automatically miss 20% of the credit for in-class quizzes if the class is excused - which is better than a zero for unexcused absences.

In the student E-mail, students should list the specific dates, their name, and the class (ME 452). Faculty may teach 3 to 5 different classes simultaneously and most faculty get dozens to hundreds of emails a day and thus may go several days before being able to check all messages. So an e-mail from <SteelerFan23@gmail.com> saying “I’m missing class tomorrow” isn’t helpful at all in identifying the student, class, or date being missed.

### Course assessment policy

Students can choose between two grading options:

The final grade is based on 500 total points will be assigned after the third exam.  

``` md
   3 exams                     =   300 points 
   homework                    =   150 points 
   final project               =   25  points
   quizzes  + muddiest points  =   25  points 
   Total                           500 points
```

The homework is generally one assignment per week for each of the 15 weeks - note that, because Thanksgiving has no assignment, the first week will effectively have 2 assignments. The number quizzes may vary depending on the number of cellphone calls and similar disruptions, as each disruption results in one quiz. If, at the end of the semester, the homework or quiz points don’t add up to the total in these categories, then unused points will be given to the students as automatic full credit. If the total of points is larger than the totals listed above, then the totals will be multiplied by a fraction such that the re-scaled values match the total points above.

Short homework assignments will be given over the entire semester, roughly one assignment per lecture (the assignment will go with the lecture material).  Homework problems will be due one week after the completion of the lecture topic at the beginning of class, since I sometimes present the solutions in class. Late homework assignments will be docked 20% for the first class period that it is late, but will not be accepted for more than 1 class period after the due date. If we discuss or post the solutions, then no submissions will be accepted thereafter; this typically happens around exam dates or 2 weeks after an assignment is due, whichever is sooner.

To make the due dates very clear, the due dates will be listed as each assignment is posted.

Short quizzes (5 minutes each) will be given over the semester based on assigned reading from the text or other supplemental material provided in class.  Each quiz will be worth 3 points and will be given unannounced at the beginning of class.  Because the purpose of this quiz is to ensure that students arrive to class on time, no makeup quizzes will be allowed.

In the case a cell phone, pager, buzzer, etc. goes off in class, there will be an automatic on-the-spot pop quiz.

This class uses at times a special type of quiz: Muddiest points. At unannounced times at the end of class, all students will be asked to write out a short (1-2 sentence) question concerning a topic covered in class that week that they felt was not well-explained or remains unclear.  These are like quizzes, but are only graded pass/fail and there are no wrong answers - students who do the Muddiest Points always recieve full points, even if the submission is a blank page with their name at top.  At the beginning of the following class, the most commonly asked questions will usually be discussed.  No makeup muddiest points will be allowed.

Exams are be based on material from the class discussions, lecture notes, and homework, with particular but not exclusive focus on lecture topics.  Unless otherwise specified, exams are closed-book, closed-notes. Students using AI tools or external chat features will automatically receive a zero.  Makeup exams will only be arranged for students with valid excuses provided at least one class period before the scheduled exam.  If students have a known conflict, please let the professor know as soon as possible - usually, several make-up exam times are available.  

Exams will be held roughly after Lessons 12, 24, and 36 and correspond to first, middle, and final thirds of the class. Exact dates are not given due to snow days, travel, and test track events, but usually happen on the Tuesday or Thursday evenings the week after the above lessons are completed.

Example exams are posted on this repo site.

### Required Course Materials

There is not a required textbook, but students must have access to the MATLAB software suite, the Student Edition… Students can find this software at all campus bookstores, at any of the campus computer labs, etc. The price is about $100 for a student license. Note: industry engineers have to pay about $30k for the same software after they graduate. So valuable are the student editions of MATLAB that many engineers keep their software throughout their careers.

It is also helpful - but not required - that students have a laptop that can be used in class to program MATLAB and interact with Canvas. If a student does not have this access, the professor can bring spare laptops to the class.

### Non-required Course References

The following references have either been past textbooks in the class or serve well as good references. Students who plan careers in this field are strongly encouraged to collect and read these materials as they are classics in this field:

Gillespie, Thomas. Fundamentals of Vehicle Dynamics. Society of Automotive Engineers, Inc. This is a good starter book for anyone new to vehicle dynamics, and as the title suggests - is a core reference for fundamentals. But for those really interested in vehicle dynamics, the text may leave one wanting for more depth. This book was the class text from 2004-2007.

Tires, Suspension, and Handling 2nd Edition by John C. Dixon, SAE Press, ISBN 1-56091-831-4, 1996. This is not a comprehensive book covering every aspect of vehicle dynamics, but it has some of the best material on transient handling response and suspension design; this seems to be a primary interest area of students in the course, particularly those on the racing teams. This book was used it as the class text from 2007-2010.

Tire and Vehicle Dynamics, by Hans B. Pacejka, published by the Society of Automotive Engineers, Inc.2002. This is a definitive book on tire modeling with a solid, but terse treatment of vehicle dynamics. Because this book obtains its depth too quickly for most undergraduates to understand, it is not appropriate for beginners or as a first book on vehicle dynamics. It has good nuggets for those familiar with the material and is a great must-read text for graduate students working in tire dynamics and tire modeling.

Wong, J.Y., Theory of Ground Vehicles, Second or Third Edition, John Wiley, 1997. Another good “beginner book” that is often suggested in lieu of Gillespie. Its treatment of ground forces and tracked vehicles is among the best introductions to applying vehicle dynamics to ground robots including tracked vehicles. Thus, this is among the best textbooks on non-traditional vehicles (such as tanks) that is presently available.

Bosch Automotive Handbook, 8th edition, BOSCH GmbH, 2011. It remains a great reference for all types of automotive systems, components, and engineering principles. Unfortunately, it is organized to almostly solely be a reference, not a textbook to teach vehicle dynamics.

Vehicle Stability by Karnopp. This is a among the best books on vehicle stability analysis, and is one of the few books on vehicle dynamics on this list that is clearly graduate-level. However, like the title says, the focus is on stability and little else. This is a critical and core issue, but the class covers much more beyond just this issue.

Milliken and Milliken, Race Car Vehicle Dynamics. This book provides great coverage of vehicle setup, especially for racing and transient handling, and is considered one of the “must read” books for those working in vehicle dynamics. However, for a semester-long course, the material is far too detailed for a beginning student. It's focus on racing can over-emphasize design issues that do not well describe core issues in the design and operation of production vehicles. As well, it takes a good chunk of time to navigate through the tremendous amount of material they provide. This is a book that one must almost have to be an expert in vehicle dynamics first in order to understand the nuances within. It is very easy with this book to confuse a minor detail with a primary effect, and beginners are not encouraged to start with this book.

J.R. Ellis, Vehicle Handling Dynamics, Mechanical Engineering Publication Limited, London, 1993. A strong book, but one that was hard to obtain when the class was formed and thus not used extensively.

Automotive Engineering Fundamentals, Richard Stone and Jeffrey Ball, 2004. This is a great “all around” book, covering everything from chassis to powertrain to aerodynamics. It does not get into enough depth into any one area to be the key reference for any topic, but this is a book that I reach for (with Gillespie) to train someone to understand vehicle design generally, in just one book. This is one of the books to buy if you want to have an introduction to most everything, in a way that is accessible to undergrad engineers. This book was the core text for the course in 2008-2010.

Herb Adams, Chassis Engineering: Chassis Design, Building, & Tuning for High Performance Handling. HP Books.  This is a great book for those students in the class that are tuning vehicles for high performance in a garage somewhere (Formula SAE). The content is high-school level at best, but the insights and explanations give a practical insight that, in some parts, is actually better than almost any technical vehicle textbook. And the book is cheap!

Chassis Handbook: Fundamentals, Driving Dynamics, Components, Mechatronics, Perspectives (ATZ/MTZ-Fachbuch) by Bernd Heißing and Metin Ersoy (Oct 14, 2010). This book is written with a very strong industry focus, and is meant to be the “book to read” for interns that are joining European OEMs. The material is written very directly with little interpretation or flourish, but as a result the book is DENSE in content. If one understands everything in this book, they will unquestionably be an expert on vehicle design. This is meant to be one of the books on the shelf of an automotive engineer, but the material is so thick that I doubt that many engineers will dig through it. Like Racecar Vehicle Dynamics, it is a book to read after one is already nearly an expert in the field.

Vehicle Dynamics. by Reza N. Jazar, Springer. This is quite a heft of a book (a back-breaking 1000+ pages!) for the price ($75 the last I checked), and especially comprehensive. Unlike the Racecar Vehicle Dynamics, the primary focus is on passenger vehicles, as is this class. Unfortunately, the size of the book is intimidating and the 2nd edition is actually larger than the 1st, adding more secondary and tertiary topics rather than paring the material down to core design issues. The strength of this book is in its detail. In fact, the book is presented in a format that is mostly bulleted insights on details rather than mathematical development of core ideas. There are lots of examples within, but more focus is needed for this text to fit well within our undergraduate course.

CarSim Educational UMTRI – The University of Michigan Transportation Institute and MSC – Mechanical Simulation Corporation, July 1997. This software is sometimes installed in the MNE computer labs, and might be used for some of the homework assignments. This software is VERY expensive but is production-grade quality used by industry. Because the goal of the course is for students to understand what is within the software to a level they can write their own, students are encouraged to master the dynamics of vehicles using their own codes up to a level where they appreciate the nuance and additional details added by this professional software. Jumping into this software without this understanding can cause students to misinterpret vehicle results and confuse primary dynamics with secondary effects. Or worse, the software results may be incorrectly trusted because core simulation assumptions and implementations would be unchallenged by novice users.

### Questions

Please feel free to ask questions before, during, or after class, since this saves E-mail exchanges, scheduled meetings, etc. E-mail works as well, and if the question is good, they may be posted here to this repo.

But one key request: include a hypothesis. In other words, don’t simply ask “What do I do here?” or “What do you mean?” or “I don’t understand…”. Instead, write, “I think you mean X here, is this correct?” or, “I think I should do Y, right?”  A good question is one where we can reply with a yes or no answer (or a number), since this shows that you have a good understanding of both the material, and what type of answer you want.

Finally, the homework is meant to challenge but not overwhelm. So don’t spend hours banging your head against a wall, especially on a software issue. If you aren’t getting anywhere after a reasonable effort (20-30 minutes is a reasonable amount of time to work on a problem section), please just ask!

### Potluck

Students will have the opportunity to choose (vote) the curriculum near the end of the semester.  Potluck topics include:

1. Driver behavior and vehicle/driver interaction
2. Vehicle Automation
3. Powertrain design: dynamic considerations
4. Student choice!

### Final exam

There is no final exam.

### Academic Integrity Statement

Standard (required) statement: The University defines academic integrity as the pursuit of scholarly activity in an open, honest and responsible manner. All students should act with personal integrity, respect other students' dignity, rights and property, and help create and maintain an environment in which all can succeed through the fruits of their efforts - refer to Senate Policy 49-20. Dishonesty of any kind will not be tolerated in this course. Dishonesty includes, but is not limited to, cheating, plagiarizing, fabricating information or citations, facilitating acts of academic dishonesty by others, having unauthorized possession of examinations, submitting work of another person or work previously used without informing the instructor, or tampering with the academic work of other students. Students who are found to be dishonest will receive academic sanctions and will be reported to the University's Office of Student Conduct for possible further disciplinary sanctions (refer to Senate Policy G-9).

Specific to this class:  Students are encouraged to work together on homework assignments; however, original solutions are required.  

So how do we expect students to balance “working together” with “original solutions”? For homework, the threshold of cheating is defined as follows: if the person or algorithm grading the assignments is able to identify which students have worked together by their solutions or specific aspects of their solution approach, and their interaction is NOT clearly documented on the solutions (“I obtained the following equation from Mary, I copied this function from Tom ”), then these students are working too closely together. If students document where and how they are working together, this is usually acceptable - unless it's copying entire problems or sets of problems.

If cheating or copying is suspected, all students involved will receive a warning if the violation is minor and if this is their first such warning. For obvious and major violations, e.g. major portions of the assignment are copied (such as simulations), then no credit will be given for the assignment to all students involved.  After the first warning, any subsequent cheating – minor or major – will result in a zero for the entire assignment and the student will be referred to the college for an academic integrity violation. Three cheating events will result in failing the class. Cheating - especially using AI tools - during an exam is considered a major violation and will result in a zero for the exam.

Again, note that we tend to be far more forgiving of issues if teamwork is documented, e.g. “Mary helped me with my simulation block representing the coordinate transforms.” Vague documentation such as “Mary helped me” is better than nothing but may still result in a zero or severe grade penalty for you (but not Mary) if that help is not specifically documented, and if it seems like you didn’t do anything but use Mary’s simulation. But if a student clearly used Mary's work without documenting it, but the student and Mary will both receive a zero grade. If you are the one helping someone else, a suggestion is to document this help in your own problem set.

Again, cheating of any kind on exams will not be tolerated and will be immediately processed as an academic integrity violation resulting in at minimum a zero exam grade.

### Course-specific AI Statement

Students are strongly encouraged to use AI tools as much as possible with the exception of during exams or quizzes. As well, students may be trained to develop AI prompts and are encouraged to teach others and the professor any best practices, tools, tricks, etc. that apply to the course.

### Students with Diabilities

Penn State welcomes students with disabilities into the University's educational programs. If you have a disability-related need for reasonable academic adjustments in this course, contact the Office for Disability Services (ODS) at 814-863-1807 (V/TTY). For further information regarding ODS, please visit the Office for Disability Services Web site at <http://equity.psu.edu/ods/>. In order to receive consideration for course accommodations, you must contact ODS and request academic adjustment letters at the beginning of each semester. See: <http://equity.psu.edu/ods/guidelines/documentation-guidelines>

Of note: exams are not time restricted, so there is no need to present time accomodation requests for the class - all students have whatever time they need to complete their exams.

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

### Classroom Safety

Building Evacuation
If you need to evacuate the building, know the location of at least two exits and follow posted evacuation routes - in general, the exits are at each end of every hallway segment. If and when an evacuation is announced, remain calm, leave the building promptly, and follow instructions from emergency personnel. Do not use elevators during a fire or other emergency unless directed to do so. Once outside, move away from the building and proceed to the designated assembly area, if one has been identified. Do not re-enter the building until emergency personnel indicate that it is safe to do so.

Active Shooter / Armed Threat
Follow RUN-HIDE-FIGHT rule. If there is an active shooter or other armed threat, your first priority is to protect yourself and get to a safe location. If it is safe to do so, leave the area and move as far away from the threat as possible. If you cannot safely leave, find a secure location, lock or barricade the door if possible, silence electronic devices, and remain quiet. As a last resort, if you are confronted by the attacker and your life is in imminent danger, be prepared to defend yourself. Follow instructions from law enforcement and emergency personnel when they arrive. Please review this: <https://www.police.psu.edu/run-hide-fight-surviving-active-attacker>

General Emergencies
For general emergencies, remain calm and follow instructions from university officials, emergency personnel, and campus alerts. Depending on the situation, you may be instructed to evacuate, shelter in place, or take other protective action. Be aware of your surroundings and know how to report an emergency. If you are able to do so safely, assist others who may need help. Additional emergency procedures and resources are available through the university's emergency preparedness and safety resources (see information at: <https://www.police.psu.edu/emergency-preparedness>)

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Installation

1. Make sure to run MATLAB 2020b or higher. Why? The "digitspattern" command used in the DebugTools utilities was released late 2020 and this is used heavily in the Debug routines. If debugging is shut off, then earlier MATLAB versions will likely work, and this has been tested back to 2018 releases.

2. Clone the repo

   ```sh
   git clone https://github.com/ivsg-psu/Classes_VehicleDynamics_2026Fall
   ```

3. Run the main code in the root of the folder (script_demo_Laps.m), this will download the required utilities for this code, unzip the zip files into a Utilities folder (.\Utilities), and update the MATLAB path to include the Utility locations. This install process will only occur the first time. Note: to force the install to occur again, delete the Utilities directory and clear all global variables in MATLAB (type: "clear global *").
4. Confirm it works! Run script_demo_Laps. If the code works, the script should run without errors. This script produces numerous example images such as those in this README file.

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

<!-- STRUCTURE OF THE REPO -->
### Directories

The following are the top level directories within the repository:
<ul>
 <li>/Documents folder: Descriptions of the functionality and usage of the various MATLAB functions and scripts in the repository.</li>
 <li>/Functions folder: The majority of the code for the point and patch association functionalities are implemented in this directory. All functions as well as test scripts are provided.</li>
 <li>/Utilities folder: Dependencies that are utilized but not implemented in this repository are placed in the Utilities directory. These can be single files but are most often folders containing other cloned repositories.</li>
</ul>

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

### Dependencies

* [Errata_Tutorials_DebugTools](https://github.com/ivsg-psu/Errata_Tutorials_DebugTools) - The DebugTools repo is used for the initial automated folder setup, and for input checking and general debugging calls within subfunctions. The repo can be found at: <https://github.com/ivsg-psu/Errata_Tutorials_DebugTools>

* [PathPlanning_PathTools_PathClassLibrary](https://github.com/ivsg-psu/PathPlanning_PathTools_PathClassLibrary) - the PathClassLibrary contains tools used to find intersections of the data with particular line segments, which is used to find start/end/excursion locations in the functions. The repo can be found at: <https://github.com/ivsg-psu/PathPlanning_PathTools_PathClassLibrary>

    Each should be installed in a folder called "Utilities" under the root folder, namely ./Utilities/DebugTools/ , ./Utilities/PathClassLibrary/ . If you wish to put these codes in different directories, the main call stack in script_demo_(reponame) can be easily modified with strings specifying the different location, but the user will have to make these edits directly.

    For ease of getting started, the zip files of the directories used - without the .git repo information, to keep them small - are included in this repo.

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

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

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

#### fcn_Laps_fillSampleLaps

The function fcn_Laps_fillSampleLaps creates dummy data to test lap functions. The test laps are in general difficult situations, including scenarios where laps loop back onto themself and/or with separate looping structures. These challenges show that the library can work on varying and complicated data sets. NOTE: within this function, commented out typically, there is code to allow users to draw their own lap test cases.

<pre align="center">
  <img src=".\Images\fcn_Laps_fillSampleLaps.png" alt="fcn_Laps_fillSampleLaps picture" width="400" height="300">
  <figcaption>Fig.2 - The function fcn_Laps_fillSampleLaps creates test data sets for exercising lap functions.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font -->
</pre>

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

#### fcn_Laps_plotZoneDefinition

The function fcn_Laps_plotZoneDefinition plots any type of zone, allowing user-defined colors. For example, the figure below shows a radial zone for the start, and a line segment for the end. For the line segment, an arrow is given that indicates which direction the segment must be crossed in order for the condition to be counted.

<pre align="center">
  <img src=".\Images\fcn_Laps_plotZoneDefinition.png" alt="fcn_Laps_plotZoneDefinition picture" width="400" height="300">
  <figcaption>Fig.3 - The function fcn_Laps_plotZoneDefinition plots the zone definitions.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font -->
</pre>

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

#### fcn_Laps_plotSegmentZoneDefinition

The function fcn_Laps_plotSegmentZoneDefinition plots a segment zone, allowing user-defined colors. This function is mostly used to support fcn_Laps_plotZoneDefinition.m.

<!--pre align="center">
  <img src=".\Images\fcn_Laps_plotZoneDefinition.png" alt="fcn_Laps_plotZoneDefinition picture" width="400" height="300">
  <figcaption>Fig.3 - The function fcn_Laps_plotZoneDefinition plots the zone definitions.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font>
</pre -->

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

### Core Functions

#### fcn_Laps_breakDataIntoLaps

The function fcn_Laps_breakDataIntoLaps is the core function for this repo that breaks data into laps. Note: the example shown below uses radial zone definitions, and the results illustrate how a lap, when it is within a start zone, starts at the FIRST point within a start zone. Similarly, each lap ends at the LAST point before exiting the end zone definition. The input data is a traversal type for this particular function.

<pre align="center">
  <img src=".\Images\fcn_Laps_breakDataIntoLaps.png" alt="fcn_Laps_breakDataIntoLaps picture" width="400" height="300">
  <figcaption>Fig.4 - The function fcn_Laps_breakDataIntoLaps is the core function in the repo, and breaks data into laps.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font -->
</pre>

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

#### fcn_Laps_checkZoneType

The function fcn_Laps_checkZoneType supports fcn_Laps_breakDataIntoLaps by checking if the zone definition inputs are either a point or line segment zone specification.

<!--pre align="center">
  <img src=".\Images\fcn_Laps_breakDataIntoLaps.png" alt="fcn_Laps_breakDataIntoLaps picture" width="400" height="300">
  <figcaption>Fig.5 - The function fcn_Laps_checkZoneType checks inputs to determine if zones are point or line segment type.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font>
</pre-->

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

#### fcn_Laps_breakDataIntoLapIndices

The function fcn_Laps_breakDataIntoLapIndices is a more advanced version of fcn_Laps_breakDataIntoLaps, where the outputs are the indices that apply to each lap. The input type is also easier to use, a "path" type which is just an array of [X Y]. The example here shows the use of a segment type zone for the start zone, a point-radius type zone for the end zone. The results of this function are the row indices of the data. The plot below illustrates that the function returns 3 laps in this example, and as well returns the pre-lap and post-lap data. One can observe that it is common that the prelap data for one lap (Lap 2) consists of the post-lap data for the prior lap (Lap 1).

<pre align="center">
  <img src=".\Images\fcn_Laps_breakDataIntoLapIndices.png" alt="fcn_Laps_breakDataIntoLapIndices picture" width="600" height="300">
  <figcaption>Fig.5 - The function fcn_Laps_breakDataIntoLapIndices is a more advanced version of fcn_Laps_breakDataIntoLaps, where the outputs are the indices that apply to each lap.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font -->
</pre>

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

#### fcn_Laps_findSegmentZoneStartStop

The function fcn_Laps_findSegmentZoneStartStop is a supporting function that finds the portions of a path that meet a segment zone criteria, returning the starting/ending indices for every crossing of a segment zone. The crossing must cross in the correct direction, and a segment is considered crossed if either the start or end of segment lie on the segment line. This is illustrated in the challenging example shown below, where the input path (thin blue) starts at the top, and then zig-zags repeatedly over a segment definition (green). For each time the blue line crosses the line segment, that portion of the path is saved as a separate possible crossing and thus, for this example, there are 5 possible crossings.

<pre align="center">
  <img src=".\Images\fcn_Laps_findSegmentZoneStartStop.png" alt="fcn_Laps_findSegmentZoneStartStop picture" width="400" height="300">
  <figcaption>Fig.5 - The function fcn_Laps_findSegmentZoneStartStop is a supporting function that finds the portions of a path that meet a segment zone criteria, returning the starting/ending indices for every crossing of a segment zone.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font -->
</pre>

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

#### fcn_Laps_findPointZoneStartStopAndMinimum

The function fcn_Laps_findPointZoneStartStopAndMinimum is a supporting function that finds the portions of a path that meet a point zone criteria, returning the starting/ending indices for every crossing of a point zone. Note that a minimum number of points must be within the zone for it to be considered activated, which is useful for real-world data (such as GPS recordings) where noise may randomly push one point of a path randomly into a zone, and then jump out. This number of points threshold can be user-defined. In the example below, the threshold is 4 points and one can see that, for a path that crosses over the zone three times, that two of the crossings are found to meet the 4-point criteria.

<pre align="center">
  <img src=".\Images\fcn_Laps_findPointZoneStartStopAndMinimum.png" alt="fcn_Laps_findPointZoneStartStopAndMinimum picture" width="400" height="300">
  <figcaption>Fig.6 - The function fcn_Laps_findPointZoneStartStopAndMinimum is a supporting function that finds the portions of a path that meet a point zone criteria, returning the starting/ending indices for every crossing of a point zone.</figcaption>
  <!--font size="-2">Photo by <a href="https://unsplash.com/ko/@samuelchenard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Samuel Chenard</a> on <a href="https://unsplash.com/photos/Bdc8uzY9EPw?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a></font -->
</pre>

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

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

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

### Examples

1. Run the main script to set up the workspace and demonstrate main outputs, including the figures included here:

   ```sh
   script_demo_Laps
   ```

    This exercises the main function of this code.

2. After running the main script to define the included directories for utility functions, one can then navigate to the Functions directory and run any of the functions or scripts there as well. All functions for this library are found in the Functions sub-folder, and each has an associated test script. Run any of the various test scripts; each can work as a stand-alone script.

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

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

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

## Major release versions

This code is still in development (alpha testing)

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

<!-- CONTACT -->
## Contact

Sean Brennan - [sbrennan@psu.edu](sbrennan@psu.edu)

Project Link: [hhttps://github.com/ivsg-psu/Classes_VehicleDynamics_2026Fall](https://github.com/ivsg-psu/Classes_VehicleDynamics_2026Fall)

<a href="#classes_vehicledynamics_2026fall">Back to top</a>

***

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
