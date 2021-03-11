class Job < ApplicationRecord


	validates :title, presence: true
	validates :category, presence: true, :inclusion => { :in => %w(frontend backend) }
	validates :yoe, presence: true, format: {with: /[0-9]+/, message: "Must be integer"}, numericality: { greater_than: 0 }
	validate :status
end
