# Prolog-Codes

[![Generic badge](https://img.shields.io/badge/Artificial-Intelligence-<BLUE>.svg)](https://shields.io/)

Prolog Assignment - 1 of AI Course of IIIT Allahabad

![](https://img.shields.io/badge/Language-Prolog-orange.svg)

## Ques 1

Write a prolog program to define two predicates evenlength (list) and oddlength(list) so that they are true if
their argument is a list of even or odd length.

## Ques 2

Write a recursive Prolog program Towers of Hanoi puzzle

### Description about problem:

This object of this famous puzzle is to move N disks from the left peg to the right peg using the center peg
as an auxiliary holding peg. At no time can a larger disk be placed upon a smaller disk. The following diagram
depicts the starting setup for N=3 disks.


## Ques 3
Write a prolog program of water jug problem.

### Description about problem:

A Water Jug Problem: You are given two jugs, a 4-gallon one and a 3-gallon one, a pump which has
unlimited water which you can use to fill the jug, and the ground on which water may be poured. Neither jug
has any measuring markings on it. How can you get exactly 2 gallons of water in the 4-gallon jug?
### State Representation and Initial State 
we will represent a state of the problem as a tuple (x, y) where x
represents the amount of water in the 4-gallon jug and y represents the amount of water in the 3-gallon jug.
Note 0 ≤ x ≤ 4, and 0 ≤ y ≤ 3. Our initial state: (0,0)
### Goal Predicate – 
state = (2,y) where 0 ≤ y ≤ 3.

## Ques 4
Write a prolog program for missionaries and cannibals

### Description About problem:
In this problem, three missionaries and three cannibals must cross a river using a boat which can carry at
most two people, under the constraint that, for both banks, that the missionaries present on the bank cannot
be outnumbered by cannibals. The boat cannot cross the river by itself with no people on board.


## Ques 5.1
i. The following relation classifies numbers into three classes: positive, zero and negative:

Class (Number, positive) :- Number > 0.
Class (0, zero).
Class (Number, negative) :- Number less than 0
Define this procedure in a more efficient way using cuts.

## Ques 5.2
Define the procedure
split(Numbers, Positives, Negatives)
which splits a list of numbers into two lists: positive ones (including zero) and negative ones. 
Propose two versions: one with a cut and one without.

![](https://ForTheBadge.com/images/badges/built-with-love.svg)

