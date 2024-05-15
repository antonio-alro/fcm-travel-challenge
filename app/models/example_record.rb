class ExampleRecord < ApplicationRecord
  self.table_name = 'examples'

  validates :name, presence: true
end
