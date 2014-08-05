# map-reduce mapper
# For calculating the largest dollar trade of a given security on a given date
# Raw lines look like this:
# trader, date, security, buy shares, sell shares, median price for that date
# 0006639E,04/06/2011,00000009,500,500,2.4900000095
# 0006639E,04/07/2011,00000009,10000,10000,2.5
# 0005F428,04/07/2011,00000009,0,5000,2.5

ARGF.each do |line|

   # remove any newline
   line = line.chomp

   # do nothing with lines shorter than 2 characters
   next if ! line || line.length < 2

   split = line.split(',')
   next if split.length != 6
   trader,date,security,buy,sell,price = split

   # key equals combination of date and security
   key = date + ":" + security

   # value is rest of record
   value = trader + ":" + buy + ":" + sell + ":" + price

   # output to STDOUT
   # <key><tab><value><newline>
   puts key + "\t" + value

end

