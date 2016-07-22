module Usine
  class Sequence
    attr_reader :attribute

    def initialize(attribute, *args, &block)
      @attribute = attribute
      @block = block
      @value = args.first || 1

      unless @value.respond_to?(:next)
        raise(UsineError::SequenceInvalidInitialValue, "Invalid initial value, it must respond to #next")
      end
    end

    def next
      @block.call(@value)
    ensure
      @value = @value.next
    end
  end
end
