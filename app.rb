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
if VIVO_BASE_URL.blank?
  puts "INPUT_BASE_URL is blank"
  exit 1
end
ACCESS_KEY = ENV['INPUT_ACCESS_KEY']
if ACCESS_KEY.blank?
  puts "INPUT_ACCESS_KEY is blank"
  exit 1
end
ACCESS_SECRET = ENV['INPUT_ACCESS_SECRET']
if ACCESS_SECRET.blank?
  puts "INPUT_ACCESS_SECRET is blank"
  exit 1
end

def parse_event_json
  return @event_json if defined? @event_json
  @event_json = JSON.load_file(EVENT_JSON)
end

def commit_message
  parse_event_json['head_commit']['message']
end

def parse_config_gradle
  return @config_gradle if defined? @config_gradle
  @config_gradle = File.read('config.gradle')
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
