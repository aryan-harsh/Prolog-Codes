present(see).
past(saw).
past(believed).
past(told).
past_participle(seen).
past_participle(believed).
past_participle(told).


proper_noun(john).
proper_noun(fred).
proper_noun(mary).

prep(to).
prep(by).



be(was).
be(been).



sentence_struct(S) :-
    verbphr(S).

sentence_struct(S) :-
    interro_vstruct(S).

sentence_struct([N]) :-
    proper_noun(N).

sentence_struct(S) :-
    append(S1, [PREP | S2], S),
    sentence_struct(S1),
    prep(PREP),
    sentence_struct(S2).

sentence_struct(S) :-
    append([N], S2, S),
    proper_noun(N),
    verbphr(S2).


interro_vstruct(S) :-
    S = [B, N, V],
    be(B),
    proper_noun(N),
    past_participle(V).

verbphr(S) :-
    vstruct(S).

verbphr(S) :-
    append(S1, [N], S),
    vstruct(S1),
    proper_noun(N).


vstruct(S) :-
    S = [B, V],
    be(B),
    past_participle(V).



vstruct(S) :-
    S = [have | S1],
    vstruct(S1).

vstruct(S) :-
    S = [V],
    present(V).

vstruct(S) :-
    S = [V],
    past(V).



