FactoryBot.define do

  factory :user do
    name {'sasebo@dic.com'}
    email {'sasebo@dic.com'}
    password {'password'}
  end

  factory :secound_user, class:User do
    name {'fukuoka@dic.com'}
    email {'fukuoka@dic.com'}
    password {'password'}
  end

  factory :third_user, class:User do
    name {'tokyo@dic.com'}
    email {'tokyo@dic.com'}
    password {'password'}
    admin {'true'}
  end
end
