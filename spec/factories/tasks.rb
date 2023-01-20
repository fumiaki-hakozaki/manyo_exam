FactoryBot.define do

  factory :task do
    task_name {'nagasaki'}
    task_content {'タスクネーム設定'}
    deadline {'2022/01/02'}
    status {'完了'}
    priority{'高'}
  end

  factory :second_task, class: Task do
    task_name {'セカンドタスク2'}
    task_content {'セカンドタスク2'}
    deadline {'2022/02/10'}
    status {'未着手'}
    priority{'低'}
  end
end