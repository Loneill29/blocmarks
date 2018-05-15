require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:bookmark) { Bookmark.create!(url: url) }
  let(:url) { RandomData.random_sentence }
  let(:bookmark) { topic.bookmarks.create!(url: url) }

it { is_expected.to belong_to(:topic) }

describe "attributes" do
  it "has a url attribute" do
    expect(bookmark).to have_attributes(url: url)
  end
end
