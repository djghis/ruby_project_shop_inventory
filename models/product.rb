require_relative('../db/sql_runner')

class Product

  attr_reader :id

  attr_accessor :picture, :book_name, :author, :genre, :description, :supplier_id, :quantity, :wholesale_price, :retail_price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @picture = options['picture']
    @book_name = options['book_name']
    @author = options['author']
    @genre = options['genre']
    @description = options['description']
    @supplier_id = options['supplier_id'].to_i
    @quantity = options['quantity'].to_i
    @wholesale_price = options['wholesale_price'].to_i
    @retail_price = options['retail_price'].to_i
  end

  def save()
    sql = "INSERT INTO products (
    picture, book_name, author, genre, description, supplier_id, quantity, wholesale_price, retail_price
  )
  VALUES (
    $1, $2, $3, $4, $5, $6, $7, $8, $9
    ) RETURNING id"
    values = [@picture, @book_name, @author, @genre, @description, @supplier_id, @quantity, @wholesale_price, @retail_price]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE products SET (picture, book_name, author, genre, description, supplier_id, quantity, wholesale_price, retail_price) = ($1, $2, $3, $4, $5, $6, $7, $8, $9) WHERE id = $10"
    values = [@picture, @book_name, @author, @genre, @description, @supplier_id, @quantity, @wholesale_price, @retail_price, @id]
    SqlRunner.run(sql, values)
  end

  def supplier()
    sql = "SELECT * FROM suppliers WHERE id = $1"
    values = [@supplier_id]
    results = SqlRunner.run(sql, values)
    return Supplier.new(results.first)
  end

  def quantity_level()
    if @quantity == 0
      return {color: "red", text: "Out of Stock"}
    elsif @quantity <= 5
      return {color: "orange", text: "Low Stock"}
    else
      return {color: "green", text: "In Stock"}
    end
  end

  def self.all()
    sql = "SELECT * FROM products"
    results = SqlRunner.run(sql)
    return results.map{|product| Product.new(product)}
  end

  def self.find(id)
    sql = "SELECT * FROM products WHERE id = $1"
    values = [id]
    product = SqlRunner.run(sql, values)
    result = Product.new(product.first)
    return result
  end

  def self.delete(id)
    sql = "DELETE FROM products WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM products"
    SqlRunner.run(sql)
  end

end
