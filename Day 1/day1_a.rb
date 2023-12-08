class CalibrationCalculator
  def self.calculate_calibration_value(line)
    digits = line.scan(/\d/)
    return 0 if digits.empty?

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
    input = CalibrationCalculator.read_from_file('test_input_a.txt')
    assert_equal 142, CalibrationCalculator.sum_of_calibration_values(input)
  end
end

input = CalibrationCalculator.read_from_file('input.txt')
puts CalibrationCalculator.sum_of_calibration_values(input)
