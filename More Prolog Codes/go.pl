play :-
    nl,
    write('********************'), nl,
	  write('* Prolog GO game *'), nl,
	  write('********5x5 Board************'), nl, nl,
          game.

game:-
    nl,write('Enter s for single player'),nl,
    read(Game),nl,
    ( Game \= s, Game \= m,!,
      write('Error : Not valid Game. Try again (s or m)'),nl,
      game;
    ask_player(Game)
               ).
ask_player(Game):-
    nl,write('Player 1? (o or x)'),nl,
    read(Player_1),nl,
    ( Player_1 \= o, Player_1 \= x, !,
      write('Error : not a valid color !'), nl,
      ask_player(Game);
      Board=[-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-],
      show_board(Board),nl,

      S=0,
      S1=0,
      Invalid_move=[],
      move_player1(Board,S,S1,Invalid_move)
    ).

move_player1(Board,S,S1,Invalid_move):-
      write('Player 1 Move? (x)'),nl,
      read(Pos),nl,
      Player = x,
      replace(Board, Pos,Player, NextBoard),
      show_board(NextBoard),
      write('Player X :'),write(S),nl,write('Player O :'),write(S1),nl,
      sleep(5),
      Opponent=o,
      Counter=0,
      check_winpose(Player,Opponent,NextBoard,Counter,S,S1,Invalid_move).


move_player2(NextBoard,S,S1,Invalid_move):-
      Player = o,
      Opponent=x,
      Counter=0,
      check_winpose_1(Player,Opponent,NextBoard,Counter,S,S1,Invalid_move).



check_winpose(Player,Opponent,Board,Counter,S,S1,Invalid_move):-
     Counter < 25,
     nth0(Counter,Board,Y),
     Opp_list=[],
     Neighbour=[],
     winpose(Y,Player,Opponent,Board,Counter,Opp_list,Neighbour,S,S1,Invalid_move),
    Counter1 is Counter+1,
    check_winpose(Player,Opponent,Board,Counter1,S,S1,Invalid_move);
    Opponent = o, move_player2(Board,S,S1,Invalid_move);
    Opponent = x,   move_player1(Board,S,S1,Invalid_move).


winpose(Y,Player, Opponent,Board,Pos,Opp_list,Neighbour,S,S1,Invalid_move):-
    Y= Opponent,
    collect_Neighbour(Opponent,Board,Pos,Opp_list,Neighbour,S,S1,Invalid_move),
    write('End neighbour list');
    Counter1 is Pos+1,
    check_winpose(Player,Opponent,Board,Counter1,S,S1,Invalid_move),write('miss'),nl.

collect_Neighbour(Opponent,Board,Pos,Opp_list,Neighbour,S,S1,Invalid_move):-

    member_chk(Pos,Opp_list,A),
    A=false,
    member_chk(Pos,Neighbour,Z),

    Z=false,
    add(Pos,Opp_list,New_Opp_list),

    NU is Pos-5,
    limit_neighbour(NU,Neighbour, New_neighbour1),
    delete(New_neighbour1,Pos,Neb_List1),

    ND is Pos+5,
    limit_neighbour(ND,Neb_List1, New_neighbour2),
    delete(New_neighbour2,Pos,Neb_List2),

    NL is Pos-1,
    limit_neighbour2(Pos,NL,Neb_List2, New_neighbour3),
    delete(New_neighbour3,Pos,Neb_List3),

    NR is Pos+1,
    limit_neighbour1(Pos,NR,Neb_List3, New_neighbour4),
    delete(New_neighbour4,Pos,Neb_List),

    Counter=0,!,
    check_opp(Pos,Opponent,Board,New_Opp_list,Neb_List,Counter,S,S1,Invalid_move);
    check_neighbour_list(Opponent,Board,Opp_list,Neighbour,S,S1,Invalid_move).

check_opp(Pos,Opponent,Board,Opp_list,Neighbour,Counter,S,S1,Invalid_move):-
    Counter<25,
    member_chk(Counter,Neighbour,X),
    X = true,
    nth0(Counter,Board,Y),
    is_mem(Y,Opponent,Board,Counter,Opp_list,Neighbour,S,S1,Invalid_move),
    Counter1 is Counter+1,
    check_opp(Pos,Opponent,Board,Opp_list,Neighbour,Counter1,S,S1,Invalid_move);
    Counter<25,
    Counter1 is Counter+1,
    check_opp(Pos,Opponent,Board,Opp_list,Neighbour,Counter1,S,S1,Invalid_move);
    Counter=25,
    check_neighbour_list(Opponent,Board,Opp_list,Neighbour,S,S1,Invalid_move).


check_neighbour_list(Opponent,Board,Opp_list,Neighbour,S,S1,Invalid_move):-
   len(Opp_list,Len),
   Length is Len-1,
    nth0(Length,Opp_list,D),
   delete(Neighbour,D,Neb_List),
    Counter=0,
    len(Neb_List,Len1),
    is_surounded_by_player(Counter,Len1,Opponent,Board,Opp_list,Neb_List,S,S1,Invalid_move).

is_surounded_by_player(Counter,Len ,Opponent,Board,Opp_list,Neb_List,S,S1,Invalid_move):-
    Counter<Len,
    nth0(Counter,Neb_List,M),
    nth0(M,Board,Pos),
    Pos \= Opponent,
    Pos \= -,
    Counter_1 is Counter+1,
    is_surounded_by_player(Counter_1,Len ,Opponent,Board,Opp_list,Neb_List,S,S1,Invalid_move);

    Counter=Len,
    Counter2=0,
    len(Opp_list,Len1),
    remove_opponent(Counter2,Len1 ,Opponent,Board,Opp_list,Neb_List,S,S1,Invalid_move).


remove_opponent(Counter,Len1 ,Opponent,Board,Opp_list,Neb_List,S,S1,Invalid_move):-
     Counter<Len1,
     nth0(Counter,Opp_list,M),
     L1=[M],
     append(L1,Invalid_move,Invalid_move_1),
    replace(Board,M,-, NextBoard),
    Counter1 is Counter+1,
    remove_opponent(Counter1,Len1 ,Opponent,NextBoard,Opp_list,Neb_List,S,S1,Invalid_move_1);
     Counter=Len1,
 update_board(Opponent,Board,S,S1,Invalid_move).

update_board(Opponent,Board,X,X2,Invalid_move):-
     nl,show_board(Board),
     Opponent = o,incr(X, X1),write('Player X :'),write(X1),nl,write('Player O :'),write(X2),nl, move_player2(Board,X1,X2,Invalid_move);
    Opponent = x,incr(X2, X3),write('Player X :'),write(X),nl,write('Player O :'),write(X3),nl, move_player1(Board,X,X3,Invalid_move).

incr(X, X1) :-
    X1 is X+1
    .
is_mem(Y,Opponent,Board,Mem,Opp_list,Neighbour,S,S1,Invalid_move):-
    Y=Opponent,
    delete(Neighbour,Mem,Neb_List),
    collect_Neighbour(Opponent,Board,Mem,Opp_list,Neb_List,S,S1,Invalid_move).


member_chk(Pos,List,X):-

    member(Pos,List),
    X= true,!;
    X= false.

add(X,List,[X|List]).

len([], LenResult):-
    LenResult is 0.

len([_|Y], LenResult):-
    len(Y, L),
    LenResult is L + 1.

limit_neighbour(N,Neighbour, New_neighbour):-
    N> -1,
    N<25,
    L=[N],
    append(L,Neighbour, New_neighbour);New_neighbour=Neighbour.

limit_neighbour1(Pos,N,Neighbour, New_neighbour):-
    List=[4,9,14,19,24],
    memberchk(Pos,List),
    New_neighbour=Neighbour;

    N> -1,
    N<25,
    L=[N],
    append(L,Neighbour, New_neighbour).

limit_neighbour2(Pos,N,Neighbour, New_neighbour):-
    List=[0,5,10,15,20],
    memberchk(Pos,List),
    New_neighbour=Neighbour;

    N> -1,
    N<25,
    L=[N],
    append(L,Neighbour, New_neighbour).


replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.

show_board([X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16,X17,X18,X19,X20,X21,X22,X23,X24,X25]):-
     open('data.txt', write,Stream),
      write(Stream,[X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,X16,X17,X18,X19,X20,X21,X22,X23,X24,X25]),nl,
      close(Stream),
    write('    '),write('0 '),write('1 '),write('2 '),write('3 '),write('4'),nl,nl,

    write('0   '),show2(X1),show2(X2),show2(X3),show2(X4),show2(X5),nl,
    write('5   '),show2(X6),show2(X7),show2(X8),show2(X9),show2(X10),nl,
    write('10  '),show2(X11),show2(X12),show2(X13),show2(X14),show2(X15),nl,
    write('15  '),show2(X16),show2(X17),show2(X18),show2(X19),show2(X20),nl,
    write('20  '),show2(X21),show2(X22),show2(X23),show2(X24),show2(X25),nl.


% show2(+Term)
% Write the term to current outupt
% Replace 0 by ' '.
show2(X) :-
    X = -, !,
    write('- ').
show2(X) :-
    write(X),write(' ').


check_winpose_1(Player,Opponent,Board,Counter,S,S1,Invalid_move):-
     Counter < 25,
     nth0(Counter,Board,Y),
     Opp_list=[],
     Neighbour=[],
     winpose_1(Y,Player,Opponent,Board,Counter,Opp_list,Neighbour,S,S1,Invalid_move),
    Counter1 is Counter+1,
    check_winpose_1(Player,Opponent,Board,Counter1,S,S1,Invalid_move);
    Counter=0,
    check_winpose_2(Player,Opponent,Board,Counter,S,S1,Invalid_move).


winpose_1(Y,Player, Opponent,Board,Pos,Opp_list,Neighbour,S,S1,Invalid_move):-
    Y= Opponent,
    collect_Neighbour_1(Opponent,Board,Pos,Opp_list,Neighbour,S,S1,Invalid_move),
    write('End neighbour list');
    Counter1 is Pos+1,
    check_winpose_1(Player,Opponent,Board,Counter1,S,S1,Invalid_move),write('miss'),nl.

collect_Neighbour_1(Opponent,Board,Pos,Opp_list,Neighbour,S,S1,Invalid_move):-
    member_chk(Pos,Opp_list,A),

    A=false,
    member_chk(Pos,Neighbour,Z),
    Z=false,
    add(Pos,Opp_list,New_Opp_list),

    NU is Pos-5,
    limit_neighbour(NU,Neighbour, New_neighbour1),
    delete(New_neighbour1,Pos,Neb_List1),
    ND is Pos+5,

    limit_neighbour(ND,Neb_List1, New_neighbour2),
    delete(New_neighbour2,Pos,Neb_List2),

    NL is Pos-1,
    limit_neighbour2(Pos,NL,Neb_List2, New_neighbour3),
    delete(New_neighbour3,Pos,Neb_List3),
    NR is Pos+1,

    limit_neighbour1(Pos,NR,Neb_List3, New_neighbour4),
    delete(New_neighbour4,Pos,Neb_List),

    Counter=0,!,
    check_opp_1(Pos,Opponent,Board,New_Opp_list,Neb_List,Counter,S,S1,Invalid_move);

    check_neighbour_list_1(Opponent,Board,Opp_list,Neighbour,S,S1,Invalid_move).

check_opp_1(Pos,Opponent,Board,Opp_list,Neighbour,Counter,S,S1,Invalid_move):-
    Counter<25,

    member_chk(Counter,Neighbour,X),
    X = true,
    nth0(Counter,Board,Y),
    is_mem_1(Y,Opponent,Board,Counter,Opp_list,Neighbour,S,S1,Invalid_move),
    Counter1 is Counter+1,
    check_opp_1(Pos,Opponent,Board,Opp_list,Neighbour,Counter1,S,S1,Invalid_move);
    Counter<25,
   Counter1 is Counter+1,
    check_opp_1(Pos,Opponent,Board,Opp_list,Neighbour,Counter1,S,S1,Invalid_move);
    Counter=25,
    check_neighbour_list_1(Opponent,Board,Opp_list,Neighbour,S,S1,Invalid_move).


is_mem_1(Y,Opponent,Board,Mem,Opp_list,Neighbour,S,S1,Invalid_move):-
    Y=Opponent,
    delete(Neighbour,Mem,Neb_List),
    collect_Neighbour_1(Opponent,Board,Mem,Opp_list,Neb_List,S,S1,Invalid_move).

check_neighbour_list_1(Opponent,Board,Opp_list,Neighbour,S,S1,Invalid_move):-
   len(Opp_list,Len),
   Length is Len-1,
    nth0(Length,Opp_list,D),
   delete(Neighbour,D,Neb_List),
    Counter=0,
    len(Neb_List,Len1),
    New_list=[],
    is_surounded_by_player_1(Counter,Len1,Opponent,Board,Opp_list,Neb_List,S,S1,New_list,Invalid_move).

is_surounded_by_player_1(Counter,Len ,Opponent,Board,Opp_list,Neb_List,S,S1,New_list,Invalid_move):-
    Counter<Len,
    nth0(Counter,Neb_List,M),
    nth0(M,Board,Pos),
    Pos \= Opponent,
    Pos = -,
    L=[M],
    append(L,New_list,Last_list),

    Counter_1 is Counter+1,
    !,
    is_surounded_by_player_1(Counter_1,Len ,Opponent,Board,Opp_list,Neb_List,S,S1,Last_list,Invalid_move);
    Counter<Len,
    Counter_1 is Counter+1,
    !,
    is_surounded_by_player_1(Counter_1,Len ,Opponent,Board,Opp_list,Neb_List,S,S1,New_list,Invalid_move);
    len(New_list,Len1),
    Len1=1,
    nth0(0,Neb_List,F1),
    nth0(F1,Board,F2),
    F2 \= x,

    nth0(1,Neb_List,F3),
    nth0(F3,Board,F4),
    F4 \= x,

    nth0(0,New_list,First_mem),
    member_chk(First_mem,Invalid_move,X),!,
    X=false,
    move_player_2(Board,S,S1,First_mem,Invalid_move).

move_player_2(NextBoard,S,S1,Pos,Invalid_move):-

      write('Player 2 Move? Computer (o)'),nl,
      write(Pos),nl,
      Player = o,
      replace(NextBoard, Pos, Player, Board),
      show_board(Board),
      write('Player X :'),write(S),nl,write('Player O :'),write(S1),nl,
      sleep(5),
      Opponent=x,
      Counter=0,
      check_winpose(Player,Opponent,Board,Counter,S,S1,Invalid_move).

check_winpose_2(Player,Opponent,Board,Counter,S,S1,Invalid_move):-
     Counter < 25,
     nth0(Counter,Board,Y),
     Opp_list=[],
     Neighbour=[],
     winpose_2(Y,Player,Opponent,Board,Counter,Opp_list,Neighbour,S,S1,Invalid_move),
    Counter1 is Counter+1,
    check_winpose_2(Player,Opponent,Board,Counter1,S,S1,Invalid_move).



winpose_2(Y,Player, Opponent,Board,Pos,Opp_list,Neighbour,S,S1,Invalid_move):-
    Y= Opponent,
    collect_Neighbour_2(Opponent,Board,Pos,Opp_list,Neighbour,S,S1,Invalid_move),
    write('End neighbour list');
    Counter1 is Pos+1,
    check_winpose_2(Player,Opponent,Board,Counter1,S,S1,Invalid_move),write('miss'),nl.

collect_Neighbour_2(Opponent,Board,Pos,Opp_list,Neighbour,S,S1,Invalid_move):-

    member_chk(Pos,Opp_list,A),
    A=false,
    member_chk(Pos,Neighbour,Z),
    Z=false,
    add(Pos,Opp_list,New_Opp_list),
    NU is Pos-5,
    limit_neighbour(NU,Neighbour, New_neighbour1),
    delete(New_neighbour1,Pos,Neb_List1),
    ND is Pos+5,
    limit_neighbour(ND,Neb_List1, New_neighbour2),
    delete(New_neighbour2,Pos,Neb_List2),
    NL is Pos-1,
    limit_neighbour2(Pos,NL,Neb_List2, New_neighbour3),
    delete(New_neighbour3,Pos,Neb_List3),
    NR is Pos+1,

    limit_neighbour1(Pos,NR,Neb_List3, New_neighbour4),
    delete(New_neighbour4,Pos,Neb_List),

    Counter=0,!,
    check_opp_2(Pos,Opponent,Board,New_Opp_list,Neb_List,Counter,S,S1,Invalid_move);
    check_neighbour_list_2(Opponent,Board,Opp_list,Neighbour,S,S1,Invalid_move).

check_opp_2(Pos,Opponent,Board,Opp_list,Neighbour,Counter,S,S1,Invalid_move):-
    Counter<25,

    member_chk(Counter,Neighbour,X),
    X = true,
    nth0(Counter,Board,Y),

    is_mem_2(Y,Opponent,Board,Counter,Opp_list,Neighbour,S,S1,Invalid_move),
    Counter1 is Counter+1,
    check_opp_2(Pos,Opponent,Board,Opp_list,Neighbour,Counter1,S,S1,Invalid_move);
    Counter<25,
   Counter1 is Counter+1,
    check_opp_2(Pos,Opponent,Board,Opp_list,Neighbour,Counter1,S,S1,Invalid_move);
    Counter=25,
    check_neighbour_list_2(Opponent,Board,Opp_list,Neighbour,S,S1,Invalid_move).

is_mem_2(Y,Opponent,Board,Mem,Opp_list,Neighbour,S,S1,Invalid_move):-

    Y=Opponent,
    delete(Neighbour,Mem,Neb_List),
    collect_Neighbour_2(Opponent,Board,Mem,Opp_list,Neb_List,S,S1,Invalid_move).

check_neighbour_list_2(Opponent,Board,Opp_list,Neighbour,S,S1,Invalid_move):-
   len(Opp_list,Len),
   Length is Len-1,
    nth0(Length,Opp_list,D),
   delete(Neighbour,D,Neb_List),
    Counter=0,
    len(Neb_List,Len1),
    New_list=[],
    is_surounded_by_player_2(Counter,Len1,Opponent,Board,Opp_list,Neb_List,S,S1,New_list,Invalid_move).

is_surounded_by_player_2(Counter,Len ,Opponent,Board,Opp_list,Neb_List,S,S1,New_list,Invalid_move):-
    Counter<Len,
    nth0(Counter,Neb_List,M),
    nth0(M,Board,Pos),
    Pos \= Opponent,
    Pos = -,
    L=[M],
    append(L,New_list,Last_list),
    Counter_1 is Counter+1,

    is_surounded_by_player_2(Counter_1,Len ,Opponent,Board,Opp_list,Neb_List,S,S1,Last_list,Invalid_move);
    nth0(0,New_list,First_mem),
    member_chk(First_mem,Invalid_move,X),!,
    X=false,
    move_player_2(Board,S,S1,First_mem,Invalid_move).


