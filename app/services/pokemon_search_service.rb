# frozen_string_literal: true

class PokemonSearchService
  class << self
    def search(params)
      pokes = Pokemon.where('name LIKE ?', "%#{params[:name]}%")
      pokes = pokes.paginate(page: params[:page], per_page: 25)

      serializer_options = make_serializer_options
      make_response(pokes, serializer_options)
    end

    private

    def make_response(pokes, serializer_options)
      {
        'total Pokemons find': pokes.count,
        'total Pages': pokes.total_pages,
        next: pokes.next_page || nil,
        'List Pokemons': ActiveModelSerializers::SerializableResource.new(pokes, serializer_options)
      }.compact
    end

    def make_serializer_options
      {
        each_serializer: PokemonSerializer,
        only: true
      }.compact
    end
  end
end
