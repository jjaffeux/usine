$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'usine'
require 'trailblazer'
require 'minitest/autorun'

# Fake models
class User
  attr_accessor :email
  attr_accessor :name
  attr_accessor :tags
end

class Item
  attr_accessor :title
  attr_accessor :type
  attr_accessor :subtitle
  attr_accessor :valid
  attr_accessor :current_user

  def initialize(params)
    @current_user = User.new
    params.fetch(:item, {}).each do |k, v|
      self.send("#{k}=", v)
    end

    params.fetch(:current_user, {}).each do |k, v|
      @current_user.send("#{k}=", v)
    end
  end
end

# Fake operation
class Item::Create < Trailblazer::Operation
  def model!(params)
    Item.new(params)
  end

  def process(params)
    params
  end
end
