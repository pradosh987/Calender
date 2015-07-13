#puts "hello world!"
#imports
require 'date'

class Calender

	#constructor
	def initialize()
		@state = Date.today
		@state = Date.new(@state.year, @state.mon,1)
	end

	#instance methods
	def change_month(i)
		@state = @state << i
	end

	#prints the calender
	def printCalender(before, on, after)
		puts "\n\t " + Date::MONTHNAMES[@state.mon] 
		masterCount = 1
		dayCount = 1
		totalDays = Date.civil(@state.year, @state.mon, -1).mday

		#printing month in console
		for i in 0..5 
			for j in 0..6 
				if masterCount < @state.cwday
					masterCount+=1
					print '   '
					next
				else
					print dayCount
					print ' ' if dayCount<10
			  	print ' '
					dayCount +=1
				break if dayCount > totalDays
				end
			end
			break if dayCount > totalDays
			puts "\n"
		end
		puts "\n"
	end
end
