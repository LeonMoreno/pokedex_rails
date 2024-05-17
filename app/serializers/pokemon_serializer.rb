class PokemonSerializer < ActiveModel::Serializer
  attributes  :id, :natpoke_num, :name, :type, :total, :hp,
              :attack, :defense, :sp_atk, :sp_def, :speed, :generation, :legendary


  def natpoke_num
    object.num
  end

  def type
    [object.type_1, object.type_2]
  end

  def attributes(*args)
    hash = super

    if instance_options[:only]
      hash.slice!(:natpoke_num, :name, :type)
    end
    hash
  end
end
