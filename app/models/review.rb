class Review < ApplicationRecord
  belongs_to :reviewer
  belongs_to :reviewed
  belongs_to :event
end
