draw_clear(c_black);

//
// Apply camera
//
camera.apply();

//
// Draw sky dome
//
new BBMOD_Matrix()
	.Scale(new BBMOD_Vec3(1000))
	.Translate(camera.Position)
	.ApplyWorld();
modSky.render();

//
// Draw jeep body
//
var _jeepScale = 0.23;
var _scale = _jeepScale / 0.25;
var _jeepMatrix = matrix_build(
	-30 * _scale, 0, 20 * _scale,
	0, 0, 90,
	_jeepScale, _jeepScale, _jeepScale
);

var _rigidBodyMatrix = matrix_build_identity();
jeepRigidBody.get_transform(_rigidBodyMatrix);

var _matrix = matrix_multiply(_jeepMatrix, _rigidBodyMatrix);

matrix_set(matrix_world, _matrix);
jeep.render();

//
// Draw jeep wheels
//
var _tireMatrix, _wheelMatrix;

for (var i = 0; i < vehicle.get_wheel_count(); ++i)
{
	var _wheel = vehicle.get_wheel(i);
	_tireMatrix = matrix_build(0, 0, 0, 0, 0, 90 * ((i % 2 == 0) ? -1 : 1), _jeepScale, _jeepScale, _jeepScale);
	_wheelMatrix = matrix_build_identity();
	_wheel.get_transform(_wheelMatrix);
	_wheelMatrix = matrix_multiply(_tireMatrix, _wheelMatrix);
	matrix_set(matrix_world, _wheelMatrix);
	jeepTire.render();

	if (global.gameSpeed > 0)
	{
		var _inContact = _wheel.is_in_contact();
		var _deltaRotation = radtodeg(_wheel.get_delta_rotation());
		var _spawnDirt = (_inContact && abs(_deltaRotation) > 2 && random(1) < 0.2) ? 1 : 0;

		if (_inContact && !wheelInContact[i])
		{
			_spawnDirt += 10;
		}
		wheelInContact[@ i] = _inContact;

		var _pos = matrix_transform_vertex(_wheelMatrix, 0, 0, 0);
		repeat (_spawnDirt)
		{
			var _dirtPos = new BBMOD_Vec3().FromArray(_pos);
			_dirtPos.X += random_range(-5, 5);
			_dirtPos.Y += random_range(-5, 5);
			_dirtPos.Z -= 5;
			dirtEmitter.spawn_particle(_dirtPos);
		}
	}
}

//
// Reset world matrix to identity
//
BBMOD_MATRIX_IDENTITY.ApplyWorld();

//
// Execute renderer
//
renderer.render();
