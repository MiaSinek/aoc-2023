class CubeConundrum
  def self.sum_of_power_of_minimum_sets_of_cubes(input_lines)
    input_lines.sum { |line| self.power_of_max_color_combos(line) }
  end

  private

  def self.max_color_combos_of(line)
    red = line.scan(/(\d+)\sred/).max_by { |number| number.first.to_i }.first
    blue = line.scan(/(\d+)\sblue/).max_by { |number| number.first.to_i }.first
    green = line.scan(/(\d+)\sgreen/).max_by { |number| number.first.to_i }.first

    [red, blue, green]
  end

  def self.power_of_max_color_combos(line)
    self.max_color_combos_of(line).reduce(1) { |product, number| product * number.to_i }
  end

  def self.read_from_file(file_path)
    File.readlines(file_path).map(&:chomp)
  end
end

require 'minitest/autorun'

class CubeConundrumTest < Minitest::Test
  def test_sum_of_power_of_minimum_sets_of_cubes
    input_lines = CubeConundrum.read_from_file('test_input_b.txt')
    assert_equal 2286, CubeConundrum.sum_of_power_of_minimum_sets_of_cubes(input_lines)
  end
end

input_lines = CubeConundrum.read_from_file('input.txt')
puts CubeConundrum.sum_of_power_of_minimum_sets_of_cubes(input_lines)
