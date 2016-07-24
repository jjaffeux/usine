module Usine
  class Utils
    def self.merge_hashes(a, b)
      b.each_pair do |current_key, other_value|
        this_value = a[current_key]

        next if !this_value.nil? &&
                !other_value.nil? &&
                other_value.class != this_value.class

        a[current_key] = if this_value.is_a?(Hash) && other_value.is_a?(Hash)
          Usine::Utils.merge_hashes(this_value, other_value)
        else
          other_value
        end
      end

      a
    end
  end
end
