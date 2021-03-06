# NCAA-Softball-Analysis

## Background and Sources
My favorite sport of all time is softball. I played this sport since early childhood. While I never played in college, I absolutely enjoy watching the the NCAA Torunament and Women's College World Seres (WCWS) every May-June. 

Just like with any sport, there is excitement and anticipation for which teams are selected for the NCAA tournament, and ultimately get the chance to play for the national title. While we do not know the exact formula for how teams are selected for this prestigious tournament, it is known that Rating Percentage Index (RPI) is one of the most telling factors. RPI is generally computed by weighing the team's winning percentage, the opponent's winning percentage, and the opponent's opponent's winning percentage (source: http://www.rpiratings.com/WhatisRPI.php).

While I do not have those raw numbers, I was able to glean publicly available data concerning end of the season RPI, wins, losses, and Strength of Schedule (SOS), among other factors. Data was extracted from the NCAA's website in its aggregate form: http://stats.ncaa.org/selection_rankings/nitty_gritties/26863.

## ETL (Extract, Transform, Load)
1. Data was extracted from the NCAA's website, which is pubilicly available.
2. The data were cleaned and transformed in Python (using pandas) in preparation for exploratory analyses, machine learning, and loading into SQL.
3. After transformation, the data were loaded into a postgres SQL database.

## Exploratory Data Analyses
Before the data were loaded into Python, I quickly added a column "advanced" in the csv file to label whether the team advanced to the NCAA tournament (1) or did not (0). 

Analyses explored the teams with the strongest and weakest strength of schedule (SOS). Looking at the top 16 (teams that would be seeded), 13 of them were selected to advance to the NCAA tournament; however, three teams were not selected. Looking more closely at their metrics, the teams that were not selected did have fewer wins and more losses compared to teams that were selected.

![image](https://user-images.githubusercontent.com/90559756/171449499-f83ba6ca-1f02-4015-a45a-773d1cd3eddd.png)

When comparing some descriptive statistics of teams who advanced and did not advance, I noted that advancing teams had better RPI and SOS (the lower the value, the better) and more wins and fewer losses. While there are other metrics that could play a role, these factors appear to play an important role in predicting whether or not a team is selected for the NCAA tournament.

![image](https://user-images.githubusercontent.com/90559756/171449601-224340e8-9b4f-4b74-9b23-e129d49c4cff.png)

I also looked into the relation between RPI and wins and losses. There were strong correlations between these factors such that the more wins a team had, the lower (better ranked) their RPI. Conversely, the fewer losses the team had, the lower (better ranked) the RPI. 

![image](https://user-images.githubusercontent.com/90559756/171450433-113fb826-aa8a-4d5c-a310-0278d3d8effb.png)

![image](https://user-images.githubusercontent.com/90559756/171450275-16f0a50f-4b11-4827-a184-fd7b2847b5ef.png)


## Visualizations
Visualizations were generated using pandas and matplotlib. I also created a separate Tableau storyboard to summarize key performance indicators. https://public.tableau.com/app/profile/angele.yazbec/viz/WCWS2022Insight/Story1

## SQL Queries
A table schema was created before inserting the transformed data from Python.
I created a series of queries investigating RPI, SOS, wins, and losses by conference and by advancement status.
Used "GROUP BY" clauses to group the results of a set (frequently with conferences).
Used "ORDER BY" clauses to sort the results in ascending and descending order.
Used "AVG" and "SUM" functions.

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

![image](https://user-images.githubusercontent.com/90559756/171456164-c3a40d5a-ffc8-4ffa-bfa6-8d8738bbe722.png)


## Machine Learning
For this portion of the project, I used readily available code from Sci-kit learn, which is popularly used in machine learning.

First, I conducted a Random Forest Classifier to reduce the number of features in the dataset. Interestingly, conference did not apepar to be an important feature in the model.

Then, I ran two separate Logistic Regression Models, one with all of the features and one without all of the features, to see which model performed better. The Logistic Regression Model with the selected features from the Random Forest Classifier was more accurate (92% compared to 86%).

![image](https://user-images.githubusercontent.com/90559756/171450643-7fea61ef-42c0-4730-abac-5e9d71f0182e.png)


Next, I wanted to see if I could further optimize the model by applying a Linear Support Vector Classifier. This model was actually less accurate than our Logistic Regression Model with selected features (88%).


![image](https://user-images.githubusercontent.com/90559756/171450789-a69e73a2-de5e-4d9e-a94a-55126b72b9bd.png)


## Deep Learning
As a follow-up, I took a deep learning approach to see if I could simulate a neural network that would be even better at predicting which teams advanced to the NCAA tournament than the Logistic Regression Model with selected features. I used the kears-tuner and tensor flow library for this portion of the analysis.

I conducted an analysis to determine which hyperparameters would be the most optimal, and determined the following:
- four neural layers
- tanh activation method (with sigmond activation on the last layer)
- 11 units on the first layer
- 21 units on the second layer
- 16 units on the third layer
- one unit on the fourth layer

After training the model, the overall accuracy was 85.5%, which was lower than machine learning models I considered previously.

## Conclusion

I explored a few different factors that could predict whether a softball team would be chosen to advance to the NCAA tournament. Using publicly available data, I was able to develop a fairly accurate Logistic Regression Model that predicts a teams advancement status correctly 92% of the time. Additional visualizations, analyses, and queries lend more insight for how factors such as RPI, SOS, wins, and losses are related to advancement status.
