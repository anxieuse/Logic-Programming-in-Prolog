% Реализация предикатов обработки списков

% length(список, длина)
leo_length([], 0).
leo_length([_|T], N) :- leo_length(T, N1), N is N1 + 1.

% member(член, список)
leo_member(A, [A|_]).
leo_member(A, [_|T]) :- leo_member(A, T).

% append(первый список, второй, результат)
leo_append([], L, L).
leo_append([X|L1], L2, [X|L3]) :- leo_append(L1, L2, L3).

% remove(кого, откуда, результат)
leo_remove(X, [X|T], T).
leo_remove(X, [Y|T], [Y|Z]) :- leo_remove(X, T, Z).

% permute(список, перестановка)
leo_permute([], []).
leo_permute(L, [X|T]) :- leo_remove(X, L, Y), leo_permute(Y, T).

% sublist(подсписок, список)
leo_sublist(S, L) :- leo_append(_, L1, L), leo_append(S, _, L1).

% 16: Нахождение номера первого вхождения элемента с заданным значением
    % рекурсия (ff - find first)
    ff(X, [X|_], 0) :- !.
    ff(X, [_|T], N) :-
        leo_member(X, T),
        ff(X, T, N1),
        N is N1 + 1,
        !.
    % стд
    ff_std(X, T, N) :-
        append(L, [X|T1], T),
        length(L, N),
        !.


% 1: Вычисление суммы элементов
    % рекурсия
    sum([], 0).
    sum([X|T], R) :-
        sum(T, R1),
        R is R1 + X.
    % другая версия рекурсии
    sumstd(L,R) :-
        sumstd(L,0,R).
    sumstd([],F,F).
    sumstd([H|T],F,R) :-
        F2 is F+H,
        sumstd(T,F2,R).

% пример совместного использования предикатов
    % найти позицию второго вхождения числа X в списке L
    fs(X,L,N) :-
        append(Left, [X|Tail], L),
        ff(X, Tail, N1),
        length(Left, N2),
        N is N1 + N2 + 1.
