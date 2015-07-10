#puts "hello world!"
#imports
require 'date'

class Calender

	@@monthMap = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

	@@daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30,31]

	#constructor
	def initialize()
		@state = Date.today
		@state = Date.new(@state.year, @state.mon,1)
	end

	#class methods
	def Calender.mapMonth(m)
		return @@monthMap[m-1]
	end

	def Calender.getDaysInMonth(month, year)
		return 29 if month == 2 and Date.new(year).leap?
		return @@daysInMonth[month]
	end

	#instance methods
	#changes state to next month
	def nextMonth()
		@state = @state << -1
	end

	#changes state to previous month
	def previousMonth()
		@state = @state << 1
	end

	#prints the calender
	def printCalender()
		puts "\n\t " + Calender.mapMonth(@state.mon) 
		masterCount = 1
		dayCount = 1
		totalDays = Calender.getDaysInMonth(@state.mon-1, @state.year)
		
		#printing month in console
		for i in 0..4 
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
