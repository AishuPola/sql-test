#### Schemas

--```sql
CREATE TABLE artists (
    artist_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    birth_year INT NOT NULL
);

CREATE TABLE artworks (
    artwork_id INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    artist_id INT NOT NULL,
    genre VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    artwork_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (artwork_id) REFERENCES artworks(artwork_id)
);

INSERT INTO artists (artist_id, name, country, birth_year) VALUES
(1, 'Vincent van Gogh', 'Netherlands', 1853),
(2, 'Pablo Picasso', 'Spain', 1881),
(3, 'Leonardo da Vinci', 'Italy', 1452),
(4, 'Claude Monet', 'France', 1840),
(5, 'Salvador Dalí', 'Spain', 1904);

INSERT INTO artworks (artwork_id, title, artist_id, genre, price) VALUES
(1, 'Starry Night', 1, 'Post-Impressionism', 1000000.00),
(2, 'Guernica', 2, 'Cubism', 2000000.00),
(3, 'Mona Lisa', 3, 'Renaissance', 3000000.00),
(4, 'Water Lilies', 4, 'Impressionism', 500000.00),
(5, 'The Persistence of Memory', 5, 'Surrealism', 1500000.00);

INSERT INTO sales (sale_id, artwork_id, sale_date, quantity, total_amount) VALUES
(1, 1, '2024-01-15', 1, 1000000.00),
(2, 2, '2024-02-10', 1, 2000000.00),
(3, 3, '2024-03-05', 1, 3000000.00),
(4, 4, '2024-04-20', 2, 1000000.00);
--```


select * from artists
select * from artworks
select * from sales

--### Section 1: 1 mark each

--1. Write a query to calculate the price of 'Starry Night' plus 10% tax.

select (price)*1.1 as total_price from artworks  where title='starry night';



--2. Write a query to display the artist names in uppercase.


select upper(name)  as uppercase_names from artists




--3. Write a query to extract the year from the sale date of 'Guernica'.

select datepart(year,sale_date) from sales where artwork_id=2





--4. Write a query to find the total amount of sales for the artwork 'Mona Lisa'.



select sum(total_amount) from sales where artwork_id=3


--### Section 2: 2 marks each

select * from artists
select * from artworks
select * from sales

--5. Write a query to find the artists who have sold more artworks than the average number of artworks sold per artist.

with cte_table as 

(select a.artist_id,name,count(artwork_id) as countt from artists as a join artworks as art on 
a.artist_id=art.artist_id group by a.artist_id,name)

select * from cte_table  where countt> (select avg(countt) from cte_table )


--6. Write a query to display artists whose birth year is earlier than the average birth year of artists from their country.

select * from artists
select * from artworks
select * from sales

select birth_year from artists where birth_year > all (select avg(birth_year) from artists group by country) 
group by birth_year,country




--7. Write a query to create a non-clustered index on the `sales` table to improve query performance for queries filtering by `artwork_id`.

create  nonclustered index  non_clustered_index
on sales(artwork_id)


--8. Write a query to display artists who have artworks in multiple genres.

select artist_id,name from artists where exists(select artist_id from artworks where artists.artist_id=artworks.artist_id group by artist_id
having count(genre)>1 )
group by artist_id,name


--9. Write a query to rank artists by their total sales amount and display the top 3 artists.


select top 3 artists.artist_id,name,sum(total_amount), rank() over( order by sum(total_amount) desc ) from artists join artworks on
artists.artist_id=artworks.artist_id join sales on artworks.artwork_id=sales.artwork_id

group by artists.artist_id,name


--10. Write a query to find the artists who have created artworks in both 'Cubism' and 'Surrealism' genres.

select * from artists
select * from artworks
select * from sales


select artists.artist_id,name from artists join artworks on artists.artist_id=artworks.artist_id
where genre='cubism'
intersect
select artists.artist_id,name from artists join artworks on artists.artist_id=artworks.artist_id
where genre='surrealism'


--11. Write a query to find the top 2 highest-priced artworks and the total quantity sold for each.


select * from artists
select * from artworks
select * from sales


select top 2 artworks.artwork_id,title,count(quantity) as total_quantity, price from artworks join sales on artworks.artwork_id=sales.artwork_id
group by artworks.artwork_id,title,price 
order by price desc

--12. Write a query to find the average price of artworks for each artist.

select name,avg(price) as avg_price from artists join artworks on artists.artist_id=artworks.artist_id

group by name

--13. Write a query to find the artworks that have the highest sale total for each genre.

select  artworks.artwork_id,title,genre,sum(total_amount) from artworks join sales on artworks.artwork_id=sales.artwork_id
group by  artworks.artwork_id,title,genre
order by sum(total_amount) desc

--14. Write a query to find the artworks that have been sold in both January and February 2024.

select artworks.artwork_id,title from artworks  join sales on artworks.artwork_id=sales.artwork_id where 
datepart(year,sale_date)=2024 and  datepart(month,sale_date)=01

intersect

select artworks.artwork_id,title from artworks  join sales on artworks.artwork_id=sales.artwork_id where 

datepart(year,sale_date)=2024 and  datepart(month,sale_date)=02



--15. Write a query to display the artists whose average artwork price is higher than every artwork price in the 'Renaissance' genre.

select name from artists join artworks on artists.artist_id=artworks.artist_id 
group by name
having avg(price)> all(select price from artworks where genre='renaissance')



--### Section 3: 3 Marks Questions

--16. Write a query to create a view that shows artists who have created artworks in multiple genres.


create view  vwshowartistsinmultiplegenre
as 
select artist_id,name from artists where  exists(select artist_id from artworks where artists.artist_id=artworks.artist_id 
 group by artist_id having count(genre)>1)
group by artist_id,name

select * from vwshowartistsinmultiplegenre


--17. Write a query to find artworks that have a higher price than the average price of artworks by the same artist.

select artwork_id,title from artworks where price > all (select avg(price) from artworks group by artist_id) 



--18. Write a query to find the average price of artworks for each artist and only include artists 
--whose average artwork price is higher than the overall average artwork price.


select * from artists
select * from artworks
select * from sales

select avg(price)  from artworks group by artist_id having avg(price)>
 all(select avg(price) from artworks )

 




--### Section 4: 4 Marks Questions

--19. Write a query to export the artists and their artworks into XML format.

select artists.artist_id as [@id],
artists.name as [artists/name],
artists.country as [artists/country],
artists.birth_year as [artists/birth_year],

artworks.artist_id as [artists/birth_year],
artworks.title as [artists/birth_year],


artworks.artist_id as [artists/artist_id],
artworks.genre as [artists/genre],
artworks.price as [artists/price]
from 
 artists join artworks
 on artists.artist_id=artworks.artwork_id
 for xml path






--20. Write a query to convert the artists and their artworks into JSON format.


select artists.artist_id as 'id',
artists.name as 'artists.name',
artists.country as 'artists.country',
artists.birth_year as 'artists.birth_year',

artworks.artist_id as 'artists.artist_id',
artworks.title as 'artists.title',


artworks.artist_id as 'artworks.artist_id',
artworks.genre as 'artworks.genre',
artworks.price as 'artworks.price'
from 
 artists join artworks
 on artists.artist_id=artworks.artwork_id
 for json path 



--### Section 5: 5 Marks Questions

--21. Create a multi-statement table-valued function (MTVF) to return the total quantity sold for each genre and use it in a query to display the results.


create function dbo.totalquantityy()
returns @total_quantity table(genre varchar(100),quantity int)
as
begin
     insert into @total_quantity
	 select genre,sum(quantity) from artworks inner join  sales on artworks.artwork_id= sales.artwork_id  group by genre
	 return;
end
 
select * from dbo.totalquantityy();




--22. Create a scalar function to calculate the average sales amount for artworks in a given genre and write a query to use this function for 'Impressionism'.

create  function dbo.avgsalesamount(@genre varchar(30))
returns varchar(30)
as 
begin 
return (select avg(total_amount) from sales join artworks on sales.artwork_id=artworks.artwork_id where genre=@genre)
end 

exec dbo.avgsalesamount 'Impressionism'

--23. Write a query to create an NTILE distribution of artists based on their total sales, divided into 4 tiles.



select * from artists
select * from artworks
select * from sales
select total_amount,
	case 
	when [group_number]=1 then 'high'
	when [group_number]=2 then 'medium'
	when [group_number]=3 then 'low'
	when [group_number]=4 then 'below low'

	end as ended
	from (
select 
    total_amount,NTILE(4) over (order by total_amount desc) as group_number 
	from sales
	) as ended



--24. Create a trigger to log changes to the `artworks` table into an `artworks_log` table, capturing the `artwork_id`, `title`, and a change description.

create table artworks_log(tablename varchar(30),artwork_id int,
getdate date 
)



create trigger trigtochange
on artworks---sql listens to this table
 after update---before/ after (insert,delete,update)---action
 as

 select * from artworks
 
 if(update(artwork_id))
 begin

 insert into artworks_log
 select  'artworks',artwork_id,getdate()
 from inserted
 end
 go

 update artworks set artwork_id=6





--25. Create a stored procedure to add a new sale and update the total sales for the artwork. 
--Ensure the quantity is positive, and use transactions to maintain data integrity.

select * from artists
select * from artworks
select * from sales
create proc addnewsale
AS  
    SELECT * FROM sales;    
BEGIN TRY 
    Begin transaction
   commit transaction
END TRY  
BEGIN CATCH  
    rollback 
END CATCH; 

Alter PROCEDURE  addnewsale
    @genre varchar(100) 
As
Begin
	Begin Transaction;
	Begin Try
	-- Shield	
	if not Exists (Select genre from artworks Where genre= @genre)
		throw 60000, 'genre name  is not present!!!', 1;
	-- Shield	
	
	insert into sales (sale_id,artwork_id,sale_date,quantity,total_amount)values(5,5,'2024-05-25',1,1500000)
	select * ,sum(total_amount) from sales group by sale_id,artwork_id,sale_date,quantity,total_amount

	Commit Transaction;
	End Try
	Begin Catch
		Rollback Transaction;
		print Concat('Error number is: ', Error_number());
		print Concat('Error message is: ', Error_message());
		print Concat('Error state is: ', Error_State());
	End Catch
End

exec  addnewsale @genre='impressionism'




--### Normalization (5 Marks)

--26. **Question:**
--    Given the denormalized table `ecommerce_data` with sample data:

--| id  | customer_name | customer_email      | product_name | product_category | product_price | order_date | order_quantity | order_total_amount |
--| --- | ------------- | ------------------- | ------------ | ---------------- | ------------- | ---------- | -------------- | ------------------ |
--| 1   | Alice Johnson | alice@example.com   | Laptop       | Electronics      | 1200.00       | 2023-01-10 | 1              | 1200.00            |
--| 2   | Bob Smith     | bob@example.com     | Smartphone   | Electronics      | 800.00        | 2023-01-15 | 2              | 1600.00            |
--| 3   | Alice Johnson | alice@example.com   | Headphones   | Accessories      | 150.00        | 2023-01-20 | 2              | 300.00             |
--| 4   | Charlie Brown | charlie@example.com | Desk Chair   | Furniture        | 200.00        | 2023-02-10 | 1              | 200.00             |

--Normalize this table into 3NF (Third Normal Form). Specify all primary keys, foreign key constraints, unique constraints, not null constraints, and check constraints.













--### ER Diagram (5 Marks)









--27. Using the normalized tables from Question 26, create an ER diagram. Include the entities, relationships, primary keys, foreign keys, unique constraints, not null constraints, and check constraints. Indicate the associations using proper ER diagram notation.