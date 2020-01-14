rev([],X,X).
rev([X|Y],Z,L):-rev(Y,[X|Z],L).
