% Решение для https://swish.swi-prolog.org/:

% CLAUSES

% конец списка - признак выхода из рекурсии.
delete(_, [], []) :- !.

% если в начале списка стоит заданное число, то не добавляем его в
% результирующий список.
delete(Input, [Input|Tail], ResultList) :-
    delete(Input, Tail, ResultList), !.

% если в начале списка стоит не заданное число, то добавляем его в
% результирующий список.
delete(Input, [NotInput|Tail], [NotInput|ResultList]) :-
    delete(Input, Tail, ResultList).


% GOAL

delete(2, [3,5,2,4,2,6], ResultList).
