class RecipesController < ApplicationController
    skip_before_action :require_login, only: [:index, :show]
    before_action :find_recipe, except: [:index, :new, :create]
    before_action :correct_user, only: [:edit, :update, :destroy]

    def index
        @recipes = Recipe.all
    end

    def show
    end

    def new
        @recipe = Recipe.new
        @recipe.instructions.build
        @recipe.ingridients.build
        
    end

    def create
        @recipe = Recipe.create(recipe_params)
        @recipe.user = current_user
            
        if @recipe.save
            redirect_to root_path
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @recipe.update(recipe_params)
            redirect_to @recipe
        else
            render :edit
        end
    end

    def destroy
        if @recipe.destroy
            redirect_to root_path
        else
            render @recipe
        end
    end

    private 

    def recipe_params
        params.require(:recipe).permit(:title, :description,
            instructions_attributes: [:id, :order, :instruction_info, :_destroy],
            ingridients_attributes: [:id, :name, :_destroy])
    end

    def find_recipe
        @recipe = Recipe.find(params[:id])
    end

    def correct_user
        unless user_equals?(@recipe.user)
            flash[:danger] = 'You dont have permission!'
            redirect_to root_path and return
        end
    end
end
