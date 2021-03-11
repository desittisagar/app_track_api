class RegistrationController < ApplicationController

	def create
		#puts params[:phone]
		#@candidate = Candidate.create!(user_params)
		if session[:user_id] || session[:phone]
			render json: {
				status: 505,
				errors: "Already logged-in"
			}
		else
			@candidate = Candidate.new(user_params)

			if @candidate.save
				session[:user_id] = @candidate.id
				render json: {
					status: 200,
					info: :created,
					user: @candidate
				}
			else
				render json: {
					status: 500,
					errors: @candidate.errors
				}
			end
		end
	end


	private

	def user_params
		params.permit(:name, :email, :age, :yoe, :skills, :phone, :password, :password_confirmation)
	end
end