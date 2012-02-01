class Task
  include Mongoid::Document
  include Mongoid::Timestamps
#  include ActsAsList::Mongoid # THROWS A STACK LEVEL TOO DEEP ERROR... WHY, GOD, WHY?

  field :name, :type => String
  field :done, :type => Boolean
  # Also, the notion of "show" == "start" seems a bit tricky.
  # This is wrong, I think. I think Poms need their own object structure with started_at, finished_at, and interruptions
  field :estimated_pomodoros, :type => Integer
  field :completed_pomodoros, :type => Integer
  field :interruptions, :type => Integer
  field :archived, :type => Boolean
  field :pos, :type => Integer

  referenced_in :user

  embeds_many :pomodoros
  embeds_many :tags

  before_create :set_default_pos

  def completed_pomodoros
    self[:completed_pomodoros] || 0
  end

  def estimated_pomodoros
    self[:estimated_pomodoros] || 0
  end

  def self.ordered_tasks
    order_by([[:done, :asc], [:pos, :asc]])
  end

  def set_default_pos
    self.pos = (Task.order_by(:pos, :desc).first.pos + 1)
  end

end
