require 'minitest/autorun'

class Lottery

  def self.total_number_of_lottery_cards(input)
    build_lottery_data(input)
    calculate_total_number_of_cards(input)
  end

  private

  def self.calculate_total_number_of_cards(input)
    lottery_cards = build_lottery_data(input)

    lottery_cards.each do |key, value|
      value[:amount].times do
        (1..value[:number_of_matches]).each do |i|
          next_key = key.to_i + i
          next_card = lottery_cards[next_key.to_s]
          next_card[:amount] += 1 if next_card
        end
      end
    end
    p lottery_cards
    lottery_cards.sum { |key, value| value[:amount] }
  end

  def self.build_lottery_data(input)
    lottery_cards = {}

    input.each do |line|
      card_data, numbers = line.split(':')
      card_id = card_data.scan(/\d+/).first

      lottery_nums, chosen_nums = numbers.split('|')
      number_of_matches = (lottery_nums.split.map(&:to_i) & chosen_nums.split.map(&:to_i)).size

      lottery_cards[card_id] = { number_of_matches: number_of_matches, amount: 1 }
    end
    lottery_cards
  end



  def self.read_from_file(file_path)
    File.readlines(file_path).map(&:chomp)
  end
end

class LotteryTest < Minitest::Test
  def test_total_number_of_lottery_cards
    input = Lottery.read_from_file('test_input_b.txt')
    total_value = Lottery.total_number_of_lottery_cards(input)

    assert_equal 30, total_value
  end
end

input = Lottery.read_from_file('input.txt')
puts  Lottery.total_number_of_lottery_cards(input)
