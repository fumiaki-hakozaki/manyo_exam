require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
     context 'タスクのタイトルが空の場合' do
      it 'バリデーションに引っ掛かる' do
        task = Task.new(task_name: '', task_content: '失敗テスト', status: '', priority: '')
        expect(task).not_to be_valid
      end
     end
     context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(task_name: '失敗テスト', task_content: '', status: '', priority: '')
        expect(task).not_to be_valid
      end
     end
     context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(task_name: 'セカンド', task_content: 'セカンド', status: '未着手', priority:'低')
      end
     end
  end
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task)}
    let!(:second_task) { FactoryBot.create(:second_task) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.search_name('nagasaki')).to include(task)
        expect(Task.search_name('nagasaki')).not_to include(second_task)
        expect(Task.search_name('nagasaki').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('完了')).to include(task)
        expect(Task.search_status('着手中')).not_to include(second_task)
        expect(Task.search_status('完了').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_name('nagasaki').where(status: '完了')).to include(task)
        expect(Task.search_name('nagasaki').where(status: '着手中')).not_to include(second_task)
        expect(Task.search_name('nagasaki').where(status: '完了').count).to eq 1
      end
    end
  end
end
