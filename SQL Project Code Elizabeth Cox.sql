/* Question 1 What are the top 10 genres with the highest total sales?
*/
SELECT Genre_Name, SUM(Subtotal) Total_Sales
FROM
(SELECT g.name Genre_Name,(il.unitprice*il.quantity) Subtotal
FROM genre g
JOIN track t
ON t.genreid=g.genreid
JOIN invoiceline il
ON il.trackid=t.trackid
) AS sub1
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
/*End Question 1*/


/*Question 2 If we were to start a membership program what would the distribution of the current customers be?*/
SELECT Membership_Level, COUNT(Membership_Level) Total_Membership
FROM
(SELECT First_Name, Last_Name,
    CASE
      WHEN Total_Sales >= 45 THEN 'Gold Member'
      WHEN Total_Sales <45 AND Total_Sales >= 40 THEN 'Silver Member'
      ELSE 'Basic Member'
    END Membership_Level
FROM
(SELECT c.firstname First_Name, c.lastname Last_Name, SUM(i.total) Total_Sales
FROM invoice i
JOIN customer c
ON c.customerid=i.customerid
GROUP BY 2,1
ORDER BY 3
) AS sub1
) AS sub2
GROUP BY 1;
/*End Question 2*/


/*Question 3 Who was the top selling artist of 2011?*/
SELECT Artist_Name, SUM(Subtotal) Total_Sales
FROM
(SELECT a.name Artist_Name, (il.unitprice*il.quantity) Subtotal
FROM artist a
JOIN album al
ON a.artistid=al.artistid
JOIN track t
ON t.albumid=al.albumid
JOIN invoiceline il
ON il.trackid=t.trackid
JOIN invoice i
ON i.invoiceid=il.invoiceid
WHERE i.invoicedate >= '2011-01-01' AND i.invoicedate < '2012-01-01'
) AS sub1
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
/*End Question 3*/


/*Question 4 What are the top three longest playlists?*/
SELECT Playlist_Name, (Total_Time_in_Milliseconds/3600000) Total_Time_in_Hours
FROM
(SELECT p.name Playlist_Name, Sum(t.milliseconds) Total_Time_in_Milliseconds
FROM playlist p
JOIN playlisttrack pt
ON pt.playlistid=p.playlistid
JOIN track t
ON t.trackid=pt.trackid
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3
) AS sub1;
/*End Question 4*/
