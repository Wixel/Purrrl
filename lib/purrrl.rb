require "thor"
require "colorize"
require "rest_client"
require 'json'
require 'filesize'
require 'io/console'
require 'uri/http'
require 'pp'

class Purrrl < Thor
  # Return the base URL of the API service
  #
  def self.base_url 
    "http://purrrl.link"
  end
  
  # Return the constructed service API path
  #
  # @param string resource
  # @param string path
  def self.api_url(resource, path = nil)
    if !path.nil?
      "#{self.base_url}/api/#{resource}#{path}"
    else
      "#{self.base_url}/api/#{resource}"      
    end
  end
  
  # Return the API key path
  #
  # @return string  
  def self.key_path
    "#{ENV['HOME']}/.purrrl.api_key"
  end
  
  # Determine if we have an API key set
  #
  # @return boolean  
  def self.has_api_key_file?
    File.exists? self.key_path
  end
  
  # Return the API Key
  #
  # @return boolean  
  def self.api_key
    if self.has_api_key_file?
      File.open(self.key_path) do |f| 
        f.readline 
      end
    else
       raise "Please log in before attempting to use the service"
    end
  end
  
  # Write an API key locally
  #
  # @param string key
  def self.write_key(key)
    File.open(self.key_path, 'w') do |file| 
      file.write(key) 
    end
  end
  
  # Fetch the next upload path
  #
  # @return string
  def self.get_upload_path
    begin
      response = JSON.parse(RestClient.get(Purrrl.api_url("up"), {
        :params => {:api_key => self.api_key}
      }))
      
      if response["success"]
        response["url"]
      else
        puts response["message"].red
      end
    rescue Exception => e
      puts e.response.red
    end
  end
  
  # Construct & return the public share URL
  #
  # @return string
  def self.share_url(file)
    "#{self.base_url}/#{file["user_id"]}/#{file["slug"]}"
  end
  
  #### API Methods ####
  
  desc "login", "Log into your Purrrl account and store the API key on this machine"
  def login
    begin
      puts "Log In - Purrrl"
      puts "---------------"
      print "Email Address: "
      @email_address = STDIN.gets.chomp
      print "Password: "
      @password = STDIN.noecho(&:gets).chomp
      puts "\n\nChecking..."
    rescue Exception => e
      exit
    end

    begin
      response = JSON.parse(RestClient.post(Purrrl.api_url("authenticate"), {
        :email    => @email_address, 
        :password => @password
      }))
    
      if response["success"]
        Purrrl.write_key(response["api_key"])
        puts response["message"].green
      else
        puts response["message"].red
      end
    rescue Exception => e
      puts e.message.red
    end
  end
  
  desc "upload <your file>", "Upload the provided file to your Purrrl account"
  def upload(file)
    if File.exists? file
      remote_path = Purrrl.get_upload_path

      print "Uploading file to... #{remote_path} ".green
      
      begin
        result = RestClient.post(Purrrl.get_upload_path, {
          :file => File.new(file, 'rb')
        })
        print "✓ Done, happy sharing \n".blue
      rescue Exception => e
        print "✗ Failed, #{e.message.red} \n".red
      end
    else 
      puts "The chosen file '#{file}' does not exist".red
    end      
  end
  
  desc "ls", "Display a list of files you've uploaded to your Purrrl account"
  def ls
    begin
      files = JSON.parse(RestClient.get(Purrrl.api_url("files"), {
        :params => {:api_key => Purrrl.api_key}
      }))
      
      files.each do |file|
        print Purrrl.share_url(file).green
        print "\t"
        print file["name"]
        print " (#{Filesize.from("#{file["size"]} B").pretty})".blue
        print "\n"
      end
    rescue Exception => e
      puts e.message.red
    end    
  end
  
  #desc "upload_directory", "Upload an entire directory of files at once"
  #def upload_dir
  #  begin
  #    files = JSON.parse(RestClient.get(Purrrl.api_url("files"), {
  #      :params => {:api_key => Purrrl.api_key}
  #    }))
      
  #    files.each do |file|
  #      print Purrrl.share_url(file).green
  #      print "\t"
  #      print file["name"]
  #      print " (#{Filesize.from("#{file["size"]} B").pretty})".blue
  #      print "\n"
  #    end
  #  rescue Exception => e
  #    puts e.message.red
  #  end    
  #end  
  
  desc "rm <url>", "Delete an uploaded file resource using its path"
  def rm(url)
    begin
      uri = URI.parse(url)
      
      response = JSON.parse(RestClient.delete(Purrrl.api_url("delete", uri.path), {
        :params => {:api_key => Purrrl.api_key}
      }))      
      
      if response["success"]
        puts "✓ File remove".green
      else
        puts "✗ #{response["message"]}".red
      end
    rescue Exception => e
      puts e.message.red
    end    
  end  
  
end

Purrrl.start(ARGV)