%https://docs.google.com/document/d/1RNgFMlSqOKiwe9SEi1U2cQjCmdFfWNflqycSfp7Qa-w/edit


%--------------------------
%--------Punto 1-----------
%--------------------------

kiosquero(dodain , lunes , 9, 15).
kiosquero(dodain , miercoles , 9, 15).
kiosquero(dodain , viernes , 9, 15).

kiosquero(lucas , martes , 10, 20).

kiosquero(juanC , sabado , 18, 22).
kiosquero(juanC , domingo , 18, 22).

kiosquero(juanFdS , jueves , 10, 20).
kiosquero(juanFdS , viernes , 12, 20).

kiosquero(leoC , lunes , 14, 18).
kiosquero(leoC , miercoles , 14, 18).

kiosquero(martu , miercoles , 23, 24).

kiosquero(vale , lunes , 9 , 15).
kiosquero(vale , miercoles , 9 , 15).
kiosquero(vale , viernes , 9 , 15).
kiosquero(vale , sabado , 18, 22).
kiosquero(vale , domingo , 18, 22).

%Los horarios de maiu no estan definidos, por el concepto de universo cerrado, se asume que no trabaja.
%Por este mismo concepto no aclaro q nadie trabaja en el mismo horario que leoC, si no esta en la base entonces no pasa

%--------------------------
%--------Punto 2-----------
%--------------------------

atiende(Dia , Hora , Kiosquero):-
    kiosquero(Kiosquero , Dia , HoraInicio , HoraFin),
    between(HoraInicio , HoraFin , Hora).


%--------------------------
%--------Punto 3-----------
%--------------------------

atiendeSolo(Dia , Hora , Kiosquero):-
    atiende(Dia , Hora , Kiosquero),
    not(atiendeOtroKiosquero( Dia , Hora , Kiosquero)).

atiendeOtroKiosquero(Dia , Hora , Kiosquero):-
    atiende(Dia , Hora , OtroKiosquero),
    Kiosquero \= OtroKiosquero.

%--------------------------
%--------Punto 5-----------
%--------------------------


venta(lunes10agosto, dodain , golosina(1200)).
venta(lunes10agosto, dodain , cigarrillo([jockey])).
venta(lunes10agosto, dodain , golosina(50)).

venta(miercoles12agosto, dodain , golosina(10)).
venta(miercoles12agosto, dodain , bebida(alcoholica , 8)).
venta(miercoles12agosto, dodain , bebida(noAlcoholica , 1)).

venta(miercoles12agosto, martu , golosina(1000)).
venta(miercoles12agosto, martu , cigarrillo([chesterfield , colorado , parisiennes])).

venta(miercoles12agosto, lucas , golosina(600)).
venta(martes18agosto, lucas , cigarrillo([derby])).
venta(martes18agosto, lucas , bebida(noAlcoholica , 2)).


% Queremos saber si una persona vendedora es suertuda, esto ocurre si para todos los días en los que vendió, la primera venta que hizo fue importante. Una venta es importante:
% en el caso de las golosinas, si supera los $ 100.
% en el caso de los cigarrillos, si tiene más de dos marcas.
% en el caso de las bebidas, si son alcohólicas o son más de 5.

esSuertudo(Vendedor):-
    venta(_, Vendedor , _),
    forall(venta(Dia , Vendedor , _) , huboVentaImportante(Dia , Vendedor)).

huboVentaImportante(Dia , Vendedor):-
    venta(Dia , Vendedor , Venta),
    ventaImportante(Venta).

ventaImportante(golosina(Precio)):-
    Precio > 100.

ventaImportante(bebida(alcoholica , _)).

ventaImportante(bebida(_ , Cantidad)):-
    Cantidad > 5.

ventaImportante(cigarrillo(Marcas)):-
    length(Marcas , Cantidad),
    Cantidad > 2.
    