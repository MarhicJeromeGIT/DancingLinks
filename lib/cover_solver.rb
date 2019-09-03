# Cover problem solver
# Ruby implementation of https://arxiv.org/abs/cs/0011047 (Dancing Link algorithm)
# Can be used to solve tetramino or sudoku problems
# @author Marhic Jerome 2019

require "matrix_preprocessor"

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

  def search(k, root, solution = [])
    if root.right == root
      print_solution(solution)
      return solution
    end

    column = choose_column(root)
    cover_column(column)

    r = column.down
    loop do
      break if r == column

      solution[k] = r

      j = r.right
      loop do
        break if j == r

        cover_column(j.column)
        j = j.right
      end

      search(k + 1, root, solution)

      r = solution[k]
      column = r.column

      j = r.left
      loop do
        break if j == r

        uncover_column(j.column)

        j = j.left
      end

      r = r.down
    end

    uncover_column(column)

    [] # no solution
  end

  def print_solution(solution)
    puts "Solution"
    solution.each do |data_object|
      row = []
      current = data_object
      loop do
        row << current.column.name
        current = current.right
        break if current == data_object
      end
      puts row.join(" ")
    end
    puts "_____"
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
