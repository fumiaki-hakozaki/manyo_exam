require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        date = Date.new(2013,12,11)
        visit new_task_path
        fill_in "task[task_name]", with: 'nagasaki'
        fill_in "task[task_content]", with:'nagasaki'
        select '完了', from: 'task[status]'
        fill_in "task[deadline]", with: date
        select '高', from: 'task[priority]'
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
        expect(page).to have_content 'nagasaki'
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
  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'search[task_name]',with: 'test'
        task_1 = FactoryBot.create(:task, task_name: "test")
        task_2 = FactoryBot.create(:task, task_name: "content")
        task_3 = FactoryBot.create(:task, task_name: "どうだ！")
        click_button "検索"
        expect(page).to have_content task_1.task_name
        expect(page).not_to have_content task_2.task_name
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '完了', from: 'search[status]'
        task_1 = FactoryBot.create(:task, status: "着手中")
        task_2 = FactoryBot.create(:task, status: "完了")
        task_3 = FactoryBot.create(:task, status: "未着手")
        click_button "検索"
        expect(page).to have_content task_2.status
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        task_1 = FactoryBot.create(:task)
        task_2 = FactoryBot.create(:second_task)
        fill_in 'search[task_name]',with: 'na'
        select '完了', from: 'search[status]'
        click_button "検索"
        expect(page).to have_content task_1.task_name
        expect(page).not_to have_content task_2.task_name
      end
    end
  end

    context 'タスクが終了期限の昇順で並んでいる場合' do
      it '終了期限が近いタスクが一番上に表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path(task)
        click_link "終了期限でソートする"
        task_list = page.all('.task_low')
        expect(page).to have_content 'nagasaki'
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