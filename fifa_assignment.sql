CREATE database fifa;
use fifa;
# How many players are there in the dataset ?
SELECT COUNT(*) AS players_cnt FROM fifa;
# How many nationalities do these players belong to?
SELECT COUNT(DISTINCT Nationality) AS distinct_nationality_count FROM fifa;
# What is the total wage given to all players? What's the average and standard deviation?
SELECT SUM(Wage) AS sum_of_wage,AVG(Wage) AS avg_of_wage,STDDEV(Wage) AS stddev_of_wage FROM fifa;
#Which nationality has the highest number of players, what are the top 3 nationalities by # of players?
SELECT Nationality, COUNT(*) AS player_cnt FROM fifa GROUP BY Nationality ORDER BY player_count DESC LIMIT 3; 
#Which player has the highest wage? Who has the lowest?
# Highest
SELECT id,Name, Wage FROM fifa ORDER BY Wage DESC LIMIT 1;

# Lowest
SELECT id,Name, Wage FROM fifa ORDER BY Wage ASC LIMIT 1;

# The player having the – best overall rating? Worst overall rating?
# Best
SELECT id,Name, Overall FROM fifa ORDER BY Overall DESC LIMIT 1;
# Worst
SELECT id,Name, Overall FROM fifa ORDER BY Overall ASC LIMIT 1;
# Club having the highest total of overall rating and highest average of overall rating ?
# Highest total
SELECT Club, SUM(Overall) AS total_rating FROM fifa GROUP BY Club ORDER BY total_rating DESC LIMIT 1;
# Highest average
SELECT Club, AVG(Overall) AS Higest_avg_rating FROM fifa GROUP BY Club ORDER BY avg_rating DESC LIMIT 1;
# What are the top 5 clubs based on the average ratings of their players and their corresponding averages?
SELECT Club, AVG(Overall) AS average_rating FROM fifa GROUP BY Club ORDER BY average_rating DESC LIMIT 5;
# What is the distribution of players whose preferred foot is left vs right?
# What is the distribution of players whose preferred foot is left vs right?
SELECT Preferred_Foot, COUNT(*) AS cnt FROM fifa GROUP BY Preferred_Foot;
# Which jersey number is the luckiest?
SELECT Jersey_Number, AVG(Overall) AS average_rating FROM fifa GROUP BY Jersey_Number ORDER BY average_rating DESC LIMIT 1;
# What is the frequency distribution of nationalities among players whose club name starts with M?
SELECT Nationality, COUNT(*) AS player_cnt FROM fifa WHERE Club LIKE 'M%' GROUP BY Nationality ORDER BY player_cnt DESC;
# How many players have joined their respective clubs in the date range 20 May 2018 to 10 April 2019 (both inclusive)?
SELECT COUNT(*) AS players_joined FROM fifa WHERE STR_TO_DATE(Joined, '%d-%m-%Y') BETWEEN '2018-05-20' AND '2019-04-10';
# How many players have joined their respective clubs date wise?
SELECT Joined, COUNT(*) AS players_cnt FROM fifa GROUP BY Joined ORDER BY Joined;

# How many players have joined their respective clubs yearly?
SELECT YEAR(STR_TO_DATE(Joined, '%d-%m-%Y')) AS join_year,COUNT(*) AS players_cnt FROM fifa GROUP BY join_year ORDER BY join_year;