#macro DELTA_TIME (delta_time * global.gameSpeed)

// Used to pause the game (with 0)
global.gameSpeed = 1;

////////////////////////////////////////////////////////////////////////////////
//
// Create a renderer
//
renderer = new BBMOD_DeferredRenderer();
renderer.UseAppSurface = true;
renderer.EnableShadows = true;
renderer.EnableGBuffer = true;
renderer.EnableSSAO = true;
renderer.SSAORadius = 32;
renderer.SSAODepthRange = 5;
renderer.SSAOPower = 2;

renderer.add(global.terrain); // Call terrain's `render` automatically

////////////////////////////////////////////////////////////////////////////////
//
// Add post-processing effects
//
postProcessor = new BBMOD_PostProcessor();
renderer.PostProcessor = postProcessor;

directionalBlur = new BBMOD_DirectionalBlurEffect();
postProcessor.add_effect(directionalBlur);

radialBlur = new BBMOD_RadialBlurEffect();
postProcessor.add_effect(radialBlur);

postProcessor.add_effect(new BBMOD_ExposureEffect());
postProcessor.add_effect(new BBMOD_LightBloomEffect(new BBMOD_Vec3(-1)));
postProcessor.add_effect(new BBMOD_ReinhardTonemapEffect());
postProcessor.add_effect(new BBMOD_GammaCorrectEffect());
postProcessor.add_effect(new BBMOD_LensFlaresEffect());
postProcessor.add_effect(new BBMOD_ColorGradingEffect(sprite_get_texture(SprColorGrading, 0)));
postProcessor.add_effect(new BBMOD_LumaSharpenEffect(2));
postProcessor.add_effect(new BBMOD_FilmGrainEffect(0.05));
postProcessor.add_effect(new BBMOD_ChromaticAberrationEffect(4));
postProcessor.add_effect(new BBMOD_VignetteEffect(1));
postProcessor.add_effect(new BBMOD_FXAAEffect());

////////////////////////////////////////////////////////////////////////////////
//
// Create camera
//
z = 0;
zprevious = z;
camera = new BBMOD_Camera();
camera.Exposure = 2;
camera.FollowObject = self;
camera.FollowFactor = 0.5;
camera.Offset.Set(0, 0, 20);
camera.Zoom = 120;

////////////////////////////////////////////////////////////////////////////////
//
// Disable ambient lighting
//
bbmod_light_ambient_set(BBMOD_C_BLACK);

////////////////////////////////////////////////////////////////////////////////
//
// Add sky dome
//
matSky = BBMOD_MATERIAL_SKY.clone();
matSky.BaseOpacity = -1;

// TODO: Fix memory leaks
bbmod_sprite_add_async(
	"Data/BBMOD/Skies/Sky-15.png",
	method(self, function (_err, _sprite) {
		if (!_err)
		{
			matSky.BaseOpacity = sprite_get_texture(_sprite, 0);
		}
	}));

bbmod_sprite_add_async(
	"Data/BBMOD/Skies/IBL-15.png",
	method(self, function (_err, _sprite) {
		if (!_err)
		{
			skyLight = new BBMOD_ImageBasedLight(sprite_get_texture(_sprite, 0));
			bbmod_ibl_set(skyLight);
		}
	}));

modSky = BBMOD_RESOURCE_MANAGER.load(
	"Data/BBMOD/Models/Sphere.bbmod",
	method(self, function (_err, _model) {
		if (!_err)
		{
			_model.Materials[@ 0] = matSky;
			_model.freeze();
		}
	}));

////////////////////////////////////////////////////////////////////////////////
//
// Add directional light
//
var _moonLight = new BBMOD_DirectionalLight(
	new BBMOD_Color().FromHex(0x2A2A32),
	new BBMOD_Vec3(-0.89, -0.16, -0.42));
_moonLight.CastShadows = true;
_moonLight.ShadowmapResolution = 4096;
bbmod_light_directional_set(_moonLight);

// Add sun shafts
postProcessor.add_effect(new BBMOD_SunShaftsEffect(
	_moonLight.Direction,
	0.5,
	BBMOD_C_SILVER.Mix(BBMOD_C_BLACK, 0.9),
	undefined, //
	undefined, // Use defaults...
	undefined, //
	0.1
));

////////////////////////////////////////////////////////////////////////////////
//
// Add a reflectiton probe
//
var _probeX = global.terrain.Size.X * global.terrain.Scale.X * 0.5;
var _probeY = global.terrain.Size.Y * global.terrain.Scale.Y * 0.5;
var _probeZ = global.terrain.get_height(_probeX, _probeY) + 20;
var _reflectionProbe = new BBMOD_ReflectionProbe(new BBMOD_Vec3(_probeX, _probeY, _probeZ));
_reflectionProbe.Infinite = true;
bbmod_reflection_probe_add(_reflectionProbe);

////////////////////////////////////////////////////////////////////////////////
//
// Dirt particle emitter
//
dirtEmitter = new BBMOD_ParticleEmitter(new BBMOD_Vec3(), DirtParticleSystem());
renderer.add(dirtEmitter); // Call dirtEmitter's `render` automatically

////////////////////////////////////////////////////////////////////////////////
//
// Create a physics world
//
physicsWorld = (new CBulletPhysicsWorld()).create();
physicsWorld.set_gravity(new BBMOD_Vec3(0, 0, -180));

//
// Add terrain to physics world
//
terrainShape = physicsWorld.create_terrain_shape(global.terrain);
terrainCollider = physicsWorld.create_rigid_body(terrainShape, 0);
physicsWorld.add_rigid_body(terrainCollider);
physicsWorld.align_terrain(global.terrain, terrainCollider);

////////////////////////////////////////////////////////////////////////////////
//
// Create jeep
//
steering = 0;
velocity = new BBMOD_Vec3();
wheelInContact = array_create(4, false);

//
// Load jeep model
//
var _freezeOnLoad = function (_err, _res)
{
	if (!_err)
	{
		_res.freeze();
	}
};

jeep = BBMOD_RESOURCE_MANAGER.load("Data/Assets/jeep/JeepBody.bbmod", _freezeOnLoad);
jeepTire = BBMOD_RESOURCE_MANAGER.load("Data/Assets/jeep/JeepTire.bbmod", _freezeOnLoad);

//
// Add jeep lights
//
var _createJeepLight = function ()
{
	var _light = new BBMOD_SpotLight();
	_light.RenderPass = ~(1 << BBMOD_ERenderPass.ReflectionCapture);
	_light.Color = BBMOD_C_ORANGE.Mix(BBMOD_C_WHITE, 0.5);
	_light.Color.Alpha = 0.25;
	_light.Range = 500;
	_light.AngleOuter = 45;
	_light.CastShadows = true;
	_light.ShadowmapResolution = 1024;
	return _light;
};

jeepLight1 = _createJeepLight();
bbmod_light_punctual_add(jeepLight1);

jeepLight2 = _createJeepLight();
bbmod_light_punctual_add(jeepLight2);

//
// Create lens flares for jeep lights
//
var _createJeepLensFlare = function (_light)
{
	var _lensFlare = new BBMOD_LensFlare();
	_lensFlare.AngleInner = _light.AngleInner;
	_lensFlare.AngleOuter = _light.AngleOuter;
	_lensFlare.DepthThreshold = 0.1;
	_lensFlare.add_ghosts(SprLensFlare, 0, 8, 0, 2, 1, 0.1, 8, BBMOD_C_ORANGE.Mix(BBMOD_C_BLACK, 0.8));

	var _streak = new BBMOD_LensFlareElement(BBMOD_SprLensFlareStreak);
	_streak.Color = BBMOD_C_BLUE;
	_streak.Scale.Set(2, 1.5);
	_lensFlare.add_element(_streak);

	return _lensFlare;
};

jeepLensFlare1 = _createJeepLensFlare(jeepLight1);
bbmod_lens_flare_add(jeepLensFlare1);

jeepLensFlare2 = _createJeepLensFlare(jeepLight2);
bbmod_lens_flare_add(jeepLensFlare2);

//
// Create jeep physics body. Please note that these are not real world values,
// just something that works visually!
//
jeepScale = 6.16;

vehicleTuning = physicsWorld.create_vehicle_tuning();
vehicleTuning.set_suspension_force_max(vehicleTuning.get_suspension_force_max() * jeepScale);
vehicleTuning.set_suspension_stiffness(20 * jeepScale);
vehicleTuning.set_suspension_damping(2.3 * jeepScale);
vehicleTuning.set_suspension_compression(4.4 * jeepScale);

vehicleShape = physicsWorld.create_box_shape(new BBMOD_Vec3(6, 3, 2).ScaleSelf(jeepScale));
vehicleShape.set_margin(1.1);

jeepRigidBody = physicsWorld.create_rigid_body(vehicleShape, 800);

vehicle = physicsWorld.create_vehicle(jeepRigidBody, vehicleTuning);

var _wheelDirection = new BBMOD_Vec3(0, 0, -1);
var _wheelAxle = new BBMOD_Vec3(0, -1, 0);
var _suspensionRestLength = 0.5 * jeepScale;
var _radius = 1.5 * jeepScale;

wheel1 = vehicle.add_wheel(
	new BBMOD_Vec3(4.5, -3, -1.5).ScaleSelf(jeepScale),
	_wheelDirection,
	_wheelAxle,
	_suspensionRestLength,
	_radius,
	true);
wheel2 = vehicle.add_wheel(
	new BBMOD_Vec3(4.5, 3, -1.5).ScaleSelf(jeepScale),
	_wheelDirection,
	_wheelAxle,
	_suspensionRestLength,
	_radius,
	true);
wheel3 = vehicle.add_wheel(
	new BBMOD_Vec3(-4.5, -3, -1.5).ScaleSelf(jeepScale),
	_wheelDirection,
	_wheelAxle,
	_suspensionRestLength,
	_radius,
	false);
wheel4 = vehicle.add_wheel(
	new BBMOD_Vec3(-4.5, 3, -1.5).ScaleSelf(jeepScale),
	_wheelDirection,
	_wheelAxle,
	_suspensionRestLength,
	_radius,
	false);

for (var i = 0; i < vehicle.get_wheel_count(); ++i)
{
	var _wheel = vehicle.get_wheel(i);
	_wheel.set_friction_slip(1000);
	_wheel.set_roll_influence(0.01);
}

physicsWorld.add_rigid_body(jeepRigidBody);
physicsWorld.add_vehicle(vehicle);

// Translate jeep to the center of the map
var _jeepX = global.terrain.Size.X * global.terrain.Scale.X * 0.5;
var _jeepY = global.terrain.Size.Y * global.terrain.Scale.Y * 0.5;
var _jeepZ = global.terrain.get_height(_probeX, _probeY) + 40;
jeepRigidBody.translate(new BBMOD_Vec3(_jeepX, _jeepY, _jeepZ));
