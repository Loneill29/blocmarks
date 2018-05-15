require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:title) { RandomData.random_word }
  let(:topic) { Topic.create!(title: title) }

  it { is_expected.to have_many(:bookmarks) }

  describe "attributes" do
    it "has a title attribute" do
      expect(topic).to have_attributes(title: title)
    end
  end
end
