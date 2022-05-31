--Querying teams that advanced to the NCAA tournament and their conference
SELECT team, conference FROM softball
WHERE advanced = 1;

--Ordering teams by RPI, in ascending order
SELECT rpi, team, conference, win, loss, sos
FROM softball
ORDER BY rpi;

--Average RPI by conference
SELECT AVG(rpi), conference
FROM softball
GROUP BY conference
ORDER BY AVG(rpi);

--Strength of schedule (SOS) by conference
SELECT AVG(sos), conference
FROM softball
GROUP BY conference
ORDER BY AVG(sos);

--Teams' SOS
SELECT AVG(sos), advanced, team, conference
FROM softball
GROUP BY advanced, team, conference
ORDER BY AVG(sos);

--Advancing teams' SOS
SELECT AVG(sos), advanced, team, conference
FROM softball
WHERE advanced = 1
GROUP BY advanced, team, conference
ORDER BY AVG(sos);

--Non-advancing teams' SOS
SELECT AVG(sos), advanced, team, conference
FROM softball
WHERE advanced = 0
GROUP BY advanced, team, conference
ORDER BY AVG(sos);

--Sum of wins among teams
SELECT SUM(win), advanced, team, conference
FROM softball
GROUP BY advanced, team, conference
ORDER BY SUM(win) DESC;

--Sum of losses among teams
SELECT SUM(loss), advanced, team, conference
FROM softball
GROUP BY advanced, team, conference
ORDER BY SUM(loss);

--Creating view with only advanced teams
CREATE VIEW advanced_teams AS
SELECT team, conference, rpi, win, loss
FROM softball
WHERE advanced=1;

--Querying which teams from the ACC conference advanced
SELECT team, conference, rpi, win, loss
FROM advanced_teams
WHERE conference='ACC';

--Grouping by conferences
SELECT team, conference, rpi, win, loss
FROM advanced_teams
GROUP BY conference, team, rpi, win, loss
ORDER BY conference;

