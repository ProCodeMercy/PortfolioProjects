
SELECT*
FROM [PORTFOLIO PROJECT].dbo.[LIBRARY DATABASE]

--Find the average rating of books in each genre
SELECT [GENRE NAME], AVG(RATING) AS AVERAGE_RATING
FROM [PORTFOLIO PROJECT].dbo.[LIBRARY DATABASE]
GROUP BY [GENRE NAME]

--Retrieving all books published after 2020
SELECT *
FROM [PORTFOLIO PROJECT].dbo.[LIBRARY DATABASE]
WHERE [PUBLICATION DATE] > '2010-01-01'

--Counting the number of books borrowed by each borrower
SELECT [BORROWER_ID], [BORROWER NAME], COUNT(*) AS BOOKS_BORROWED
FROM [PORTFOLIO PROJECT].dbo.[LIBRARY DATABASE]
GROUP BY [BORROWER_ID], [BORROWER NAME]

--Identyfying the most popular authors(those with the highest number of books)
SELECT TOP 5 [AUTHOR NAME], COUNT(*) AS BOOK_COUNT
FROM [PORTFOLIO PROJECT].dbo.[LIBRARY DATABASE]
GROUP BY [AUTHOR NAME]
ORDER BY BOOK_COUNT DESC

--Listing books with their corresponding borrowers and return date
SELECT B.[TITLE], B.[AUTHOR NAME], T.[BORROWER NAME], T.[RETURN DATE]
FROM [PORTFOLIO PROJECT].dbo.[LIBRARY DATABASE] B
INNER JOIN [PORTFOLIO PROJECT].dbo.[LIBRARY DATABASE] T ON B.BOOK_ID = T.BOOK_ID

--Finding books with ratings higher than 4
SELECT *
FROM [PORTFOLIO PROJECT].dbo.[LIBRARY DATABASE]
WHERE RATING > 4

--Retrieving books borrowed by a specific borrower
SELECT *
FROM [PORTFOLIO PROJECT].dbo.[LIBRARY DATABASE]
WHERE BORROWER_ID = '123'

--Counting the number of books in the library
SELECT COUNT(*) AS Total_Books
FROM [LIBRARY DATABASE]

--Finding the most borrowed book in the last month
SELECT TOP 10 [TITLE], COUNT(*) AS Times_Borrowed
FROM [LIBRARY DATABASE]
WHERE [CHECKOUT DATE] >= DATEADD(month, -1, GETDATE())
GROUP BY [TITLE]
ORDER BY Times_Borrowed DESC

--calculate the average number of days a book is borrowed
SELECT AVG(DATEDIFF(day, [CHECKOUT DATE], [RETURN DATE])) AS Avg_Days_Borrowed
FROM [LIBRARY DATABASE]

--Identify the borrowers with the most overdue books
SELECT TOP 10 [BORROWER_ID], [BORROWER NAME], COUNT(*) AS Overdue_Books
FROM [LIBRARY DATABASE]
WHERE [RETURN DATE] < GETDATE()  -- Assuming overdue if return date is in the past
GROUP BY [BORROWER_ID], [BORROWER NAME]
ORDER BY Overdue_Books DESC

--Determining the most popular journal in the library
SELECT [GENRE NAME], COUNT(*) AS Total_Books
FROM [LIBRARY DATABASE]
GROUP BY [GENRE NAME]
ORDER BY Total_Books DESC

--Finding the borrowers who borrowed the same book multiple times
SELECT [BORROWER_ID], [BORROWER NAME], [BOOK_ID], [TITLE], COUNT(*) AS Times_Borrowed
FROM [LIBRARY DATABASE]
GROUP BY [BORROWER_ID], [BORROWER NAME], [BOOK_ID], [TITLE]
HAVING COUNT(*) > 1

--Calculating the late return rate for each genre based on the number of records where the return date is in the past
SELECT [GENRE NAME], 
       (SUM(CASE WHEN [RETURN DATE] < GETDATE() THEN 1 ELSE 0 END) * 1.0 / COUNT(*)) AS Late_Return_Rate
FROM [LIBRARY DATABASE]
GROUP BY [GENRE NAME]

--Creating view to store data for later visualization
CREATE VIEW library_summary_view AS
SELECT 
    B.[BOOK_ID],
    B.[TITLE],
    B.[GENRE NAME],
    A.[AUTHOR NAME],
    COUNT(T.[TRANSACTION ID]) AS Total_Borrow_Count,
    AVG(DATEDIFF(day, T.[CHECKOUT DATE], T.[RETURN DATE])) AS Avg_Days_Borrowed
FROM 
    [LIBRARY DATABASE] B
JOIN 
    [LIBRARY DATABASE] A ON B.[AUTHOR_ID] = A.[AUTHOR_ID]
LEFT JOIN 
    [LIBRARY DATABASE] T ON B.[BOOK_ID] = T.[BOOK_ID]
GROUP BY 
    B.[BOOK_ID],
    B.[TITLE],
    B.[GENRE NAME],
    A.[AUTHOR NAME]
















