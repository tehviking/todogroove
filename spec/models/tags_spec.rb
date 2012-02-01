require 'spec_helper'

describe Tag do
  before do
    @tag = Tag.new :name => 'Test Tag'
  end

  describe "sanity check" do
    42.should == 42
  end

  describe "#slug" do
    it "should downcase the tag name" do
      # should it also hyphenate?
      @tag.slug.should == 'test tag'
    end
  end
end

