#puts "hello world!"
#imports
load 'Calender.rb'

puts "\t Welcome"

cal = Calender.new
cal.printCalender()

print "\n Enter choice: "
while (input = gets.chomp) != 'E'
	if input == 'N' or input == 'n'
		cal.decrementMonth(-1)
	elsif input == 'P' or input == 'p'
		cal.decrementMonth(1)
	elsif input == 'W' or input == 'w'
		print "\nEnter start of week: "
		cal.dayOfWeek = gets.chomp
	end
	cal.printCalender()
	print "\n Enter choice: "
end



