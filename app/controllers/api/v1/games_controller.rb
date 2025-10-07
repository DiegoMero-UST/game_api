class Api::V1::GamesController < ApplicationController
  before_action :set_game, only: [:show, :update, :destroy]

  # GET /api/v1/games
  def index
    @games = Game.includes(:player, :cards).order(created_at: :desc)
    
    games_data = @games.map do |game|
      {
        id: game.id,
        token: game.token,
        played: game.played?,
        form_submitted: game.form_submitted?,
        played_at: game.played_at,
        form_submitted_at: game.form_submitted_at,
        created_at: game.created_at,
        won_prize: game.won_prize&.name,
        player_picked_card: game.player&.picked_card,
        card_distribution: game.cards.ordered_by_position.map do |card|
          {
            position: card.position,
            prize: card.prize.name
          }
        end
      }
    end
    
    render json: {
      games: games_data,
      total: @games.count,
      played_games: @games.where(played: true).count,
      unplayed_games: @games.where(played: false).count
    }
  end

  # GET /api/v1/games/:token
  def show
    @game = Game.includes(:player, :cards).find_by!(token: params[:token])
    
    game_data = {
      id: @game.id,
      token: @game.token,
      played: @game.played?,
      form_submitted: @game.form_submitted?,
      played_at: @game.played_at,
      form_submitted_at: @game.form_submitted_at,
      created_at: @game.created_at,
      won_prize: @game.won_prize&.name,
      player_picked_card: @game.player&.picked_card,
      card_distribution: @game.cards.ordered_by_position.map do |card|
        {
          position: card.position,
          prize: card.prize.name
        }
      end
    }
    
    render json: game_data
  end

  # POST /api/v1/games
  def create
    begin
      @game = GameCreationService.create_game!
      
      render json: {
        id: @game.id,
        token: @game.token,
        played: @game.played?,
        form_submitted: @game.form_submitted?,
        created_at: @game.created_at,
        card_distribution: @game.cards.ordered_by_position.map do |card|
          {
            position: card.position,
            prize: card.prize.name
          }
        end
      }, status: :created
    rescue => e
      render json: { 
        error: "Failed to create game: #{e.message}" 
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/games/:token
  def update
    if @game.update(game_params)
      render json: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/games/:token
  def destroy
    @game.destroy
    head :no_content
  end

  private

  def set_game
    @game = Game.find_by!(token: params[:token])
  end

  def game_params
    params.require(:game).permit(:played, :form_submitted)
  end
end