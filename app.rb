require 'openssl'
require 'httparty'
require 'json'
require 'time'

puts '666'
puts ENV.to_hash
puts `pwd`
puts `ls -lah`
puts `cat /github/workflow/event.json`


EVENT_JSON = '/github/workflow/event.json'
VIVO_BASE_URL = ENV['INPUT_BASE_URL']
if VIVO_BASE_URL.nil?
  puts "INPUT_BASE_URL is blank"
  exit 1
end
ACCESS_KEY = ENV['INPUT_ACCESS_KEY']
if ACCESS_KEY.nil?
  puts "INPUT_ACCESS_KEY is blank"
  exit 1
end
ACCESS_SECRET = ENV['INPUT_ACCESS_SECRET']
if ACCESS_SECRET.nil?
  puts "INPUT_ACCESS_SECRET is blank"
  exit 1
end
puts "VIVO_BASE_URL: #{VIVO_BASE_URL} ACCESS_KEY: #{ACCESS_KEY} ACCESS_SECRET: #{ACCESS_SECRET}"
def parse_event_json
  return @parse_event_json if defined? @parse_event_json

  @parse_event_json = JSON.load_file(EVENT_JSON)
end

def commit_message
  parse_event_json['head_commit']['message']
end

def update_desc

end

def online_time
  return @online_time if defined? @online_time

  @online_time = commit_message.match(/\s*(\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2})/)[1]
end

def parse_config_gradle
  return @parse_config_gradle if defined? @parse_config_gradle

  @parse_config_gradle = File.read('config.gradle')
end

def version_code
  return @version_code if defined? @version_code

  @version_code = parse_config_gradle.match(/VersionCode\s*:\s*(\d+)/)[1]
end

def version_name
  return @version_name if defined? @version_name

  @version_name = parse_config_gradle.match(/VersionName\s*:\s*"([^"]+)"/)[1]
end

puts "Commit Message: #{commit_message}"
puts "VersionCode: #{version_code}"
puts "VersionName: #{version_name}"
puts "Online Time: #{online_time}"
