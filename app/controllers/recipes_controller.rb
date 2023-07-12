class RecipesController < ApplicationController
	def index
    @recipes = Recipe.all
  end

  def search
    @recipes = Recipe.search(params[:cuisine], params[:ingredient])
    if @recipes.empty?
      flash.now[:notice] = 'No recipes found.'
    end
  end
end
