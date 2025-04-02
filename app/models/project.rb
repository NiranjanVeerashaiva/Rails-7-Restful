class Project
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  has_many :tasks, dependent: :destroy

  after_create -> { ProjectBroadcaster.broadcast_project(self, action: :create) }
  after_destroy -> { ProjectBroadcaster.broadcast_project(self, action: :destroy) }

end
