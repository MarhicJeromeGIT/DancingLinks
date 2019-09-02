require "data_object"

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
