# frozen_string_literal: true

class V1::NotesController < V1Controller
  before_action :set_note, only: [:show]

  def index
    @notes = Note.search(params[:search])

    render json: @notes
  end

  def show
    render json: @note
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end
end
