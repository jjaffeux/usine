$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'usine'
require 'factory_girl'
require 'trailblazer'
require 'minitest/autorun'

# Fake models
class User
  attr_accessor :email
end

class Item
  attr_accessor :title
  attr_accessor :subtitle
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

class Item::Create < Trailblazer::Operation
  def model!(params)
    Item.new(params)
  end

  def process(params)
    params
  end
end

FactoryGirl.define do
  sequence :title do |n|
    "title_#{n}"
  end

  factory :item do
    title { "DEFAULT TITLE"}
  end

  factory :book, class:Usine::NullModel do
    title { generate(:title) }
    subtitle { generate(:title) }
  end
end
