# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

i = 1
["Whom do you want to punch?", "A boy/girl got slapped in college who do you think he was?",
"Who resembles this guy?", "Which of your friend you think has got wrong gender?", "If you are stuck in a room with a friend, with whom you would want to?", "Which of your friends always destroy mood?", "Which of your friend flirted with teacher?", "Who isyour of your friend has daring?", "Who will get most attention in a stripper act?", "Who is your 4AM friend?", "Who is your ready to fight friend?", "Who is your cool friend?", "Who spends more money from his dad's account?", "Who is your irritating friend?", "Which of your friends do you want to meet?", "Among you friends, whose timepass is Pornmovie?", "Who is your miss-call friend?", "Who is your pappu friend?", "Who is your Scholar friend?"].each do |question|
   Question.create!(question_text: question, order: i)
   i += 1
end


