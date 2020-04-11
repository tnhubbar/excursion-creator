class ExcursionsController < ApplicationController


    get '/excursions/' do
        @excursions = Excursion.all
        erb :"/excursions/index"
    end

    get '/excursions/new' do
    if !Helpers.is_logged_in?(session)
        redirect to '/'
    end
    erb :"/excursions/new"
end


post '/excursions/' do
    excursion = Excursion.new(name: params[:excursion][:name], description: params[:excursion][:description], days_duration: params[:excursion][:days_duration])
    user = Helpers.current_user(session) 
    excursion.user = user 
    excursion.save
    
    params[:excursion][:places].each do |place|
       p = Place.create(place)
       p.excursion = excursion
       p.save
    end

    @places = Place.all 

    redirect to "/users/#{user.id}"
end

get '/excursions/:id' do
    if !Helpers.is_logged_in?(session)
        redirect to '/'
    end 
    @excursion = Excursion.find_by(id: params[:id])
    @places = @excursion.places
    if !@excursion
        redirect to '/excursions'
    end
    erb :'/excursions/show'
end

get '/excursions/:id/edit' do
    @excursion = Excursion.find_by(id: params[:id])
    if !Helpers.is_logged_in?(session) || if @excursion.user != Helpers.current_user(session)
        redirect to '/'
    end
end
    erb :'/excursions/edit'
end

patch '/excursions/:id' do
  excursion = Excursion.find_by(id: params[:id])
  if excursion && excursion.user == Helpers.current_user(session)
    excursion.update(name: params[:name], description: params[:description], days_duration: params[:days_duration])
    redirect to "/excursions/#{excursion.id}"
  else 
    redirect to "/excursions"
  end
end

delete '/excursions/:id/delete' do
    @excursion = Excursion.find_by_id(params[:id])
    if @excursion && @excursion.user == Helpers.current_user(session)
        @excursion.delete
        redirect to "/"
    end
end

end