DROP TABLE tickets;
DROP TABLE customers;
DROP TABLE films;


CREATE TABLE films(
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  screening_time DATETIME,
  price INT
);

CREATE TABLE customers(
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  funds INT
);

CREATE TABLE tickets(
  id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT REFERENCES films(id) ON DELETE CASCADE
);
