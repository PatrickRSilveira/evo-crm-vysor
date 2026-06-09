# frozen_string_literal: true

class KnowledgeDocumentChunk < ApplicationRecord
  belongs_to :knowledge_document

  validates :content, presence: true
end
