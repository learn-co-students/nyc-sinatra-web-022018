class FiguresController < ApplicationController
	get '/figures' do 
		@figures = Figure.all
		erb :'/figures/index'
	end

	get '/figures/new' do
		@landmarks = Landmark.all
		@titles = Title.all

		erb :'/figures/new'
	end

	get '/figures/:id' do
		@figure = Figure.find(params[:id])
		erb :'/figures/show'
	end

	get '/figures/:id/edit' do
		@landmarks = Landmark.all
		@titles = Title.all

		@figure = Figure.find(params[:id])
		erb :'/figures/edit'
	end

	post '/figures' do
		@figure = Figure.create(params[:figure])
		if !params[:landmark][:name].empty?
			landmark = Landmark.create(params[:landmark])
			landmark.figure = @figure
			@figure.landmarks << landmark
		end
		if !params[:title][:name].empty?
			title = Title.create(params[:title])
			title.figures << @figure
			@figure.titles << title
		end
		redirect "/figures/#{@figure.id}"
	end

	patch '/figures/:id' do
		@figure = Figure.find(params[:id])
		@figure.update(params[:figure])
		if !params[:landmark][:name].empty?
			landmark = Landmark.create(params[:landmark])
			landmark.figure = @figure
			@figure.landmarks << landmark
		end
		if !params[:title][:name].empty?
			title = Title.create(params[:title])
			title.figures << @figure
			@figure.titles << title
		end
		redirect "/figures/#{@figure.id}"
	end
end
