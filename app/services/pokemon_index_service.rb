# frozen_string_literal: true

class PokemonIndexService
  def initialize(pokes, request)
    puts "count = #{pokes.count}"

    @pokes = pokes
    @request = request
  end

  def res

    host = @request.host_with_port
    path = @request.fullpath.split("=")[0]

    poke_res = Hash.new
    poke_res["total Pokemons:"] = @pokes.count
    poke_res["total Pages:"] = @pokes.total_pages
    poke_res["next:"] = "#{path}=#{@pokes.next_page}"
    
    serializer_options = {}
    serializer_options[:each_serializer] = PokemonSerializer
    serializer_options[:only] = true
    poke_res["List Pokemons:"] = ActiveModelSerializers::SerializableResource.new(@pokes, serializer_options)
    poke_res
  end
end