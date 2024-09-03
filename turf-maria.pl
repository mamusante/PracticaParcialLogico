%----------------------------
%----------Punto 1-----------
%----------------------------
jockey(valdivieso , 155 , 52).
jockey(leguisamo , 161 , 49).
jockey(lezcano , 149 , 50).
jockey(baratucci , 153 , 55).
jockey(falero , 157 , 52).

caballo(botofago).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).

preferencia(botafogo , Jockey):-
    jockey(Jockey , _ , Peso),
    Peso < 52.

preferencia(botafogo , baratucci).

preferencia(oldMan , Jockey):-
    jockey(Jockey , _ , _),
    nombreMasDe7Letras(Jockey).

preferencia(energica , Jockey):-
    jockey(Jockey , _ , _),
    not(preferencia(botafogo , Jockey)).

preferencia(matBoy , Jockey):-
    jockey(Jockey , Altura , _),
    Altura > 170.

nombreMasDe7Letras(Nombre):-
    atom_length(Nombre, Cantidad),
    Cantidad > 7.
    
stud(valdivieso , elTute).
stud(falero , elTute).
stud(lezcano , lasHormigas).
stud(baratucci , elCharabon).
stud(leguisamo , elCharabon).

premio(botafogo , granPremioNacional).
premio(botafogo , granPremioRepublica).
premio(oldMan , granPremioRepublica).
premio(oldMan , campeonatoPalermoDeOro).

%energica y yatasto no ganaron ningun premio, no lo agrego a la base de conocimientso pro el principio del universo cerrado

%----------------------------
%----------Punto 2-----------
%----------------------------

prefiereAMasDeUnJockey(Caballo):-
    preferencia(Caballo , Jockey1),
    preferencia(Caballo , Jockey2),
    Jockey1 \= Jockey2.

%----------------------------
%----------Punto 3-----------
%----------------------------

caballoEnContraDeCaballeriza(Caballo , Stud):-
    caballo(Caballo),
    stud(_ , Stud),
    forall(stud(Jockey , Stud), not(preferencia(Caballo , Jockey))).


%----------------------------
%----------Punto 4-----------
%----------------------------
jockey(Jockey):-
    jockey(Jockey , _ , _).

premioImportante(granPremioNacional).
premioImportante(granPremioRepublica).

% Queremos saber quiénes son les jockeys "piolines", que son las personas preferidas por todos los caballos que ganaron un premio importante. El Gran Premio Nacional y el Gran Premio República son premios importantes.

% Por ejemplo, Leguisamo y Baratucci son piolines, no así Lezcano que es preferida por Botafogo pero no por Old Man. El predicado debe ser inversible.

piolin(Jockey):-
    jockey(Jockey),
    forall(caballoQueGanoPremioImportante(Caballo), preferencia(Caballo ,Jockey)).

caballoQueGanoPremioImportante(Caballo):-
    premioImportante(Premio),
    premio(Caballo , Premio).

%----------------------------
%----------Punto 5-----------
%----------------------------

% apuesta(ganador(Caballo)).
% apuesta(segundo(Caballo)).
% apuesta(exacta(Primero , Segundo)).
% apuesta(imperfecta(Caballo1 , Caballo2)).

% resultadoCarrera(Carrera , posiciones(Primero,Segundo)).

apuestaGanadora(ganador(Caballo) , posiciones(Caballo , _)).

apuestaGanadora(segundo(Caballo) , posiciones(Caballo , _)).

apuestaGanadora(segundo(Caballo) , posiciones(_ , Caballo)).

apuestaGanadora(exacta(Primero , Segundo) , posiciones(Primero , Segundo)).

apuestaGanadora(imperfecta(Caballo1 , Caballo2) , posiciones(Caballo1 , Caballo2)).

apuestaGanadora(imperfecta(Caballo1 , Caballo2) , posiciones(Caballo2 , Caballo1)).


%----------------------------
%----------Punto 6-----------
%----------------------------

%no lo hago porque es de explosion combinatoria y ni idea man