take(X,[X|R],R).
take(X,[Y|L],[Y|L2]):-take(X,L,L2).
