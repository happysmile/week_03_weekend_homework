require('date')
require('pry')
require('pp')

require_relative('models/film.rb')
require_relative('models/customer.rb')
require_relative('models/ticket.rb')
require_relative('models/screening.rb')
require_relative('models/room.rb')

Film.delete_all()
Room.delete_all()
Customer.delete_all()
Ticket.delete_all()
Screening.delete_all()

# ----------------- FILMS ----------------------------

  la_la_land = Film.new({
    'title' => 'La La Land',
    'price' => 10
  })
  la_la_land.save()


  gangster_squad = Film.new({
    'title' => 'Gangster Squad',
    'price' => 10
  })
  gangster_squad.save()

  crazy_stupid_love = Film.new({
    'title' => 'Crazy Stupid Love',
    'price' => 10
  })
  crazy_stupid_love.save()

  film_not_showing = Film.new({
    'title' => 'Film Not Showing',
    'price' => 10
  })
  film_not_showing.save()

# ----------------- CUSTOMERS ----------------------------

  john_smith = Customer.new({
    'first_name' => 'John',
    'last_name' => 'Smith',
    'funds' => '60'
  })
  john_smith.save()

  ross_khan = Customer.new({
    'first_name' => 'Ross',
    'last_name' => 'Khan',
    'funds' => '45'
  })
  ross_khan.save()

  lee_green = Customer.new({
    'first_name' => 'Lee',
    'last_name' => 'Green',
    'funds' => '73'
  })
  lee_green.save()

  maria_stevenson = Customer.new({
    'first_name' => 'Maria',
    'last_name' => 'Stevenson',
    'funds' => '55'
  })
  maria_stevenson.save()

  alice_wong = Customer.new({
    'first_name' => 'Alice',
    'last_name' => 'Wong',
    'funds' => '89'
  })
  alice_wong.save()

# ----------------- ROOMS ----------------------------

  room1 = Room.new({
    'room_number' => 1,
    'seats' => 10
  })
  room1.save()

  room2 = Room.new({
    'room_number' => 2,
    'seats' => 20
  })
  room2.save()

  room3 = Room.new({
    'room_number' => 3,
    'seats' => 15
  })
  room3.save()

  # ----------------- SCREENINGS ----------------------------

    screening1 = Screening.new({
      'film_id' => la_la_land.id,
      'screening_date' => "2020-01-01",
      'screening_time' => "18:10",
      'room_id'=> room1.id
    })
    screening1.save()

    screening2 = Screening.new({
      'film_id' => la_la_land.id,
      'screening_date' => "2020-01-01",
      'screening_time' => "19:40",
      'room_id'=> room1.id
    })
    screening2.save()

    screening3 = Screening.new({
      'film_id' => gangster_squad.id,
      'screening_date' => "2020-01-02",
      'screening_time' => "18:40",
      'room_id'=> room2.id
    })
    screening3.save()

    screening4 = Screening.new({
      'film_id' => gangster_squad.id,
      'screening_date' => "2020-01-03",
      'screening_time' => "19:40",
      'room_id'=> room2.id
    })
    screening4.save()

    screening5 = Screening.new({
      'film_id' => crazy_stupid_love.id,
      'screening_date' => "2020-01-01",
      'screening_time' => "16:30",
      'room_id'=> room1.id
    })
    screening5.save()

    screening6 = Screening.new({
      'film_id' => crazy_stupid_love.id,
      'screening_date' => "2020-01-02",
      'screening_time' => "15:40",
      'room_id'=> room2.id
    })
    screening6.save()

    screening7 = Screening.new({
      'film_id' => crazy_stupid_love.id,
      'screening_date' => "2020-01-02",
      'screening_time' => "17:40",
      'room_id'=> room2.id
    })
    screening7.save()

    screening8 = Screening.new({
      'film_id' => crazy_stupid_love.id,
      'screening_date' => "2020-01-02",
      'screening_time' => "16:40",
      'room_id'=> room2.id
    })
    screening8.save()


# ----------------- TICKETS ----------------------------

  ticket1 = Ticket.new({
    'customer_id' => alice_wong.id,
    'screening_id' => screening1.id
  })
  ticket1.save()

  ticket2 = Ticket.new({
    'customer_id' => john_smith.id,
    'screening_id' => screening1.id
  })
  ticket2.save()

  ticket3 = Ticket.new({
    'customer_id' => maria_stevenson.id,
    'screening_id' => screening1.id
  })
  ticket3.save()

  ticket4 = Ticket.new({
    'customer_id' => lee_green.id,
    'screening_id' => screening1.id
  })
  ticket4.save()

  ticket5 = Ticket.new({
    'customer_id' => ross_khan.id,
    'screening_id' => screening2.id
  })
  ticket5.save()

  ticket6 = Ticket.new({
    'customer_id' => lee_green.id,
    'screening_id' => screening2.id
  })
  ticket6.save()

  ticket7 = Ticket.new({
    'customer_id' => maria_stevenson.id,
    'screening_id' => screening3.id
  })
  ticket7.save()

  ticket8 = Ticket.new({
    'customer_id' => ross_khan.id,
    'screening_id' => screening3.id
  })
  ticket8.save()

  ticket9 = Ticket.new({
    'customer_id' => john_smith.id,
    'screening_id' => screening3.id
  })
  ticket9.save()

  ticket10 = Ticket.new({
    'customer_id' => ross_khan.id,
    'screening_id' => screening4.id
  })
  ticket10.save()

  ticket11 = Ticket.new({
    'customer_id' => lee_green.id,
    'screening_id' => screening5.id
  })
  ticket11.save()

  ticket12 = Ticket.new({
    'customer_id' => maria_stevenson.id,
    'screening_id' => screening6.id
  })
  ticket12.save()



  binding.pry
  nil
