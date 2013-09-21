class Science

 @@filepath = nil

 attr_accessor :title, :author, :publication, :date
 
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

 end

 def initialize(args={})
	  @title       = args[:title]       || ""
	  @author      = args[:author]      || ""
	  @publication = args[:publication] || ""
	  @date        = args[:date]        || ""
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

     return self.new(args)
 end

 def save
   return false unless Science.file_usable?
   File.open(@@filepath, 'a') do |file|
   file.puts "#{[@title, @author, @publication, @date].join("\t")}"  
   end
   return true
 end


end
