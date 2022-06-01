# ncaa-softball-analysis

## Background and Sources
My favorite sport of all time is softball. I played this sport since I was young. I never played in college; however, I absolutely enjoy watching the Women's College World Seres (WCWS) every May-June. 

Just like with any sport, there is excitement and anticipation for which teams are selected for the NCAA tournament, and ultimately get the chance to play for the national title. While we do not know the exact formula for how teams are selected for this prestigious tournament, it is known that Rating Percentage Index (RPI) is one of the most telling factors. RPI is generally computed by weighing the team's winning percentage, the opponent's winning percentage, and the opponent's opponent's winning percentage (source: http://www.rpiratings.com/WhatisRPI.php).

While we do not have those raw numbers, we were able to glean publicly available data concerning end of the season RPI, wins, losses, and Strength of Schedule (SOS), among other factors. Data was extracted from the NCAA's website in its aggregate form: https://www.ncaa.com/rankings/softball/d1/ncaa-womens-softball-rpi.

## ETL (Extract, Transform, Load)
1. Data was extracted from the NCAA's website, which is pubilicly available.
2. The data were cleaned and transformed in Python in preparation for exploratory analyses, machine learning, and loading into SQL.
3. After transformation, the data were loaded into a SQL database.

## Exploratory Data Analyses

## Visualizations
Visualizations were generated using pandas and matplotlib. A separate Tableau visualization was also created: https://public.tableau.com/app/profile/angele.yazbec/viz/WCWS2022Insight/Story1

## SQL Queries
A table schema was created before inserting the transformed data from Python.
A series of queries investigating RPI, SOS, wins, and losses by conference and by advancement status (advanced=1, not_advanced=0).

## Machine Learning
First, I conducted a Random Forest Classifier to reduce the number of features in the dataset. Then, I ran two separate Logistic Regression Models, one with all of the features and one without all of the features, to see which model performed better. The Logistic Regression Model with the selected features from the Random Forest Classifier was more accurate (92% compared to 86%).

Next, I wanted to see if I could further optimize the model by applying a Linear Support Vector Classifier. This model was actually less accurate than our Logistic Regression Model with selected features (88%).

## Deep Learning
As a follow-up, I took a deep learning approach to see if I could simulate a neural network that would be even better at predicting which teams advanced to the NCAA tournament than the Logistic Regression Model with selected features.

I conducted an analysis to determine which hyperparameters would be the most optimal, and determined the following:
- four neural layers
- tanh activation method (with sigmond activation on the last layer)
- 11 units on the first layer
- 21 units on the second layer
- 16 units on the third layer
- one unit on the fourth layer

After training the model, the overall accuracy was 85.5%, which was lower than machine learning models I considered previously.

## Conclusion

