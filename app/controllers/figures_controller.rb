class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    # binding.pry
    if params[:title][:name]
      @title = Title.create(name: params[:title][:name])
      @figure.titles << @title
    end
    #     # params[:figure][:title_ids].each do |t|
    #     #
    #     # end
    if params[:landmark][:name]
      @landmark = Landmark.create(name: params[:landmark][:name])
      @figure.landmarks << @landmark
    end
    # params[:figure][:landmark_ids].each do |t|
    #
    # end

    # binding.pry
    redirect to "/figures/#{@figure.id}"
    # redirect to "/recipes/#{@recipe.id}"

  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  get '/figures/:id/edit' do
    @titles = Title.all
    @landmarks = Landmark.all
    @figure=Figure.find(params[:id])
    erb :'/figures/edit'
  end

  get '/figures/:id' do

    @figure=Figure.find(params[:id])
    erb :'figures/show'
  end

  patch '/figures/:id' do
    # binding.pry
    # figure"=>
    #   {"name"=>"COOL DIDDY",
    #    "title_ids"=>["4", "5"],
    #    "landmark_ids"=>["6", "7"]},

    @figure=Figure.find(params[:id])
    @figure.update(params[:figure])

    ##################################################if new title

    if params[:title][:name]
      @title = Title.create(name: params[:title][:name])
      @figure.titles << @title
    end
    if !params[:figure][:title_ids].nil? && params[:figure][:title_ids].size > 0
      params[:figure][:title_ids].each {|tid| @figure.titles << Title.find(tid)  if !@figure.titles.include?(Title.find(tid))}
    end
    ##################################################if new landmark
    if params[:landmark][:name]
      # STDERR puts "**********NEW Landmark"
      # binding.pry
      # STDERR puts "**********NEW Landmark:name->#{params}"
      @landmark = Landmark.create(name: params[:landmark][:name])

      # STDERR puts "**********NEW Landmark:name->#{@landmark.name}"
      @figure.landmarks << @landmark
    end
    if !params[:figure][:landmark_ids].nil? && params[:figure][:landmark_ids].size > 0
      params[:figure][:landmark_ids].each {|lid| @figure.landmarks << Landmark.find(lid)  if !@figure.landmarks.include?(Landmark.find(lid))}
    end
    ##############update figure

    redirect to "/figures/#{@figure.id}"
  end

end
