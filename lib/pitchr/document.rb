module Pitchr

  # base model
  module Document
    extend ActiveSupport::Concern
    include Mongoid::Document
    include Mongoid::Timestamps

    module ClassMethods
      # return a document that matches a single id
      def by_id(id)
        by_ids(id).first
      end

      # look for an id, throwing an exception if not found
      def by_id!(id)
        by_id(id) || (raise Mongoid::Errors::DocumentNotFound.new(self, id))
      end

      # return documents that match a list of ids
      def by_ids(*ids)
        # pick the valid ids
        ids = ids.flatten.map{|id| id.to_s}.select{|id| BSON::ObjectId.legal?(id) }

        # send it off to mongoid
        self.criteria.for_ids(*ids)
      end
    end

    def to_param
      id.to_s
    end

    protected

      # returns a list of matching objects for ids, in the order given
      def fetch_ids(model, ids)
        mapping = {}

        # find the matching records
        matches = model.any_in(:_id => ids.to_a)

        # add in conditions that are defined in the block
        matches = yield(matches) if block_given?

        # reorder
        matches.each{|record| mapping[record.id.to_s] = record }

        # restore the order of the tiles
        ids.map{|id| mapping[id.to_s]}.compact
      end

      # send a mongodb query to the current document
      def update_document(fields, safe = false)
        collection.update({"_id" => self.id}, fields, :safe => safe)
        reload
      end
  end
end
