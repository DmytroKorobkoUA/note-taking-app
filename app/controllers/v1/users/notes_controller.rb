# frozen_string_literal: true

class V1::Users::NotesController < V1::AuthenticationController
  before_action :set_note, only: [:update, :destroy]
  before_action :authorize_request, only: [:create, :update, :destroy]

  def create
    @note = Note.new(note_params)
    @note.save!

    head :ok
  end

  def update
    if @note.update(note_params)
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy!

    head :ok
  end

  private

  def note_params
    params.permit :title, :content
  end

  def set_note
    @note = Note.find(params[:id])
  end
end
