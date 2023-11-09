class_name Seed

enum SeedKind {BOMB, BRIDGE, FRUIT, JUMP, CASTLE, HEART, SAND, ICE}

var kind: SeedKind

func resource():
	match kind:
		SeedKind.BOMB: return preload("res://cubes/bomb_cube.tscn")
		SeedKind.BRIDGE: return preload("res://cubes/bridge_cube.tscn")
		SeedKind.FRUIT: return preload("res://cubes/fruit_cube.tscn")
		SeedKind.JUMP: return preload("res://cubes/jump_cube.tscn")
		SeedKind.CASTLE: return preload("res://cubes/castle_cube.tscn")
		SeedKind.HEART: return preload("res://cubes/heart_cube.tscn")
		SeedKind.SAND: return preload("res://cubes/sand_cube.tscn")
		SeedKind.ICE: return preload("res://cubes/ice_cube.tscn")

func growTime():
	match kind:
		SeedKind.BOMB: return 5
		SeedKind.BRIDGE: return 3
		SeedKind.FRUIT: return 2
		SeedKind.JUMP: return 3
		SeedKind.CASTLE: return 5
		SeedKind.HEART: return 5
		SeedKind.SAND: return 2
		SeedKind.ICE: return 5

static func randSeedKind():
	#return randi() % SeedKind.keys().size()
	var allowed = [SeedKind.BRIDGE, SeedKind.JUMP, SeedKind.HEART]
	return allowed[randi() % allowed.size()]
