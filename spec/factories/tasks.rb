FactoryBot.define do

  factory :task do
    task_name {'nagasaki'}
    task_content {'タスクネーム設定'}
    deadline {'Wed, 11 Jan 2023'}
    status {'タスクネーム設定'}
    priority{'タスクネーム設定'}
  end

  factory :second_task, class: Task do
    task_name {'セカンドタスク2'}
    task_content {'セカンドタスク2'}
    deadline {'Wed, 11 Jan 2023'}
    status {'セカンドタスク2'}
    priority{'セカンドタスク2'}
  end
end