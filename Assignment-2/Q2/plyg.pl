play:-
nl,
    (
    Board=[-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-,-],
show_board(Board),nl,
P1cap=0,
P2cap=0,
WrongMv=[],
player1_turn(Board,P1cap,P2cap,WrongMv)
    ).

player1_turn(Board,P1cap,P2cap,WrongMv):-
      write('Player 1 Move? (b)'),nl,
      read(Pos),nl,
      Player = b,
      replace(Board, Pos,Player, Next_Board),
      show_board(Next_Board),
      write('Captures by Black :'),write(P1cap),write(', Captures by White :'),write(P2cap),nl,
      sleep(5),
      Opponent=w,
      Count=0,
      check_win_pos(Player,Opponent,Next_Board,Count,P1cap,P2cap,WrongMv).

player2_turn(Next_Board,P1cap,P2cap,WrongMv):-
Player = w,
Opponent=b,
Count=0,
check_win_pos_1(Player,Opponent,Next_Board,Count,P1cap,P2cap,WrongMv).

check_win_pos(Player,Opponent,Board,Count,P1cap,P2cap,WrongMv):-
Count < 25,
nth0(Count,Board,Y),
listOpp=[],
Neighbour=[],
win_pos(Y,Player,Opponent,Board,Count,listOpp,Neighbour,P1cap,P2cap,WrongMv),
    Counter1 is Count+1,
    check_win_pos(Player,Opponent,Board,Counter1,P1cap,P2cap,WrongMv);
    Opponent = w, player2_turn(Board,P1cap,P2cap,WrongMv);
    Opponent = b,   player1_turn(Board,P1cap,P2cap,WrongMv).

win_pos(Y,Player, Opponent,Board,Pos,listOpp,Neighbour,P1cap,P2cap,WrongMv):-
Y= Opponent,
collect_Neighbour(Opponent,Board,Pos,listOpp,Neighbour,P1cap,P2cap,WrongMv),
write('End neighbour list');
Counter1 is Pos+1,
check_win_pos(Player,Opponent,Board,Counter1,P1cap,P2cap,WrongMv),write('miss'),nl.

collect_Neighbour(Opponent,Board,Pos,listOpp,Neighbour,P1cap,P2cap,WrongMv):-

    member_chk(Pos,listOpp,A),
    A=false,
    member_chk(Pos,Neighbour,Z),

    Z=false,
    add(Pos,listOpp,New_Opp_list),

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

    Count=0,!,
    check_opp(Pos,Opponent,Board,New_Opp_list,Neb_List,Count,P1cap,P2cap,WrongMv);
    check_neighbour_list(Opponent,Board,listOpp,Neighbour,P1cap,P2cap,WrongMv).

check_opp(Pos,Opponent,Board,listOpp,Neighbour,Count,P1cap,P2cap,WrongMv):-
    Count<25,
    member_chk(Count,Neighbour,B),
    B = true,
    nth0(Count,Board,Y),
    is_mem(Y,Opponent,Board,Count,listOpp,Neighbour,P1cap,P2cap,WrongMv),
    Counter1 is Count+1,
    check_opp(Pos,Opponent,Board,listOpp,Neighbour,Counter1,P1cap,P2cap,WrongMv);
    Count<25,
    Counter1 is Count+1,
    check_opp(Pos,Opponent,Board,listOpp,Neighbour,Counter1,P1cap,P2cap,WrongMv);
    Count=25,
    check_neighbour_list(Opponent,Board,listOpp,Neighbour,P1cap,P2cap,WrongMv).


check_neighbour_list(Opponent,Board,listOpp,Neighbour,P1cap,P2cap,WrongMv):-
len(listOpp,Len),
Length is Len-1,
nth0(Length,listOpp,D),
    delete(Neighbour,D,Neb_List),
    Count=0,
    len(Neb_List,Len1),
    is_surounded_by_player(Count,Len1,Opponent,Board,listOpp,Neb_List,P1cap,P2cap,WrongMv).

is_surounded_by_player(Count,Len ,Opponent,Board,listOpp,Neb_List,P1cap,P2cap,WrongMv):-
    Count<Len,
    nth0(Count,Neb_List,M),
    nth0(M,Board,Pos),
    Pos \= Opponent,
    Pos \= -,
    Counter_1 is Count+1,
    is_surounded_by_player(Counter_1,Len ,Opponent,Board,listOpp,Neb_List,P1cap,P2cap,WrongMv);

    Count=Len,
    Counter2=0,
    len(listOpp,Len1),
    remove_opponent(Counter2,Len1 ,Opponent,Board,listOpp,Neb_List,P1cap,P2cap,WrongMv).


remove_opponent(Count,Len1 ,Opponent,Board,listOpp,Neb_List,P1cap,P2cap,WrongMv):-
     Count<Len1,
     nth0(Count,listOpp,M),
     L1=[M],
     append(L1,WrongMv,Invalid_move_1),
    replace(Board,M,-, Next_Board),
    Counter1 is Count+1,
    remove_opponent(Counter1,Len1 ,Opponent,Next_Board,listOpp,Neb_List,P1cap,P2cap,Invalid_move_1);
     Count=Len1,
 update_board(Opponent,Board,P1cap,P2cap,WrongMv).

update_board(Opponent,Board,B,X2,WrongMv):-
     nl,show_board(Board),
     Opponent = w,incr(B, X1),write('Captures by Black :'),write(X1),write(', Captures by White :'),write(X2),nl, player2_turn(Board,X1,X2,WrongMv);
    Opponent = b,incr(X2, X3),write('Captures by Black :'),write(B),write(', Captures by White :'),write(X3),nl, player1_turn(Board,B,X3,WrongMv).

incr(B, X1) :-
    X1 is B+1
    .
is_mem(Y,Opponent,Board,Mem,listOpp,Neighbour,P1cap,P2cap,WrongMv):-
    Y=Opponent,
    delete(Neighbour,Mem,Neb_List),
    collect_Neighbour(Opponent,Board,Mem,listOpp,Neb_List,P1cap,P2cap,WrongMv).


member_chk(Pos,List,B):-

    member(Pos,List),
    B= true,!;
    B= false.

add(B,List,[B|List]).

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


replace([_|T], 0, B, [B|T]).
replace([H|T], I, B, [H|R]):- I > -1, NI is I-1, replace(T, NI, B, R), !.

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
show2(B) :-
    B = -, !,
    write('- ').
show2(B) :-
    write(B),write(' ').


check_win_pos_1(Player,Opponent,Board,Count,P1cap,P2cap,WrongMv):-
     Count < 25,
     nth0(Count,Board,Y),
     listOpp=[],
     Neighbour=[],
     winpose_1(Y,Player,Opponent,Board,Count,listOpp,Neighbour,P1cap,P2cap,WrongMv),
    Counter1 is Count+1,
    check_win_pos_1(Player,Opponent,Board,Counter1,P1cap,P2cap,WrongMv);
    Count=0,
    check_winpose_2(Player,Opponent,Board,Count,P1cap,P2cap,WrongMv).


winpose_1(Y,Player, Opponent,Board,Pos,listOpp,Neighbour,P1cap,P2cap,WrongMv):-
    Y= Opponent,
    collect_Neighbour_1(Opponent,Board,Pos,listOpp,Neighbour,P1cap,P2cap,WrongMv),
    write('End neighbour list');
    Counter1 is Pos+1,
    check_win_pos_1(Player,Opponent,Board,Counter1,P1cap,P2cap,WrongMv),write('miss'),nl.

collect_Neighbour_1(Opponent,Board,Pos,listOpp,Neighbour,P1cap,P2cap,WrongMv):-
    member_chk(Pos,listOpp,A),

    A=false,
    member_chk(Pos,Neighbour,Z),
    Z=false,
    add(Pos,listOpp,New_Opp_list),

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

    Count=0,!,
    check_opp_1(Pos,Opponent,Board,New_Opp_list,Neb_List,Count,P1cap,P2cap,WrongMv);

    check_neighbour_list_1(Opponent,Board,listOpp,Neighbour,P1cap,P2cap,WrongMv).

check_opp_1(Pos,Opponent,Board,listOpp,Neighbour,Count,P1cap,P2cap,WrongMv):-
    Count<25,

    member_chk(Count,Neighbour,B),
    B = true,
    nth0(Count,Board,Y),
    is_mem_1(Y,Opponent,Board,Count,listOpp,Neighbour,P1cap,P2cap,WrongMv),
    Counter1 is Count+1,
    check_opp_1(Pos,Opponent,Board,listOpp,Neighbour,Counter1,P1cap,P2cap,WrongMv);
    Count<25,
   Counter1 is Count+1,
    check_opp_1(Pos,Opponent,Board,listOpp,Neighbour,Counter1,P1cap,P2cap,WrongMv);
    Count=25,
    check_neighbour_list_1(Opponent,Board,listOpp,Neighbour,P1cap,P2cap,WrongMv).


is_mem_1(Y,Opponent,Board,Mem,listOpp,Neighbour,P1cap,P2cap,WrongMv):-
    Y=Opponent,
    delete(Neighbour,Mem,Neb_List),
    collect_Neighbour_1(Opponent,Board,Mem,listOpp,Neb_List,P1cap,P2cap,WrongMv).

check_neighbour_list_1(Opponent,Board,listOpp,Neighbour,P1cap,P2cap,WrongMv):-
   len(listOpp,Len),
   Length is Len-1,
    nth0(Length,listOpp,D),
   delete(Neighbour,D,Neb_List),
    Count=0,
    len(Neb_List,Len1),
    New_list=[],
    is_surounded_by_player_1(Count,Len1,Opponent,Board,listOpp,Neb_List,P1cap,P2cap,New_list,WrongMv).

is_surounded_by_player_1(Count,Len ,Opponent,Board,listOpp,Neb_List,P1cap,P2cap,New_list,WrongMv):-
    Count<Len,
    nth0(Count,Neb_List,M),
    nth0(M,Board,Pos),
    Pos \= Opponent,
    Pos = -,
    L=[M],
    append(L,New_list,Last_list),

    Counter_1 is Count+1,
    !,
    is_surounded_by_player_1(Counter_1,Len ,Opponent,Board,listOpp,Neb_List,P1cap,P2cap,Last_list,WrongMv);
    Count<Len,
    Counter_1 is Count+1,
    !,
    is_surounded_by_player_1(Counter_1,Len ,Opponent,Board,listOpp,Neb_List,P1cap,P2cap,New_list,WrongMv);
    len(New_list,Len1),
    Len1=1,
    nth0(0,Neb_List,F1),
    nth0(F1,Board,F2),
    F2 \= b,

    nth0(1,Neb_List,F3),
    nth0(F3,Board,F4),
    F4 \= b,

    nth0(0,New_list,First_mem),
    member_chk(First_mem,WrongMv,B),!,
    B=false,
    move_player_2(Board,P1cap,P2cap,First_mem,WrongMv).

move_player_2(Next_Board,P1cap,P2cap,Pos,WrongMv):-

      write('Player 2 Move? Computer (w)'),nl,
      write(Pos),nl,
      Player = w,
      replace(Next_Board, Pos, Player, Board),
      show_board(Board),
      write('Captures by Black :'),write(P1cap),write(', Captures by White :'),write(P2cap),nl,
      sleep(5),
      Opponent=b,
      Count=0,
      check_win_pos(Player,Opponent,Board,Count,P1cap,P2cap,WrongMv).

check_winpose_2(Player,Opponent,Board,Count,P1cap,P2cap,WrongMv):-
     Count < 25,
     nth0(Count,Board,Y),
     listOpp=[],
     Neighbour=[],
     winpose_2(Y,Player,Opponent,Board,Count,listOpp,Neighbour,P1cap,P2cap,WrongMv),
    Counter1 is Count+1,
    check_winpose_2(Player,Opponent,Board,Counter1,P1cap,P2cap,WrongMv).



winpose_2(Y,Player, Opponent,Board,Pos,listOpp,Neighbour,P1cap,P2cap,WrongMv):-
    Y= Opponent,
    collect_Neighbour_2(Opponent,Board,Pos,listOpp,Neighbour,P1cap,P2cap,WrongMv),
    write('End neighbour list');
    Counter1 is Pos+1,
    check_winpose_2(Player,Opponent,Board,Counter1,P1cap,P2cap,WrongMv),write('miss'),nl.

collect_Neighbour_2(Opponent,Board,Pos,listOpp,Neighbour,P1cap,P2cap,WrongMv):-

    member_chk(Pos,listOpp,A),
    A=false,
    member_chk(Pos,Neighbour,Z),
    Z=false,
    add(Pos,listOpp,New_Opp_list),
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

    Count=0,!,
    check_opp_2(Pos,Opponent,Board,New_Opp_list,Neb_List,Count,P1cap,P2cap,WrongMv);
    check_neighbour_list_2(Opponent,Board,listOpp,Neighbour,P1cap,P2cap,WrongMv).

check_opp_2(Pos,Opponent,Board,listOpp,Neighbour,Count,P1cap,P2cap,WrongMv):-
    Count<25,

    member_chk(Count,Neighbour,B),
    B = true,
    nth0(Count,Board,Y),

    is_mem_2(Y,Opponent,Board,Count,listOpp,Neighbour,P1cap,P2cap,WrongMv),
    Counter1 is Count+1,
    check_opp_2(Pos,Opponent,Board,listOpp,Neighbour,Counter1,P1cap,P2cap,WrongMv);
    Count<25,
   Counter1 is Count+1,
    check_opp_2(Pos,Opponent,Board,listOpp,Neighbour,Counter1,P1cap,P2cap,WrongMv);
    Count=25,
    check_neighbour_list_2(Opponent,Board,listOpp,Neighbour,P1cap,P2cap,WrongMv).

is_mem_2(Y,Opponent,Board,Mem,listOpp,Neighbour,P1cap,P2cap,WrongMv):-

    Y=Opponent,
    delete(Neighbour,Mem,Neb_List),
    collect_Neighbour_2(Opponent,Board,Mem,listOpp,Neb_List,P1cap,P2cap,WrongMv).

check_neighbour_list_2(Opponent,Board,listOpp,Neighbour,P1cap,P2cap,WrongMv):-
   len(listOpp,Len),
   Length is Len-1,
    nth0(Length,listOpp,D),
   delete(Neighbour,D,Neb_List),
    Count=0,
    len(Neb_List,Len1),
    New_list=[],
    is_surounded_by_player_2(Count,Len1,Opponent,Board,listOpp,Neb_List,P1cap,P2cap,New_list,WrongMv).

is_surounded_by_player_2(Count,Len ,Opponent,Board,listOpp,Neb_List,P1cap,P2cap,New_list,WrongMv):-
    Count<Len,
    nth0(Count,Neb_List,M),
    nth0(M,Board,Pos),
    Pos \= Opponent,
    Pos = -,
    L=[M],
    append(L,New_list,Last_list),
    Counter_1 is Count+1,

    is_surounded_by_player_2(Counter_1,Len ,Opponent,Board,listOpp,Neb_List,P1cap,P2cap,Last_list,WrongMv);
    nth0(0,New_list,First_mem),
    member_chk(First_mem,WrongMv,B),!,
    B=false,
    move_player_2(Board,P1cap,P2cap,First_mem,WrongMv).