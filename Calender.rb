#puts "hello world!"
#imports


require 'date'

class Calender

	# REVIEW -- you already have access to a fully functional date library. Why
	# do you need to define this again? All these three things are easily
	# obtainable from the Ruby Date library. No point in re-inventing the wheel.
	@@monthMap = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
	@@daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30,31]
	@@days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

	attr_writer :dayOfWeek

	#constructor
	def initialize()
		@state = Date.today
		@state = Date.new(@state.year, @state.mon,1)
		@dayOfWeek = 1
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
	#changes internal state of Calender by specified month 
	#+ve i increments month
	#-vw i decrements month

	# REVIEW: badly named function. decrementMonth means that the month is
	# always going to decrease, however, you're also allowing the months to
	# increase from this method. It should probably be called change_month. Also
	# Ruby convention is to use snake_case not camelCase for naming.
	def decrementMonth(i)
		@state = @state << i
	end

	#prints the calender
	def printCalender()
		masterCount = 1
		dayCount = 1
		totalDays = Calender.getDaysInMonth(@state.mon-1, @state.year)
		
		#printing month in 
		puts "\n\t " + Calender.mapMonth(@state.mon) + ' ' + @state.year.to_s()
		puts "\n"


		# REVIEW -- does this really need a conditional? Aren't all these the
		# special cases of some general formula?
		startDay = @state.cwday
		if startDay == @dayOfWeek.to_i()
			startDay = 1 
		elsif @dayOfWeek.to_i < startDay
			startDay = startDay - @dayOfWeek.to_i()+ 1
		elsif @dayOfWeek.to_i > startDay  
			startDay = 1 + 7 - (@dayOfWeek.to_i() - startDay).abs()
		end

		prevMonth = @state << 1
		prevMonthDays = Calender.getDaysInMonth(prevMonth.mon-1, prevMonth.year)- startDay + 2
		temp =1

		#print days
		t=@dayOfWeek.to_i() -1
		for i in 0..6
			t = 0 if t > 6
			print @@days[t].to_s() + ' ' 
			t+=1
		end
		print "\n"
		for i in 0..5 
			for j in 0..6 
				if masterCount < startDay
					masterCount+=1
					print prevMonthDays.to_s() + '* ' 
					prevMonthDays += 1
					next
				elsif if dayCount > totalDays
					print temp.to_s() + '* '
					temp += 1	
				end
				else
					print dayCount.to_s() + '  '
					print ' ' if dayCount<10
					dayCount +=1
				end
			end
			break if dayCount > totalDays
			puts "\n"
		end
		puts "\n"
	end
end
