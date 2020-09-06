class Provider < ApplicationRecord

  validates :name, :lowest_price, :rating, presence: true

  scope :search_by, ->(column, value) do
    where("LOWER(#{column}) LIKE ?", "%#{value.downcase}%") if column.present? && value.present?
  end

  scope :order_by, ->(column, direction) do
    column = %w(lowest_price rating).include?(column) ? column : 'name'
    direction = %w(asc desc).include?(direction) ? direction : 'asc'
    order("#{column} #{direction}")
  end

end
