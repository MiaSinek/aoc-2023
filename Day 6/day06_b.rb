require 'minitest/autorun'

class BoatRace

  def self.count_combinations(t, t_from, s)
    t_to = t - t_from

    (t_from..t_to).count do |a|
      a * (t - a) > s
    end
  end
end

class TestBoatRace < Minitest::Test
  def test_count_combinations
    assert_equal 71503, BoatRace.count_combinations(71530, 14, 940200)
  end
end

p BoatRace.count_combinations(42_686_985, 14, 284_100_511_221_341)
