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
        self.class.get("/users/#{@name}/repos").each do  |repo|
            # binding.pry
            avatar = repo["owner"]["avatar_url"]
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

Github.new(ARGV[0]).retrieve_repos