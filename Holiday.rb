require 'csv'


class Holiday

	attr_reader :description, :date, :legend

	def initialize(date,description,legend = nil)
		@date = date
		@description = description
		@legend = legend
	end

	def self.readFromFile(filePath)
		holidays = Array.new
		legends = Array.new(('a'..'z').to_a())
		legendCount = 0
		CSV.foreach(filePath) do |row|
			date = row[0].split('-')
			hol = Holiday.new(Date.new(date[0].to_i,date[1].to_i,date[2].to_i),row[1],legends[legendCount])
			legendCount += 1
			holidays.push(hol)
		end
		return holidays
	end

	def self.get_holiday(date)
		begin
			hol = @@holidays[date.year][date.mon][date.mday]
		rescue
			nil
		end
	end



	def self.getDefaultHolidays(date)
		holidays = Array.new
		legends = Array.new(('a'..'z').to_a())
		legendCount = 0
		var = @@holidays[date.year][date.mon]
		if var
	    var.each do |var|
  	  	hol = Holiday.new(Date.new(date.year, date.mon,var[0].to_i), var[1], legends[legendCount])
    		legendCount += 1
    		holidays.push(hol)
    	end
    else return nil
    end
    return holidays
	end

	##hash store
	#Level 1 -> Year
	#Level 2 -> Month
	#Level 3 -> Date
	@@holidays = {
		2015 => {
			01 => {
				26 => "Republic Day"
			},
			02 => {
				14 => 'Valentine Day'
			},
			03 => {
				04 => 'Holiday'
			},
			07 => {
				19 => 'Eid',
				24 => "Also a Holiday"
			},
			12 => {
				25 =>'Christmas'
			}
		}
	}
end
