require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'cucumber/language_support/Cuke4NukeGenerator'

describe Cuke4NukeGenerator do
  before :each do
    @generator = Cuke4NukeGenerator.new
    @generator.generate
  end

  it "should not have illegal characters in attribute names" do
    @generator.keywords.flatten.each do |keyword|
      keyword.should_not =~ /[\(\)<>\s']/
    end
  end

  it "should remove text in parantesis" do
    @generator.keywords.flatten.each do |keyword|
      keyword.should_not == "Romanian(diacritical)"
    end
  end

  describe "keywords" do
    it "should have a unique list of keywords" do
      @generator.keywords.uniq.should == @generator.keywords
    end

    it "should not give given when then as i18n keywords" do
      @generator.keywords.flatten.each do |keyword|
        keyword.should_not =~ /^given$/i
        keyword.should_not =~ /^when$/i
        keyword.should_not =~ /^then$/i
      end
    end

  end
end
