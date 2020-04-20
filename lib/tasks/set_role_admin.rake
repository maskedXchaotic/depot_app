desc "Set particualr users role to admin whose email is supplied"
task set_role_admin: :environment  do
  user  = User.find_by(email: ENV["email"])
  user.role = 'admin'
  user.save
end