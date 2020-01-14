selectionsort([],[]).
selectionsort([First|Rest], [Smallest|SortedList]) :-
	smallest(Rest, First, Smallest),
	remove([First|Rest], Smallest, NewList),
	selectionsort(NewList, SortedList).

/* looks for the smallest element in the list
   atom A is the current smallest 
*/
smallest([], Smallest,Smallest).
smallest([First|Rest], CurrSmallest, Smallest) :- 
	First < CurrSmallest, smallest(Rest, First, Smallest).
smallest([_|Rest], CurrSmallest, Smallest) :-
	smallest(Rest, CurrSmallest, Smallest).

/* remove the first occurance of atom A from L */
remove([], _, []).
remove([First|Rest], First, Rest).
remove([First|Rest], Element, [First|NewList]) :- 
		remove(Rest, Element, NewList).
