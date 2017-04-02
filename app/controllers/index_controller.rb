class IndexController < ApplicationController
  def main
    Time.zone = "Eastern Time (US & Canada)"

    @thing_data_short = EnvDatum.joins(:thing).group('things.name').
      where("env_data.created_at >= ?", Time.zone.now - 4.hours)
    @thing_data_long = EnvDatum.joins(:thing).group('things.name').
      where("env_data.created_at >= ?", Time.zone.now - 2.weeks)
    @data_count = EnvDatum.all.count
  end
end
