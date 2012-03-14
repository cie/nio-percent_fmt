require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require "nio"

describe "Nio::PercentFmt" do
  specify "write" do
    fmt = Nio::PercentFmt.new.mode!(:sig, 3)
    
    0.75.nio_write(fmt).should == "75.0%"
    1.75.nio_write(fmt).should == "175%"
    0.759.nio_write(fmt).should == "75.9%"
    0.00759.nio_write(fmt).should == "0.759%"
  end

  specify "read" do
    fmt = Nio::PercentFmt.new.mode!(:sig, 3)
    
    Float.nio_read("75.0%", fmt).should == 0.75
    Float.nio_read("175%", fmt).should == 1.75
    Float.nio_read("75.9%", fmt).should == 0.759
    Float.nio_read("0.759%", fmt).should == 0.00759
  end
end
