# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Exam.delete_all
College.delete_all

10.times do |index|
  college = College.create()
  puts "created #{college.inspect}"
end

College.all.each.with_index(1) do |college, index|
  exam = college.exams.create(starts_at: Time.now, ends_at: index.days.from_now)
  puts "created #{exam.inspect}"
end

10.times do |index|
  user = User.create!(first_name: "First#{index+1}", last_name: "Last#{index+1}", phone_number: "1-312-772-#{rand(1111..9999)}")
  puts "created #{user.inspect}"
end

User.all.take(2).each do |user|
  user.update(exam_id: Exam.first.id)
end
