require_relative("../db/sql_runner.rb")

class Room

  attr_reader :id, :room_number, :seats

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @room_number = options["room_number"]
    @seats = options["seats"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM rooms"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * from rooms"
    room_data = SqlRunner.run(sql)
    return room_data.map{|room| Room.new(room)}
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM rooms WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    rooms_hash = results.first
    return Room.new(rooms_hash)
  end

  def save()
    sql = "INSERT INTO rooms (room_number, seats)
    VALUES ($1, $2)
    RETURNING id"
    values = [@room_number, @seats]
    room_data = SqlRunner.run(sql, values)
    @id = room_data[0]["id"].to_i
  end

  def delete()
    sql = "DELETE FROM rooms where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE rooms SET (room_number, seats) = ($1, $2)
    WHERE id = $3"
    values = [@room_number, @seats, @id]
    SqlRunner.run(sql, values)
  end

  def decrease_seats()
    @seats -=1
    update()
  end

  def is_there_a_seat_left()
    if @seats.to_i() >= 1
      return true
    else
      return false
    end
  end

end
