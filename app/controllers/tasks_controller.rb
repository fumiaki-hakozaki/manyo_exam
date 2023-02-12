class TasksController < ApplicationController
  def index
    @labels = Label.all
    @tasks = current_user.tasks.includes(:user)
    if params[:sort_expired]
      @tasks = @tasks.order(deadline: "DESC")
    else params[:sort_priority]
      @tasks = @tasks.sort_priority
    end
    if params[:search].present?
      @tasks = @tasks
      .search_name(params[:search][:task_name])
      .search_status(params[:search][:status])
      .search_label(params[:search][:label_id])
    end
    @tasks = @tasks.page(params[:page]).per(3)
  end

  def new
    @task = Task.new
    @task.task_labels.build
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to task_path(@task), notice: 'タスクを作成しました'
    else
      render :new
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
    @task.user = current_user
    @labels = Label.all
    render :new if @task.invalid?
  end


  private

  def task_params
    params.require(:task).permit(:task_name, :task_content, :deadline, :status, :priority, :user_id, { label_ids:[] } )
  end
end
