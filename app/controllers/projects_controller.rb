class ProjectsController < ApplicationController
  # before_action :find_project, only: [:show, :edit, :update, :destroy]
  def index
    client = TrackerApi::Client.new(token:  Rails.application.secrets.pivotal_tracker_api_key)
    @pivotal_tracker_projects = client.projects
  end

  def new
    @project = Project.new
    client = TrackerApi::Client.new(token:  Rails.application.secrets.pivotal_tracker_api_key)
    @pivotal_tracker_projects = client.projects
  end

  def edit
    @project = Project.find(params[:id])
    client = TrackerApi::Client.new(token:  Rails.application.secrets.pivotal_tracker_api_key)
    @pivotal_tracker_projects = client.projects
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project
    else
      render 'new'
    end
  end

  def update

    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end

  end


  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end


  def show
    client = TrackerApi::Client.new(token:  Rails.application.secrets.pivotal_tracker_api_key)
    @project  = client.project(params[:id])
  end

  def create_story
    client = TrackerApi::Client.new(token:  Rails.application.secrets.pivotal_tracker_api_key)
    @project  = client.project(params[:id])
    labels = [params[:reported_by]]
    @project.create_story(name: params[:projects][:short_description], story_type: 'bug', description: params[:projects][:long_description], labels: labels)
    redirect_to project_path
  end

  private
  def project_params
    params.require(:project).permit(:name, :pivotal_tracker_id, :active)
  end

end
