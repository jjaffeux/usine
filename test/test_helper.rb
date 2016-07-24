require 'bundler/setup'
require 'minitest/autorun'
require 'factory_girl'
require 'active_model'
require 'trailblazer'
require 'trailblazer/operation/policy'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'usine'

# Fake models
class User
  include ActiveModel::Model

  attr_accessor :email
end

class Item
  include ActiveModel::Model

  attr_accessor :title
  attr_accessor :subtitle
end

class Item::Create < Trailblazer::Operation
  include Policy::Guard

  policy do |params|
    params[:current_user].present?
  end

  contract do
    property :title
    property :subtitle
  end

  def model!(params)
    Item.new(params[:item])
  end

  def process(params)
    params
  end
end

class User::Create < Trailblazer::Operation
  contract do
    property :email
  end

  def model!(params)
    User.new(params[:user])
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
