require 'test_helper'

describe Usine::Utils do
  it ".merge_hashes" do
    a = {email: "j.jaffeux@example.com", age: 18}
    b = {email: "franck@example.com", name: "franck"}

    merging = Usine::Utils.merge_hashes(a, b)

    merging.must_equal(email: "franck@example.com", name: "franck", age: 18)
  end
end
