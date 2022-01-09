class_name ProcTilemap
extends TileMap

const TREES_TILE = 0
const GRASS_TILE = 1
const PLAINS_TILE = 2

const TILE_SIZE = 16
const TILE_OFFSET = 8
const RANGE = 256

const LOW_BAND = -0.2
const HIGH_BAND = 0.3

export(float) var rngSeed : float = 0

var Treesource = preload("res://Treesource.tscn")
var Rocksource = preload("res://Rocksource.tscn")


func _ready():

	var _k = 0
	var _lo = 0
	var _hi = 0

	var _rng = RandomNumberGenerator.new()
	_rng.randomize()
	rngSeed = _rng.randf_range(0,9999999)
	
	var _noise = OpenSimplexNoise.new()
	
	_noise.seed = rngSeed
	_noise.octaves = 2
	_noise.period = 8
	_noise.persistence = 0.15
	_noise.lacunarity = 1.4
	
	for _i in range(39):
		for _j in range (-RANGE,RANGE):
			_k = _noise.get_noise_2d(_i, _j)
			if  _k < LOW_BAND:
				set_cell(_i, _j, TREES_TILE)
				_lo += 1
				if _rng.randi_range(1,10) == 1:
					var _tree = Treesource.instance() 
					_tree.position = Vector2( _i * TILE_SIZE + TILE_OFFSET,\
											 _j * TILE_SIZE + TILE_OFFSET )
					add_child(_tree)
			elif _k > HIGH_BAND:
				set_cell(_i, _j, GRASS_TILE)
				_hi += 1
				if _rng.randi_range(1,20) == 1:
					var _rock = Rocksource.instance()	
					_rock.position = Vector2( _i * TILE_SIZE + TILE_OFFSET,\
											 _j * TILE_SIZE + TILE_OFFSET )
					add_child(_rock)
			else:
				set_cell(_i, _j, PLAINS_TILE)
								
	print(_lo)
	print(_hi)
