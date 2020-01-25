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

  def self.all()
    sql = "SELECT * from screenings"
    screening_data = SqlRunner.run(sql)
    return screening_data.map{|screening| Screening.new(screening)}
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    screenings_hash = results.first
    return Screening.new(screenings_hash)
  end

  def self.all_films_showing()
    sql = "SELECT DISTINCT films.* FROM films INNER JOIN screenings ON films.id = screenings.film_id ORDER BY films.title"
    results = SqlRunner.run(sql)
    return results.map {|film| Film.new(film)} if results.any?
  end

  def self.screenings_table()
    puts "~~~~~~~~~~~~~~~ Cinema Screenings ~~~~~~~~~~~~~~~"
    all_films_showing = self.all_films_showing()
    all_screenings_for_all_films = all_films_showing.map { |film| { film.title => film.screenings() } }
    for screenings_per_film in all_screenings_for_all_films
        film_key = screenings_per_film.keys[0]
        puts "*** #{film_key} ***"
        screenings_array = screenings_per_film[film_key]
        for screening in screenings_array
          room_n = Room.find_by_id(screening.room_id).room_number
          puts "#{screening.screening_date} #{screening.screening_time} - ROOM #{room_n}"
        end
    end
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  end

  def self.most_popular()
    all_screenings = self.all()
    return all_screenings.max_by { |screening| screening.how_many_customers() }
  end

  def save()
    sql = "INSERT INTO screenings (film_id, screening_date, screening_time, room_id)
    VALUES ($1, $2, $3, $4)
    RETURNING id"
    values = [@film_id, @screening_date, @screening_time, @room_id]
    screening_data = SqlRunner.run(sql, values)
    @id = screening_data[0]["id"].to_i
  end

  def delete()
    sql = "DELETE FROM screenings where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE screenings SET (film_id, screening_date, screening_time, room_id) = ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@film_id, @screening_date, @screening_time, @room_id, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE tickets.screening_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|customer| Customer.new(customer)} if result.any?
  end

  def how_many_customers()
    customers = customers()
    if customers != nil
      return customers.count()
    else
      return 0
    end
  end

end
