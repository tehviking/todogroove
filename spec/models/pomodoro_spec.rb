require 'spec_helper'

describe Pomodoro do
  before do
    @pomodoro = Pomodoro.new
    @pomodoro.events << [:start, 25.minutes.ago]
    @pomodoro.events << [:interruption, 5.minutes.ago, "Janitor on fire"]
    @pomodoro.events << [:resume, 3.minutes.ago]
  end

  describe "#complete?" do
    describe "given incomplete Pomodoro" do
      it "should not be complete" do
        @pomodoro.should_not be_complete
      end
    end

    describe "given a complete Pomodoro" do
      before do
        @pomodoro.events << [:complete, Time.now]
      end

      it "should be complete" do
        @pomodoro.should be_complete
      end
    end
    
    describe "given an abandoned Pomodoro" do
      before do
        @pomodoro.events << [:abandon, Time.now]
      end

      it "should not be complete" do
        @pomodoro.should_not be_complete
      end
    end

    describe "given an unstarted Pomodoro" do
      before do
        @pomodoro = Pomodoro.new
      end

      it "should not be complete" do
        @pomodoro.should_not be_complete
      end
    end
  end
end
