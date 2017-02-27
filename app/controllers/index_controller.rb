class IndexController < ApplicationController
  def main
    Time.zone = "Eastern Time (US & Canada)"

    @thing_data = EnvDatum.where("created_at >= ?", Time.zone.now - 1.day).group(:thing_id)
    @data_count = EnvDatum.all.count
  end
end
