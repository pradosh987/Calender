#puts "hello world!"
#imports
load 'Calender.rb'

puts "\t Welcome"

cal = Calender.new
cal.printCalender()

puts "\n Enter choice: "
while (input = gets.chomp) != 'E'
	if input == 'N'
		cal.nextMonth()
	elsif input == "P"
		cal.previousMonth()
	end
	cal.printCalender()
end



