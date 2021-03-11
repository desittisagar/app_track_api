class ApplicationController < ActionController::API

	before_action :set_current_candidate

	def set_current_candidate
		if session[:user_id]
			Current.candidate = Candidate.find_by(id: session[:user_id])
		end
	end

	def require_candidate_login!
		if Current.candidate.nil?
			render json: {
				status: 300,
				info: "Must need a Candidate login!"
			}
		end
	end


	# def set_current_admin
	# 	if session[:phone]
	# 		Current.admin = Admin.find_by(id: session[:phone])
	# 	end
	# end

	# def require_admin_login!
	# 	if Current.admin.nil?
	# 		render json: {
	# 			status: 300,
	# 			info: "Must need an Admin login!"
	# 		}
	# 	end
	# end
end
