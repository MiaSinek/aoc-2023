require 'minitest/autorun'

class BoatRace
  def self.number_of_ways_to_win(input)
    input.map do |e|
      count_combinations(e[0], e[1])
    end.reduce(1, :*) # 1 the initial value, ensuring that the multiplication starts with 1 (since multiplying by 0 would result in 0).
  end

  private

  def self.count_combinations(t, s)
    (1..t).count do |a|
      a * (t - a) > s
    end
  end
end

class TestBoatRace < Minitest::Test
  def test_number_of_ways_to_win
    input = [[7, 9], [15, 40], [30, 200]]
    assert_equal 288, BoatRace.number_of_ways_to_win(input)
  end
end

input = [[42, 284], [68, 1005], [69, 1122], [85, 1341]]
p BoatRace.number_of_ways_to_win(input)
