# frozen_string_literal: true

class Api::V1::KnowledgeBasesController < Api::V1::BaseController
  before_action :set_knowledge_base, only: [:show, :update, :destroy]

  def index
    @knowledge_bases = Current.account.knowledge_bases
  end

  def show
  end

  def create
    @knowledge_base = Current.account.knowledge_bases.new(knowledge_base_params)

    if @knowledge_base.save
      render :show, status: :created
    else
      render json: { error: @knowledge_base.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def update
    if @knowledge_base.update(knowledge_base_params)
      render :show
    else
      render json: { error: @knowledge_base.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def destroy
    @knowledge_base.destroy!
    head :no_content
  end

  private

  def set_knowledge_base
    @knowledge_base = Current.account.knowledge_bases.find(params[:id])
  end

  def knowledge_base_params
    params.require(:knowledge_base).permit(:name, :description)
  end
end
