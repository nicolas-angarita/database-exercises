

/* 3a How many rows are in the albums table? There are 31 rows*/

/* 3b SELECT Distinct Artist From albums;
How many unique artist names are in the albums table? I believe there is 23 unique artist with 1 row having "various artists" */

/* 3c What is the primary key for the albums table? An Int numbered from 1-31*/

/* 3d SELECT release_date,name, artist FROM albums Order By release_date;

SELECT release_date,name, artist FROM albums Order By release_date DESC;

What is the oldest release date for any album in the albums table? What is the most recent release date? The oldest release date of any album is "Sgt. Pepper's Lonely Hearts Club Band" by The Beatles. The most recent release date is Adele's "21" album released in 2011*/


/* 4a */
SELECT name,artist FROM albums WHERE artist = "Pink Floyd";

/* 4b */
SELECT name,release_date FROM albums WHERE name =  "Sgt. Pepper's Lonely Hearts Club Band";

/* 4c */
SELECT name,genre FROM albums WHERE name = "Nevermind";

/* 4d */
SELECT name,release_date FROM albums WHERE release_date BETWEEN '1990' AND '1999';

/* 4e */ 
SELECT name,sales FROM albums WHERE sales < 20;

/* 4f  All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"? These query results don't include albums with a genre of "Hard Rock" or "Progressive Rock" because those are other genres of Rock. We specifically told sql for the genre to be 'Rock'*/
SELECT name,genre FROM albums WHERE genre = 'Rock';


