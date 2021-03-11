class Admin < ApplicationRecord

	validates :name, format: {with: /[a-zA-Z]+/, message: "Must be Characters only"}
	validates :phone, presence: true, format: {with: /\A\d{10}\z/, message: "Must be a 10 digit valid number"}
	validates :otp, presence: true, format: {with: /\A\d{4}\z/, message: "Must be a 4 digit valid number"}
end
