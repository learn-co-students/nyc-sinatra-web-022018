require 'pry'
class FiguresController < ApplicationController

get '/figures/new' do
  @titles = Title.all
  @landmarks = Landmark.all
  erb :'/figures/new'
end
get '/figures' do
  # binding.pry
  @figures = Figure.all
  erb :'/figures/index'
end

post '/figures' do
  @figure = Figure.create(params[:figure])
    if !params[:title][:name].empty?
      title = Title.create(params[:title])
      @figure.figure_titles << FigureTitle.create(figure_id: @figure.id, title_id: title.id)
    end
    if !params[:landmark][:name].empty?
      landmark = Landmark.create(params[:landmark])
      @figure.landmarks << landmark
    end
  @figure.save
  redirect to "/figures/#{@figure.id}"
  end
  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/show'
  end
  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb  :'/figures/edit'
  end
  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    if !params[:title][:name].empty?
      title = Title.create(params[:title])
      @figure.figure_titles << FigureTitle.create(figure_id: @figure.id, title_id: title.id)
    end
    if !params[:landmark][:name].empty?
      landmark = Landmark.create(params[:landmark])
      @figure.landmarks << landmark
    end
    @figure.update(params["figure"])
    redirect to "/figures/#{@figure.id}"
  end


end
