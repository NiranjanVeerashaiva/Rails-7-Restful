class TaskBroadcaster
  def self.broadcast_task(task, action: :create)
    project = task.project
    broadcast_task_counts(project)
    Turbo::StreamsChannel.broadcast_replace_to(
      "tasks",
      target: "tasks-progress-bar",
      partial: "tasks/progress",
      locals: { project: task.project }
    )
    case action
    when :create
      Turbo::StreamsChannel.broadcast_prepend_to(
        "tasks",
        target: "tasks_list_#{task.status}",
        partial: "tasks/task",
        locals: { task: task, project: task.project }
      )
      Turbo::StreamsChannel.broadcast_replace_to(
        "tasks",
        target: "notification-container",
        partial: "tasks/notification"
      )
    when :update
      Turbo::StreamsChannel.broadcast_remove_to("tasks", target: dom_id(task))

      Turbo::StreamsChannel.broadcast_append_to(
        "tasks",
        target: "tasks_list_#{task.status}",
        partial: "tasks/task",
        locals: { task: task, project: task.project }
      )
    when :destroy
      Turbo::StreamsChannel.broadcast_remove_to("tasks", target: dom_id(task))
    end
  end

  def self.broadcast_task_counts(project)
    Turbo::StreamsChannel.broadcast_update_to(
      "tasks",
      target: "tasks-count-to-do",
      partial: "tasks/count",
      locals: { count: project.tasks.where(status: "to_do").count }
    )

    Turbo::StreamsChannel.broadcast_update_to(
      "tasks",
      target: "tasks-count-in-progress",
      partial: "tasks/count",
      locals: { count: project.tasks.where(status: "in_progress").count }
    )

    Turbo::StreamsChannel.broadcast_update_to(
      "tasks",
      target: "tasks-count-completed",
      partial: "tasks/count",
      locals: { count: project.tasks.where(status: "completed").count }
    )
  end

  def self.dom_id(record, prefix = nil)
    ActionView::RecordIdentifier.dom_id(record, prefix)
  end
end


