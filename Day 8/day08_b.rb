require 'minitest/autorun'

class HauntedWasteland
  attr_reader :map, :instructions

  def initialize(input_path, instructions_path)
    @raw_map = build_raw_map(input_path)
    @map = build_map
    @instructions = build_instructions(instructions_path)
  end

  def number_of_steps_to_reach_endpoints
    @current_locations = build_starting_points
    @end_points = build_end_points

    all_steps = []
    @current_locations.each do |current_location|
      all_steps << number_of_steps_to_reach_z(current_location)
    end

    puts all_steps.reduce(:lcm)
  end

  private

  def number_of_steps_to_reach_z(current_location)
    steps = 0

    loop do
      @instructions.each do |instruction|
        steps += 1
        current_location = @map[current_location][instruction]
        if current_location[-1] == "Z"
          puts current_location
          break
        end
      end
      if current_location[-1] == "Z"
        puts current_location
        break
      end
    end
    steps
  end

  def read_from_file(file_path)
    File.readlines(file_path).map(&:chomp).join("\n")
  end

  def build_raw_map(file_path)
    read_from_file(file_path)
  end

  def build_starting_points
    @raw_map.scan(/(..A) =/).flatten
  end

  def build_end_points
    @raw_map.scan(/(..Z) =/).flatten.sort
  end

  def build_instructions(file_path)
    read_from_file(file_path).split("")
  end

  def build_map
    result = {}
    @raw_map.each_line do |line|
      key, values = line.split('=').map(&:strip)
      left, right = values.tr('()', '').split(',').map(&:strip)
      result[key] = { "L" => left, "R" => right }
    end
    result
  end
end

class TestHauntedWasteland < Minitest::Test
  def test_number_of_steps_to_reach_endpoints
    hw = HauntedWasteland.new('test_input_b.txt', 'test_instructions_b.txt')

    assert_equal 6, hw.number_of_steps_to_reach_endpoints
  end
end

hw = HauntedWasteland.new('input.txt', 'instructions.txt')
hw.number_of_steps_to_reach_endpoints
