class MyDatabase

    attr_accessor :id,:titleVal,:companylocationVal,:companylocationVal,:salaryVal

    def initialize(id=nil,titleVal,companynameVal,companylocationVal,salaryVal)
        @id=id;
        @titleVal=titleVal;
        @companynameVal=companynameVal;
        @companylocationVal=companylocationVal;
        @salaryVal=salaryVal;

    end

    def readValues
        puts "#{@titleVal}"


    end

    def create_table
        sql= <<-SQL
        CREATE TABLE IF NOT EXISTS favourites( 
            id INTEGER PRIMARY KEY,
            title TEXT,
            company_name TEXT,
            company_location TEXT,
            salary TEXT
        )
        SQL
        DB[:conn].execute(sql)
    end

    def drop_table
        sql= "DROP TABLE IF NOT EXISTS favourites"
    end

    def update
        sql= "UPDATE favourites SET title=?,company_name=?,company_location=?,salary=?"
        DB[:conn].execute(sql,@titleVal,@companynameVal,@companylocationVal,@salaryVal)
    end

    def save
        if self.id
            self.update
            puts "Record exists"
        else
            sql= <<-SQL
            INSERT INTO favourites(title,company_name,company_location,salary)
            VALUES(?,?,?,?)
            SQL

            DB[:conn].execute(sql,@titleVal,@companynameVal,@companylocationVal,@salaryVal)
            @id=DB[:conn].execute("SELECT last_insert_rowid() FROM favourites")[0][0]

           # puts "Success"
        
        end
    end

    
end

class ViewDatabase
attr_accessor :database

    def showTable
        sql= "SELECT * FROM favourites"
        database =  DB[:conn].execute(sql)
        system("clear") || system("cls")
        puts database
    end   
    
    def deleteRow(index)
        checksql= <<-SQL
        SELECT EXISTS(SELECT 1 FROM favourites WHERE id= ?)
        SQL
        test = DB[:conn].execute(checksql, index)
       # puts "this is #{test[0][0]} and #{index}"
        checkval=test[0][0]
        if checkval != 1 #1 is true(exists) 0 is false
        puts "This record does not exist"

        else
        self.showTable
        sql= <<-SQL
        DELETE FROM favourites 
        WHERE id= ?
        SQL
        DB[:conn].execute(sql,index)
        puts "Success"
        end
    end

end
