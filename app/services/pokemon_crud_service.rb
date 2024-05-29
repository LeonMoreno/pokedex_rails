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
    path = request.fullpath.split('=')[0]
    path = make_path(path)

    serializer_options = make_serializer_options
    make_response(path, serializer_options)
  end

  def show
    if poke_id.is_a?(Integer)
      Pokemon.find_by(id: poke_id)
    elsif poke_id.is_a?(String)
      Pokemon.find_by(name: poke_id)
    end
  end

  def create
    poke = Pokemon.find_or_initialize_by(name: params[:pokemon][:name])

    poke.new_record? ? poke_save(poke) : nil
  end

  def update
    puts "params = #{params}"
    poke_to_update = Pokemon.find_by(id: params[:id])

    poke_to_update.nil? ? nil : poke_save(poke_to_update)
  end

  def delete
    poke = Pokemon.find_by(id: params[:id])

    poke.nil? ? nil : poke.destroy
  end

  private

  def make_path(path)
    return path if path.include?('?page')

    "#{path}?page"
  end

  def make_response(path, serializer_options)
    {
      'total Pokemons:' => pokes.count,
      'total Pages:' => pokes.total_pages,
      'next:' => pokes.next_page ? "#{path}=#{pokes.next_page}" : nil,
      'previous:' => pokes.previous_page ? "#{path}=#{pokes.previous_page}" : nil,
      'results:' => ActiveModelSerializers::SerializableResource.new(pokes, serializer_options)
    }.compact
  end

  def make_serializer_options
    {
      'each_serializer:' => PokemonSerializer,
      'only:' => true
    }.compact
  end

  def poke_save(poke_to_save)
    poke_new_data = params[:pokemon]

    poke_new_data.each_pair { |key, value| poke_to_save[key] = value }
    poke_to_save.save
    poke_to_save
  end
end