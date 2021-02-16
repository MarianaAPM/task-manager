class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all
  end

  def show   
    @complete = ""
    if @task.completed == false
      @complete = "The task is not completed yet"
    else
      @complete = "This task is completed"
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to task_path(@task)
  end

  def edit
  end

  def update
    @task.update(task_params)
    
    if @task.completed == false && @task.persisted? 
      @task.completed = true
    else
      @task.completed = false
    end
    @task.save

    redirect_to task_path(@task)
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:title, :details)
  end
end
