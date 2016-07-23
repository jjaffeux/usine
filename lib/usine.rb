require "uber/inheritable_attr"
require "factory_girl"
require "usine/version"
require "usine/utils"
require "usine/null_model"
require "usine/operation_factory"
require "usine/operation_wrapper"

module Usine
  extend Uber::InheritableAttr
  inheritable_attr :operations
  self.operations = []

  class << self
    [:call, :run, :present].each do |mode|
      define_method mode, ->(*args, &block) {
        operation = args.shift
        attributes = args.shift || {}
        OperationWrapper.(mode, operation, attributes)
      }
    end

    def operation(operation, *args, &block)
      self.operations << OperationFactory.new(operation, &block)
    end
  end
end
