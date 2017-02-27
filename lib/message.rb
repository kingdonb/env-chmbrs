class Message
  attr_accessor :feeds, :channel
  def self.fetch_and_process_message(uri)
    Rails.logger.info "Fetching 30 results from ThingSpeak Feeds API"
    response = Net::HTTP.get(uri)
    j = JSON.parse(response)
    Rails.logger.info "Parsed JSON response"

    Rails.logger.info "Pulling channel json and copying entries to heroku, ..."
    m = Message.new(j["feeds"], j["channel"])
    if m.valid?
      Rails.logger.info "found valid feed message"
      m.data
    end
    Rails.logger.info " done."
  end

  def initialize(feeds,channel)
    @feeds = feeds
    @channel = channel
  end

  def valid?
    return false unless channel["field1"] == "Humidity 1" && \
      channel["field2"] == "Temp C 1" && \
      channel["field3"] == "Temp F 1" && \
      channel["field4"] == "Humidity 2" && \
      channel["field5"] == "Temp C 2" && \
      channel["field6"] == "Temp F 2"

    return true
  end

  def data
    feeds.map do |datum|
      if datum["field1"].blank? and datum["field2"].blank? and datum["field3"].blank?
        idem_add_data_thing2(datum)
      elsif datum["field4"].blank? and datum["field5"].blank? and datum["field6"].blank?
        idem_add_data_thing1(datum)
      else
        nil
      end
    end
  end
  
  private
  def idem_add_data_thing1(datum)
    e = EnvDatum.find_by(entry_id: datum["entry_id"])
    unless e
      Rails.logger.info "adding entry_id #{datum["entry_id"]} for thing1"
      e = EnvDatum.new
      thing_id = 1

      e.thing_id = thing_id
      e.humidity = datum["field1"]
      e.temp_c = datum["field2"]
      e.temp_f = datum["field3"]
      e.entry_id = datum["entry_id"]
      e.save
      Rails.logger.info "saved"
    end
    return e
  end
  def idem_add_data_thing2(datum)
    e = EnvDatum.find_by(entry_id: datum["entry_id"])
    unless e
      Rails.logger.info "adding entry_id #{datum["entry_id"]} for thing2"
      e = EnvDatum.new
      thing_id = 2

      e.thing_id = thing_id
      e.humidity = datum["field4"]
      e.temp_c = datum["field5"]
      e.temp_f = datum["field6"]
      e.entry_id = datum["entry_id"]
      e.save
      Rails.logger.info "saved"
    end
    return e
  end
end
