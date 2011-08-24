require "spec_helper"

describe Crush::Engine do
  class Stripper < Crush::Engine
    def evaluate(*args)
      case options[:direction]
      when :left
        data.lstrip
      when :right
        data.rstrip
      else
        data.strip
      end
    end
  end
  
  describe ".compress" do
    it "compresses the given data" do
      Stripper.compress("  data  ").should == "data"
    end
    
    it "accepts options" do
      Stripper.compress("  data  ", :direction => :left).should == "data  "
      Stripper.compress("  data  ", :direction => :right).should == "  data"
    end
    
    it "is aliased as `compile`" do
      Stripper.compile("  data  ").should == "data"
    end
  end
  
  describe "#initialize" do
    it "does not raise errors without a file or block" do
      expect {
        Stripper.new
      }.to_not raise_error(ArgumentError)
    end
  end
  
  describe "#compress" do
    it "compresses the given data" do
      Stripper.new.compress("  data  ").should == "data"
    end
    
    it "uses options set when initializing" do
      Stripper.new(:direction => :left).compress("  data  ").should == "data  "
      Stripper.new(:direction => :right).compress("  data  ").should == "  data"
    end
    
    it "is aliased as `compile`" do
      Stripper.new.compile("  data  ").should == "data"
    end
  end
end
