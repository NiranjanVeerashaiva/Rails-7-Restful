class ProjectBroadcaster
  def self.broadcast_project(project, action: :create)
    case action
    when :create
      Turbo::StreamsChannel.broadcast_prepend_to(
        "projects",
        target: "projects-list",
        partial: "projects/project",
        locals: { project: project }
      )
    when :destroy
      Turbo::StreamsChannel.broadcast_remove_to("projects", target: "id_#{dom_id(project)}" )
    end
  end

  def self.dom_id(record, prefix = nil)
    ActionView::RecordIdentifier.dom_id(record, prefix)
  end
end