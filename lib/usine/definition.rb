module Usine
  class Definition
    attr_reader :name
    attr_reader :block

    def initialize(name, *args, &block)
      @name = name
      @block = block
    end
  end
end
