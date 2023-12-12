require 'minitest/autorun'

class HauntedWasteland
  def initialize(input_path, instructions_path)
    @map = build_map(input_path)
    @instructions = build_instructions(instructions_path)
  end

  def number_of_steps_to_reach_zz
    @current_location = "AAA"
    @steps = 0

    loop do
      @instructions.each do |instruction|
        @steps += 1
        @current_location = @map[@current_location][instruction]
        break if @current_location == "ZZZ"
      end
      break if @current_location == "ZZZ"
    end
    @steps
  end

  private

  def read_from_file(file_path)
    File.readlines(file_path).map(&:chomp).join("\n")
  end

  def build_instructions(file_path)
    read_from_file(file_path).split("")
  end
  def build_map(file_path)
    raw_map = read_from_file(file_path)

    result = {}
    raw_map.each_line do |line|
      key, values = line.split('=').map(&:strip)
      left, right = values.tr('()', '').split(',').map(&:strip)
      result[key] = { "L" => left, "R" => right }
    end
    result
  end
end

class TestHauntedWasteland < Minitest::Test
  def test_number_of_steps_to_reach_zz
    hw = HauntedWasteland.new('test_input.txt', 'test_instructions.txt')

    assert_equal 6, hw.number_of_steps_to_reach_zz
  end
end

hw = HauntedWasteland.new('input.txt', 'instructions.txt')
p hw.number_of_steps_to_reach_zz
