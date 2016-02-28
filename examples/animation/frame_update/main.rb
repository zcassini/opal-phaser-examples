require 'opal'
require 'opal-phaser'

class Mummy
  def initialize(game)
    @sprite_key    = "mummy"
    @sprite_url    = "assets/sprites/metalslug_mummy37x45.png"
    @animation_key = "walk"
    @game          = game
  end

  def preload
    @game.load.spritesheet(@sprite_key, @sprite_url, 37, 45, 18)
  end

  def create
    on_update = proc do
      @text.text = "Frame #{@animation_walk.frame}"
    end

    @sprite = @game.add.sprite(200, 360, @sprite_key, 5)
    @animation_walk = @sprite.animations.add(@animation_key)

    @animation_walk.enable_update = true
    @animation_walk.on_update.add(on_update)

    @animation_walk.play(5, true)

    @text = @game.add.text(300, 264, "Frame 1", { font: "28px Arial", fill: "#ff0044" });
  end
end

class Game
  def initialize
    @phaser_game  = Phaser::Game.new(width: 800, height: 600, renderer: Phaser::CANVAS, parent: "example")
    state = MainState.new(@phaser_game)
    @phaser_game.state.add(:main, state, true)
  end
end

class MainState < Phaser::State
  def initialize(game)
    @mummy      = Mummy.new(game)

    @objects    = [@mummy]
    @game       = game
  end

  def call_state_method(state)
    @objects.each { |object| object.send(state) }
  end

  def preload
    call_state_method :preload
  end

  def create
    call_state_method :create
  end
end

Game.new
