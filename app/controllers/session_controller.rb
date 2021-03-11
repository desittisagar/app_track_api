class SessionController < ApplicationController

	def create
		puts  "SESSION", session[:user_id], session[:phone]
		if session[:user_id] || session[:phone]
			render json: {
				status: 500,
				errors: "Already logged-in"
			}
		else
			@candidate = Candidate.find_by(email: params[:email])
			if @candidate.present? && @candidate.authenticate(params[:password])
				session[:user_id] = @candidate.id
				puts "sessionid", session[:user_id]
				render json: {
					status: "Successfully Logged-in",
					user: @candidate
				}
			else
				render json: {
					status: "Invalid username/password"
					#errors: @candidate.errors
				}
			end
		end
	end


	def check_admin
		if session[:user_id]
			render json: {
				status: :failed,
				errors: "Cannot login when candidate is already logged-in"
			}
		else
			if session[:phone]
				render json: {
					status: "already logged-in as Admin"
				}
			else
				#@otp = rand(1111..9999)
				if params[:phone].to_i > 6000000000 && params[:phone].to_i < 9999999999
					session[:otp] = rand(1111..9999)
					puts "OTP", session[:otp]
					#@phone 
					session[:number] = params[:phone]
					puts "sess",params[:phone]
					render json: {
						status: :checked
					}
				else
					render json: {
						status: 500,
						info: "Enter correct number"
					}
				end
			end
		end
	end


	def login_admin
		if session[:user_id]
			render json: {
				status: :failed,
				errors: "Cannot login when candidate is already logged-in"
			}
		elsif session[:phone]
				render json: {
					status: "already logged-in as Admin"
				}
		elsif session[:number] == params[:phone]
			session_otp = session[:otp]
			#puts session_otp, params[:otp].to_s, params[:otp]
			params_otp = params[:otp].to_s
			if session_otp == params[:otp].to_i
				session[:phone] = session[:number]
				session[:number] = nil
				@admin = Admin.new(admin_params)
				@admin.save
				puts "ADMIN", @admin.errors
				render json: {
					status: "Admin logged-in",
					phone: params[:phone]
					#info: @admin
				}
			else
				render json: {
					status: "Wrong OTP"
				}
			end
		else
			render json: {
				status: "First Enter the correct phone number"
			}
		end
	end

	def destroy
		if session[:user_id] || session[:phone]
			reset_session
			render json: {
				status: "Logged-out successfully"
			}
		else
			render json: {
				status: "No user to logout"
			}
		end
	end

	private

	def admin_params
		params.permit(:name, :phone, :otp)
	end
end