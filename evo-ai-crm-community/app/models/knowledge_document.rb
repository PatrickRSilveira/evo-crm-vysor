# frozen_string_literal: true

class KnowledgeDocument < ApplicationRecord
  belongs_to :knowledge_base
  has_many :knowledge_document_chunks, dependent: :destroy

  validates :title, presence: true
end
