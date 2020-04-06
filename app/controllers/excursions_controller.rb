class ExcursionsController < ApplicationController


    get '/excursions' do
        @excursion = Excursion.all
        erb :"/excursions/index"
    end

    get '/excursions/new' do
    if !Helpers.is_logged_in?(session)
        redirect to '/'
    end
    erb :"/excursions/new"
end


post '/excursions' do
    excursion = Excursion.create(params)
    user = Helpers.current_user(session)
    excursion.user = user
    excursion.save
    redirect to "/users/#{user.id}"
end

get 'excursions/:id' do
    if !Helpers.is_logged_in?(session)
        redirect to '/'
    end 
    @excursion = Excursion.find_by(id: params[:id])
    if !@excursion
        redirect to '/excursions'
    end

    erb :'excursions/show'
end

get '/excursions/:id/edit' do
    if !Helpers.is_logged_in?(session) || if @excursion.user != Helpers.current_user(session)
        redirect to '/'
    end
    @excursion = Excursion.find_by(id: params[:id])
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




end