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
