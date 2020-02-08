DROP TABLE products;
DROP TABLE suppliers;
DROP TABLE stock_items;

CREATE TABLE suppliers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  contact_number VARCHAR(255),
  website VARCHAR(255)
);

CREATE TABLE stock_items (
  id SERIAL PRIMARY KEY,
  quantity INT
);

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  book_name VARCHAR(255),
  author VARCHAR(255),
  genre VARCHAR(255),
  description TEXT,
  supplier_id INT REFERENCES suppliers(id),
  stock_item_id INT REFERENCES stock_items(id),
  wholesale_price INT,
  retail_price INT
);
