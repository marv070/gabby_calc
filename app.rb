require "sinatra"
require_relative "Subtraction.rb"
require_relative "Multiplication.rb"
require_relative "Addition.rb"
require_relative "Division.rb"
enable :sessions

get "/" do 
	session[:msg] = ""
	erb :loginpage, locals: {msg: session[:msg]}
end
post "/user_pass" do
	username = params[:username] 
	password = params[:password]
	if username == "Open" && password == "Saysme"
		session[:msg] = "Successful Login"
		redirect "/name?username=" + username + "&password=" + password
	elsif username == "Mined" && password == "Minds"
		session[:msg] = "Successful Login"
		redirect "/name?username=" + username + "&password=" + password
	elsif username == "Powdered" && password == "Doughnut"
		session[:msg] = "Successful Login"
		redirect "/name?username=" + username + "&password=" + password
	elsif username == "Prim" && password == "Rose"
		session[:msg] = "Successful Login"
		redirect "/name?username=" + username + "&password=" + password
	else
		session[:msg] = "Error. The username or password that was entered is incorrect"
		erb :loginpage, locals: {msg: session[:msg]}
	end
end

get "/name" do
	erb :fullname, locals:{msg:session[:msg]}
end
post "/fullname" do
	first = params[:f_name]
	last = params[:l_name]
	redirect "/numbers?f_name="+ first + "&l_name=" + last
end

get "/numbers" do
	first = params[:f_name]
	last = params[:l_name]
	erb :equation_choice, locals:{f_name:first, l_name:last}
end

post "/choice" do
	first = params[:f_name]
	last = params[:l_name]
	num1 = params[:number_1]
	num2 = params[:number_2]
	session[:method_choice] = params[:method]
	if session[:method_choice] == "+"
		session[:results] = addition(num1.to_i, num2.to_i)
	elsif session[:method_choice] == "-"
		session[:results] = subtraction(num1.to_i, num2.to_i)
	elsif session[:method_choice] == "/"
		session[:results] = division(num1.to_i, num2.to_i)
	elsif session[:method_choice] == "*"
		session[:results] = multiply(num1.to_i, num2.to_i)
	end
	redirect "/results?f_name="+ first + "&l_name=" + last + "&num1=" + num1 + "&num2=" + num2
end	

get "/results" do
	first = params[:f_name]
	last = params[:l_name]
	num1 = params[:num1]
	num2 = params[:num2]
	erb :results, locals:{f_name: first, l_name: last, num1:num1, num2:num2, results:session[:results].to_s, method_type:session[:method_choice]}
end

post '/return' do
	session[:msg] = "Welcome Back!"
	erb :loginpage, locals:{msg:session[:msg]}
end