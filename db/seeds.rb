# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

i = 1
["Whom do you want to punch?", "A boy/girl got slapped in college, who do you think he was?",
"Who resembles this guy?", "Which of your friend you think should be of opposite gender?", "If you are stuck in a room with a friend, who it should be?", "Which of your friends always spoils your mood?", "Which of your friends has flirted with a teacher?", "Which of your friends is the most daring?", "Who is your 4AM friend?", "Who is your ready-to-fight friend?", "Who is your cool friend?", "Who spends more of his dad's money?", "Who is your most irritating friend?", "Which of your old friends do you want to meet now?", "Who is your missed-call friend?", "Who is your pappu friend?", "Who is your Scholar friend?"].each do |question|
   Question.create!(question_text: question, order: i)
   i += 1
end


