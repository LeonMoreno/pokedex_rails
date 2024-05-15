class PokemonSerializer < ActiveModel::Serializer
  attributes  :num, :name, :type_1, :type_2, :total, :hp,
              :attack, :defense, :sp_atk, :sp_def, :speed, :generation, :legendary

  def attributes(*args)
    hash = super

    if instance_options[:only]
      hash.slice!(:num, :name)
    end
    hash
  end
end
