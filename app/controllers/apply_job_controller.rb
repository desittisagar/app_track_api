class ApplyJobController < ApplicationController

	before_action :require_candidate_login!

	def create
		#params[:job_id]
		@job = Job.find_by(id: params[:job_id], status: true)
		# puts "job id"
		# puts @job,"i"
		if @job.present?
			@cids = ApplyStatus.where(cid: Current.candidate.id)
			if @cids.find_by(jid: params[:job_id])
				render json: {
					status: 200,
					info: "already applied"
				}
			else
				puts "ELSE"
				@apply = ApplyStatus.create({
					jid: params[:job_id], 
					cid: Current.candidate.id, 
					job_title: @job.title,
					c_name: Current.candidate.name,
					status: false
				})
				render json: {
					status: :created
				}
			end
		else
			render json:{
				status: 500,
				info: "Job is inactive."
			}
		end
	end
end