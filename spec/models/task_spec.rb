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
        task = Task.new(task_name: '成功', task_content: '成功', status: '成功', priority:'成功')
      end
     end
  end
end
