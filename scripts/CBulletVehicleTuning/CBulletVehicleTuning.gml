/// @func CBulletVehicleTuning()
///
/// @desc A tuning of a Bullet physics vehicle.
function CBulletVehicleTuning() constructor
{
	/// @var {Pointer}
	/// @private
	__ptr = pointer_null;

	/// @func create()
	///
	/// @return {Struct.CBulletVehicleTuning} Returns `self`.
	static create = function ()
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__ptr = btVehicleTuning_create();
		return self;
	};

	/// @func set_suspension_stiffness(_stiffness)
	///
	/// @desc
	///
	/// @param {Real} _stiffness
	///
	/// @return {Struct.CBulletVehicleTuning} Returns `self`.
	static set_suspension_stiffness = function (_stiffness)
	{
		gml_pragma("forceinline");
		btVehicleTuning_setSuspensionStiffness(__ptr, _stiffness);
		return self;
	};

	/// @func get_suspension_stiffness()
	///
	/// @desc
	///
	/// @return {Real}
	static get_suspension_stiffness = function ()
	{
		gml_pragma("forceinline");
		return btVehicleTuning_getSuspensionStiffness(__ptr);
	};

	/// @func set_suspension_compression(_compression)
	///
	/// @desc
	///
	/// @param {Real} _compression
	///
	/// @return {Struct.CBulletVehicleTuning} Returns `self`.
	static set_suspension_compression = function (_compression)
	{
		gml_pragma("forceinline");
		btVehicleTuning_setSuspensionCompression(__ptr, _compression);
		return self;
	};

	/// @func get_suspension_compression()
	///
	/// @desc
	///
	/// @return {Real}
	static get_suspension_compression = function ()
	{
		gml_pragma("forceinline");
		return btVehicleTuning_getSuspensionCompression(__ptr);
	};

	/// @func set_suspension_damping(_damping)
	///
	/// @desc
	///
	/// @param {Real} _damping
	///
	/// @return {Struct.CBulletVehicleTuning} Returns `self`.
	static set_suspension_damping = function (_damping)
	{
		gml_pragma("forceinline");
		btVehicleTuning_setSuspensionDamping(__ptr, _damping);
		return self;
	};

	/// @func get_suspension_damping()
	///
	/// @desc
	///
	/// @return {Real}
	static get_suspension_damping = function ()
	{
		gml_pragma("forceinline");
		return btVehicleTuning_getSuspensionDamping(__ptr);
	};

	/// @func set_suspension_travel_max(_travelMax)
	///
	/// @desc
	///
	/// @param {Real} _travelMax
	///
	/// @return {Struct.CBulletVehicleTuning} Returns `self`.
	static set_suspension_travel_max = function (_travelMax)
	{
		gml_pragma("forceinline");
		btVehicleTuning_setMaxSuspensionTravelCm(__ptr, _travelMax);
		return self;
	};

	/// @func get_suspension_travel_max()
	///
	/// @desc
	///
	/// @return {Real}
	static get_suspension_travel_max = function ()
	{
		gml_pragma("forceinline");
		return btVehicleTuning_getMaxSuspensionTravelCm(__ptr);
	};

	/// @func set_friction_slip(_frictionSlip)
	///
	/// @desc
	///
	/// @param {Real} _frictionSlip
	///
	/// @return {Struct.CBulletVehicleTuning} Returns `self`.
	static set_friction_slip = function (_frictionSlip)
	{
		gml_pragma("forceinline");
		btVehicleTuning_setFrictionSlip(__ptr, _frictionSlip);
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
		return btVehicleTuning_getFrictionSlip(__ptr);
	};

	/// @func set_suspension_force_max(_forceMax)
	///
	/// @desc
	///
	/// @param {Real} _forceMax
	///
	/// @return {Struct.CBulletVehicleTuning} Returns `self`.
	static set_suspension_force_max = function (_forceMax)
	{
		gml_pragma("forceinline");
		btVehicleTuning_setMaxSuspensionForce(__ptr, _forceMax);
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
		return btVehicleTuning_getMaxSuspensionForce(__ptr);
	};

	static destroy = function ()
	{
		gml_pragma("forceinline");
		btVehicleTuning_destroy(__ptr);
		__ptr = pointer_null;
		return undefined;
	};
}
