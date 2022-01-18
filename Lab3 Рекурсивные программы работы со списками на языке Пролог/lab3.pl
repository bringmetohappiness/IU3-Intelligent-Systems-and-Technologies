% Решение для https://swish.swi-prolog.org/:

% CLAUSES

person("Galina", 25).
person("Katerina", 31).
person("Dasha", 22).
person("Nelly", 27).
person("Aleksandra", 18).
person("Vladimir", 23).
person("Sergey", 21).
person("Petr", 51).
person("Trofim", 27).
person("Aleksey", 18).

getData(data(Name, Age)) :-
    person(Name, Age).


getDataList(PersonList) :-
    findall(Person, getData(Person), PersonList).


findMinEl([data(Name, Age) | Tail], Min) :-
    findMinEl_re(Tail, data(Name, Age), Min).


findMinEl_re([], Min, Min).

findMinEl_re([data(Name, Age) | Tail], data(_, Age1), Min) :-
    Age > Age1,
    findMinEl_re(Tail, data(Name, Age), Min), !.

findMinEl_re([_ | Tail], CurMin, Min) :-
    findMinEl_re(Tail, CurMin, Min).

% Если головной элемент H списка оказывается больше текущего минимального
% значения CurMin, процедура запускается рекурсивно для хвостовой части списка
% со значением CurMin = H. Иначе процедура запускается рекурсивно с сохранением
% значения CurMin. Рекурсия заканчивается, когда мы приходим к пустому списку.
% При этом в текущее значение CurMin принимают за искомое минимальное значение:
% Min = CurMin.


% Аксиомы для объединения двух списков в один
append([], List, List).

append([data(Name, Age) | Tail1], List2, [data(Name, Age) | Tail3]) :-
    append(Tail1, List2, Tail3).


% Аксиомы для исключения элемента из списка
cutEl(List, X, NewList) :-
    cutEl_re([], List, X, NewList).


cutEl_re(Head, [], _, Head). % на случай, если элемент Х отсутствует в списке.
                             % При сортировке невозможно.

cutEl_re(Head, [M | Tail], X, NewList) :-
    M = X,
    append(Head, Tail, NewList), !.

cutEl_re(Head, [M | Tail], X, NewList) :-
    append(Head, [M], NewHead),
    cutEl_re(NewHead, Tail, X, NewList).


% Процедура исключения заданного элемента из списка.
% Процедура удаляет первое вхождение элемента X в список List и сохраняет
% полученный список в NewList. Процедура работает следующим образом:
% Список делим на три части:
% |--------------------------|---|------------------------------|
% |           Head           | M |           Tail               |
% |--------------------------|---|------------------------------|
% Head - головная часть, M - текущий элемент, Tail - хвостовая часть.
% Если M <> X, то мы присоединяем текущий элемент M к головной части списка Head
% и переходим к анализу следующего элемента.
% k-ый шаг рекурсии:
% |--------------------------|---|------------------------------|
% |           Head           | M |           Tail               |
% |--------------------------|---|------------------------------|
%  (k+1)-ый шаг рекурсии:
% |------------------------------|---|--------------------------|
% |           Head               | M |           Tail           |
% |------------------------------|---|--------------------------|
% Если же M = X (заданному элементу), то мы возвращаем результирующий список,
% составленный из Head и Tail.
% На Последнем шаге рекурсии в качестве результата возвращается следующий список:
% |--------------------------|------------------------------|
% |           Head           |           Tail               |
% |--------------------------|------------------------------|


% Аксиомы для выполнения сортировки списка по убыванию
sortListDesc([], []).

sortListDesc(List, Result) :-
    findMinEl(List, Min), % находим наименьший элемент списка
    cutEl(List, Min, Rest), % исключаем его из списка
    sortListDesc(Rest, Result0), % запускаем сортировку рекурсивно на полученном списке
    Result = [Min | Result0]. % ставим наименьшитй элемент на первое место


printList([]).

printList([data(Name, Age)|Tail]) :-
    Age mod 2 >= 1,
    write(Name), write("\t"), write(Age), nl, printList(Tail), !.

printList([_|Tail]) :- printList(Tail).


% GOAL

getDataList(List), sortListDesc(List, Result), printList(Result), nl, fail.
