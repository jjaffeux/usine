require "usine/version"
require "usine/factory"
require "usine/exceptions"
require "usine/definition_runner"
require 'uber/inheritable_attr'

module Usine
  def self.call(*args)
    Factory.(:call, args.shift, args.shift)
  end

  def self.run(*args)
    Factory.(:run, args.shift, args.shift)
  end

  def self.present(*args)
    Factory.(:present, args.shift, args.shift)
  end

  extend Uber::InheritableAttr
  inheritable_attr :definitions
  self.definitions = {}

  class << self
    def define(operation, *extensions, &block)
      operation_name = operation.to_s

      self.definitions[operation_name] ||= []

      extensions.each do |extension|
        self.definitions[operation_name] << extension
      end

      self.definitions[operation_name] << block
    end
  end
end
