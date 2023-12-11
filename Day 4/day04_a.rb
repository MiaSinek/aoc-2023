require 'minitest/autorun'

class Lottery

  def self.calculate_total_value(input)
    input.reduce(0) do |sum, line|
      card_data, numbers = line.split(':')
      lottery_nums, chosen_nums = numbers.split('|')
      number_of_matches = (lottery_nums.split.map(&:to_i) & chosen_nums.split.map(&:to_i)).size

      value = number_of_matches == 0 ? 0 : 2 ** (number_of_matches - 1)

      sum + value
    end
  end

  def self.read_from_file(file_path)
    File.readlines(file_path).map(&:chomp)
  end
end

class LotteryTest < Minitest::Test
  def test_calculate_total_value
    input = Lottery.read_from_file('test_input.txt')
    total_value = Lottery.calculate_total_value(input)

    assert_equal 13, total_value
  end
end

input = Lottery.read_from_file('input.txt')
puts  Lottery.calculate_total_value(input)
