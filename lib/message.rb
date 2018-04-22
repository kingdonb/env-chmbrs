class Message
  attr_accessor :feeds, :channel

  def self.fetch_and_process_message(uri)
    Rails.logger.debug "Fetching data points via ThingSpeak Feeds API"
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.get(uri)
    j = JSON.parse(response.body)
    Rails.logger.debug "Parsed JSON response"

    m = Message.new(j["feeds"], j["channel"])
    Rails.logger.debug "Copying new entries to heroku, ..."
    if m.valid?
      Rails.logger.debug "Found valid feed message"
      m.data
    end

    Rails.logger.debug "Update complete, rufus-scheduler sleeping another 30 minutes."
  end

  def self.create_env_datum(entry, thing_id, thing_name, humidity_field, temp_c_field, temp_f_field)
    e = EnvDatum.new
    e.thing_id = thing_id
    e.humidity = entry[humidity_field]
    e.temp_c = entry[temp_c_field]
    e.temp_f = entry[temp_f_field]
    e.entry_id = entry["entry_id"]
    e.created_at = DateTime.parse(entry["created_at"])
    e.save
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
      Rails.logger.debug "adding entry_id #{datum["entry_id"]} from thing1"
      thing_id = 1
      Message.create_env_datum(datum, thing_id, "thing1", "field1", "field2", "field3")
      Rails.logger.debug "saved"
    end
    return e
  end
  def idem_add_data_thing2(datum)
    e = EnvDatum.find_by(entry_id: datum["entry_id"])
    unless e
      Rails.logger.debug "adding entry_id #{datum["entry_id"]} from thing2"
      thing_id = 2
      Message.create_env_datum(datum, thing_id, "thing2", "field4", "field5", "field6")
      Rails.logger.debug "saved"
    end
    return e
  end
end
