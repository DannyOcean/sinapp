require 'rubygems'
require 'sinatra'
require './lab_1_1'
require './lab_1_2'
require './lab_1_3'

get '/stylesheets/:name.css' do
 content_type 'text/css', :charset => 'utf-8'
 sass(:"stylesheets/#{params[:name]}")
end

get '/' do
  haml :index, layout: false
end

get '/lab1' do
  haml :lab1
end

post '/lab1' do
  @cipher = Cipher.new
  if params[:action] == 'encrypt'
    @cipher.encrypt(params[:phrase], params[:key])
  else
    @cipher.decrypt(params[:phrase], params[:key])
  end
  @result = @cipher.sub_phrase
  haml :lab1, locals: { result: @result }
end

get '/lab2' do
  haml :lab2
end

post '/lab2' do
  @permutator = Permutator.new
  if params[:action] == 'encrypt'
    @permutator.encode(params[:phrase])
    @result = @permutator.encoded_phrase
  else
    @permutator.decode(params[:phrase])
    @result = @permutator.decoded_phrase
  end
  haml :lab2, locals: { result: @result }
end

get '/lab3' do
  haml :lab3
end

post '/lab3' do
  @gamma = Gamma.new
  if params[:action] == 'encrypt'
    @gamma.encrypt(params[:phrase], params[:key])
    @result = @gamma.encrypted_phrase
  else
    @gamma.decrypt(params[:phrase], params[:key])
    @result = @gamma.decrypted_phrase
  end
  haml :lab3, locals: { result: @result }    
end