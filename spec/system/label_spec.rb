require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
    def login
      visit new_label_path
      fill_in 'session[email]', with: 'tokyo@dic.com'
      fill_in 'session[password]', with: 'password'
      click_button 'ログイン'
    end
  describe 'ラベル新規作成' do
    before do 
      user = FactoryBot.create(:third_user)
    end
    context 'ラベルを新規作成した場合' do
      it '作成したラベルが表示される' do
        visit new_label_path
        fill_in 'session[email]', with: 'tokyo@dic.com'
        fill_in 'session[password]', with: 'password'
        click_button 'ログイン'
        click_link 'ラベル作成画面へ'
        fill_in 'label[label_name]', with: 'test_label'
        click_on '作成する'
        expect(page).to have_content 'test_label'
      end
    end
  end
  describe 'ラベルの付与機能' do
    let!(:third_user){FactoryBot.create(:third_user)}
    context 'タスク作成と同時にラベルを選択した場合' do
      it '作成したタスクにラベルが表示される' do
        label = FactoryBot.create(:label)
        label_1 = FactoryBot.create(:label_1)
        date = Date.new(2013,12,11)
        login
        visit new_task_path
        click_link '新しいタスクを作成'
        fill_in "task[task_name]", with: 'nagasaki'
        fill_in "task[task_content]", with:'nagasaki'
        select '完了', from: 'task[status]'
        fill_in "task[deadline]", with: date
        select '高', from: 'task[priority]'
        check "Mk-1"
        click_on '登録'
        expect(page).to have_content 'Mk-1'
      end
    end
  end
  describe 'ラベル検索機能' do
    let!(:third_user){FactoryBot.create(:third_user)}
    let!(:task) { FactoryBot.create(:task, user: third_user) }
    let!(:label){ FactoryBot.create(:label) }
    let!(:label_1){FactoryBot.create(:label_1)}
    let!(:task_label){ FactoryBot.create(:task_label, task: task, label: label)}
    context 'タスク検索でラベルを検索した場合' do
      it '検索されたラベルが付いているタスクを表示する' do
        login
        visit tasks_path
        select "Mk-1", from: "search[label_id]"
        click_button "検索"
        expect(page).to have_content 'Mk-1'
      end
    end
  end
end