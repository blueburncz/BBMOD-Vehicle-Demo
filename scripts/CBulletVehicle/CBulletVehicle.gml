/// @func CBulletVehicle()
///
/// @desc A Bullet physics vehicle.
function CBulletVehicle() constructor
{
	/// @var {Pointer}
	/// @private
	__ptr = pointer_null;

	/// @var {Pointer}
	/// @private
	__raycaster = pointer_null;

	/// @var {Struct.CBulletRigidBody, Undefined}
	/// @private
	__rigidBody = undefined;

	/// @var {Struct.CBulletVehicleTuning, Undefined}
	/// @private
	__tuning = undefined;

	/// @var {Struct.CBulletRigidWorld, Undefined}
	/// @private
	__world = undefined;

	/// @func create(_rigidBody, _tuning, _world)
	///
	/// @desc Creates the vehicle. Must be called before using other methods!
	///
	/// @param {Struct.CBulletRigidBody} _rigidBody The vehicle's rigid
	/// body.
	/// @param {Struct.CBulletVehicleTuning} _tuning The tuning of the
	/// vehicle.
	/// @param {Struct.CBulletPhysicsWorld} _world The world to create
	/// the vehile in.
	///
	/// @return {Struct.CBulletVehicle} Returns `self`.
	static create = function (_rigidBody, _tuning, _world)
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__raycaster = btDefaultVehicleRaycaster_create(_world.__ptr);
		__ptr = btRaycastVehicle_create(_tuning.__ptr, _rigidBody.__ptr, __raycaster);
		__rigidBody = _rigidBody;
		__tuning = _tuning;
		set_coordinate_system(0, 1, 2);
		return self;
	};

	/// @func get_transform(_outMatrix)
	///
	/// @desc Retrieves the transformation matrix of the vehicle.
	///
	/// @param {Array<Real>} _outMatrix The matrix to store the vehicle's
	/// transformation to.
	///
	/// @return {Struct.CBulletVehicle} Returns `self`.
	static get_transform = function (_outMatrix)
	{
		gml_pragma("forceinline");
		var _transform = btRaycastVehicle_getChassisWorldTransform(__ptr);
		btTransform_getMatrix(_transform, _outMatrix);
		return self;
	};

	/// @func set_steering_value(_wheelIndex, _steering)
	///
	/// @desc
	///
	/// @param {Real} _wheelIndex
	/// @param {Real} _steering
	///
	/// @return {Struct.CBulletVehicle} Returns `self`.
	static set_steering_value = function (_wheelIndex, _steering)
	{
		gml_pragma("forceinline");
		btRaycastVehicle_setSteeringValue(__ptr, _steering, _wheelIndex);
		return self;
	};

	/// @func get_steering_value(_wheelIndex)
	///
	/// @desc
	///
	/// @param {Real} _wheelIndex
	///
	/// @return {Real}
	static get_steering_value = function (_wheelIndex)
	{
		gml_pragma("forceinline");
		return btRaycastVehicle_getSteeringValue(__ptr, _wheelIndex);
	};

	/// @func apply_engine_force(_wheelIndex, _force)
	///
	/// @desc
	///
	/// @param {Real} _wheelIndex
	/// @param {Real} _force
	///
	/// @return {Struct.CBulletVehicle} Returns `self`.
	static apply_engine_force = function (_wheelIndex, _force)
	{
		gml_pragma("forceinline");
		btRaycastVehicle_applyEngineForce(__ptr, _force, _wheelIndex);
		return self;
	};

	/// @func get_wheel_transform(_wheelIndex, _outMatrix)
	///
	/// @desc
	///
	/// @param {Real} _wheelIndex
	/// @param {Array<Real>} _outMatrix
	///
	/// @return {Struct.CBulletVehicle} Returns `self`.
	static get_wheel_transform = function (_wheelIndex, _outMatrix)
	{
		gml_pragma("forceinline");
		var _transform = btRaycastVehicle_getWheelTransformWS(__ptr, _wheelIndex);
		btTransform_getMatrix(_transform, _outMatrix);
		return self;
	};

	/// @func add_wheel(_connectionPoint, _wheelDirection, _wheelAxle, _suspensionRestLength, _radius, _isFrontWheel)
	///
	/// @desc
	///
	/// @param {Struct.BBMOD_Vec3} _connectionPoint
	/// @param {Struct.BBMOD_Vec3} _wheelDirection
	/// @param {Struct.BBMOD_Vec3} _wheelAxle
	/// @param {Real} _suspensionRestLength
	/// @param {Real} _radius
	/// @param {Bool} _isFrontWheel
	///
	/// @return {Struct.CBulletWheel} Returns the added wheel.
	static add_wheel = function (
		_connectionPoint,
		_wheelDirection,
		_wheelAxle,
		_suspensionRestLength,
		_radius,
		_isFrontWheel)
	{
		gml_pragma("forceinline");
		var _tempConnectionPoint = btVector3_create(
			_connectionPoint.X, _connectionPoint.Y, _connectionPoint.Z);
		var _tempWheelDirection = btVector3_create(
			_wheelDirection.X, _wheelDirection.Y, _wheelDirection.Z);
		var _tempWheelAxle = btVector3_create(
			_wheelAxle.X, _wheelAxle.Y, _wheelAxle.Z);
		btRaycastVehicle_addWheel(
			__ptr,
			_tempConnectionPoint,
			_tempWheelDirection,
			_tempWheelAxle,
			_suspensionRestLength,
			_radius,
			__tuning.__ptr,
			_isFrontWheel);
		btVector3_destroy(_tempConnectionPoint);
		btVector3_destroy(_tempWheelDirection);
		btVector3_destroy(_tempWheelAxle);
		return get_wheel(get_wheel_count() - 1);
	};

	/// @func get_wheel_count()
	///
	/// @desc Retrieves the number of wheels that the vehicle has.
	///
	/// @return {Real} The number of wheels of the vehicle.
	static get_wheel_count = function ()
	{
		gml_pragma("forceinline");
		return btRaycastVehicle_getNumWheels(__ptr);
	};

	/// @func get_wheel(_wheelIndex)
	///
	/// @desc Retrieves a wheel.
	///
	/// @param {Real} _wheelIndex The index of the wheel.
	///
	/// @return {Struct.CBulletWheel} The vehicle's wheel at given index.
	static get_wheel = function (_wheelIndex)
	{
		gml_pragma("forceinline");
		bbmod_assert(_wheelIndex >= 0 && _wheelIndex < get_wheel_count(), $"Wheel index {_wheelIndex} out of range!");
		var _wheel = new CBulletWheel();
		_wheel.__ptr = btRaycastVehicle_getWheelInfo(__ptr, _wheelIndex);
		return _wheel;
	};

	/// @func set_brake(_wheelIndex, _brake)
	///
	/// @desc
	///
	/// @param {Real} _wheelIndex
	/// @param {Real} _brake
	///
	/// @return {Struct.CBulletVehicle} Returns `self`.
	static set_brake = function (_wheelIndex, _brake)
	{
		gml_pragma("forceinline");
		btRaycastVehicle_setBrake(__ptr, _brake, _wheelIndex);
		return self;
	};

	/// @func set_pitch_control(_pitch)
	///
	/// @desc
	///
	/// @param {Real} _pitch
	///
	/// @return {Struct.CBulletVehicle} Returns `self`.
	static set_pitch_control = function (_pitch)
	{
		gml_pragma("forceinline");
		btRaycastVehicle_setPitchControl(__ptr, _pitch);
		return self;
	};

	/// @func get_rigid_body()
	///
	/// @desc
	///
	/// @return {Struct.CBulletRigidBody}
	static get_rigid_body = function ()
	{
		gml_pragma("forceinline");
		return __rigidBody;
	};

	/// @func get_up_axis()
	///
	/// @desc
	///
	/// @return {Struct.BBMOD_Vec3}
	static get_up_axis = function ()
	{
		gml_pragma("forceinline");
		return (new BBMOD_Vec3()).SetIndex(btRaycastVehicle_getUpAxis(__ptr), 1);
	};

	/// @func get_right_axis()
	///
	/// @desc
	///
	/// @return {Struct.BBMOD_Vec3}
	static get_right_axis = function ()
	{
		gml_pragma("forceinline");
		return (new BBMOD_Vec3()).SetIndex(btRaycastVehicle_getRightAxis(__ptr), 1);
	};

	/// @func get_forward_axis()
	///
	/// @desc
	///
	/// @return {Struct.BBMOD_Vec3}
	static get_forward_axis = function ()
	{
		gml_pragma("forceinline");
		return (new BBMOD_Vec3()).SetIndex(btRaycastVehicle_getForwardAxis(__ptr), 1);
	};

	/// @func get_forward()
	///
	/// @desc
	///
	/// @return {Struct.BBMOD_Vec3}
	static get_forward = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btRaycastVehicle_getForwardVector(__ptr, _temp);
		var _forward = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _forward;
	};

	/// @func get_speed()
	///
	/// @desc
	///
	/// @return {Real}
	static get_speed = function ()
	{
		gml_pragma("forceinline");
		return btRaycastVehicle_getCurrentSpeedKmHour(__ptr);
	};

	/// @func set_coordinate_system(_forwardIndex, _rightIndex, _upIndex)
	///
	/// @desc
	///
	/// @param {Real} _forwardIndex
	/// @param {Real} _rightIndex
	/// @param {Real} _upIndex
	///
	/// @return {Struct.CBulletVehicle} Returns `self`.
	static set_coordinate_system = function (_forwardIndex, _rightIndex, _upIndex)
	{
		gml_pragma("forceinline");
		btRaycastVehicle_setCoordinateSystem(__ptr, _rightIndex, _upIndex, _forwardIndex);
		return self;
	};

	static destroy = function ()
	{
		gml_pragma("forceinline");
		if (__world != undefined)
		{
			__world.remove_vehicle(self);
			__world = undefined;
		}
		btRaycastVehicle_destroy(__ptr);
		__ptr = pointer_null;
		btDefaultVehicleRaycaster_destroy(__raycaster);
		__rigidBody = undefined;
		__tuning = undefined;
		return undefined;
	};
}
