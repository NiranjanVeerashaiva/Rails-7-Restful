class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("modal_frame", partial: "projects/form", locals: { project: @project })
      end
    end
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
    if @project.update(project_params)
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end
end
