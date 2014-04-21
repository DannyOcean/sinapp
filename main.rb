require 'rubygems'
require 'sinatra'
Dir["#{File.dirname(__FILE__)}/labs/**/*.rb"].each { |f| load(f) }

get '/' do
  haml :index, layout: false
end

get '/lab1' do
  haml :lab1, locals: { action: "/lab1" }
end

post '/lab1' do
  cipher = Cipher.new
  if params[:action] == 'encrypt'
    cipher.encrypt(params[:phrase], params[:key])
  else
    cipher.decrypt(params[:phrase], params[:key])
  end
  @result = cipher.sub_phrase
  haml :lab1, locals: { result: @result, action: "/lab1" }
end

get '/lab2' do
  haml :lab2, locals: { action: "/lab2"}
end

post '/lab2' do
  permutator = Permutator.new
  if params[:action] == 'encrypt'
    permutator.encode(params[:phrase])
    @result = permutator.encoded_phrase
  else
    permutator.decode(params[:phrase])
    @result = permutator.decoded_phrase
  end
  haml :lab2, locals: { result: @result, action: "/lab2" }
end

get '/lab3' do
  haml :lab3, locals: { action: "/lab3" }
end

post '/lab3' do
  gamma = Gamma.new
  if params[:action] == 'encrypt'
    gamma.encrypt(params[:phrase], params[:key])
    @result = gamma.encrypted_phrase
  else
    gamma.decrypt(params[:phrase], params[:key])
    @result = gamma.decrypted_phrase
  end
  haml :lab3, locals: { result: @result, action: "/lab3" }    
end

get '/lab4' do
  haml :lab4, locals: { action: "/lab4" }
end

post '/lab4' do
  bc = BlockCipher.new
  if params[:action] == 'encrypt'
    bc.encrypt(params[:phrase], params[:key])
    @result = bc.encrypted_phrase
  else
    bc.decrypt(params[:phrase], params[:key])
    @result = bc.decrypted_phrase
  end
  haml :lab4, locals: { result: @result, action: "/lab4" }
end

get '/lab5' do
  haml :lab5, locals: { action: "/lab5" }
end

post '/lab5' do
  f = FeistelCipher.new
  if params[:action] == 'encrypt'
    f.encrypt(params[:phrase], params[:key])
    @result = f.encrypted_phrase
  else
    f.decrypt(params[:phrase], params[:key])
    @result = f.decrypted_phrase
  end
  haml :lab5, locals: { result: @result, action: "/lab5" }
end

get '/lab6' do
  haml :lab6, locals: { action: "/lab6" }
end

post '/lab6' do
  d = DES.new
  if params[:action] == 'encrypt'
    d.encrypt(params[:phrase], params[:key])
    @result = d.encrypted_phrase
  else
    d.decrypt(params[:phrase], params[:key])
    @result = d.decrypted_phrase
  end
  haml :labd, locals: { result: @result, action: "/lab6" }
end
