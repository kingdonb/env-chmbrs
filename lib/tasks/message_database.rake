desc "Update messages from thingspeak in database"
task :message_database => :environment do
  puts "Pulling channel json and copying entries to heroku"
  require "#{Rails.root}/script/feeds"
  puts "done."
end
