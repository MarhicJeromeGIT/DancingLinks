# Cover problem solver
# Ruby implementation of https://arxiv.org/abs/cs/0011047 (Dancing Link algorithm)
# Can be used to solve tetramino or sudoku problems
# @author Marhic Jerome 2019

# represents a "1" in the given matrix
class DataObject
  attr_accessor :left, :right, :up, :down # left, right, up and down links
  attr_reader :column # link to column object

  # @param column [ColumnObject]
  def initialize(column)
    @column = column
    @left = nil
    @right = nil
    @up = nil
    @down = nil
  end
end

# a column header
class ColumnObject < DataObject
  attr_reader :s # size (number of 1 in the column)
  attr_reader :n # name

  def initialize(s, n)
    super(nil)

    @s = s
    @n = n
  end
end

# Transforms an array into a linked list of data and column objects
class MatrixPreprocessor
  attr_reader :matrix
  attr_reader :row_count
  attr_reader :col_count

  def initialize(matrix)
    @matrix = matrix
    @row_count = matrix.size
    @col_count = matrix[0].size
  end

  def call
    # Generates the column objects
    headers = []
    (0..col_count - 1).each do |col|
      col_size = size(col)
      headers[col] = ColumnObject.new(col_size, col.to_s)
    end

    # Fill the left and right for each header object
    prev = headers[-1]
    headers.each do |current|
      current.left = prev
      prev.right = current
      prev = current
    end

    # Generates the data objects (one for each 1 in the matrix)
    data_objects = []
    row_objects_array = []
    col_objects_array = []
    (0..row_count - 1).each do |row|
      data_objects[row] = []
      row_objects_array[row] = []
      (0..col_count - 1).each do |col|
        column = headers[col]
        col_objects_array[col] = [column] if col_objects_array[col].nil?
        next unless matrix[row][col] == 1

        data_object = DataObject.new(column)
        data_objects[row][col] = data_object
        row_objects_array[row] << data_object
        col_objects_array[col] << data_object
      end
    end

    # Fill the left and right fields
    row_objects_array.each do |row_objects|
      prev = row_objects[-1]
      loop do
        break if row_objects.empty?

        current = row_objects.shift
        current.left = prev
        prev.right = current
        prev = current
      end
    end

    # Fill the up and down fields
    col_objects_array.each do |col_objects|
       prev = col_objects[-1]
       loop do
         break if col_objects.empty?

         current = col_objects.shift
         current.up = prev
         prev.down = current
         prev = current
       end
    end

    # insert the root between headers[-1] and headers[0]
    root = ColumnObject.new(0, "root")
    headers[-1].right = root
    headers[0].left = root
    root.right = headers[0]
    root.left = headers[-1]

    root
  end

  private

  # @return [Integer] Number of 1 in the given column
  def size(col)
    size = 0
    (0..row_count - 1).each do |row|
      size += 1 if matrix[row][col] == 1
    end
    size
  end
end

# Solves the cover problem with algorithm "X"
class CoverSolver
  attr_reader :matrix
  attr_reader :row_count
  attr_reader :col_count

  def initialize(matrix)
    @matrix = matrix
    @row_count = matrix.size
    @col_count = matrix[0].size
  end

  def solve
  end

  def preprocess
  end
end

# 0 0 1 0 1 1 0
# 1 0 0 1 0 0 1
# 0 1 1 0 0 1 0
# 1 0 0 1 0 0 0
# 0 1 0 0 0 0 1
# 0 0 0 1 1 0 1
