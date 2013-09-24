require 'helper/num_helper'
class Science

 include NumHelper

 @@filepath = nil

 attr_accessor :title, :author, :publication, :date, :location
 
 def self.filepath=(path=nil)
    @@filepath = File.join(APP_ROOT, path)
 end

 def self.file_exists?
	   if @@filepath && File.exists?(@@filepath)
	      return true
	   else
	      return false
	   end
 end

 def self.file_usable?
     return false unless @@filepath
     return false unless File.exists?(@@filepath)
     return false unless File.readable?(@@filepath)
     return false unless File.writable?(@@filepath)
     return true
 end

 def self.create_file
     File.open(@@filepath, 'w') unless file_exists?
     return file_usable?
 end

 def self.saved_articles

     #read the article file
     articles = []
     if file_usable?
        file = File.new(@@filepath, 'r')
	     file.each_line do |line|
	      articles << Science.new.import_line(line.chomp) 
	     end
	file.close
     end
     #return the instances of articles
     return articles

 end

 def initialize(args={})
	  @title       = args[:title]       || ""
	  @author      = args[:author]      || ""
	  @publication = args[:publication] || ""
	  @date        = args[:date]        || ""
          @location    = args[:location]    || ""
 end

 def self.build_using_questions
     args = {}
    
     print "Add Title: "
     #science.title = gets.chomp.strip
      args[:title] = gets.chomp.strip
     
     print "Add Author: "
     #science.author = gets.chomp.strip
      args[:author] = gets.chomp.strip
     
     print "Add Publication: "
     #science.publication = gets.chomp.strip
      args[:publication] = gets.chomp.strip
     
     print "Add Date: "
     #science.date = gets.chomp.strip
      args[:date] = gets.chomp.strip

    print "Add Location: "
     #science.location = gets.chomp.strip
      args[:location] = gets.chomp.strip

     return self.new(args)
 end

 def import_line(line)

     line_array = line.split("\t")
     #can use either way
     #@title = line_array.shift
     #@author = line_array.shift
     #@publication = line_array.shift
     #@date = line_array.shift

    #multiple assignment together in an array. 
    #Though the square brackets are missing but the following is an array
    #it will assign each value in the array to the instance variables.
    @title, @author, @publication, @date, @location = line_array

    return self
    #need to return an instance(method used above) and populate that 
    #instance in the articles in saved_article method

 end

 def save
   return false unless Science.file_usable?
   File.open(@@filepath, 'a') do |file|
   file.puts "#{[@title, @author, @publication, @date, @location].join("\t")}"  
   end
   return true
 end

 def formatted_price
     #format_currency(@price)
 end


end
