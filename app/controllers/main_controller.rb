class MainController < ApplicationController

	def index
		if session[:phone]		# for Admins
			@jobs = Job.all
			@candidates = Candidate.all
			@all_applied_jobs = ApplyStatus.select("cid, jid, c_name, job_title, status")
			render json: {
				jobs: @jobs,
				candidate: @candidates,
				all_applied_jobs: @all_applied_jobs
			}
		elsif Current.candidate		# for candidates
			@jobs = Job.where(status: true)
			@applied_jobs = ApplyStatus.select("c_name, job_title, status").where(jid: @jobs, cid: Current.candidate.id)
			render json: {
				jobs: @jobs,
				applied_jobs: @applied_jobs
			}
		else				# for non-logged-in members
			@jobs = Job.where(status: true)
			render json: {
				jobs: @jobs
			}
		end
	end
end