#puts "hello world!"
#imports
load 'Calender.rb'

puts "\t Welcome"

cal = Calender.new
cal.print_with_legends()

print "\n Enter choice: "
while (input = gets.chomp) != 'E'
	if input == 'N' or input == 'n'
		cal.change_month(-1)
	elsif input == 'P' or input == 'p'
		cal.change_month(1)
	elsif input == 'W' or input == 'w'
		print "\nEnter start of week: "
		cal.dayOfWeek = gets.chomp
	end
	cal.print_with_legends()
	print "\n Enter choice: "
end



