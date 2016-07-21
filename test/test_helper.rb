$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'usine'
require 'trailblazer'

require 'minitest/autorun'

class Item
  attr_accessor :title
  attr_accessor :subtitle
  attr_accessor :valid

  def initialize(params)
    params.each do |k, v|
      self.send("#{k}=", v)
    end
  end
end

class Item::Create < Trailblazer::Operation
  def model!(params)
    Item.new(params)
  end

  def process(params)
    params
  end
end

class Item::Update < Item::Create
end

Usine.define(Item::Create) do
  title { "DEFAULT_TITLE" }
end
