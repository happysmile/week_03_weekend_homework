
require('date')
require('pry')

require_relative('models/film.rb')
require_relative('models/customer.rb')
require_relative('models/ticket.rb')



Ticket.delete_all()
Film.delete_all()
Customer.delete_all()


  la_la_land = Film.new({
    'title' => 'La La Land',
    'screening_time' => '2020-02-15 16:10:00',
    'price' => 10
  })
  la_la_land.save()


  gangster_squad = Film.new({
    'title' => 'Gangster Squad',
    'screening_time' => '2020-02-15 17:43:00',
    'price' => 10
  })

  gangster_squad.save()

  crazy_stupid_love = Film.new({
    'title' => 'Crazy Stupid Love',
    'screening_time' => '2020-02-15 15:34:00',
    'price' => 10
  })

  crazy_stupid_love.save()

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

  ticket1 = Ticket.new({
    'customer_id' => alice_wong.id,
    'film_id' => la_la_land.id
  })
  ticket1.save()

  ticket2 = Ticket.new({
    'customer_id' => john_smith.id,
    'film_id' => la_la_land.id
  })
  ticket2.save()

  ticket3 = Ticket.new({
    'customer_id' => maria_stevenson.id,
    'film_id' => la_la_land.id
  })
  ticket3.save()

  ticket4 = Ticket.new({
    'customer_id' => lee_green.id,
    'film_id' => la_la_land.id
  })
  ticket4.save()

  ticket5 = Ticket.new({
    'customer_id' => ross_khan.id,
    'film_id' => gangster_squad.id
  })
  ticket5.save()

  ticket6 = Ticket.new({
    'customer_id' => lee_green.id,
    'film_id' => gangster_squad.id
  })
  ticket6.save()

  ticket7 = Ticket.new({
    'customer_id' => maria_stevenson.id,
    'film_id' => gangster_squad.id
  })
  ticket7.save()

  ticket8 = Ticket.new({
    'customer_id' => ross_khan.id,
    'film_id' => crazy_stupid_love.id
  })
  ticket8.save()

  ticket9 = Ticket.new({
    'customer_id' => john_smith.id,
    'film_id' => crazy_stupid_love.id
  })
  ticket9.save()



  binding.pry
  nil
