
:-dynamic reached/2.
reached(integer, integer).



setsize(jug1, 4).
setsize(jug2, 3).
    
print(N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, N11):-
    write(N1),
    write(N2),
    write(N3),
    write(N4),
    write(N5),
    write(N6),
    write(N7),
    write(N8),
    write(N9),
    write(N10), writeln(N11).

print(N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13):-
    write(N1),
    write(N2),
    write(N3),
    write(N4),
    write(N5),
    write(N6),
    write(N7),
    write(N8),
    write(N9),
    write(N10), write(N11), write(N12), writeln(N13).


solve(integer, integer).

solve(2, _). 

solve(Jug1, Jug2) :-
    setsize(jug1, Lim1),
    Jug1 < Lim1, 
    not(reached(Lim1, Jug2)),
    assert(reached(Lim1, Jug2)),
    print("Fill " , Lim1 , " gallon completely (", Jug1, ", " , Jug2, ") -> (", Lim1, ", ", Jug2, ") \n"),
    solve(Lim1, Jug2).


solve(Jug1, Jug2) :-
    setsize(jug2, Lim2),
    Jug2 < Lim2, 
    not(reached(Jug1, Lim2)),
    assert(reached(Jug1, Lim2)),
    print("Fill " , Lim2 , " gallon completely (", Jug1, ", " , Jug2, ") -> (", Jug1, ", ", Lim2, ") \n"),
    solve(Jug1, Lim2).



solve(Jug1, Jug2) :-
    setsize(jug1, Lim1),
    Jug1 > 0,
    not(reached(0, Jug2)),
    assert(reached(0, Jug2)),
    print("Throw ", Lim1, " gallon completely (", Jug1, ", " , Jug2, ") -> (", 0, ", ", Jug2, ") \n"),
    solve(0, Jug2).

solve(Jug1, Jug2) :-
    setsize(jug2, Lim2),
    Jug2 > 0,
    not(reached(Jug1, 0)),
    assert(reached(Jug1, 0)),
    print("Throw ", Lim2, " gallon completely (", Jug1, ", " , Jug2, ") -> (", Jug1, ", ", 0, ") \n"),
    solve(Jug1, 0).

solve(Jug1, Jug2) :-
    setsize(jug1, Lim1),
    setsize(jug2, Lim2),
    Jug1 + Jug2 >= Lim1,
    Jug2 > 0,
    NextJug2 is Jug2 - (Lim1 - Jug1),
    not(reached(Lim1, NextJug2)),
	assert(reached(Lim1, NextJug2)),
    print("Pour from ", Lim2, " gallon to ", Lim1, " gallon until it is full  (", Jug1, ", " , Jug2, ") -> (", Lim1, ", ", NextJug2, ") \n"),
    solve(Lim1, NextJug2).

solve(Jug1, Jug2) :-
    setsize(jug1, Lim1),
    setsize(jug2, Lim2),
    Jug1 + Jug2 >= Lim2,
    Jug1 > 0,
    NextJug1 is Jug1 - (Lim2 - Jug2),
    not(reached(NextJug1, Lim2)),
	assert(reached(NextJug1, Lim2)),
    print("Pour from ", Lim2, " gallon to ", Lim1, " gallon until it is full  (", Jug1, ", " , Jug2, ") -> (", NextJug1, ", ", Lim2, ") \n"),
    solve(NextJug1, Lim2).

solve(Jug1, Jug2) :-
    setsize(jug1, Lim1),
    setsize(jug2, Lim2),
    Jug1 + Jug2 =< Lim1,
    Jug2 > 0,
    NextJug1 is Jug1 + Jug2,
    not(reached(NextJug1, 0)),
    assert(reached(NextJug1, 0)),
    print("Pour all from ", Lim2, " gallon to ", Lim1, " gallon (", Jug1, ", " , Jug2, ") -> (", NextJug1, ", ", 0, ") \n"),
    solve(NextJug1, 0).

solve(Jug1, Jug2) :-
    setsize(jug1, Lim1),
    setsize(jug2, Lim2),
    Jug1 + Jug2 =< Lim2,
    Jug1 > 0,
    NextJug2 is Jug1 + Jug2,
    not(reached(0, NextJug2)),
   	assert(reached(0, NextJug2)),
    print("Pour all from ", Lim1, " gallon to ", Lim2, " gallon (", Jug1, ", " , Jug2, ") -> (", 0, ", ", NextJug2, ") \n"),
    solve(0, NextJug2).


getsolution(X, Y):-
    assert(reached(X, Y)),
    solve(X, Y).





