class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  post '/figures' do
    figure = Figure.create(params[:figure])
    if !params[:title][:name].empty?
      title = Title.create(params[:title])
      FigureTitle.create(title_id: title.id, figure_id: figure.id)
    else
      FigureTitle.create(title_id: params[:figure][:title_id], figure_id: figure.id)
    end
    if !params[:landmark][:name].empty?
      params[:landmark][:figure_id] = figure.id
      figure.landmarks << Landmark.create(params[:landmark])
      figure.save
    end
    redirect '/figures'
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end

  patch "/figures/:id" do
    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]
    @figure.save
    params[:figure][:title_ids].each do |id|
      FigureTitle.create(title_id: id, figure_id: @figure.id)
    end
    params[:figure][:landmark_ids].each do |id|
      @figure.landmarks << Landmark.find(id)
    end
    @figure.save
    erb :'/figures/show'
  end

end
