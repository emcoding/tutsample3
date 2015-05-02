##THis is exercise 5.38, probably only to let us try something with a different assert_ method.
# Does not seem very helpfull, though, and certainly not very DRY. So maybe I misunderstood [TODO]

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do

    assert_equal full_title, "Mauds Rails App"
    assert_equal full_title("Help"), "Help | Mauds Rails App"
    #puts "Hello Maud apphelpertest is called here"

  end
end
