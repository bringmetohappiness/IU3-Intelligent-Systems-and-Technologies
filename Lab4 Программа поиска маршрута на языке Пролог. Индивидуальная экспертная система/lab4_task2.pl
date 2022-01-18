:- dynamic 
right(Quest, Key).
:- dynamic
wrong(Quest, Key).

% readchar
process(Quest, Ans):- 
    write(Quest), 
    read(Key), 
    write(Key), nl, 
    updatebase(Quest, Ans, Key). 

updatebase(Quest, Ans, Key):- 
    Key = Ans, 
    assertz(right(Quest, Key)), !. 

updatebase(Quest, Ans, Key):- 
    assertz(wrong(Quest, Key)).

right_list(Count1):- 
    right(Quest, Key), 
    retract(right(Quest, Key)), 
    write(Quest), 
    write(Key), nl, 
    right_list(Count), 
    Count1 is Count + 1; 
    Count1 = 0.

wrong_list(Count2):- 
    wrong(Quest, Key), 
    retract(wrong(Quest, Key)), 
    write(Quest), write(Key), nl, 
    wrong_list(Count), 
    Count2 is Count + 1; 
    Count2 = 0. 

summarize :- 
    nl, write("Вы ответили правильно на следующие вопросы:"), nl, 
    right_list(RightNumber), 
    nl, write("Вы ответили неверно на следующие вопросы:"), nl, 
    wrong_list(WrongNumber), 
    Accuracy is RightNumber / (RightNumber + WrongNumber) * 100, 
    write("Точность ваших ответов составляет "), write(Accuracy), write(", а именно вы ответили верно на "), write(RightNumber), write(" из 8 вопросов"), nl. 

data("Его зовут Михаил?", 'y'). 
data("Он имеет задолженности по учёбе?", 'n'). 
data("Он старательный студент?", 'y'). 
data("Он коренной москвич?", 'n'). 
data("Он обучается в бакалавриате?", 'y'). 
data("Он умеет программировать на Prolog?", 'y'). 
data("Он боится летать на самолёте?", 'n'). 
data("Он планирует поступать в магистратуру?", 'y').

GOAL

write("Вы интересуетесь сведениями о Михаиле Шевченко, студенте группы ИУ3-73"), nl, nl, fail; 
data(Quest, Ans), process(Quest, Ans), fail; 
summarize.
