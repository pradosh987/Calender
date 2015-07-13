require 'csv'

CSV.foreach('holidays.csv') do |row|
  puts row.inspect
end