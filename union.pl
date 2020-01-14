member(X,[X|R]).
member(X,[Y|R]):-member(X,R).

con([],L,L)
con([X],L,[X|L]):-\+member(X,L).
con([X],L,L):-member(X,L).
con([X|L],L2,[X|L3]):-con(L,L2,L3).



