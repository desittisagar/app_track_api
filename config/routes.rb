Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "main#index"		# list of all jobs to non-loggedin users
  post "apply", to: "apply_job#create"		# to apply for jobs

  post "sign_up", to: "registration#create"		# to check valid user and then register

  post "sign_in", to: "session#create"			# login candidate
  delete "logout", to: "session#destroy"		# to destroy all session if any

  get "admin_login", to: "session#check_admin"	# check if admin or not - before login with mobile
  post "admin_login", to: "session#login_admin"	# to login admin - mobile and otp

  get "admin_login/jobs", to: "admin#joblist"	# list of jobs, candidates and applied_jobs
  post "admin_login/jobs/create_jobs", to: "admin#create_job"
  patch "admin_login/jobs/update_jobs", to: "admin#edit_job"
  patch "admin_login/jobs/update_candidates", to: "admin#update_candidate_status"

  #patch "password", to: "password#update"		# to change the existing password
  patch "profile/password", to: "profile#update_password"		# to change password

  get "profile", to: "profile#get_profile"			# to get candidate profile
  post "profile/update", to: "profile#update_profile"
end
