# Oh gosh you guys, this model fell into total disuse, but I can't bring myself
#  to delete the Pomodoro model from a Pomodoro app. It'll be needed for analytics etc.

class Pomodoro
  include Mongoid::Document

  embedded_in :task

  include Mongoid::Timestamps

  field :interruptions, :type => Array, :default => lambda{ Array.new }
  field :started_at, :type => Time
  field :completed_at, :type => Time

  def complete?
    events.last && events.last[0] == :complete
  end
end
