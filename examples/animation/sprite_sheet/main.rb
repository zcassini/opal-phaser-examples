require 'opal'
require 'opal-phaser'

class Mummy
  def initialize(game)
    @game          = game
    @sprite_key    = "mummy"
    @sprite_url    = "assets/sprites/metalslug_mummy37x45.png"
    @animation_key = "walk"
  end

  def preload
    #  37x45 is the size of each frame
    #  There are 18 frames in the PNG - you can leave this value blank if the
    #  frames fill up the entire PNG, but in this case there are some
    #  blank frames at the end, so we tell the loader how many to load
    @game.load.spritesheet(@sprite_key, @sprite_url, 37, 45, 18);
  end

  def create
    @mummy = @game.add.sprite(300, 200, 'mummy');

    #  Here we add a new animation called 'walk'
    #  Because we didn't give any other parameters it's going to make an animation from all available frames in the 'mummy' sprite sheet
    @walk = @mummy.animations.add(@animation_key);

    #  And this starts the animation playing by using its key ("walk")
    #  30 is the frame rate (30fps)
    #  true means it will loop when it finishes
    @mummy.animations.play(@animation_key, 30, true);
  end
end

class Game
  def initialize
    @phaser_game  = Phaser::Game.new(width: 800, height: 600, renderer: Phaser::AUTO, parent: "example")
    state = MainState.new(@phaser_game)
    @phaser_game.state.add(:main, state, true)
  end
end

class MainState < Phaser::State
  def initialize(game)
    @mummy      = Mummy.new(game)
    @objects    = [@mummy]
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
