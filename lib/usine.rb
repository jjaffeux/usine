require "usine/version"
require "usine/utils"
require "usine/factory"
require "usine/factory_evaluator"
require "usine/exceptions"
require "usine/definition_evaluator"
require "usine/definition"
require "usine/sequence"
require "uber/inheritable_attr"

module Usine
  extend Uber::InheritableAttr
  inheritable_attr :definitions
  self.definitions = []
  inheritable_attr :factories
  self.factories = []
  inheritable_attr :sequences
  self.sequences = []

  class << self

    [:call, :run, :present].each do |mode|
      define_method mode, ->(*args, &block) {
        operation = args.shift
        factory = find_factory_for_operation(operation)
        FactoryEvaluator.call(factory, mode, args.shift)
      }
    end

    def factory(operation, *extensions, &block)
      self.factories ||= []

      self.factories << Factory.new(operation, *extensions, &block)

      extensions.each do |extension|
        self.factories << Factory.new(operation, *extension, &block)
      end
    end

    def sequence(name, initial_value = 1, &block)
      self.sequences << Sequence.new(name, initial_value, &block)
    end

    def definition(attribute, *extensions, &block)
      self.definitions ||= []

      self.definitions << Definition.new(attribute, &block)

      extensions.each do |extension|
        self.definitions << Definition.new(attribute, &block)
      end
    end

    protected

    def find_factory_for_operation(operation)
      factory = Usine.factories.detect do |f|
        f.operation == operation
      end

      if factory.nil?
        raise "NOT FOUND FACTORY for #{operation}"
      end

      factory
    end
  end
end
