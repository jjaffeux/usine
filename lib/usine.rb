require "usine/version"
require "usine/factory"
require "usine/exceptions"
require "usine/evaluator"
require "usine/definition"
require "usine/sequence"
require "uber/inheritable_attr"

module Usine
  extend Uber::InheritableAttr
  inheritable_attr :definitions
  self.definitions = {}
  inheritable_attr :sequences
  self.sequences = []

  class << self
    def call(*args)
      Factory.(:call, args.shift, args.shift)
    end

    def run(*args)
      Factory.(:run, args.shift, args.shift)
    end

    def present(*args)
      Factory.(:present, args.shift, args.shift)
    end

    def sequence(name, initial_value = 1, &block)
      self.sequences << Sequence.new(name, initial_value, &block)
    end

    def definition(operation, *extensions, &block)
      self.definitions[operation] ||= []

      self.definitions[operation] << Definition.new(operation, &block)

      extensions.each do |extension|
        self.definitions[operation] << Definition.new(operation, &block)
      end
    end
  end
end
