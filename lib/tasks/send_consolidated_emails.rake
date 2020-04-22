desc "Send Consolidated emails"
task send_consolidated_emails: :environment  do
  User.find_each do |user|
    UserMailer.send_consolidated_email(user).deliver_later
  end
end