require 'article'
class Search

attr_accessor :actions

 def initialize
    @actions = ['software', 'articles', 'books', 'quit']
 end

 def get_commands
     action = nil
     until @actions.include?(action)
     puts "Actions: " + @actions.join(', ') if action
     print "finder>> "
     user_input = gets.chomp
     action = user_input.downcase.strip
     end
   return action     
 end

 def start_app
     intro
	     result = nil
	     until result == :quit
		  action = get_commands
		  result = input_commands(action)
	     end
     conclusion
 end

 def launch_search
     article = Article.new('article.txt')
     article.start!
 end

 def input_commands(action)
     case action
     when "software"
          puts "searching software list"
     when "articles"
          launch_search
     when "books"
         puts "searching books list"
     when "quit"
          return :quit
     else
        puts "\nCommand cannot be recognized, Please try again!!"
     end
 end

 def intro
     puts "\n\n<<< Welcome to the Article Finder >>>\n"
     puts "\nAn interactive Ruby program to help you find articles you are striving with!!\n\n"
     puts "What would you like to search?? "
 end

 def conclusion
     puts "\n\n<<< Goodbye and Thank you for using Article Finder!!!! >>>\n\n"
 end


end
