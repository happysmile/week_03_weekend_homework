require_relative("../db/sql_runner.rb")

class Screening

  attr_reader :id
  attr_accessor :film_id, :screening_date, :screening_time, :room_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @film_id = options["film_id"]
    @screening_date = options["screening_date"]
    @screening_time = options["screening_time"]
    @room_id = options["room_id"]
  end

  def save()
    sql = "INSERT INTO screenings (film_id, screening_date, screening_time, room_id)
    VALUES ($1, $2, $3, $4)
    RETURNING id"
    values = [@film_id, @screening_date, @screening_time, @room_id]
    screening_data = SqlRunner.run(sql, values)
    @id = screening_data[0]["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * from screenings"
    screening_data = SqlRunner.run(sql)
    return screening_data.map{|screening| Screening.new(screening)}
  end

  def update()
    sql = "UPDATE screenings SET (film_id, screening_date, screening_time, room_id) = ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@film_id, @screening_date, @screening_time, @room_id, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets on tickets.customer_id = customers.id WHERE tickets.screening_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|customer| Customer.new(customer)} if result.any?
  end

  def how_many_customers()
    customers = customers()
    return customers.count()
  end


end
