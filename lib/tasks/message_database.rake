desc "Update messages from thingspeak in database"
task :message_database => :environment do
  require 'rufus/scheduler'

  scheduler = Rufus::Scheduler.new

  scheduler.every '20m' do
    print "Pulling channel json and copying entries to heroku, ..."
    require "#{Rails.root}/script/feeds"
    puts " done."
  end
end
