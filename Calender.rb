#puts "hello world!"
#imports
require 'date'

class Calender
	attr_writer :dayOfWeek

	#constructor
	def initialize()
		@state = Date.today
		@state = Date.new(@state.year, @state.mon,1)
		@dayOfWeek = 1
	end

  def change_month(i)
    @state = @state << i
  end

	 def print_calender(
    print_func= nil, 
    before_month = nil, 
    before_week = nil,
    after_week = nil,
    after_month = nil)
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
        print_func.call(startDay, master_count, @state)
        master_count += 1
      end
      puts "\n"
      break if master_count > (startDay + (Date.civil(@state.year, @state.mon, -1).mday))
    end
  end

  def print_calender_with_dow()
  	print_func = lambda do |start, count, date|
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
  	print_calender(print_func)
  end
end
