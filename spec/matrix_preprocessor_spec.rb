require "./cover_solver"
require "byebug"

RSpec.describe MatrixPreprocessor do
  subject { described_class.new(matrix) }

  describe ".call" do
    context "empty matrix" do
      let(:matrix) do
        []
      end
    end

    context "non empty matrix" do
      let(:matrix) do
        [
          [0, 0, 1, 0, 1, 1, 0],
          [1, 0, 0, 1, 0, 0, 1],
          [0, 1, 1, 0, 0, 1, 0],
          [1, 0, 0, 1, 0, 0, 0],
          [0, 1, 0, 0, 0, 0, 1],
          [0, 0, 0, 1, 1, 0, 1]
        ]
      end

      it "returns a root object" do
        root = subject.call
        expect(root.n).to eq "root"
      end

      it "links the root to the column headers" do
        root = subject.call
        expect(root.right).to be_a ColumnObject
        expect(root.right.left).to eq root
        expect(root.left).to be_a ColumnObject
        expect(root.left.right).to eq root
      end

      it "links the data objects vertically" do
        root = subject.call
        col1 = root.right

        expect(col1.up).to be_a DataObject
        expect(col1.up.down).to eq col1
        expect(col1.down).to be_a DataObject
        expect(col1.down.up).to eq col1
      end

      it "links the data objects horizontally" do
        root = subject.call
        col1 = root.right
        data_object = col1.down

        expect(data_object.left).to be_a DataObject
        expect(data_object.left.right).to eq data_object
        expect(data_object.right).to be_a DataObject
        expect(data_object.right.left).to eq data_object
      end
    end
  end
end
