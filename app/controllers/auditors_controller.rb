class AuditorsController < ApplicationController
	include HTTParty
  base_uri 'https://lion-api.herokuapp.com'

	def index
		@response = self.class.get('/individuals', body: { "access-token" => session[:token], client: session[:client], uid: session[:uid] })
		# connection_verify(@response.headers)
		@individuals = @response.parsed_response
	end

	def login
	end

	def sign_in
		@response = self.class.post('/auth/sign_in', body: { email: params[:email], password: params[:password] } )
		if @response["errors"]
			flash[:error] = @response["errors"][0]
			render :login
		elsif @response.parsed_response["data"]["auditor"]
			session[:token] = @response.headers["access-token"]
			session[:client] = @response.headers["client"]
			session[:uid] = @response.headers["uid"]
			redirect_to root_path
		else
			flash[:error] = "You're not an auditor."
			render :login
		end
	end

	def individuals_by_city_report
    @response = self.class.get("/individuals/#{params[:city]}/by_city", body: { "access-token" => session[:token], client: session[:client], uid: session[:uid] })
  end

  def individuals_by_goods_value_report
  	@response = self.class.get('/individuals/by_goods_value', body: { "access-token" => session[:token], client: session[:client], uid: session[:uid] })
  end

	private
	def connection_verify(headers)
		if headers["access-token"]
			session[:token] = headers["access-token"]
			session[:client] = headers["client"]
			session[:uid] = headers["uid"]
		else
			session[:token] = nil
			session[:client] = nil
			session[:uid] = nil
			redirect_to auditors_login_path
		end
	end
end
