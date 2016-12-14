require 'discordrb'

keroBot = Discordrb::Commands::CommandBot.new token: 'MjU3NzQ4NjY4ODAxNzQ0ODk2.Cy_Oqg.pqBPtGYpnTNiyhYQVRLeM7pLxMU',
                                              client_id: 257748668801744896,
                                              prefix: '$'

keroBot.mention do |event|
  event.respond "Hi there #{event.user.name}"
end

keroBot.message(content: 'ding') do |event|
  event.respond 'Dong~~~'
end

keroBot.message(content: 'kero') do |event|
  event.respond 'Kero~~~'
end

keroBot.command(:user, description: 'Suwako tells you who you are. Baka~~~', usage: '$user') do |event|
  event.user.name
end

keroBot.command(:ping, description: 'Tests Suwako\'s response time', usage: '$ping') do |event|
  event.respond  "Got back to you in #{((Time.now - event.timestamp) * 1000).to_i}ms. Im fast as fuc boiiiiiiiii."
end

keroBot.command(:random, description: 'Given a number range, Suwako will choose a random number in between.', usage: '$random [min] [max]') do |event, min, max|
  if(min == nil or max == nil)
      event.respond '$help random'
  else
    event.respond rand(min.to_i .. max.to_i)
  end
end

keroBot.command(:generate, description: 'Generate a set of random numbers within a range', usage: '$generate [amount] [min] [max]') do |event, amount, min, max|
  if (amount == nil or min == nil or max == nil)
    event.respond 'Invalid arguments!'
  else
    num_array = Array.new(amount.to_i)
    num_array.each_with_index do |element, index|
      num_array[index] = rand(min.to_i .. max.to_i)
    end
    event.respond "Commander, I've generated the following numbers for you: #{num_array.join(' ')}"
  end
end

keroBot.command(:choose, description: 'Given a set of choices, Suwako will choose one she likes.', usage: '$choose [arg1] | [arg2] ...') do |event, *args|
  #items = args.keep_if { |choice| choice != '|'}
  choice = args.join(' ')
  items = choice.split('|')
  num_elements = items.count
  event.respond "I choose #{items[rand(num_elements)]}!"
end


keroBot.command(:fb, description: 'Mother fucking FizzBuzz. Sanity check because I can\'t code', usage: '$fb [number]') do |event, number|
  number = number.to_i
  print "Mod 3: #{number % 3}\n"
  print "Mod 5: #{number % 5}\n"
  if (number % 3 == 0 and number % 5 == 0)
    event.respond "FizzBuzz"
  elsif (number % 5 == 0)
    event.respond "Buzz"
  elsif (number % 3 == 0)
    event.respond "Fizz"
  else
    event.respond "Not a fizzbuzz."
  end

end

keroBot.run
