#### Schemas

```sql
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
```

### Section 1: 1 mark each

1. Write a query to calculate the price of 'Starry Night' plus 10% tax.

2. Write a query to display the artist names in uppercase.

3. Write a query to extract the year from the sale date of 'Guernica'.

4. Write a query to find the total amount of sales for the artwork 'Mona Lisa'.

### Section 2: 2 marks each

5. Write a query to find the artists who have sold more artworks than the average number of artworks sold per artist.

6. Write a query to display artists whose birth year is earlier than the average birth year of artists from their country.

7. Write a query to create a non-clustered index on the `sales` table to improve query performance for queries filtering by `artwork_id`.

8. Write a query to display artists who have artworks in multiple genres.

9. Write a query to rank artists by their total sales amount and display the top 3 artists.

10. Write a query to find the artists who have created artworks in both 'Cubism' and 'Surrealism' genres.

11. Write a query to find the top 2 highest-priced artworks and the total quantity sold for each.

12. Write a query to find the average price of artworks for each artist.

13. Write a query to find the artworks that have the highest sale total for each genre.

14. Write a query to find the artworks that have been sold in both January and February 2024.

15. Write a query to display the artists whose average artwork price is higher than every artwork price in the 'Renaissance' genre.

### Section 3: 3 Marks Questions

16. Write a query to create a view that shows artists who have created artworks in multiple genres.

17. Write a query to find artworks that have a higher price than the average price of artworks by the same artist.

18. Write a query to find the average price of artworks for each artist and only include artists whose average artwork price is higher than the overall average artwork price.

### Section 4: 4 Marks Questions

19. Write a query to export the artists and their artworks into XML format.

20. Write a query to convert the artists and their artworks into JSON format.

### Section 5: 5 Marks Questions

21. Create a multi-statement table-valued function (MTVF) to return the total quantity sold for each genre and use it in a query to display the results.

22. Create a scalar function to calculate the average sales amount for artworks in a given genre and write a query to use this function for 'Impressionism'.

23. Write a query to create an NTILE distribution of artists based on their total sales, divided into 4 tiles.

24. Create a trigger to log changes to the `artworks` table into an `artworks_log` table, capturing the `artwork_id`, `title`, and a change description.

25. Create a stored procedure to add a new sale and update the total sales for the artwork. Ensure the quantity is positive, and use transactions to maintain data integrity.

### Normalization (5 Marks)

26. **Question:**
    Given the denormalized table `ecommerce_data` with sample data:

| id  | customer_name | customer_email      | product_name | product_category | product_price | order_date | order_quantity | order_total_amount |
| --- | ------------- | ------------------- | ------------ | ---------------- | ------------- | ---------- | -------------- | ------------------ |
| 1   | Alice Johnson | alice@example.com   | Laptop       | Electronics      | 1200.00       | 2023-01-10 | 1              | 1200.00            |
| 2   | Bob Smith     | bob@example.com     | Smartphone   | Electronics      | 800.00        | 2023-01-15 | 2              | 1600.00            |
| 3   | Alice Johnson | alice@example.com   | Headphones   | Accessories      | 150.00        | 2023-01-20 | 2              | 300.00             |
| 4   | Charlie Brown | charlie@example.com | Desk Chair   | Furniture        | 200.00        | 2023-02-10 | 1              | 200.00             |

Normalize this table into 3NF (Third Normal Form). Specify all primary keys, foreign key constraints, unique constraints, not null constraints, and check constraints.

### ER Diagram (5 Marks)

27. Using the normalized tables from Question 26, create an ER diagram. Include the entities, relationships, primary keys, foreign keys, unique constraints, not null constraints, and check constraints. Indicate the associations using proper ER diagram notation.