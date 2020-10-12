solve(С) :- % список вида с(фамилия,профессия,возраст)
  length(С, 4),                              %  всего в списке 4 человека
  member(с(_,_,4), С),                       %  кто-то самый старший (условный возраст 4)   
  member(с(_,_,3), С),                       %  а есть также и младше
  member(с(_,_,2), С),                       %  и еще   младше
  member(с(_,_,1), С),                       %  возможно кто-то самый младший
  member(с(_,baker,_), С),                     %  есть 4 профессии    
  member(с(_,doctor,_), С),                    %  если их здесь
  member(с(_,policeman,_), С),                 %  не указать
  member(с(_,engineer,_), С),                  %  неверно работает предикат not
  neighboors(с(korneev,_,_), с(dokshin,_,_), С),    % korneev и dokshin - neighboors
  rides(с(korneev,_,_),С),rides(с(dokshin,_,_), С), % они ездят на работу
  member(с(dokshin,_,DAGE), С), member(с(mareev,_,MAGE), С), DAGE>MAGE, % dokshin > mareev
  play(с(korneev,_,_),с(skobelev,_,_),С),% игроки в пинг-понг
  not(rides(с(_,baker,_),С)),            % baker ходит пешком (не rides)
  not(neighboors(с(_,policeman,_), с(_,doctor,_), С)),        % policeman не живет рядом с doctor (не neighboors)
  meetOnce(с(_,engineer,_), с(_,policeman,_), С), % engineer и policeman встречались 1 раз 
  member(с(_,policeman,POLAGE), С),member(с(_,doctor,DOCAGE), С),POLAGE>DOCAGE,% policeman > doctor 
  member(с(_,engineer,ENGAGE), С),POLAGE>ENGAGE. % policeman > engineer

%будем считать, что в списке первые двое - neighboors (учитываем, что игроки и neighboors пересекаются)
neighboors(А,B,С):-С=[А,B,_,_];С=[B,А,_,_].

%игроки на 2-м и 3-м месте списка (учитываем, что игроки и neighboors пересекаются)
play(А,B,С):-С=[_,А,B,_];С=[_,B,А,_]. 

%знаем, что ездят neighboors
rides(А,С):-neighboors(А,_,С).

%если встречались 1 раз, то они не neighboors и не играют вместе 
meetOnce(А,B,С):-not(neighboors(А,B,С)), not(play(А,B,С)).
