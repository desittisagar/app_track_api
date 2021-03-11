class AddOtpToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :otp, :integer
  end
end
