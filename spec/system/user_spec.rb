require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザーの新規登録テスト' do
    context '新規登録ができる場合' do
      it 'ユーザーの新規登録ができ、マイページを表示する' do
        visit new_user_path
        fill_in 'user[name]', with: 'nagasaki@dic.com'
        fill_in 'user[email]', with: 'nagasaki@dic.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '登録'
        expect(page).to have_content 'nagasaki'
      end
    end
    context 'ユーザーがログインできない場合' do
      it 'ログインせずにタスク一覧に飛ぼうとした時、ログイン画面に遷移する' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'セッション機能テスト' do
    before do
      user = FactoryBot.create(:user)
      user_1 = FactoryBot.create(:secound_user)
        visit new_session_path
        fill_in 'session[email]', with: 'sasebo@dic.com'
        fill_in 'session[password]', with: 'password'
        click_button 'ログイン'
    end
    context 'ログインができる場合' do
      it 'ログインができる' do
      expect(page).to have_content 'ログインしました'
      end
    end
    context 'ログインしている場合' do
      it 'ログインしているマイページを表示' do
        click_link 'プロフィール'
        expect(page).to have_content 'ページ'
        expect(page).not_to have_content 'ログインしました'
      end
      it '一般ユーザーが他人の詳細画面にリンクするとタスクの一覧画面に戻る' do
        visit user_path(:secound_user)
        expect(page).to have_content "タスク一覧"
      end
      it 'ログアウトできること' do
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理画面テスト' do
    before do
      user = FactoryBot.create(:user)
      user_1 = FactoryBot.create(:secound_user)
      user_2 = FactoryBot.create(:third_user)
    end
    context '管理ユーザーは管理画面にアクセスできる' do
      it '管理ユーザーの管理画面表示' do
        visit user_path(:third_user)
        fill_in 'session[email]', with: 'tokyo@dic.com'
        fill_in 'session[password]', with: 'password'
        click_button 'ログイン'
        click_link '管理者画面'
        expect(page).to have_content 'タスク数'
      end
      it '一般ユーザーは管理画面にアクセスできない' do
        visit user_path(:secound_user)
        fill_in 'session[email]', with: 'sasebo@dic.com'
        fill_in 'session[password]', with: 'password'
        click_button 'ログイン'
        expect(page).not_to have_content '管理者画面'
      end
      it '管理ユーザーはユーザーの新規登録ができる' do
        visit user_path(:third_user)
        fill_in 'session[email]', with: 'tokyo@dic.com'
        fill_in 'session[password]', with: 'password'
        click_button 'ログイン'
        click_link '管理者画面'
        click_link '管理ユーザーの新規登録'
        fill_in 'user[name]', with: 'aomori@dic.com'
        fill_in 'user[email]', with: 'aomori@dic.com'
        uncheck "user_admin"
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button "登録"
        expect(page).to have_content "aomori"
      end
      it '編集画面からユーザーを編集できる' do
        visit user_path(:third_user)
        fill_in 'session[email]', with: 'tokyo@dic.com'
        fill_in 'session[password]', with: 'password'
        click_button 'ログイン'
        click_link '管理者画面'
        click_link '編集', match: :first
        check 'user_admin'
        click_button '登録'
        expect(page).to have_content "更新"
      end
      it '管理ユーザーの削除ができる' do
        visit user_path(:third_user)
        fill_in 'session[email]', with: 'tokyo@dic.com'
        fill_in 'session[password]', with: 'password'
        click_button 'ログイン'
        click_link '管理者画面'
        click_link '削除', match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "を"
      end
    end
  end
end