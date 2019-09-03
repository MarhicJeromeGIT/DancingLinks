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

    context "when there is a solution" do
      context "simple matrix" do
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

      context "complex matrix" do
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

        it "is ok" do
          subject.call
        end
      end
    end

    context "when there are several solutions" do
      let(:matrix) do
        [
          [1, 1],
          [0, 1],
          [1, 0]
        ]
      end

      it "is ok" do
        subject.call
      end
    end

    context "when there is no solution" do
      context "simple matrix" do
        let(:matrix) do
          [
            [0, 0],
            [1, 0]
          ]
        end

        it "is ok" do
          subject.call
        end
      end
    end
  end
end
