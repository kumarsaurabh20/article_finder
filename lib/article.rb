require 'science'
require 'helper/string_extend'
class Article

  
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
        puts "Exiting the program...!"
        exit!
     end
          
 end

 def get_action
   action = nil
	   until Article::Config.actions.include?(action)
	   puts "Actions: " + Article::Config.actions.join(", ") if action
	   print "article->> "
	   user_input = gets.chomp
	   args = user_input.downcase.strip.split(" ")
           action = args.shift
	   end
   # a multi return example, an array w/o sq. brackets
   return action, args
 end

 def start!
    topic
    #action loop (list, find, add, quit)
	    result = nil
	    until result == :quit
            #catching a returned array from get_action method
	    action, args = get_action
	    result = do_action(action, args)
	    end
    conclude
 end

 def do_action(action, args=[])
     case action
     when "list"
           #adding sorting functionality to the list
           list(args)
     when "add"
          add
     when "find"
          #you can work with all the arguments passed. 
          #for simplicity we have taken only one argument
          keyword = args.shift
          find(keyword)
     when "quit"
       return :quit
     else 
       puts "\nCommand cannot be recognized, Please try again!!"
     end
 end

 def list(args=[])
    #in case argument is nil, u need to have a fallback
    # can do this way also: sort_order ||= "name"
    # sort_order = args.shift || "name"
    sort_order = args.shift   
    sort_order = args.shift if sort_order == "by"

    sort_order = "title" unless ['title','author','publication','date'].include?(sort_order)
    
    output_action_header("Listing Articles")
    articles = Science.saved_articles
    #destructive sort, means it will sort permanently
    articles.sort! do |a1, a2|
	    case sort_order
	    when "title"
	      a1.title.downcase <=> a2.title.downcase
	    when "author"
	      a1.author.downcase <=> a2.author.downcase
	    when "publication"
	      a1.publication.downcase <=> a2.publication.downcase
	    when "date"
	      a1.date.to_i <=> a2.date.to_i
            end
    end
    output_articles(articles)
    puts "Sort using: 'list title/author/publication/date' or 'list by title/author/publication/date'"
 end

 def add 
     output_action_header("Adding Articles")

     science = Science.build_using_questions

     if science.save
       puts "\nArticle Added!\n"
     else
       puts "\nError in saving! Article not sdded!\n"
     end
 end

 def find(keyword="")

     output_action_header("Finding Articles")

     if keyword
       articles = Science.saved_articles
       found = articles.select do |art|
       art.title.downcase.include?(keyword.downcase) ||
       art.author.downcase.include?(keyword.downcase) ||
       art.publication.downcase.include?(keyword.downcase) ||
       art.date.to_i == keyword.to_i
       end  
      output_articles(found)
     else
         puts "find using a key phrase to search the articles list.\n"
         puts "Examples: 'find algorithm', 'find algo', 'find kumar', 'find Plos', 'find 2013'\n\n "
     end
 end

 private
 
 def topic
    puts "Welcome to Article finder. Please proceed with your action!!! "
 end

 def conclude
    puts "If you wish you can continue your search in different categories otherwise quit!!!"
 end

 def output_action_header(text)
     puts "\n#{text.upcase.center(140)}\n\n"
 end

 def output_articles(articles=[])

     print " " + "Title".ljust(65)
     print " " + "Author".ljust(20)
     print " " + "Publication".ljust(20)
     print " " + "Date".ljust(10)
     print " " + "Location".ljust(25) #+ "\n"
     puts "-" * 140
     articles.each do |art|
       line = " " << art.title.ljust(65)
       line << " " + art.author.titleize.ljust(20)
       line << " " + art.publication.titleize.ljust(20)
       line << " " + art.date.ljust(10)
       line << " " + art.location.ljust(25)

       puts line
     end
     puts "No listing found" if articles.empty?
     puts "-" * 140
 end

end
