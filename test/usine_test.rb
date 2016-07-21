require 'test_helper'

class UsineTest < Minitest::Test
  def test_it_does_something_useful
    p Usine.(Item::Create, title: "Spoon", subtitle: "Untold story")
    p Usine.run(Item::Create, title: "Spoon", subtitle: "Untold story")
    p Usine.present(Item::Create, title: "Spoon", subtitle: "Untold story")

  end
end
