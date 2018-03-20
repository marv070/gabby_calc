require "sinatra"
#first use 'require_relative' for the files needed to use the math methods(need to be in same folder as app.rb)
require_relative "sub.rb"
require_relative "mult.rb"
require_relative "add.rb"
require_relative "div.rb"
#enable sessions since they are disabled by default
enable :sessions

get "/" do # directs to the home page (root directory). 'get' goes to a page
	session[:msg] = ""
	erb :loginpage, locals: {msg: session[:msg]}  # directs from 'loginpage' erb(embedded ruby) file. (Shows something). SESSIONS ARE USED TO KEEP STATE.
end
post "/user_pass" do
	username = params[:username] # brings parameters from input forms, from the erb
	password = params[:password]
	if username == "Open" && password == "Saysme" #if the username entered is 'Open' AND the password is 'Saysme' it'll pass to 'Successful Login'
		session[:msg] = "Successful Login" #the session here keeps 'Successful Login' if every username and password passes
		redirect "/name?username=" + username + "&password=" + password #redirects to name(next one) and continues by adding on the username and password
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
		session[:msg] = "Error. The username or password that was entered is incorrect" #session message if usernames/passwords are incorrect(this again, keeps the state of the message & repeats the SAME message if given any incorrect words)
		erb :loginpage, locals: {msg: session[:msg]} #directs from  loginpage, locals:
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