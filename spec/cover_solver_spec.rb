RSpec.describe CoverSolver do
  subject { described_class.new(matrix) }

  context "empty matrix" do
    let(:matrix) do
      []
    end

    it "returns an empty array" do
    end
  end

  it "is ok" do
  end
end
