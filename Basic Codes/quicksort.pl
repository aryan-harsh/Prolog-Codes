quick_sort([],[]).
quick_sort([H|T],Sorted):-
pivoting(H,T,L1,L2),quick_sort(L1,Sorted1),quick_sort(L2,Sorted2),
append(Sorted1,[H|Sorted2], Sorted).
   
pivoting(_,[],[],[]).
pivoting(H,[X|T],[X|L],G):-X=<H,pivoting(H,T,L,G).
pivoting(H,[X|T],L,[X|G]):-X>H,pivoting(H,T,L,G).

append([], L2, L2).
append([H|T], L2, [H|L3]):- append(T, L2, L3).
