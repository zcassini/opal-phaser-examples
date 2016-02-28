require 'opal'
require 'opal-phaser'
#  Texture Atlas Method 2
#
#  In this example we assume that the TexturePacker JSON data is a real json
#  object stored as a variable (in this case bot_data)

class Bot
  def initialize(game)
    @game = game

    # We wrap the json in `backticks` to make it a javascript object
    @bot_data = `{
    "frames": [
      {
        "filename": "running bot.swf/0000",
        "frame": { "x": 34, "y": 128, "w": 56, "h": 60 },
        "rotated": false,
        "trimmed": true,
        "spriteSourceSize": { "x": 0, "y": 2, "w": 56, "h": 60 },
        "sourceSize": { "w": 56, "h": 64 }
      },
      {
        "filename": "running bot.swf/0001",
        "frame": { "x": 54, "y": 0, "w": 56, "h": 58 },
        "rotated": false,
        "trimmed": true,
        "spriteSourceSize": { "x": 0, "y": 3, "w": 56, "h": 58 },
        "sourceSize": { "w": 56, "h": 64 }
      },
      {
        "filename": "running bot.swf/0002",
        "frame": { "x": 54, "y": 58, "w": 56, "h": 58 },
        "rotated": false,
        "trimmed": true,
        "spriteSourceSize": { "x": 0, "y": 3, "w": 56, "h": 58 },
        "sourceSize": { "w": 56, "h": 64 }
      },
      {
        "filename": "running bot.swf/0003",
        "frame": { "x": 0, "y": 192, "w": 34, "h": 64 },
        "rotated": false,
        "trimmed": true,
        "spriteSourceSize": { "x": 11, "y": 0, "w": 34, "h": 64 },
        "sourceSize": { "w": 56, "h": 64 }
      },
      {
        "filename": "running bot.swf/0004",
        "frame": { "x": 0, "y": 64, "w": 54, "h": 64 },
        "rotated": false,
        "trimmed": true,
        "spriteSourceSize": { "x": 1, "y": 0, "w": 54, "h": 64 },
        "sourceSize": { "w": 56, "h": 64 }
      },
      {
        "filename": "running bot.swf/0005",
        "frame": { "x": 196, "y": 0, "w": 56, "h": 58 },
        "rotated": false,
        "trimmed": true,
        "spriteSourceSize": { "x": 0, "y": 3, "w": 56, "h": 58 },
        "sourceSize": { "w": 56, "h": 64 }
      },
      {
        "filename": "running bot.swf/0006",
        "frame": { "x": 0, "y": 0, "w": 54, "h": 64 },
        "rotated": false,
        "trimmed": true,
        "spriteSourceSize": { "x": 1, "y": 0, "w": 54, "h": 64 },
        "sourceSize": { "w": 56, "h": 64 }
      },
      {
        "filename": "running bot.swf/0007",
        "frame": { "x": 140, "y": 0, "w": 56, "h": 58 },
        "rotated": false,
        "trimmed": true,
        "spriteSourceSize": { "x": 0, "y": 3, "w": 56, "h": 58 },
        "sourceSize": { "w": 56, "h": 64 }
      },
      {
        "filename": "running bot.swf/0008",
        "frame": { "x": 34, "y": 188, "w": 50, "h": 60 },
        "rotated": false,
        "trimmed": true,
        "spriteSourceSize": { "x": 3, "y": 2, "w": 50, "h": 60 },
        "sourceSize": { "w": 56, "h": 64 }
      },
      {
        "filename": "running bot.swf/0009",
        "frame": { "x": 0, "y": 128, "w": 34, "h": 64 },
        "rotated": false,
        "trimmed": true,
        "spriteSourceSize": { "x": 11, "y": 0, "w": 34, "h": 64 },
        "sourceSize": { "w": 56, "h": 64 }
      },
      {
        "filename": "running bot.swf/0010",
        "frame": { "x": 84, "y": 188, "w": 56, "h": 58 },
        "rotated": false,
        "trimmed": true,
        "spriteSourceSize": { "x": 0, "y": 3, "w": 56, "h": 58 },
        "sourceSize": { "w": 56, "h": 64 }
      }],
        "meta": {
            "app": "http://www.texturepacker.com",
            "version": "1.0",
            "image": "running_bot.png",
            "format": "RGBA8888",
            "size": { "w": 252, "h": 256 },
            "scale": "0.2",
            "smartupdate": "$TexturePacker:SmartUpdate:fb56f261b1eb04e3215824426595f64c$"
        }
      }`
  end

  def preload
    @game.load.atlas('bot', 'assets/sprites/running_bot.png', nil, @bot_data)
  end

  def create
    @bot = @game.add.sprite(@game.world.center_x, 300, 'bot')

    @bot.animations.add('run')
    @bot.animations.play('run', 10, true)
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
    @bot      = Bot.new(game)

    @objects    = [@bot]
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
