desc "Set particualr users role to admin whose email is supplied"
task set_role_admin: :environment  do
  user  = User.find_by(email: ENV["email"])
  if user
    user.role = 'admin'
    if user.save
      puts 'role changed to admin'
    else
      puts 'Role change failed'
      puts user.errors
    end
  else
    puts 'No user found with particular email'
  end
end