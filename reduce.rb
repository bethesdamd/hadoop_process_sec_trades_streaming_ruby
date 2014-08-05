# Ruby code for reduce.rb
# Processes trades to find highest value trade for a given security on a given date
# Takes as input from map.rb:
# date:security <tab> trader:bought:sold:price
# 04/06/2011:00000009  0006639E:500:500:2.4900000095
# 04/07/2011:00000009  0006639E:10000:10000:2.5
# 04/07/2011:00000009  0005F428:0:5000:2.5

# Output looks like this:
# date:security <tab> amount bought in dollars:trader
# 04/04/2011:0000000F   9897:000001C1
# 04/04/2011:00000012  617653:000001A9
# 04/06/2011:00000009  443249:0001E394

prev_key = nil
max = 0.0

ARGF.each do |line|
   line = line.chomp

   # split key and value on tab character
   (key, value) = line.split(/\t/)
   trader,buy,sell,price = value.split(':')
   purchase = buy == "0" ? false : true  # purchase = true if this was a buy, else false

   # check for new key
   if prev_key  &&  key != prev_key

      # output total for previous key
      puts prev_key + "\t" + max.to_i.to_s + ":" + trader

      # reset key total for new key
      prev_key = key
      max = 0.0

   elsif ! prev_key
      prev_key = key
   end

   # look for a new maximum purchase
   if purchase
      current_value = buy.to_f * price.to_f
      max = current_value if current_value > max
   end

end
