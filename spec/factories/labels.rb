FactoryBot.define do
  factory :label do
    label_name { "Mk-1" }
  end
  factory :label_1, class: Label do
    label_name { "Mk-2" }
  end
end
