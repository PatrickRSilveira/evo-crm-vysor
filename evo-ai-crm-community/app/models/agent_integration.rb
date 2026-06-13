# frozen_string_literal: true

class AgentIntegration < ApplicationRecord
  self.table_name = 'evo_core_agent_integrations'

  # The column is `agent_id` which references `agent_bots.id`.
  belongs_to :agent_bot, foreign_key: 'agent_id'
end
