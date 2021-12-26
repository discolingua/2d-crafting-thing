extends TileMap

const TREES_TILE = 0
const GRASS_TILE = 1
const PLAINS_TILE = 2

const TILE_SIZE = 16

var Treesource = preload("res://Treesource.tscn")
var Rocksource = preload("res://Rocksource.tscn")

var rng = RandomNumberGenerator.new()

var _k = 0
var _t = 0
var _lo = 0
var _hi = 0

func _ready():
	rng.randomize()
	
	var _noise = OpenSimplexNoise.new()
	
	_noise.seed = rng.randf_range(0,999999)
	_noise.octaves = 2
	_noise.period = 8
	_noise.persistence = 0.15
	_noise.lacunarity = 1.4
	
	for _i in range(39):
		for _j in range (-128,127):
			_k = _noise.get_noise_2d(_i, _j)
			if  _k < -0.2 :
				set_cell(_i, _j, TREES_TILE)
				_lo += 1
				if rng.randi_range(1,10) == 1:
					var _tree = Treesource.instance() 
					_tree.position = Vector2( _i * TILE_SIZE + (TILE_SIZE / 2),\
											 _j * TILE_SIZE + (TILE_SIZE / 2) )
					add_child(_tree)
			elif _k > 0.3:
				set_cell(_i, _j, GRASS_TILE)
				_hi += 1
				if rng.randi_range(1,20) == 1:
					var _rock = Rocksource.instance()
					_rock.position = Vector2( _i * TILE_SIZE + (TILE_SIZE / 2) ,\
											 _j * TILE_SIZE + (TILE_SIZE / 2) )
					add_child(_rock)
			else:
				set_cell(_i, _j, PLAINS_TILE)
								
	print(_lo)
	print(_hi)
