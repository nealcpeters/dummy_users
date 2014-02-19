get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/:username/home' do
	p session
  @user = User.where(email: params[:username]).first
  erb :secret
end

post '/sign_in' do

  redirect to("/#{email}/home")
end

post '/sign_up' do
  p params
  redirect to('/') if validate_password(params[:password], params[:password_confirmation]) == false
  User.create(name: params[:name], email: params[:email], password: params[:password])
  redirect to("/#{params[:email]}/home")
end
