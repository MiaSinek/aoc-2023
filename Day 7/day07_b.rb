require 'minitest/autorun'

class CamelPoker
  def self.total_winnings(input)
    hands_data = build_hands_data(input)
    hands = hands_data.keys
    sorted_hands = sort_hands_by_rank(hands)

    sorted_hands.each_with_index.reduce(0) do |sum, (hand, index)|
      puts "Hand #{index + 1}: #{hand} - #{hands_data[hand]} bet - #{rank_of_hand(hand)} rank - #{replace_jacks(hand)} altered hand | sum: #{sum}"
      sum + (index + 1) * hands_data[hand].to_i
    end
  end

  def self.read_from_file(file_path)
    File.readlines(file_path).map(&:chomp)
  end

  private

  def self.build_hands_data(input)
    hands_data = {}

    input.each do |line|
      hand, bet = line.split(' ')
      hands_data[hand] = bet
    end
    hands_data
  end

  def self.sort_hands_by_rank(hands)
    hands.sort! do |hand1, hand2|
      rank1 = rank_of_hand(hand1)
      rank2 = rank_of_hand(hand2)

      if rank1 == rank2
        compare_hands(hand1, hand2)
      else
        rank2 <=> rank1
      end
    end
    puts "hands: #{hands.inspect}"
    hands.reverse
  end

  def self.compare_hands(hand1, hand2)
    hand1.each_char.zip(hand2.each_char).each do |card1, card2|
      strength1 = card_strength(card1)
      strength2 = card_strength(card2)
      comparison = strength2 <=> strength1
      return comparison unless comparison == 0
    end
    0
  end

  def self.rank_of_hand(hand)
    altered_hand = replace_jacks(hand)
    if altered_hand != hand
      puts "original_hand: #{hand}"
      puts "altered_hand: #{altered_hand}"
      puts "*" * 100
    end
    if five_of_a_kind?(altered_hand)
      7
    elsif four_of_a_kind?(altered_hand)
      6
    elsif full_house?(altered_hand)
      5
    elsif three_of_a_kind?(altered_hand)
      4
    elsif two_pair?(altered_hand)
      3
    elsif one_pair?(altered_hand)
      2
    else
      1
    end
  end

  def self.replace_jacks(hand)
    return hand unless hand.include?('J')

    hand_arr = hand.split('')
    most_common_card = hand_arr.reject{|x|x=='J'}.max_by { |card| hand_arr.count(card) }
    most_common_card = 'A' if hand_arr.uniq==['J']
    hand_arr.map { |card| card == 'J' ? most_common_card : card }.join
  end

  def self.five_of_a_kind?(hand)
    hand = hand.split("")
    hand.uniq.size == 1
  end

  def self.four_of_a_kind?(hand)
    hand = hand.split("")
    hand.uniq.size == 2 && hand.any? { |card| hand.count(card) == 4 }
  end

  def self.full_house?(hand)
    hand = hand.split("")
    hand.uniq.size == 2 && hand.uniq.select { |card| hand.count(card) == 3 }.size == 1
  end

  def self.three_of_a_kind?(hand)
    hand = hand.split("")
    hand.uniq.size == 3 && hand.uniq.select { |card| hand.count(card) == 3 }.size == 1
  end

  def self.two_pair?(hand)
    hand = hand.split("")
    hand.uniq.size == 3 && hand.uniq.select { |card| hand.count(card) == 2 }.size == 2
  end

  def self.one_pair?(hand)
    hand = hand.split("")
    hand.uniq.size == 4 && hand.uniq.select { |card| hand.count(card) == 2 }.size == 1
  end

  def self.card_strength(card)
    if card == 'A'
      14
    elsif card == 'K'
      13
    elsif card == 'Q'
      12
    elsif card == 'J'
      1
    elsif card == 'T'
      10
    else
      card.to_i
    end
  end
end

class TestCamelPoker < Minitest::Test
  def test_total_winnings
    input = CamelPoker.read_from_file('test_input.txt')
    assert_equal 5905, CamelPoker.total_winnings(input)
  end
end

input = CamelPoker.read_from_file('input.txt')
puts CamelPoker.total_winnings(input)
