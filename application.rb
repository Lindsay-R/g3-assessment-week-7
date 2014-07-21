require 'sinatra/base'
require 'gschool_database_connection'

require './lib/country_list'

require "rack-flash"
require "active_record"
require_relative "spec/lib/message_table"

class Application < Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @message_table = MessageTable.new(
      GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
    )
  end

  get '/' do
    erb :index
  end

  get '/continents' do
    all_continents = CountryList.new.continents
    erb :continents, locals: { continents: all_continents }
  end

  get '/continents/:continent_name' do
    list_of_countries = CountryList.new.countries_for_continent(params[:continent_name])
    erb :countries, locals: { countries: list_of_countries, continent: params[:continent_name] }
  end

  post "/message" do
    flash[:message] = "Data stuff goes here"
    @message_table.create(params[:name], params[:message])
    redirect "/"
  end


end