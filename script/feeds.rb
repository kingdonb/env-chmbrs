require 'rufus/scheduler'
require 'net/http'
require 'json'
require "#{Rails.root}/lib/message"

scheduler = Rufus::Scheduler.new

url='http://api.thingspeak.com/channels/198792/feeds.json?results=30'
uri = URI(url)

Message.fetch_and_process_message(uri)
scheduler.every '30m' do
  Message.fetch_and_process_message(uri)
end

scheduler.join
