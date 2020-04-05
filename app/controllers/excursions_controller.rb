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




end