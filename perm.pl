perm([X|Y],Z) :- perm(Y,W), take(X,Z,W).   
perm([],[]).


take(X,[X|R],R).
take(X,[Y|L],[Y|L2]):-take(X,L,L2).
