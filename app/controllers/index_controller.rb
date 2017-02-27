class IndexController < ApplicationController
  def main
    @data_count = EnvDatum.all.count

    Time.zone = "Eastern Time (US & Canada)"
    # where("created_at >= ?", DateTime.now - 10.hours).
    thing1 = EnvDatum.where(thing_id: 1).
      where("created_at >= ?", Time.zone.now - 1.day)
    thing2 = EnvDatum.where(thing_id: 2).
      where("created_at >= ?", Time.zone.now - 1.day)
    @thing1_data = thing1.group_by_period(:hour, :created_at, format: "%-l %P").average(:temp_c)
    @thing2_data = thing2.group_by_period(:hour, :created_at, format: "%-l %P").average(:temp_c)
  end
end
