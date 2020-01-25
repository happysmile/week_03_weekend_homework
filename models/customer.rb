require_relative("../db/sql_runner.rb")

class Customer

  attr_reader :id
  attr_accessor :first_name, :last_name, :funds

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @funds = options["funds"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * from customers"
    customer_data = SqlRunner.run(sql)
    return customer_data.map{|customer| Customer.new(customer)}
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    customers_hash = results.first
    return Customer.new(customers_hash)
  end

  def save()
    sql = "INSERT INTO customers (first_name, last_name, funds)
    VALUES ($1, $2, $3)
    RETURNING id"
    values = [@first_name, @last_name, @funds]
    customer_data = SqlRunner.run(sql, values)
    @id = customer_data[0]["id"].to_i
  end

  def delete()
    sql = "DELETE FROM customers where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers SET (first_name, last_name, funds) = ($1, $2, $3)
    WHERE id = $4"
    values = [@first_name, @last_name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def screenings()
    sql = "SELECT screenings.* FROM screenings INNER JOIN tickets ON tickets.screening_id = screenings.id WHERE tickets.customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|screening| Screening.new(screening)} if result.any?
  end

  def films()
    sql = "SELECT DISTINCT films.* FROM films INNER JOIN screenings ON films.id = screenings.film_id INNER JOIN tickets ON tickets.screening_id = screenings.id
    WHERE tickets.customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|film| Film.new(film)} if result.any?
  end

  def tickets()
    sql = "SELECT tickets.* FROM tickets WHERE tickets.customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|ticket| Ticket.new(ticket)} if result.any?
  end

  def how_many_tickets()
    tickets = tickets()
    return tickets.count()
  end

  def decrease_funds(amount)
    @funds -= amount
    update()
  end

  def can_afford(amount)
    if @funds.to_i() >= amount
      return true
    else
      return false
    end
  end

  def buy_ticket(screening)
    room = Room.find_by_id(screening.room_id)
    film = Film.find_by_id(screening.film_id)
    if( room.is_there_a_seat_left() )
      if( can_afford(film.price) )
        ticket = Ticket.new({
          'customer_id' => @id,
          'screening_id' => screening.id
        })
        ticket.save()
        decrease_funds(film.price)
        room.decrease_seats()
      end
    end
  end

end
