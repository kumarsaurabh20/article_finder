class Article
require 'science'
  
   class Config
     @@actions = ['list','find','add','quit']  
     def self.actions; @@actions; end
   end

 def initialize(path=nil)
      #locate the article text file at path
      Science.filepath = path
     if Science.file_usable?
        puts "Found a Science datafile!"
     #if not present than create it
     elsif Science.create_file
        puts "Created an article datafile!" 
     #if create doesnt work than exit           
     else
        puts "Exiting...!"
        exit!
     end
          
 end

 def start!
    intro
    #action loop (list, find, add, quit)
	    result = nil
	    until result == :quit
	    action = get_action
	    result = do_action(action)
	    end
    conclusion
 end

 def get_action
   action = nil
	   until Article::Config.actions.include?(action)
	   puts "Actions: " + Article::Config.actions.join(", ") if action
	   print "> "
	   user_input = gets.chomp
	   action = user_input.downcase.strip
	   end
   return action
 end

 def do_action(action)
     case action
     when "list"
       puts "listing...."
     when "add"
       puts "adding..."
     when "find"
       puts "finding..."
     when "quit"
       return :quit
     else 
       puts "\nCommand cannot be recognized!"
     end
 end

 def intro
     puts "\n\n<<< Welcome to the Article Finder >>>\n"
     puts "\nThis is an interactive Ruby program to help you list/find\narticles or bibilographic docs\n\n"
 end

 def conclusion
     puts "\n\n<<< Goodbye and Thank you for using Article Finder!!!! >>>\n\n"
 end


end