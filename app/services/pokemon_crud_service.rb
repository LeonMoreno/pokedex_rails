# frozen_string_literal: true

class PokemonCrudService
  attr_reader :pokes, :poke_id, :request, :params

  def initialize(request = nil, params = nil)
    @pokes = Pokemon.paginate(page: params[:page], per_page: 25) unless params[:page].nil?
    @request = request unless request.nil?
    @poke_id = params[:id] unless params[:id].nil?
    @params = params
  end

  def index
    host = request.host_with_port
    path = request.fullpath.split("=")[0]

    path.include?("?page") ? path = path : path = "#{path}?page"

    poke_res = Hash.new
    poke_res["total Pokemons:"] = pokes.count
    poke_res["total Pages:"] = pokes.total_pages
    poke_res["next:"] = "#{path}=#{pokes.next_page}"
    
    serializer_options = {}
    serializer_options[:each_serializer] = PokemonSerializer
    serializer_options[:only] = true
    poke_res["List Pokemons:"] = ActiveModelSerializers::SerializableResource.new(pokes, serializer_options)
    poke_res
  end

  def show 
    if poke_id.is_a?(Integer)
      Pokemon.find_by(num: poke_id)
    elsif poke_id.is_a?(String)
      Pokemon.find_by(name: poke_id)
    end
  end

  def create
    poke = Pokemon.find_or_initialize_by(name: params[:pokemon][:name])

    poke.new_record? ? poke_save(poke) : nil
  end

  def update
    poke_to_update = Pokemon.find_by(name: params[:pokemon][:name])

    poke_to_update.nil? ? nil : poke_save(poke_to_update)
  end

  private
  
  def poke_save(poke_to_save)
    poke_new_data = params[:pokemon]

    poke_new_data.each_pair { |key, value| poke_to_save[key] = value }
    poke_to_save.save
    poke_to_save
  end
end