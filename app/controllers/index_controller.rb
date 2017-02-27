class IndexController < ApplicationController
  def main
    @data_count = EnvDatum.all.count
    @thing1_count = EnvDatum.where(thing_id: 1).count
    @thing2_count = EnvDatum.where(thing_id: 2).count
  end
end
