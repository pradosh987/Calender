#puts "hello world!"
#imports
load 'Calender.rb'

puts "\t Welcome"

cal = Calender.new
cal.printCalender()

puts "\n Enter choice: "
while (input = gets.chomp) != 'E'
	if input == 'N' or input=='n'
		cal.change_month(-1)
	elsif input == "P" or input == 'p'
		cal.change_month(1)
	end
	cal.printCalender()
end



