class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all

    erb :'figures/index'
  end

  get '/figures/new' do
    #I don't think I need all these
    @figure_titles = FigureTitle.all
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new'
  end

  post '/figures' do
    figure = Figure.create(params["figure"])
    if !params["landmark"]["name"].empty?
      landmark = Landmark.create(params["landmark"])
      figure.landmarks << landmark
    end
    if !params["title"]["name"].empty?
      title = Title.create(params["title"])
      figure.titles << title
    end
    figure.save
  end

  get '/figures/:id' do

    @figure = Figure.find(params[:id])

    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all

    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    figure = Figure.find(params[:id])
    figure.update(params["figure"])
    if !params["landmark"]["name"].empty?
      landmark = Landmark.create(params["landmark"])
      figure.landmarks << landmark
    end
    if !params["title"]["name"].empty?
      title = Title.create(params["title"])
      figure.titles << title
    end
    figure.save
    redirect "figures/#{figure.id}"
  end

end
