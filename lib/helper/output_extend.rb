#module demonstrates how additional functionalities can be included (or used as "mixed-ins")
#to a class and then reused. Heavily used in RoR
module NumHelper


  def format_currency(num, options={})

      unit      = options[:unit] || '$'
      precision = options[:precision] || 2
      delimiter = options[:delimiter] || ','
      separator = options[:separator] || '.'

  end




end
