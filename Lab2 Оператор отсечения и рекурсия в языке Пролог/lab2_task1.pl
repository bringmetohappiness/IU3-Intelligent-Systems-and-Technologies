% Решение для https://swish.swi-prolog.org/:

% CLAUSES

threeZeros(A, B, C) :-
    A = 0,
    B = 0,
    C = 0,
    write("The decision is any number."), nl, !.


notEquation(A, B, C) :-
    A = 0,
    B = 0,
    not(C = 0),
    write("It is not a equation."), nl, !.


noRoots(A, B, C) :-
    D = B * B - 4 * A * C,
    D < 0,
    write("There is no roots."), nl, !.


oneRoot(A, B, C) :-
    D = B * B - 4 * A * C,
    D = 0,
    X = (-B / (2 * A)),
    write("The decision is"), nl,
    write(X), nl, !.


oneRootA(A, B, C) :-
    A = 0,
    X = (-C / B),
    write("The decision is"), nl,
    write(X), nl, !.


twoRoots(A, B, C) :-
    D = B * B - 4 * A * C,
    D > 0,
    X1 = ((-B + sqrt(D)) / (2 * A)),
    X2 = ((-B - sqrt(D)) / (2 * A)),
    write("The decision is"), nl,
    write(X1), nl,
    write(X2), nl,!.


decision(A, B, C) :-
    not(threeZeros(A, B, C)),
    not(notEquation(A, B, C)),
    not(noRoots(A, B, C)),
    not(oneRoot(A, B, C)),
    not(oneRootA(A, B, C)),
    twoRoots(A, B, C).


% GOAL

decision(0, 0, 1).
