# Cover problem solver
# Ruby implementation of https://arxiv.org/abs/cs/0011047 (Dancing Link algorithm)
# Can be used to solve tetramino or sudoku problems
# @author Marhic Jerome 2019

require "matrix_preprocessor"
require "pry"

# Solves the cover problem with algorithm "X"
class CoverSolver
  attr_reader :matrix

  def initialize(matrix)
    @matrix = matrix
  end

  def call
    root = MatrixPreprocessor.new(matrix).call
    search(0, root)
  end

  private

  def search(k, root)
    puts "search #{k}"

    column = choose_column(root)
    cover_column(column)

    current = column.down
    loop do
      break if current == column

      right = current.right
      loop do
        break if right == current

        cover_column(right)
        right = right.right
      end

      search(k + 1, root)

      j = current.left
      loop do
        break if j == current

        uncover_column(left)

        j = j.left
      end

      current = column.down
    end

    uncover_column(column)
  end

  def choose_column(root)
    root.right
  end

  # removes c from the header list
  # @param column [ColumnObject]
  def cover_column(column)
    column.right.left = column.left
    column.left.right = column.right

    i = column.down
    loop do
      break if i == column

      j = i.right
      loop do
        break if j == i

        j.down.up = j.up
        j.up.down = j.down

        j = j.right
      end

      i = i.down
    end
  end

  def uncover_column(column)
    i = column.up
    loop do
      break if i == column

      j = i.left
      loop do
        break if j == i

        j.down.up = j
        j.up.down = j

        j = j.left
      end

      i = i.up
    end

    column.left.right = column
    column.right.left = column
  end
end

# 0 0 1 0 1 1 0
# 1 0 0 1 0 0 1
# 0 1 1 0 0 1 0
# 1 0 0 1 0 0 0
# 0 1 0 0 0 0 1
# 0 0 0 1 1 0 1
