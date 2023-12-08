class CalibrationCalculator
  DIGIT_MAP = {
    'one' => '1', 'two' => '2', 'three' => '3', 'four' => '4',
    'five' => '5', 'six' => '6', 'seven' => '7', 'eight' => '8', 'nine' => '9'
  }

  def self.calculate_calibration_value(line)
    pattern = /(?=(\d|#{DIGIT_MAP.keys.join('|')}))/
    digits = line.scan(pattern).map do |d|

      DIGIT_MAP[d[0]] || d[0]
    end


   (digits.first + digits.last).to_i
  end

  def self.sum_of_calibration_values(input_lines)
    input_lines.sum { |line| calculate_calibration_value(line) }
  end

  def self.read_from_file(file_path)
    File.readlines(file_path).map(&:chomp)
  end
end

require 'minitest/autorun'

class CalibrationCalculatorTest < Minitest::Test
  def test_sum_of_calibration_values
    input = CalibrationCalculator.read_from_file('test_input_b.txt')
    assert_equal 302, CalibrationCalculator.sum_of_calibration_values(input)
  end
end

input = CalibrationCalculator.read_from_file('input.txt')
puts CalibrationCalculator.sum_of_calibration_values(input)
