#This module demonstrates how additional functionalities 
#can be included (or used as "mixed-ins")
#to a class and then reused. Heavily used in RoR
module NumHelper


  def format_currency(num, options={})

      unit      = options[:unit] || '$'
      precision = options[:precision] || 2
      delimiter = options[:delimiter] || ','
      separator = options[:separator] || '.'

     separator = '' if precision == 0

     #convert the number in two parts, integer part and decimal part
     integer, decimal = num.to_s.split(".")

     i = integer.length
     
     until i <= 3
        i -= 3
        integer = integer.insert(i, delimiter)
     end

     if precision == 0
        precise_decimal = ''
     else
        #make sure decimal is not nil
        decimal ||= "0"
        #make sure the decimal is not so large
        decimal = decimal[0, precision-1]
        #make sure the precision is not too short
        precise_decimal = decimal.ljust(precision, "0")
     end
 
     return unit + integer + separator + precise_decimal

  end

end
