require 'spec_helper'

describe Sports::Fetcher do
  @file
  context "soccer game" do
    it "should fetch and save the soccer game html page" do
      @file = Sports::Fetcher.new.fetch_soccer('2013-09-10')
      File.zero?(@file).should == false
    end
  end

  context "cricket" do
    it "should fetch and save the cricket schedule html page" do
      @file = Sports::Fetcher.new.fetch_cricket 7
      File.zero?(@file).should == false
    end

    it "should fetch and save the cricket result html page" do
      @file = Sports::Fetcher.new.fetch_cricket_result
      File.zero?(@file).should == false
    end
  end

  after do
    @file.unlink
  end
end