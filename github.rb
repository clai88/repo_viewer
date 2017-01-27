require 'httparty'
require 'colorize'
require 'pry'

class Github
    include HTTParty
    base_uri 'https://api.github.com'
    def initialize(name)
        @name = name
    end

    def retrieve_repos
        repos = {}
        avatar = ""

        results = self.class.get("/users/#{@name}/repos")

        # binding.pry

        #valid user
        if results[0] == nil
            print @name.red
            puts " does not have any repositories"
        else
        avatar = results[0]["owner"]["avatar_url"]
        results.each do  |repo|
            # binding.pry
            repo_name = repo["name"]
            repos[repo_name] = "https://github.com/#{@name}/#{repo_name}"
        end
        print "User:".red
        puts " #{@name}"
        print "Repositories".green
        puts "\t\t\tURL".green

        repos.each {|k,v| printf "%-31s %s\n", k,v}
        end
        
    end
end

Github.new(ARGV[0]).retrieve_repos