////////////////////////////////////////////////////////////////////////////////
//
// Create terrain in the init object to avoid rebuilding it every time the demo
// room restarts.
//
var _dirt = new BBMOD_TerrainLayer()
_dirt.BaseOpacity = sprite_get_texture(SprDirt, 0);
_dirt.NormalSmoothness = sprite_get_texture(SprDirt, 1);

var _sand = new BBMOD_TerrainLayer()
_sand.BaseOpacity = sprite_get_texture(SprSand, 0);
_sand.NormalSmoothness = sprite_get_texture(SprSand, 1);

var _terrain = new BBMOD_Terrain(SprHeightmap);
_terrain.Material = BBMOD_MATERIAL_TERRAIN_DEFERRED.clone();
_terrain.Material.set_shader(BBMOD_ERenderPass.Shadows, BBMOD_SHADER_DEFAULT_DEPTH);
_terrain.Scale = new BBMOD_Vec3(64, 64, 2);
_terrain.TextureRepeat = new BBMOD_Vec2(32);
_terrain.Layer[@ 0] = _sand;
_terrain.Layer[@ 1] = _dirt;
_terrain.Splatmap = sprite_get_texture(SprSplatmap, 0);
_terrain.build_layer_index();
global.terrain = _terrain;

room_goto(RmDemo);
