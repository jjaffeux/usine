module Usine
  class DefinitionEvaluator
    attr_reader :attributes
    attr_reader :sequences
    attr_reader :scoped_sequences

    def initialize(sequences = [])
      @sequences = sequences
      @scoped_sequences = []
      @attributes = {}
    end

    def method_missing(method_symbol, *args, &block)
      if block
        @attributes[method_symbol] = block.call
      else
        @attributes[method_symbol] = generate(method_symbol)
      end
    end

    def generate(attribute)
      if sequence = scoped_sequences.detect { |x| x.attribute == attribute }
        sequence.next
      elsif sequence = sequences.detect { |x| x.attribute == attribute }
        sequence.next
      else
        message = <<-MSG
Couldn’t find a sequence named: #{attribute}
Available sequences: #{scoped_sequences.concat(sequences).map(&:attribute).join(',')}
MSG
        raise(UsineError::SequenceNotFound, message)
      end
    end

    def sequence(name, initial_value = 1, &block)
      @scoped_sequences << Sequence.new(name, initial_value, &block)
    end
  end
end
