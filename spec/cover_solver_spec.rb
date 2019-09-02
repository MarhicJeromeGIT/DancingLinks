require "cover_solver"

RSpec.describe CoverSolver do
  subject { described_class.new(matrix) }

  describe "#call" do
    context "empty matrix" do
      let(:matrix) do
        []
      end

      it "returns an empty array" do
      end
    end

    let(:matrix) do
      [
        [0, 1],
        [1, 0]
      ]
    end

    it "is ok" do
      subject.call
    end
  end
end
