class LandmarksController < ApplicationController
  get '/landmarks' do
    @landmarks = Landmark.all
    erb :"/landmarks/index"
  end

  post '/landmarks' do
    #get params and make new landmark
    @landmark=Landmark.create(params[:landmark])
    #redirect to landmark/id
    redirect "/landmarks/#{@landmark.id}"
  end

  get '/landmarks/new' do
    erb :"landmarks/new"
  end

  get '/landmarks/:id/edit' do
    @landmark=Landmark.find(params[:id])
    erb :"landmarks/edit"
  end

  patch '/landmarks/:id' do
    # update particular landmark
    # STDERR puts "********************"
    # STDERR puts "********************#{params}"
    @landmark=Landmark.find(params[:id])
    @landmark.update(params[:landmark])
    # STDERR puts "**************#{@landmark}"
    # redirect to ladnmark/:id
    redirect "/landmarks/#{@landmark.id}"
  end

  get '/landmarks/:id' do
    #find landmark and make instance varaible
    @landmark=Landmark.find(params[:id])
    erb :"landmarks/show"
  end


end
