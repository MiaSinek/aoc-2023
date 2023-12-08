class CubeConundrum
  def self.max_color_combo_of(line)
    line.scan(/(\d+)\s(\w+)/).max_by { |number, color| number.to_i }
  end

  def self.valid_game_id_or_zero(line)
    game_data = max_color_combo_of(line)

    if game_data[0].to_i > 12 && game_data[1] == 'red'
      return 0
    elsif game_data[0].to_i > 13 && game_data[1] == 'green'
      return 0
    elsif game_data[0].to_i > 14 && game_data[1] == 'blue'
      return 0
    end

    line.scan(/Game (\d+)/).flatten.first.to_i
  end


  def self.sum_of_valid_game_ids(input_lines)
    input_lines.sum { |line| self.valid_game_id_or_zero(line) }
  end

  def self.read_from_file(file_path)
    File.readlines(file_path).map(&:chomp)
  end
end

require 'minitest/autorun'

class CubeConundrumTest < Minitest::Test
  def test_sum_of_valid_game_ids
    input = CubeConundrum.read_from_file('test_input_a.txt')
    assert_equal 8, CubeConundrum.sum_of_valid_game_ids(input)
  end
end

input = CubeConundrum.read_from_file('input.txt')
puts CubeConundrum.sum_of_valid_game_ids(input)
