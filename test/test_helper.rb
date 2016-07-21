$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'usine'
require 'trailblazer'

require 'minitest/autorun'

class Item; end

class Item::Create < Trailblazer::Operation
  def process(params)
    params
  end
end

Usine.define(Item::Create) do
  title { "DEFAULT_TITLE" }
end
