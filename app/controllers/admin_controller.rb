class AdminController < ApplicationController


	def joblist
		if session[:phone]
			@jobs = Job.all
			@candidates = Candidate.all
			@all_applied_jobs = ApplyStatus.select("cid, jid, c_name, job_title, status")
			render json: {
				jobs: @jobs,
				candidate: @candidates,
				all_applied_jobs: @all_applied_jobs
			}
		else
			render json: {
			status: 500,
			info: "Must need an Admin Login"
		}
		end
	end

	def create_job
		if session[:phone]
			@job = Job.new(job_params)
			if @job.save
				render json: {
					status: 200,
					info: "Job created"
				}
			else
				render json: {
					status: 500,
					errors: @job.errors
				}
			end
		else
			render json: {
				status: 500,
				info: "Need Admin login"
			}
		end
	end

	def edit_job
		if session[:phone]
			@job = Job.find_by(id: params[:id])
			if @job.present?
				if @job.update(edit_job_status)
					render json: {
						status: 200,
						info: :status_changed,
						job: @job
					}
				else
					render json: {
						status: 500,
						info: "Validation errors"
					}
				end
			else
				render json: {
					status: 500,
					info: "Job does not exist"
				}
			end
		else
			render json: {
				status: 500,
				info: "Need Admin Login"
			}
		end
	end

	def update_candidate_status
		if session[:phone]
			@can = ApplyStatus.find_by(jid: params[:job_id], cid: params[:can_id])
			puts "errors", @can
			if @can.present?
				if @can.update(cand_job_status)
					@status = ApplyStatus.find_by(jid: params[:job_id], cid: params[:can_id])
					if @status.status == true
						render json: {
							status: 200,
							info: "Candidate Selected, Email trigger."
						}
					else						
						render json: {
							status: 200,
							info: :status_changed
						}
					end
				else
					render json: {
						status: 500
					}
				end
				#puts "YES"
			else
				render json: {
					status: 500,
					info: "No available job(s) for this Candidate"
				}
			end
		else
			render json: {
				status: 500,
				info: "Need Admin Login"
			}
		end
	end

	private

	def job_params
		params.permit(:title, :category, :yoe, :status)
	end

	def edit_job_status
		params.permit(:status)
	end

	def cand_job_status
		params.permit(:status)
	end


end