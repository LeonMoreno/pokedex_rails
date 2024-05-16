# frozen_string_literal: true

class PokemonSearchService
  def self.search(params)
    res = Hash.new
    
    pokes = Pokemon.where('name LIKE ?', "%#{params[:name]}%")
    pokes = pokes.paginate(page: params[:page], per_page: 25)
    res["total Pokemons find: "] = pokes.count
    res["total Pages: "] = pokes.total_pages
    res["next:"] = pokes.next_page if pokes.next_page
    
    serializer_options = {}
    serializer_options[:each_serializer] = PokemonSerializer
    serializer_options[:only] = true
    res["List Pokemons:"] = ActiveModelSerializers::SerializableResource.new(pokes, serializer_options)
    res
  end
end