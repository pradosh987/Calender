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

		puts month
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
		masterCount = 1
		dayCount = 1
		totalDays = Calender.getDaysInMonth(@state.mon-1, @state.year)
		
		prevMonth = @state << 1
		prevMonthDays = Calender.getDaysInMonth(prevMonth.mon-1, prevMonth.year)-@state.cwday + 2
		temp =1

		#printing month in console
		puts "\n\t " + Calender.mapMonth(@state.mon)
		for i in 0..4 
			for j in 0..6 
				if masterCount < @state.cwday
					masterCount+=1
					print prevMonthDays 
					prevMonthDays += 1
					print '* '
					next
				elsif if dayCount > totalDays
					print temp
					print '*  '
					temp += 1	
				end
				else
					print dayCount
					print ' ' if dayCount<10
			  	print '  '
					dayCount +=1
				end
			end
			break if dayCount > totalDays
			puts "\n"
		end
		puts "\n"
	end
end
