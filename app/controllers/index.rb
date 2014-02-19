get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/:username/home' do
  @user = User.where(email: params[:username]).first
	redirect to('/') if session[:user_id] != @user.id
  erb :secret
end

post '/sign_in' do
  redirect to('/') if User.where(email: params[:email]).empty?
  @user = User.where(email: params[:email]).first
  redirect to('/') if @user.password != params[:password]
  session[:user_id] = @user.id
  redirect to("/#{params[:email]}/home")
end

post '/sign_up' do
  p params
  redirect to('/') if validate_password(params[:password], params[:password_confirmation]) == false
  user = User.create(name: params[:name], email: params[:email], password: params[:password])
  session[:user_id] = user.id
  redirect to("/#{params[:email]}/home")
end

post '/logout' do
  session[:user_id] = nil
  redirect to('/')
end

