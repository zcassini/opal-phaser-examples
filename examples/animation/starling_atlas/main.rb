require 'opal'
require 'opal-phaser'

class Octopus
  def initialize(game)
    @game             = game
    @sprite_key       = "octopus"
    @sprite_url       = "assets/sprites/octopus.png"
    @sprite_xml_url   = "assets/sprites/octopus.xml"
    @animation_key    = "swim"
  end

  def preload
    # Here we load the Starling Texture Atlas and XML file
    @game.load.atlas_xml(@sprite_key, @sprite_url, @sprite_xml_url)
  end

  def create
    # A more suitable underwater background color
    @game.stage.background_color = '#1873CE'

    # Create our octopus
    @sprite = @game.add.sprite(300, 200, @sprite_key)

    # Create an animation called 'swim', the fact we don't specify any frames means it will use all frames in the atlas
    @swim = @sprite.animations.add(@animation_key)

    # Play the animation at 30fps on a loop
    @sprite.animations.play(@animation_key, 30, true)

    # Bob the octopus up and down with a tween
    @game.add.tween(@sprite).to(properties: { y: 300 }, duration: 2000, ease: Phaser::Easing::Quadratic.InOut, auto_start: true, delay: 0, repeat: 1000, yoyo: true)
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
    @octopus      = Octopus.new(game)
    @objects    = [@octopus]
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
