class IndexController < ApplicationController
  def main
    Time.zone = "Eastern Time (US & Canada)"

    @thing_data = EnvDatum.joins(:thing).group('things.name').
      where("env_data.created_at >= ?", Time.zone.now - 1.day)
    @data_count = EnvDatum.all.count
  end
end
