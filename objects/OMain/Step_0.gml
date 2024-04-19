////////////////////////////////////////////////////////////////////////////////
//
// Restart room when "R" is pressed
//
if (keyboard_check_pressed(ord("R")))
{
	window_set_cursor(cr_default);
	room_restart();
	exit;
}

////////////////////////////////////////////////////////////////////////////////
//
// Jeep controls
//
steering += angle_difference(keyboard_check(ord("D")) - keyboard_check(ord("A")), steering) * 0.1;

vehicle.set_steering_value(0, steering);
vehicle.set_steering_value(1, steering);
vehicle.set_steering_value(2, 0);
vehicle.set_steering_value(3, 0);

var _forwad = (keyboard_check(ord("W")) - keyboard_check(ord("S"))) * 3000 * jeepScale;
vehicle.apply_engine_force(0, _forwad);
vehicle.apply_engine_force(1, _forwad);
vehicle.apply_engine_force(2, _forwad);
vehicle.apply_engine_force(3, _forwad);

var _brake = keyboard_check(vk_space) * 100 * jeepScale;
vehicle.set_brake(0, _brake);
vehicle.set_brake(1, _brake);
vehicle.set_brake(2, _brake);
vehicle.set_brake(3, _brake);

////////////////////////////////////////////////////////////////////////////////
//
// Update systems
//
if (DELTA_TIME > 0)
{
	dirtEmitter.update(DELTA_TIME);
}

renderer.update(DELTA_TIME);

var _deltaTime = game_get_speed(gamespeed_microseconds) * global.gameSpeed;
physicsWorld.update(_deltaTime * global.gameSpeed);

////////////////////////////////////////////////////////////////////////////////
//
// Update jeep transforms
//
var _matrix = matrix_build_identity();
jeepRigidBody.get_transform(_matrix);

var _lightDir = new BBMOD_Matrix(_matrix).Transform(new BBMOD_Vec4(1, 0, 0, 0));

var _lightPos = new BBMOD_Matrix(_matrix).Transform(new BBMOD_Vec4(35, 11, 3, 1));
jeepLight1.Position.Set(_lightPos.X, _lightPos.Y, _lightPos.Z);
jeepLight1.Direction.Set(_lightDir.X, _lightDir.Y, _lightDir.Z).NormalizeSelf();
jeepLensFlare1.Position = jeepLight1.Position.Clone();
jeepLensFlare1.Direction = jeepLight1.Direction.Clone();

_lightPos = new BBMOD_Matrix(_matrix).Transform(new BBMOD_Vec4(35, -11, 3, 1));
jeepLight2.Position.Set(_lightPos.X, _lightPos.Y, _lightPos.Z);
jeepLight2.Direction.Set(_lightDir.X, _lightDir.Y, _lightDir.Z).NormalizeSelf();
jeepLensFlare2.Position = jeepLight2.Position.Clone();
jeepLensFlare2.Direction = jeepLight2.Direction.Clone();

// Remember previous position
xprevious = x;
yprevious = y;
zprevious = z;

// Move this object to the jeep's position
x = _matrix[12];
y = _matrix[13];
z = _matrix[14];

////////////////////////////////////////////////////////////////////////////////
//
// Camera controls
//
if (mouse_check_button_pressed(mb_left))
{
	camera.set_mouselook(true);
	window_set_cursor(cr_none);
}
else if (keyboard_check_pressed(vk_escape))
{
	camera.set_mouselook(false);
	window_set_cursor(cr_default);
}

camera.Zoom = max(camera.Zoom + (mouse_wheel_down() - mouse_wheel_up()) * 5, 50);

global.gameSpeed = camera.MouseLook ? 1 : 0;

if (global.gameSpeed == 0)
{
	if (mouse_check_button(mb_right))
	{
		camera.Direction -= window_mouse_get_delta_x() * 0.5;
		camera.DirectionUp -= window_mouse_get_delta_y() * 0.5;
	}
}

camera.AspectRatio = window_get_width() / window_get_height();
camera.update(DELTA_TIME);

var _cameraHeight = (global.terrain.get_height(camera.Position.X, camera.Position.Y) ?? 0) + 1;
if (camera.Position.Z < _cameraHeight)
{
	camera.Position.Z = _cameraHeight;

	// We have to update the camera's matrices if we change its position or
	// target after we call its update method.
	camera.update_matrices();
}

////////////////////////////////////////////////////////////////////////////////
//
// Update blur strength
//
if (global.gameSpeed > 0)
{
	velocity.Set(x - xprevious, y - yprevious, z - zprevious);
}

var _cam = camera.get_forward();
var _strength = clamp(velocity.Length() / 10, 0, 1);
var _absDot = abs(_cam.Dot(velocity.Normalize()));

directionalBlur.Vector.Set((1 - _absDot) * _strength * 64, 0);
radialBlur.Strength = _absDot * _strength;
