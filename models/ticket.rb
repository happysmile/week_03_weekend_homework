require_relative("../db/sql_runner.rb")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @customer_id = options["customer_id"]
    @film_id = options["film_id"]
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id)
    VALUES ($1, $2)
    RETURNING id"
    values = [@customer_id, @film_id]
    ticket_data = SqlRunner.run(sql, values)
    @id = ticket_data[0]["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * from tickets"
    ticket_data = SqlRunner.run(sql)
    return ticket_data.map{|ticket| Ticket.new(ticket)}
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id) = ($1, $2)
    WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end



end
