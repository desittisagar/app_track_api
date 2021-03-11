class ProfileController < ApplicationController

	before_action :require_candidate_login!

	def update_password
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

	def get_profile
		@candidate = Candidate.select("name, email, age, yoe, skills, phone").find_by(id: Current.candidate.id)
		render json: {
			profile: @candidate
		}
	end

	def update_profile
		if Current.candidate.update(profile_params)
			@candidate = Candidate.select("name, email, age, yoe, skills, phone").find_by(id: Current.candidate.id)
			render json: {
				status: 200,
				profile: @candidate
			}
		else
			render json: {
				status: 500,
				info: "Updation failed due to Validations"
				#errors: @candidate.error
			}
		end
	end

	private

	def profile_params
		params.permit(:name, :email, :age, :yoe, :skills, :phone)
	end

	def password_params
		params.permit(:password, :password_confirmation)
	end

end