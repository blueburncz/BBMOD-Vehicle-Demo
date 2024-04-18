/// @func CBulletWheel()
///
/// @desc A wheel of a Bullet physics vehicle.
function CBulletWheel() constructor
{
	/// @var {Pointer}
	/// @private
	__ptr = pointer_null;

	/// @func get_transform(_outMatrix)
	///
	/// @desc
	///
	/// @param {Array<Real>} _outMatrix
	///
	/// @return {Struct.CBulletWheel} Returns `self`.
	static get_transform = function (_outMatrix)
	{
		gml_pragma("forceinline");
		var _transform = btWheelInfo_getWorldTransform(__ptr);
		btTransform_getMatrix(_transform, _outMatrix);
		return self;
	};

	/// @func get_connection_point()
	///
	/// @desc
	///
	/// @return {Struct.BBMOD_Vec3}
	static get_connection_point = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btWheelInfo_getChassisConnectionPointCS(__ptr, _temp);
		var _connectionPoint = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _connectionPoint;
	};

	/// @func get_direction()
	///
	/// @desc
	///
	/// @return {Struct.BBMOD_Vec3}
	static get_direction = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btWheelInfo_getWheelDirectionCS(__ptr, _temp);
		var _direction = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _direction;
	};

	/// @func get_axle()
	///
	/// @desc
	///
	/// @return {Struct.BBMOD_Vec3}
	static get_axle = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btWheelInfo_getWheelAxleCS(__ptr, _temp);
		var _axle = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _axle;
	};

	/// @func set_suspension_travel_max(_travelMax)
	///
	/// @desc
	///
	/// @param {Real} _travelMax
	///
	/// @return {Struct.CBulletWheel} Returns `self`.
	static set_suspension_travel_max = function (_travelMax)
	{
		gml_pragma("forceinline");
		btWheelInfo_setMaxSuspensionTravelCm(__ptr, _travelMax);
		return self;
	};

	/// @func get_suspension_travel_max(_travelMax)
	///
	/// @desc
	///
	/// @return {Real}
	static get_suspension_travel_max = function ()
	{
		gml_pragma("forceinline");
		return btWheelInfo_getMaxSuspensionTravelCm(__ptr);
	};

	/// @func get_suspension_rest_length()
	///
	/// @desc
	///
	/// @return {Real}
	static get_suspension_rest_length = function ()
	{
		gml_pragma("forceinline");
		return btWheelInfo_getSuspensionRestLength(__ptr);
	};

	/// @func set_friction_slip(_frictionSlip)
	///
	/// @desc
	///
	/// @param {Real} _frictionSlip
	///
	/// @return {Struct.CBulletWheel} Returns `self`.
	static set_friction_slip = function (_frictionSlip)
	{
		gml_pragma("forceinline");
		btWheelInfo_setFrictionSlip(__ptr, _frictionSlip);
		return self;
	};

	/// @func get_friction_slip()
	///
	/// @desc
	///
	/// @return {Real}
	static get_friction_slip = function ()
	{
		gml_pragma("forceinline");
		return btWheelInfo_getFrictionSlip(__ptr);
	};

	/// @func set_steering(_steering)
	///
	/// @desc
	///
	/// @param {Real} _steering
	///
	/// @return {Struct.CBulletWheel} Returns `self`.
	static set_steering = function (_steering)
	{
		gml_pragma("forceinline");
		btWheelInfo_setSteering(__ptr, _steering);
		return self;
	};

	/// @func get_steering()
	///
	/// @desc
	///
	/// @return {Real}
	static get_steering = function ()
	{
		gml_pragma("forceinline");
		return btWheelInfo_getSteering(__ptr);
	};

	/// @func set_rotation(_rotation)
	///
	/// @desc
	///
	/// @param {Real} _rotation
	///
	/// @return {Struct.CBulletWheel} Returns `self`.
	static set_rotation = function (_rotation)
	{
		gml_pragma("forceinline");
		btWheelInfo_setRotation(__ptr, _rotation);
		return self;
	};

	/// @func get_rotation()
	///
	/// @desc
	///
	/// @return {Real}
	static get_rotation = function ()
	{
		gml_pragma("forceinline");
		return btWheelInfo_getRotation(__ptr);
	};

	/// @func set_delta_rotation(_deltaRotation)
	///
	/// @desc
	///
	/// @param {Real} _deltaRotation
	///
	/// @return {Struct.CBulletWheel} Returns `self`.
	static set_delta_rotation = function (_deltaRotation)
	{
		gml_pragma("forceinline");
		btWheelInfo_setDeltaRotation(__ptr, _deltaRotation);
		return self;
	};

	/// @func get_delta_rotation()
	///
	/// @desc
	///
	/// @return {Real}
	static get_delta_rotation = function ()
	{
		gml_pragma("forceinline");
		return btWheelInfo_getDeltaRotation(__ptr);
	};

	/// @func set_roll_influence(_rollInfluence)
	///
	/// @desc
	///
	/// @param {Real} _rollInfluence
	///
	/// @return {Struct.CBulletWheel} Returns `self`.
	static set_roll_influence = function (_rollInfluence)
	{
		gml_pragma("forceinline");
		btWheelInfo_setRollInfluence(__ptr, _rollInfluence);
		return self;
	};

	/// @func get_roll_influence()
	///
	/// @desc
	///
	/// @return {Real}
	static get_roll_influence = function ()
	{
		gml_pragma("forceinline");
		return btWheelInfo_getRollInfluence(__ptr);
	};

	/// @func set_suspension_force_max(_force)
	///
	/// @desc
	///
	/// @param {Real} _force
	///
	/// @return {Struct.CBulletWheel} Returns `self`.
	static set_suspension_force_max = function (_force)
	{
		gml_pragma("forceinline");
		btWheelInfo_setMaxSuspensionForce(__ptr, _force);
		return self;
	};

	/// @func get_suspension_force_max()
	///
	/// @desc
	///
	/// @return {Real}
	static get_suspension_force_max = function ()
	{
		gml_pragma("forceinline");
		return btWheelInfo_getMaxSuspensionForce(__ptr);
	};

	/// @func set_engine_force(_force)
	///
	/// @desc
	///
	/// @param {Real} _force
	///
	/// @return {Struct.CBulletWheel} Returns `self`.
	static set_engine_force = function (_force)
	{
		gml_pragma("forceinline");
		btWheelInfo_setEngineForce(__ptr, _force);
		return self;
	};

	/// @func get_engine_force()
	///
	/// @desc
	///
	/// @return {Real}
	static get_engine_force = function ()
	{
		gml_pragma("forceinline");
		return btWheelInfo_getEngineForce(__ptr);
	};

	/// @func set_brake(_brake)
	///
	/// @desc
	///
	/// @param {Real} _brake
	///
	/// @return {Struct.CBulletWheel} Returns `self`.
	static set_brake = function (_brake)
	{
		gml_pragma("forceinline");
		btWheelInfo_setBrake(__ptr, _brake);
		return self;
	};

	/// @func get_brake()
	///
	/// @desc
	///
	/// @return {Real}
	static get_brake = function ()
	{
		gml_pragma("forceinline");
		return btWheelInfo_getBrake(__ptr);
	};

	/// @func set_is_front_wheel(_isFrontWheel)
	///
	/// @desc
	///
	/// @param {Bool} _isFrontWheel
	///
	/// @return {Struct.CBulletWheel} Returns `self`.
	static set_is_front_wheel = function (_isFrontWheel)
	{
		gml_pragma("forceinline");
		btWheelInfo_setIsFrontWheel(__ptr, _isFrontWheel);
		return self;
	};

	/// @func get_is_front_wheel()
	///
	/// @desc
	///
	/// @return {Bool}
	static get_is_front_wheel = function ()
	{
		gml_pragma("forceinline");
		return btWheelInfo_getIsFrontWheel(__ptr);
	};

	/// @func is_in_contact()
	///
	/// @desc
	///
	/// @return {Bool}
	static is_in_contact = function ()
	{
		gml_pragma("forceinline");
		var _raycastInfo = btWheelInfo_getRaycastInfo(__ptr);
		return btRaycastInfo_getIsInContact(_raycastInfo);
	};
}
