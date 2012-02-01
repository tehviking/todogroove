class Tag
  include Mongoid::Document
  embedded_in :task

  field :name, :type => String

  def slug
    name.downcase
  end
end

