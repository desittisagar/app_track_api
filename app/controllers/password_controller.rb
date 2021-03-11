class PasswordController < ApplicationController

	before_action :require_candidate_login!

	def update
		#puts "CANdi", Current.candidate
		if Current.candidate.update(password_params)
			render json: {
				status: 200,
				info: "Password Successfully changed"
			}
		else
			render json:{
				status: 500,
				info: "Wrong Password"
			}
		end
	end


	private

	def password_params
		params.permit(:password, :password_confirmation)
	end
end