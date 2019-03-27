require 'ruby2d'

module View 
  class Ruby2dView 

    def initialize 
      @pixel_size = 50 
    end

    def get_dsl
      extend Ruby2D::DSL
    end

    def render state
      get_dsl
      set(
        title: 'Snake', 
        width: @pixel_size * state.grid.cols, 
        height: @pixel_size * state.grid.rows
      )
      render_snake(state)
      render_food(state)
      show
    end

    private
      def render_snake state
        get_dsl
        snake = state.snake
        snake.positions.each do |pos|
          Square.new(
            x: pos.col * @pixel_size,
            y: pos.row * @pixel_size,
            size: @pixel_size,
            color: 'green'
          )
        end
      end

      def render_food state
        get_dsl
        food = state.food
        Square.new(
          x: food.col * @pixel_size,
          y: food.row * @pixel_size,
          size: @pixel_size,
          color: 'yellow',
        )
      end
  end
end