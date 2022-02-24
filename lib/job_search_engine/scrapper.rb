require "awesome_print"
class Scrapper
    @ageDescription;
    #test
    #@testArr=[]
    #
    attr_accessor :name,:location, :page, :age
    def initialize(job,location,page,age)
        @job=job;
        @location=location;
        @page=page  #page number
        @age=age #24 hours/ 3 day/ 7 day/ 14 day

    end

    def verifyAge
        #puts "this #{@age}"
        case @age
        when 1
            @age=1
            @ageDescription="Last 24 hours"   
        when 3
            @age=3
            @ageDescription="Last 7 days"   
        when 7
            @age=7
            @ageDescription="Last 14 days"   
        when 14
            @age=14
            @ageDescription="Last 24 hours"   
        else
            @age=nil
        end
        #puts "final #{@age}"

    end

    def verifyPage
        @page=@page *10 -(10)
        end

    def getJobData?
        self.verifyAge
        self.verifyPage
        jobArray=[]
        if @age!=nil #check if the date posted has correct input
            url = "https://au.indeed.com/jobs?q=#{@job}&l=#{@location}&start=#{@page}&fromage=#{@age}"
            unparsed_page = HTTParty.get(url)
            parsed_page = Nokogiri::HTML(unparsed_page.body)
            jobCount=parsed_page.css('[id=searchCountPages]').text.strip
           
            listing = parsed_page.css('div.slider_item')
           # puts listing.css("h2.jobtitle")
            #puts listing
            if listing.length!=0 #if length is 0 that means there are no Jobs available
                button=parsed_page.css('div.pagination')
                last_page=button.css('a')[-1].attribute("aria-label")
                last_page="#{last_page}"
                if last_page != "Next"
                    puts "There are no more entries"
                    return true;0
                else
                puts "Searching for #{@job} in #{@location} from #{@ageDescription}"
                puts jobCount
                listing.each do |list|
                job={
                #job << index
                    Title: list.css("h2.jobTitle").text,
                    Company_Name: list.css("span.companyName").text,
                    Company_Location: list.css("div.companyLocation").text,
                    Salary: list.css("div.salary-snippet").text
                }
                jobArray<<job
                end
                ap jobArray #prints job array
                #puts jobArray[0][:Salary]

                return true;0
            end

            else
                puts "No Jobs Found for #{@job} in #{@location}"
                #byebug
                return false;0
                end
         else
         puts "Please enter a valid number #{@age} is not valid!"
         return false;0
         end
    end

    end 

    #newJob=Scrapper.new("IT","Sydney",1)
    #newJob.getJobData

    