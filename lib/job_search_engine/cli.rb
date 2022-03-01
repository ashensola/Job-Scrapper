class CLI
@inputJob;
@inputLocation
@inputAge
@inputPage = 0
@returnBool
@newSearch
@newdatabaseInstance

 attr_accessor :title, :companynameVal, :companylocationVal, :salary

def initialize()
 @showDatabase = ViewDatabase.new()
end


def welcomeMessage
    puts "Hi , welcome to the Indeed Job Search Engine"  
    self.commandMenu
end

def commandMenu
    puts "Do you want to search a job (1) or view saved jobs (2)"
    menuInput = gets.strip.to_i
if  menuInput == 1
    puts "Please enter a Job #{@menuInput}"
    @inputJob = gets.strip

    puts "Please enter a location"
    @inputLocation= gets.strip
    puts "Press 1 for jobs from 24 hours, 3 for 3 days, 7 for 7 days and 14 for 14 days"
    @inputAge=gets.strip.to_i
    puts "Enter a page number"
    @inputPage=gets.strip.to_i
    self.searchJob
    if @returnBool == true
        self.searchAnotherJob
    end
elsif menuInput == 2
   
    @showDatabase.showTable

    puts "Do you want to delete any row (y/n)"
    inputDelete = gets.strip.downcase
    if inputDelete == "y"
        puts "Enter ID that needs to be deleted"
        getID= gets.strip.to_i
        @showDatabase.deleteRow(getID)
        @showDatabase.showTable
      
        self.commandMenu
    elsif inputDelete == "n"
        self.commandMenu

    else
        puts "invalid input"
        self.commandMenu
    end
else 
    puts "invalid input"
    self.commandMenu
end
end




def searchAnotherJob
    if @returnBool != false
        puts "Do you want to search for another job, save job, choose another page or exit(j/s/p/e)"
        getInput = gets.strip.downcase
        if getInput == "j"
            self.commandMenu
        elsif getInput =="p"
        puts "Enter a page number"
        getInput=gets.strip.to_i
        @inputPage=getInput
        #newPage=Scrapper.new(@inputJob,@inputLocation,getInput,@inputAge);
        #@returnBool= newPage.getJobData?
        self.searchJob(@inputPage)
        self.searchAnotherJob
        elsif getInput == "e"
        puts  "Thank you for using the Job Search App"
            exit
        elsif getInput == "s"
            puts "Enter index of job you want to save"
            getIndex=gets.strip.to_i
            selectDatabase(getIndex)
          
          
         else 
            puts "Please enter a valid response"
            self.searchAnotherJob
        
         end
    else
    puts "Please enter a valid input"
    self.commandMenu
    end
end




def searchJob(inputPage = @inputPage)
   
   @newSearch=Scrapper.new(@inputJob,@inputLocation,@inputPage,@inputAge);
   @returnBool= @newSearch.getJobData?
end

def selectDatabase(index)

    @newSearch.addtoDatabase(index)
    
end


# def build(newSearch)
# cli=CLI.new()
# cli.title=@newSearch.titleVal
# puts cli.title
# end



end


newCustomer=CLI.new()
newCustomer.welcomeMessage
#newSearch=Scrapper.new("IT","Sydney",3);
#newSearch.getJobData

#newSearch.getJobData