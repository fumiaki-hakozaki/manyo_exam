class Label < ApplicationRecord
  has_many :task_labels, dependent: :destroy
  has_many :tasks, through: :task_labels
  validates :label_name, presence: true
  validates :label_name, uniqueness: true
end
