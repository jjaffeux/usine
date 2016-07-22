require 'test_helper'

describe "DefinitionTest" do
  subject { Usine::Sequence.new(:email) { |n| "new_#{n}" } }

  it "#next" do
    subject.next.must_equal "new_1"
    subject.next.must_equal "new_2"
  end

  describe "setting an initial value" do
    subject { Usine::Sequence.new(:email, 'a') { |n| "new_#{n}" } }

    it "#next" do
      subject.next.must_equal "new_a"
      subject.next.must_equal "new_b"
    end
  end

  describe "setting an invalid value" do
    subject { Usine::Sequence.new(:email, Object.new) { |n| "new_#{n}" } }

    it "#next" do
      proc {
        subject.next
      }.must_raise UsineError::SequenceInvalidInitialValue
    end
  end
end
