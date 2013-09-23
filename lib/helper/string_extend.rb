#This helper is opening up core ruby String class in order to add a new method to all Strings
class String

  #Ruby has a capitalize method(used below) which capitalizes the first letter of the string.
  #But in order to capitalize the first letter if every word we have to write our own method

  def titleize
      self.split(' ').collect {|word| word.capitalize}.join(" ")
  end


end
