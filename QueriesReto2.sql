-- 1. �Cu�l es el nombre aeropuerto que ha tenido mayor movimiento durante el a�o?

select aeropuertos.Nombre_aeropuerto 
from vuelos 
join aeropuertos on vuelos.Id_aeropuerto = aeropuertos.Id_aeropuerto
group by aeropuertos.Nombre_aeropuerto
having count(*) = (
select max(a.c) 
  from (select count(*) as c
    from vuelos 
    join aeropuertos on vuelos.Id_aeropuerto = aeropuertos.Id_aeropuerto
    group by aeropuertos.Nombre_aeropuerto)
  as a);


-- 2. �Cu�l es el nombre aerol�nea que ha realizado mayor n�mero de vuelos durante el a�o?
-- Nota: se tom� que las salidas son los vuelos

select aerolineas.Nombre_aerolinea 
from vuelos 
join aerolineas on vuelos.Id_aerolinea = aerolineas.Id_aerolinea
where vuelos.Id_movimiento = 1
group by aerolineas.Nombre_aerolinea
having count(*) = (
select max(a.c) 
  from (select count(*) as c
    from vuelos 
    join aeropuertos on vuelos.Id_aeropuerto = aeropuertos.Id_aeropuerto
	where vuelos.Id_movimiento = 1
    group by aeropuertos.Nombre_aeropuerto)
  as a);


-- 3. �En qu� d�a se han tenido mayor n�mero de vuelos?
-- Nota: se tom� que las salidas son los vuelos

select count(*) as cantidad_vuelos, dia
from vuelos 
where Id_movimiento = 1
group by dia;


-- 4. �Cu�les son las aerol�neas que tienen mas de 2 vuelos por d�a?
-- Nota: se tom� que las salidas son los vuelos

select aerolineas.Nombre_aerolinea, COUNT(*) numero_vuelos
from vuelos INNER JOIN aerolineas 
on(vuelos.Id_aerolinea = aerolineas.Id_aerolinea)
where vuelos.Id_movimiento = 1
group by aerolineas.Nombre_aerolinea, vuelos.dia
having count(*)>2;
