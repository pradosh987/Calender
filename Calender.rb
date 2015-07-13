#Run: ruby Calender.rb -m 07 -y 2015

require 'date'
require 'optparse'

class Calender

	attr_reader :date, :day_of_week
	def initialize(date = Date.today,dow = 1)
		@date = date
		@day_of_week = dow
		@day_of_week = 1 if @day_of_week ==nil
	end 

	def change_month(i)
		@date = @date << i
	end

	def get_start_day()
		return 1	if  @date.cwday == @day_of_week 
		return @day_of_week.to_i < @date.cwday.to_i ? (@date.cwday - @day_of_week.to_i()+ 1) : (1 + 7 - (@day_of_week.to_i() - @date.cwday).abs())
	end
end

def print_calender(cal, print_func,control_hooks = nil, before_month = nil, before_week=nil,after_week=nil, after_month= nil)

	grid_count = 1;

	##before priting hook
	if before_month 
		before_month cal
	else
		puts ("\n\t\t" + Date::MONTHNAMES[cal.date.mon] + ' ' + cal.date.year.to_s() + "\n\n")
	end

	#compute start date
	start_day = cal.get_start_day

	t = cal.day_of_week.to_i() 
	for i in 0..6
		t = 0 if t > 6
		print_func.call(Date::ABBR_DAYNAMES[t].to_s)
		t+=1
	end	
	puts "\n"
	for i in 0..5 
		#call to a hook
		before_week.call(grid_count,cal,i) if before_week
		for j in 0..6
			#call to print hook
			print_func.call(hook_controler(grid_count,cal,control_hooks))
			grid_count += 1
		end
		puts "\n"
		break if grid_count > (start_day + (Date.civil(cal.date.year, cal.date.mon, -1).mday))
		after_week.call(grid_count,cal,i) if after_week
	end
	after_month(cal) if after_month
end

def hook_controler(grid_count,cal, procedures)
	present_month = Date.civil(cal.date.year, cal.date.mon, -1)
	start_day = cal.get_start_day
	if(grid_count < start_day)
		temp = ''
	elsif (grid_count - start_day) < present_month.mday
		temp = grid_count-start_day + 1		
	else 
		temp = ''
	end
	
	if procedures
		procedures.each do |p| 
			temp = p.call(temp,grid_count,cal)
		end
	end
	
  return temp
end

def calender_controller(options = nil)
	if options and options[:month] and options[:year]
		date_of_week = options[:dow]
		cal = Calender.new(Date.new(options[:year].to_i,options[:month].to_i),date_of_week)
	else
		cal = Calender.new
	end

	#printing hook
	print_func = lambda { |value|  printf("%7s", value.to_s) }

	before_month = nil
	before_week = nil
	after_week = nil
	after_month = nil
	control_hooks = Array.new

	##hooks
	present_month = Date.civil(cal.date.year, cal.date.mon, -1)
	previous_month = present_month << 1
	start = cal.get_start_day
	
	#hook to print previous and next month dates with *
	previous_month_dates_hook = lambda do |value,grid_count,cal|
		if(grid_count < start)
			return ('*'+ (previous_month.mday.to_i - start.to_i + grid_count.to_i + 1).to_s)
		elsif (grid_count-start) >= present_month.mday
			return ('*' +(grid_count.to_i-start.to_i+1-present_month.mday.to_i).to_s)
		end 
		value
	end

	#push hook to process
	control_hooks.push(previous_month_dates_hook)

	#add more hooks here


	print_calender(cal,print_func,control_hooks,before_month,before_week,after_week,after_month)
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

calender_controller options