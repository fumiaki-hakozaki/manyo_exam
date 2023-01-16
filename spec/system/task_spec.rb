require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        date = Date.new(2013,12,11)
        visit new_task_path
        fill_in "task[task_name]", with: 'nagasaki'
        fill_in "task[task_content]", with:'nagasaki'
        fill_in "task[status]", with: '良好'
        fill_in "task[deadline]", with: date
        fill_in "task[priority]", with: 'S'
        click_button "登録"
        expect(page).to have_content 'nagasaki'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        expect(page).to have_content 'タスクネーム設定'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:second_task)
        visit tasks_path(task)
        task_list = page.all('.task_low')
        expect(task_list.first).to have_content 'セカンドタスク'
      end
    end
    context 'タスクが終了期限の昇順で並んでいる場合' do
      it '終了期限が近いタスクが一番上に表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path(task)
        click_link "終了期限でソートする"
        task_list = page.all('.task_low')
        expect(task_list.first).to have_content 'nagasaki'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:second_task)
        visit task_path(task)
        expect(page).to have_content 'セカンドタスク2'
       end
     end
  end
end