require 'hashids'

module HashedIds
  extend ActiveSupport::Concern

  def short_hashid
    self.class.encode_short_hashid(id)
  end

  def long_hashid
    self.class.encode_long_hashid(id)
  end

  def to_param
    short_hashid
  end


  module ClassMethods
    def encode_short_hashid(id)
      Hashids.new(hashids_salt, 6).encode(id)
    end

    def decode_short_hashid(id)
      Hashids.new(hashids_salt, 6).decode(id).first
    end

    def encode_long_hashid(id)
      Hashids.new(hashids_salt, 20).encode(id)
    end

    def decode_long_hashid(id)
      Hashids.new(hashids_salt, 20).decode(id).first
    end

    private

    def hashids_salt
      Rails.application.class.parent_name + table_name
    end

  end

end
