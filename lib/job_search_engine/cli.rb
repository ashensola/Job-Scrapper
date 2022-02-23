class CLI
@inputJob;
@inputLocation
@inputAge
@inputPage = 0
@returnBool
def welcomeMessage
    puts "Hi , welcome to the Indeed Job Search Engine"  
    self.commandMenu
end

def commandMenu
    puts "Please enter a Job"
    @inputJob = gets.strip

    puts "Please enter a location"
    @inputLocation= gets.strip
    puts "Press 1 for jobs from 24 hours, 2 for 3 days, 3 for 7 days and 4 for 14 days"
    @inputAge=gets.strip.to_i
    puts "Enter a page number"
    @inputPage=gets.strip.to_i
    self.searchJob
    if @returnBool == true
        self.searchAnotherJob
    end
end


def searchAnotherJob
    if @returnBool != false
        puts "Do you want to search for another job or choose another page or exit(j/p/e)"
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
   
newSearch=Scrapper.new(@inputJob,@inputLocation,@inputPage,@inputAge);
   @returnBool= newSearch.getJobData?

    

end

end

newCustomer=CLI.new()
newCustomer.welcomeMessage
#newSearch=Scrapper.new("IT","Sydney",3);
#newSearch.getJobData

#newSearch.getJobData