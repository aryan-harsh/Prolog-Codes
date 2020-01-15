minimax(Pos, BestNextPos, Val) :-                    
    bagof(NextPos, move(Pos, NextPos), NextPosList),
    best(NextPosList, BestNextPos, Val), !.

minimax(Pos, _, Val) :-                    
    utility(Pos, Val).


best([Pos], Pos, Val) :-
    minimax(Pos, _, Val), !.

best([Pos1 | PosList], BestPos, BestVal) :-
    minimax(Pos1, _, Val1),
    best(PosList, Pos2, Val2),
    betterOf(Pos1, Val1, Pos2, Val2, BestPos, BestVal).


betterOf(Pos0, Val0, _, Val1, Pos0, Val0) :-   
    min_to_move(Pos0),                        
    Val0 > Val1, !                            
    ;
    max_to_move(Pos0),                       
    Val0 < Val1, !.                            

betterOf(_, _, Pos1, Val1, Pos1, Val1).     

move([X1, play, Board], [X2, win, NextBoard]) :-
    nextPlayer(X1, X2),
    move_aux(X1, Board, NextBoard),
    winPos(X1, NextBoard), !.

move([X1, play, Board], [X2, draw, NextBoard]) :-
    nextPlayer(X1, X2),
    move_aux(X1, Board, NextBoard),
    drawPos(X1,NextBoard), !.

move([X1, play, Board], [X2, play, NextBoard]) :-
    nextPlayer(X1, X2),
    move_aux(X1, Board, NextBoard).

move_aux(P, [0|Bs], [P|Bs]).

move_aux(P, [B|Bs], [B|B2s]) :-
    move_aux(P, Bs, B2s).

min_to_move([o, _, _]).

max_to_move([x, _, _]).

utility([o, win, _], 1).       % Previous player (MAX) has win.
utility([x, win, _], -1).      % Previous player (MIN) has win.
utility([_, draw, _], 0).

winPos(P, [X1, X2, X3, X4, X5, X6, X7, X8, X9]) :-
    equal(X1, X2, X3, P) ;    % 1st line
    equal(X4, X5, X6, P) ;    % 2nd line
    equal(X7, X8, X9, P) ;    % 3rd line
    equal(X1, X4, X7, P) ;    % 1st col
    equal(X2, X5, X8, P) ;    % 2nd col
    equal(X3, X6, X9, P) ;    % 3rd col
    equal(X1, X5, X9, P) ;    % 1st diag
    equal(X3, X5, X7, P).     % 2nd diag

drawPos(_,Board) :-
    \+ member(0, Board).

equal(X, X, X, X).


bestMove(Pos, NextPos) :-
    minimax(Pos, NextPos, _).

play :-
    nl,
    write('===================='), nl,
	  write('= Prolog TicTacToe ='), nl,
	  write('===================='), nl, nl,
	  write('Rem : x starts the game'), nl,
	  playAskColor.
	

playAskColor :-
    nl, write('Choose x or o'), nl,
	  read(Player), nl,
	  (
	    Player \= o, Player \= x, !,     
	    write('Error : not a valid choice, Please Select Again !'), nl,
	    playAskColor                    
	    ;
	    EmptyBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0],
	    show(EmptyBoard), nl,
	
	    % Start the game with color and emptyBoard
	    play([x, play, EmptyBoard], Player)
	  ).


play([Player, play, Board], Player) :- !,
    nl, write('Write your next move'), nl,
    read(Pos), nl,                                 
    (
      humanMove([Player, play, Board], [NextPlayer, State, NextBoard], Pos), !,
      show(NextBoard),
      (
        State = win, !,                            
        nl, write('Game Ended and '),
        write(Player), write(' won !'), nl, nl
        ;
        State = draw, !,                            
        nl, write('Game ended in a Draw'), nl
        ;
        play([NextPlayer, play, NextBoard], Player) 
      )
      ;
      write('Invalid Move, Try Again'), nl,            
      play([Player, play, Board], Player)        
    ).



play([Player, play, Board], HumanPlayer) :-
    nl, write('Computer choses : '), nl, nl,
    bestMove([Player, play, Board], [NextPlayer, State, BestSuccBoard]),
    show(BestSuccBoard),
    (
      State = win, !,                                 % If Player win -> stop
      nl, write('Game ended and '),
      write(Player), write(' won !'), nl, nl
      ;
      State = draw, !,                                % If draw -> stop
      nl, write('Game ended in a Draw'), nl
      ;
      play([NextPlayer, play, BestSuccBoard], HumanPlayer)
    ).

nextPlayer(o, x).
nextPlayer(x, o).

humanMove([X1, play, Board], [X2, State, NextBoard], Pos) :-
    nextPlayer(X1, X2),
    set1(Pos, X1, Board, NextBoard),
    (
      winPos(X1, NextBoard), !, State = win ;
      drawPos(X1,NextBoard), !, State = draw ;
      State = play
    ).


set1(1, E, [X|Ls], [E|Ls]) :- !, X = 0.

set1(P, E, [X|Ls], [X|L2s]) :-
    number(P),
    P1 is P - 1,
    set1(P1, E, Ls, L2s).

show([X1, X2, X3, X4, X5, X6, X7, X8, X9]) :-
    write('   '), show2(X1),
    write(' | '), show2(X2),
    write(' | '), show2(X3), nl,
    write('  -----------'), nl,
    write('   '), show2(X4),
    write(' | '), show2(X5),
    write(' | '), show2(X6), nl,
    write('  -----------'), nl,
    write('   '), show2(X7),
    write(' | '), show2(X8),
    write(' | '), show2(X9), nl.

show2(X) :-
    X = 0, !,
    write(' ').

show2(X) :-
    write(X).
