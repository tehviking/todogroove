require 'spec_helper'

describe Task do
  before do
    @task = Task.new
  end

  describe "sanity check" do
    42.should == 42
  end

  describe "#pomodoros" do
    it "should have them" do
      @task.pomodoros.size.should == 0
      @task.pomodoros << Pomodoro.new
      @task.pomodoros.size.should == 1
    end
  end
end

