class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all  
    erb :'/pets/new'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  post '/pets' do 
    @pet = Pet.create(name: params["pet_name"])
    if params["owner_id"]
      @owner = Owner.find(params["owner_id"])
    else  
      @owner = Owner.create(name: params["owner_name"])
    end
    @owner.pets << @pet
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    # ####### bug fix
    # if !params[:pet].keys.include?("owner_id")
    #   params[:pet]["owner"] = []
    # end
    # #######
    
    @pet = Pet.find(params[:id])
    @pet.update(name: params["pet_name"])
    if !params["owner_name"].empty?
      @pet.update(owner: Owner.create(name: params["owner_name"]))
    else
      @pet.update(owner_id: params["owner_id"])
    end
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end
end