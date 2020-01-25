require_relative("../db/sql_runner.rb")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @price = options["price"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * from films"
    film_data = SqlRunner.run(sql)
    return film_data.map{|film| Film.new(film)}
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    films_hash = results.first
    return Film.new(films_hash)
  end

  def save()
    sql = "INSERT INTO films (title, price)
    VALUES ($1, $2)
    RETURNING id"
    values = [@title, @price]
    film_data = SqlRunner.run(sql, values)
    @id = film_data[0]["id"].to_i
  end

  def delete()
    sql = "DELETE FROM films where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2)
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT DISTINCT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id INNER JOIN screenings ON screenings.id = tickets.screening_id
    WHERE screenings.film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|customer| Customer.new(customer)} if result.any?
  end

  def screenings()
    sql = "SELECT screenings.* FROM screenings WHERE screenings.film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|screening| Screening.new(screening)} if result.any?
  end

  def tickets()
    sql = "SELECT tickets.* FROM tickets INNER JOIN screenings ON tickets.screening_id = screenings.id WHERE screenings.film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|ticket| Ticket.new(ticket)} if result.any?
  end

end
