class Task
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :status, type: String

  belongs_to :project
  STATUSES = { to_do: "To do", in_progress: "In Progress", completed: "Completed" }
  after_create -> { TaskBroadcaster.broadcast_task(self, action: :create) }
  after_update -> { TaskBroadcaster.broadcast_task(self, action: :update) }
  after_destroy -> { TaskBroadcaster.broadcast_task(self, action: :destroy) }

end
