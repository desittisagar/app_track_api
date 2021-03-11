class Candidate < ApplicationRecord
	has_secure_password
	EMAIL_REGEX = /\A[a-z0-9\+\-_\.]+@[a-z\d\-.]+\.[a-z]+\z/
	validates :email, presence: true, format: {with: EMAIL_REGEX, message: "Must be a valid email"}
	validates :name, presence: true, format: {with: /[a-zA-Z]+/, message: "Must be Characters only"}
	validates :age, format: {with: /[0-9]+/, message: "Must be integer"}, numericality: { greater_than: 20, less_than_or_equal_to: 40 }
	validates :yoe, format: {with: /[0-9]+/, message: "Must be integer"}, numericality: { greater_than: 0, less_than_or_equal_to: 20 }
	validates :phone, format: {with: /\A\d{10}\z/, message: "Must be a 10 digit valid number"}#, numericality: {greater_than: 6000000000, less_than_or_equal_to: 9999999999}
end
