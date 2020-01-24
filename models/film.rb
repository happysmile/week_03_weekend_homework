require_relative("../db/sql_runner.rb")

class Film

  attr_reader :id
  attr_accessor :title, :screening_time, :price

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @screening_time = options["screening_time"]
    @price = options["price"].to_i
  end

  def save()
    sql = "INSERT INTO films (title, screening_time, price)
    VALUES ($1, $2, $3)
    RETURNING id"
    values = [@title, @screening_time, @price]
    film_data = SqlRunner.run(sql, values)
    @id = film_data[0]["id"].to_i
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

  def update()
    sql = "UPDATE films SET (title, screening_time, price) = ($1, $2, $3)
    WHERE id = $4"
    values = [@title, @screening_time, @price, @id]
    SqlRunner.run(sql, values)
  end



end
