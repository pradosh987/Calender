#imports
require 'date'
require 'optparse'
load 'Holidays.rb'

class Calender

	@@monthMap = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

	@@daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30,31]

	@@days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

	attr_writer :dayOfWeek

	#constructor
	def initialize(options)
		if options[:month] and options[:year]
			@state = Date.new(options[:year].to_i, options[:month].to_i)
			@dayOfWeek = options[:dow] if options[:dow]
			updateHolidays()
			printCalender()
		else
			@state = Date.today
			@state = Date.new(@state.year, @state.mon,1)
			@dayOfWeek = 1


		end
	end

	#class methods
	def Calender.mapMonth(m)
		return @@monthMap[m-1]
	end

	def updateHolidays()
		@holidays = Holidays.getInstance().getHolidaysOfMonth(@state)
	end

	def Calender.getDaysInMonth(month, year)
		return 29 if month == 2 and Date.new(year).leap?
		return @@daysInMonth[month]
	end

	#instance methods
	#changes internal state of Calender by specified month 
	#+ve i increments month
	#-ve i decrements month
	def decrementMonth(i)
		@state = @state << i
		updateHolidays()
	end

	#prints the calender
	def printCalender()
		#puts @holidays.length()
		masterCount = 1
		dayCount = 1
		totalDays = Calender.getDaysInMonth(@state.mon-1, @state.year)
		
		#printing month in 
		puts "\n\t\t" + Calender.mapMonth(@state.mon) + ' ' + @state.year.to_s() + "\n"

		startDay = @state.cwday
		if startDay == @dayOfWeek.to_i()
			startDay = 1 
		elsif @dayOfWeek.to_i < startDay
			startDay = startDay - @dayOfWeek.to_i()+ 1
		else  
			startDay = 1 + 7 - (@dayOfWeek.to_i() - startDay).abs()
		end

		prevMonth = @state << 1
		prevMonthDays = Calender.getDaysInMonth(prevMonth.mon-1, prevMonth.year)- startDay + 2
		temp =1


		legends = Array.new(('a'..'b').to_a())
		legendCount = 0
		#print days
		t = @dayOfWeek.to_i() -1
		for i in 0..6
			t = 0 if t > 6
			print @@days[t].to_s() + '   ' 
			t+=1
		end
		print "\n"
		for i in 0..5 
			for j in 0..6 
				if masterCount < startDay
					masterCount+=1
					print prevMonthDays.to_s() + '*   ' 
					prevMonthDays += 1
					next
				elsif if dayCount > totalDays
					print temp.to_s() + '*    '
					temp += 1	
				end
				else
					print dayCount.to_s()  
					if @holidays and @holidays[dayCount]
						print legends[legendCount].to_s()+'   ' 
						legendCount+=1
					else 
						print '    '
					end
					print ' ' if dayCount<10
					dayCount +=1
				end
			end
			break if dayCount > totalDays
			puts "\n"
		end
		puts "\n\n"

		#print holiday legends
		if @holidays
			puts "\nLegends: "
			for i in 0..@holidays.length-1 
				puts legends[i].to_s() + ' : ' + @holidays.values[i].to_s()
			end
		end
	end #printCalender End
end

#option parser
options = {}
OptionParser.new do |opts|
	opts.banner = "Usage: Calender.rb [options]"

	opts.on("-m ", "Month") do | m|
		#if m === (1..12)
		#	puts "less"
			options[:month] = m
		#else
		#	options[:month] = nil
		#end
	end

	opts.on("-y ", "--year", "Year") do | y|
		#if y
			options[:year] = y
		#else
		#	options[:year] = nil
		#end
	end

	opts.on("-w", "--dow", "Starting day of week") do |w|
		if w>0 and w < 8 
			options[:dow] = w  
		else
			options[:dow] = 1
		end
	end
end.parse!

Calender.new(options)