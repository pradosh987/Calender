#imports
require 'date'
require 'optparse'
load 'Holiday.rb'
load 'Holidays.rb'

class Calender

	attr_writer :dayOfWeek

	#constructor
	def initialize(options = nil)
		if options and options[:month] and options[:year]
			printFlag = true
			@state = Date.new(options[:year].to_i, options[:month].to_i)
			@dayOfWeek = options[:dow] if options[:dow]
			@holidays = Holiday.readFromFile(options[:holidays]) if options[:holidays]

			#updateHolidays
		else
			@state = Date.today
			@state = Date.new(@state.year, @state.mon,1)
			@dayOfWeek = 1
			@holidays = Holiday.getDefaultHolidays(@state)
			#updateHolidays()
		end
			
			print_calender if printFlag
	end

	#class methods
	def updateHolidays()
		@holidays = Holidays.getInstance().getHolidaysOfMonth(@state)
	end

	#instance methods
	#changes internal state of Calender by specified month 
	#+ve i increments month
	#-ve i decrements month
	def change_month(i)
		@state = @state << i
		updateHolidays()
	end

	def print_calender(
		print_func= nil, 
		before_month = nil, 
		before_week = nil,
		after_week = nil,
		after_month = nil)
	 	print_func = @@print_basic if print_func == nil
		

		

		master_count = 1
		puts "\n\t\t" + Date::MONTHNAMES[@state.mon] + ' ' + @state.year.to_s() + "\n"

		startDay = @state.cwday
		if startDay == @dayOfWeek.to_i()
			startDay = 1 
		elsif @dayOfWeek.to_i < startDay
			startDay = startDay - @dayOfWeek.to_i()+ 1
		else  
			startDay = 1 + 7 - (@dayOfWeek.to_i() - startDay).abs()
		end

		puts "\n"
		t = @dayOfWeek.to_i() 
		for i in 0..6
			t = 0 if t > 6
			printf("%7s",Date::ABBR_DAYNAMES[t].to_s) 
			t+=1
		end

		puts "\n"
		for i in 0..5 
			for j in 0..6
				@@print_basic.call(startDay, master_count, @state)
				master_count += 1
			end
			puts "\n"
			break if master_count > (startDay + (Date.civil(@state.year, @state.mon, -1).mday))
		end
	end


	@@print_basic = lambda do |start, count, date|
		present_month = Date.civil(date.year, date.mon, -1)
		previous_month = present_month << 1
		if(count<start)
			printf("%7s",'*' + (previous_month.mday - start + count + 1).to_s)
		elsif (count-start) < present_month.mday
			printf("%7s",(count-start+1))
		else 
			printf("%7s",'*' +(count-start+1-present_month.mday).to_s)
		end
	end

	@@calender_legends = lambda do |start, count, date|
		present_month = Date.civil(date.year, date.mon, -1)
		previous_month = present_month << 1

		

		if(count<start)
			printf("%7s",'*' + (previous_month.mday - start + count + 1).to_s)
		elsif (count-start) < present_month.mday
			printf("%7s",(count-start+1))
		else 
			printf("%7s",'*' +(count-start+1-present_month.mday).to_s)
		end
	end




	#DEPRECIATED
	def printcalender()
		#puts @holidays.length()
		masterCount = 1
		dayCount = 1
		totalDays = Date.civil(@state.year, @state.mon, -1).mday
		
		#printing month in 
		puts "\n\t\t" + Date::MONTHNAMES[@state.mon] + ' ' + @state.year.to_s() + "\n"

		startDay = @state.cwday
		if startDay == @dayOfWeek.to_i()
			startDay = 1 
		elsif @dayOfWeek.to_i < startDay
			startDay = startDay - @dayOfWeek.to_i()+ 1
		else  
			startDay = 1 + 7 - (@dayOfWeek.to_i() - startDay).abs()
		end

		prevMonth = @state << 1
		prevMonthDays = Date.civil(prevMonth.year, prevMonth.mon, -1).mday - startDay + 2
		temp =1

		legends = Array.new(('a'..'b').to_a())
		legendCount = 0
		#print days
		t = @dayOfWeek.to_i() -1
		for i in 0..6
			t = 0 if t > 6
			print  Date::ABBR_DAYNAMES[t].to_s + '    ' 
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
					if @holidays
						@holidays.each do |h|
							if dayCount==h.date.mday
								print h.legend.to_s + '   '
							else 
								print '    '
							end
						end 
					end
					#if @holidays and @holidays[dayCount]
					#	print legends[legendCount].to_s()+'   ' 
					#	legendCount+=1
					#else 
					#	print '    '
					#end
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
			@holidays.each do |l|
				puts l.legend.to_s + " : " + l.description
			end
		end

		#if @holidays
		#	puts "\nLegends: "
		#	for i in 0..@holidays.length-1 
		#		puts legends[i].to_s() + ' : ' + @holidays.values[i].to_s()
		#	end
		#end
	end #printCalender End
end

#option OptionParser
options = {}
OptionParser.new do |opts|
	opts.banner = "Usage: Calender.rb [options]"

	opts.on("-m ", "Month") do | m|
		options[:month] = nil
		options[:month] = m if m.to_i.between?(1,12)
	end

	opts.on("-y ", "--year", "Year") do | y|
		options[:year] = nil
		options[:year] = y  if y.to_i > 0
	end

	opts.on("-w ", "--dow", "Starting day of week") do | w|
		options[:dow] = 1
		options[:dow] = w  if w.to_i.between?(1, 7)
	end

	opts.on("-h ", "--holidays", "File with holidays") do | h|
		options[:holidays] = nil
		options[:holidays] = h if h
	end

end.parse!

Calender.new(options)