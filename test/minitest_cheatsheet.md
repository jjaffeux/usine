MiniTest::Spec
Provides RSpec-like matchers and contexts right out of the box.

require 'minitest/autorun'

describe Hipster, "Demonstration of MiniTest" do

  # Runs codes before each expectation
  before do
    @hipster = Hipster.new
  end

  # Runs code after each expectation
  after do
    @hipster.destroy!
  end

  # Define accessors - lazily runs code when it's first used
  let(:hipster) { Hipster.new}
  let(:traits) { ["silly hats", "skinny jeans"] }
  let(:labels) { Array.new }

  # Even lazier accessor - assigns `subject` as the name for us
  # this equivalent to let(:subject) { Hipster.new }
  subject { Hipster.new }

  it "#define" do
    hipster.define.must_equal "you wouldn't understand"
  end

  it "#walk?" do
    skip "I prefer to skip"
  end

  describe "when asked about the font" do
    it "should be helvetica" do
      @hipster.preferred_font.must_equal "helvetica"
    end
  end

  describe "when asked about mainstream" do
    it "won't be mainstream" do
      @hipster.mainstream?.wont_equal true
    end
  end
end
Matchers (must | wont)

In most cases you can switch between must for positive expectations and wont for negative expectations.

Assertion	Examples
must_be	labels.size.must_be :==, 0
must_be_close_to	traits.size.must_be_close_to 1,1
must_be_empty	labels.must_be_empty
must_be_instance_of	hipster.must_be_instance_of Hipster
must_be_kind_of	labels.must_be_kind_of Enumerable
must_be_nil	labels.first.must_be_nil
must_be_same_as	traits.must_be_same_as traits
must_be_silent	proc { "no stdout or stderr" }.must_be_silent
must_be_within_epsilon	traits.size.must_be_within_epsilon 1,1
must_equal	traits.size.must_equal 2
must_include	traits.must_include "skinny jeans"
must_match	traits.first.must_match /silly/
must_output	proc { print "#{traits.size}!" }.must_output "2!"
must_respond_to	traits.must_respond_to :count
must_raise	proc { traits.foo }.must_raise NoMethodError
must_send	traits.must_send [traits, :values_at, 0]
must_throw	proc { throw Exception if traits.any? }.must_throw Exception
