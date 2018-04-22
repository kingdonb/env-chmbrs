require 'rufus/scheduler'
require 'net/http'
require 'json'
require "#{Rails.root}/lib/message"

scheduler = Rufus::Scheduler.new

url = "https://api.thingspeak.com/channels/198792/feeds.json?api_key=#{ENV['THINGSPEAK_API_KEY']}&results=100"
uri = URI(url)

#Message.fetch_and_process_message(uri)
#scheduler.every '30m' do
  Message.fetch_and_process_message(uri)
  EnvDatum.older_than_two_weeks.destroy_all
#end

#scheduler.join
