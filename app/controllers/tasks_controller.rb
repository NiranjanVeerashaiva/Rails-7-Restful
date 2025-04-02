class TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def show

  end

  def new
    @task = @project.tasks.new
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("modal_frame", partial: "tasks/form", locals: { task: @task })
      end
    end
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("modal_frame", partial: "tasks/form", locals: { task: @task })
      end
    end
  end

  def update
    if @task.update(task_params) 
      respond_to do |format|
        format.turbo_stream 
      end
    else
      render :edit 
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id]) 
  end

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end
end
