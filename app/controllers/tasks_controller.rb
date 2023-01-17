class TasksController < ApplicationController
  def index
    @tasks = Task.all

    if params[:sort_expired]
      @tasks = Task.all.order(deadline: "ASC")
    else params[:sort_priority]
      @tasks = Task.sort_priority
    end

    if params[:search].present?
      @tasks = @tasks
      .search_name(params[:search][:task_name])
      .search_status(params[:search][:status])
    end
  end

  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: 'タスクを作成しました'
      else
        render :new
      end
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'タスクを編集しました'
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: 'タスクを削除しました'
  end

  def confirm
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end


  private

  def task_params
    params.require(:task).permit(:task_name, :task_content, :deadline, :status, :priority)
  end
end
