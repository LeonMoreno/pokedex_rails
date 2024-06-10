# frozen_string_literal: true

class Pokemon < ApplicationRecord
  validates :name, presence: true
  validates :type_1, presence: true
end
