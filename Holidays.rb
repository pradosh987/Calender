#Singleton class which stores list of holidays in hash structure

class Holidays
	private_class_method :new
	@@instance = nil
	def Holidays.getInstance
		@@instance = new unless @@instance
		@@instance
	end

	def getHoliday(date)
		@@holidays[date.year][date.mon][date.mday]
	end

	def getHolidaysOfMonth(date)
		@@holidays[date.year][date.mon]
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