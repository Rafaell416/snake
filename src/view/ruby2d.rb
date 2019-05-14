require 'ruby2d'
require_relative '../model/state'

module View 
  class Ruby2dView 

    def initialize(app)
      @pixel_size = 50 
      @app = app
    end

    def get_dsl
      extend Ruby2D::DSL
    end

    def start state
      get_dsl
      set(
        title: 'Snake', 
        width: @pixel_size * state.grid.cols, 
        height: @pixel_size * state.grid.rows
      )
      on :key_down do |event|
        handle_key_event(event)
      end
      show
    end

    def render state
      render_snake(state)
      render_food(state)
    end

    private
      def render_snake state
        @snake_positions.each(&:remove) if @snake_positions
        get_dsl
        snake = state.snake
        @snake_positions = snake.positions.map do |pos|
          Square.new(
            x: pos.col * @pixel_size,
            y: pos.row * @pixel_size,
            size: @pixel_size,
            color: 'green'
          )
        end
      end

      def render_food state
        @food.remove if @food
        get_dsl
        food = state.food
        @food = Square.new(
          x: food.col * @pixel_size,
          y: food.row * @pixel_size,
          size: @pixel_size,
          color: 'yellow',
        )
      end

      def handle_key_event event
        case event.key
        when 'up'
          @app.send_action(:change_direction, Model::Direction::UP)
          #move up
        when 'down'
          @app.send_action(:change_direction, Model::Direction::DOWN)
          #move down
        when 'left'
          @app.send_action(:change_direction, Model::Direction::LEFT)
          #move left
        when 'right'
          @app.send_action(:change_direction, Model::Direction::RIGHT)
          #move right  
        end
      end
      
  end
end