//
//  TrainersViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import Foundation
import Firebase



var isWorkoutScheduled = false
var numberOfWorkoutsforWeek = 0


var defaultWorkouts = ["Biceps", "Chests", "Shoulders","Triceps", "Calves", "Forearms", "Glutes", "Hamstrings", "Lats", "Lower Back", "Middle Back", "Quadriceps", "Traps"]

var bicepWorkouts = ["Incline Hammer Curls", "Standing Barbell Curl", "Spider Curl", "Hammer Curls", "Zottman Curl", "Ez-bar Curl", "Bicep Curls to Shoulder Press", "Concentration Curls", "Dumbbell Curl", "Overhead Cable Curl", "Machine Bicep Curl", "Cross Body Hammer Curl", "Preacher Curl", "Standing Cable Curl", "Barbell Lying Against Incline", "Seated Close Grip Concentration Barbell Curl", "Seated Dumbbell Curl"]
var shoulderWorkouts = ["Side Laterals to Front Raise", "Standing Palm In Press", "Clean and Press", "Push Press", "Standing Military Press", "Clean and Jerk", "Seated Military Press", "Power Partials", "Seated Dumbbell Press", "Reverse Flyes", "Standing Dumbbell Press", "Dumbbell Shoulder Press", "Front Dumbbell Raise", "Car Drivers", "Arnold Dumbbell Press", "Front Cable Raise"]
var chestWorkouts = ["Dumbbell Bench Press", "Dumbbell Flyes", "Incline Dumbbell Press", "Decline Dumbbell Press", "Incline Dumbbell Flyes", "Low Cable Crossover", "Decline Dumbbell Flyes", "Barbell Bench Press", "Decline Barbell Bench Press", "Incline Dumbbell Bench Press", "Cable Crossover", "Cable Chest Press", "Butterfly", "Push Up", "Machine Bench Press", "Standing Cable Chest Press"]
var tricepWorkouts = ["Dips", "Decline Triceps Extension", "Dumbbell Floor Press", "CloseGrip Barbell Bench Press", "Triceps Pushdown", "Kneeling Cable Tricep Extension", "Standing Dumbbell Triceps Extension", "Skull Crushers", "Seated Tricep Press", "Incline Tricep Extension", "Dip Machine", "Tricep Kickback", "Bench Dip"]
var calfWorkouts = ["Smith Machine Calf Raise", "Standing Calf Raises", "Standing Dumbbell Claf Raise", "Seated Calf Raise", "Rocking Standing Calf Raise", "Calf Press on the Leg Press Machine","Calf Press", "Stanidng Barbell Calf Riase", "Barbell Seated Calf Raise", "Donkey Calf Raise",]
var forearmWorkouts = ["Palms-Down Wrist Curl Over Bench", "Wrist Rotations with Straight Bar", "Palms-Up Barbell Wrist Curl Over Bench", "Standing Palms-Up Barbell Behind the Back Wrist Curl", "Finger Curls", "Seated Two-Arm Palms-Up Low-Pulley Wrist Curl", "Wrist Roller", "Seated Palms-Up Barbell Wrist Curl", "Seated Palms-Down Barbell Wrist Curl", "Palms-Up Dumbbell Wrist Curl Over Bench", "Palms-Down Dumbbell Wrist Curl Over Bench"]
var gluteWorkouts = ["Barbell Glute Bridge", "Barbell Hip Thrust", "Cable Kickback", "Butt Lift", "Leg Glute Bridge", "Step-Up with Knee Raise", "Kneeling Squat", "Glute Kickback", "Flutter Kicks", "Kneeling Jump Squat", "Pull Through"]
var hamstringWorkouts = ["Clean Deadlift","Romaniam Deadlift", "Romanian Deadlift with Dumbbells", "Barbell Deadlift", "Sumo Deadleft", "Power Snatch", "Power Clean from Blocks", "Romanian Deadlift From Deficit", "Natural Glute Ham Raise", "Floor Glute-Ham Raise", "Lying Leg Curls", "Stiff-Legged Dumbbell Deadlift", "Ball Leg Curl", "Power Clean", "Hang Snatch", "Front Box Jump", "Clean", "Good Morning", "Wide Stance Stiff Legs", "Front Leg Raises", "Glute Ham Raise", "Stiff-Legged Barbell Deadlift", "Dumbbell Clean", "Knee Tuck Jump", "Seated Leg Curl"]
var latWorkouts = ["Pull Ups", "Chin Ups", "Rocky Pull-Ups/Pull Downs", "V Bar Pull Down", "Muscle Up", "Shotgun Row", "Wide Grip Pull Up", "V Bar Pull Up", "Rope Climb", "Rope Straight Arm Pulldown", "Lat Pulldown", "Underhand Cable Pulldown" , "Straight Arm Pulldown", "Elevated Cable Row", "Leverage ISO Row", "Machine-Assisted Pull Up", "Bent-Arm Barbell Pullover", "Cable Incline Pushdown"]
var lowerBackWorkouts = ["Deficit Deadlift", "Hyperextensions", "Deadlift with Bands", "Deadlift with Chains", "Rack Pull with Bands", "Superman", "Rack Pulls", "Seated Back Extension", "Stiff Leg Barbell Good Morning"]
var middleBackWorkouts = ["TBar Row with Handle", "Bent Over Rows", "Dumbbell Row", "Long Bar Row", "TBar Row", "Seated Cable Rows", "Dumbbell Incline Row", "Man Maker", "Middle Back Shrug", "Smith Machine Bent Over Row", "Incline Bench Pull"]
var quadWorkouts = ["Leg Press", "Clean from Blocks", "Barbell Full Squat", "Snatch", "Box Squat", "Hang Clean", "Reverse Band Box Squat", "Barbell Walking Lunge", "Step Mill", "Olympic Squat", "Narrow Stance Squats", "Box Squat with Bands", "Squat with Chains", "Weighted Jump Squat", "Bodyweight Lunge", "Front Barbell Squat", "Dumbbell Squat", "Rowing", "Dumbbell Goblet Squat", "Barbell Squat", "Dumbbell Lunges", "Barbell Lunge", "Mountain Climbers"]
var trapWorkouts = ["Smith Machine Shrug","Smith Machine Upright Row", "Leverage Shrug", "Dumbbell Shrug", "Calf-Machine Shoulder Shrug", "Standing Upright Row", "Barbell Shrug", "Upright Cable Row", "Cable Shrugs", "Clean Shrug", "Snatch Shrug"]


