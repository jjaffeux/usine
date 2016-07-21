require "usine/version"
require "usine/factory"
require "usine/exceptions"
require "usine/definition_executor"
require 'uber/inheritable_attr'

module Usine
  def self.call(*args)
    Factory.(:call, args.shift, args.shift)
  end

  def self.run(*args)
    Factory.(:call, args.shift, args.shift)
  end

  def self.present(*args)
    Factory.(:call, args.shift, args.shift)
  end

  extend Uber::InheritableAttr
  inheritable_attr :definitions
  self.definitions = {}

  class << self
    def define(operation, &block)
      self.definitions[operation.to_s] = block
    end
  end
end
