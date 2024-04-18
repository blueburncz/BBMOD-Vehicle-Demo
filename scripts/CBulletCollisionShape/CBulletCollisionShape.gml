/// @func CBulletCollisionShape()
///
/// @desc A base struct for Bullet physics collision shapes.
function CBulletCollisionShape() constructor
{
	/// @var {Pointer}
	/// @private
	__ptr = pointer_null;

	/// @func set_scaling(_scale)
	///
	/// @desc Sets the scaling of the collision shape.
	///
	/// @param {Struct.BBMOD_Vec3} _scale The new scaling.
	///
	/// @return {Struct.CBulletCollisionShape} Returns `self`.
	static set_scaling = function (_scale)
	{
		gml_pragma("forceinline");
		btCollisionShape_setLocalScalingXYZ(__ptr, _scale.X, _scale.Y, _scale.Z);
		return self;
	};

	/// @func get_scaling(_scale)
	///
	/// @desc Retrieves the scaling of the collision shape.
	///
	/// @return {Struct.BBMOD_Vec3} The scaling of the collision shape.
	static get_scaling = function ()
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btCollisionShape_getLocalScaling(__ptr, _temp);
		var _scale = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _scale;
	};

	/// @func get_local_inertia(_mass)
	///
	/// @desc Calculates local inertia of the collision shapes given a mass.
	///
	/// @param {Real} _mass The mass of the collision shape.
	///
	/// @return {Struct.BBMOD_Vec3} The calculated local inertia.
	static get_local_inertia = function (_mass)
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		btCollisionShape_calculateLocalInertia(__ptr, _mass, _temp);
		var _localInertia = new BBMOD_Vec3(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _localInertia;
	};

	/// @func set_margin(_margin)
	///
	/// @desc Sets the margin (collision envelope) for the collision shape.
	///
	/// @param {Real} _margin The new margin value.
	///
	/// @return {Struct.CBulletCollisionShape} Returns `self`.
	static set_margin = function (_margin)
	{
		gml_pragma("forceinline");
		btCollisionShape_setMargin(__ptr, _margin);
		return self;
	};

	/// @func get_margin()
	///
	/// @desc Retrieves the collision shape's margin value.
	///
	/// @return {Real} The collision shape's margin value.
	static get_margin = function ()
	{
		gml_pragma("forceinline");
		return btCollisionShape_getMargin(__ptr);
	};

	/// @func get_aabb(_transform, _outMin, _outMax)
	///
	/// @desc Retrieves an axis-aligned bounding box (AABB) of the collision
	/// shape.
	///
	/// @param {Array<Real>} _transform The collision shape's transformation
	/// matrix.
	/// @param {Struct.BBMOD_Vec3} _outMin A vector to store the AABB's minimum
	/// coordinate to.
	/// @param {Struct.BBMOD_Vec3} _outMax A vector to store the AABB's maximum
	/// coordinate to.
	///
	/// @return {Struct.CBulletCollisionShape} Returns `self`.
	static get_aabb = function (_transform, _outMin, _outMax)
	{
		gml_pragma("forceinline");
		var _tempTransform = btTransform_create();
		btTransform_setFromMatrix(_tempTransform, _transform);
		var _tempMin = btVector3_create();
		var _tempMax = btVector3_create();
		btCollisionShape_getAabb(__ptr, _tempTransform, _tempMin, _tempMax);
		_outMin.Set(
			btVector3_getX(_tempMin),
			btVector3_getY(_tempMin),
			btVector3_getZ(_tempMin));
		_outMax.Set(
			btVector3_getX(_tempMax),
			btVector3_getY(_tempMax),
			btVector3_getZ(_tempMax));
		btTransform_destroy(_tempTransform);
		btVector3_destroy(_tempMin);
		btVector3_destroy(_tempMax);
		return self;
	};

	/// @func get_bounding_sphere(_outCenter)
	///
	/// @desc Retrieves a bounding sphere of the collision shape.
	///
	/// @param {Struct.BBMOD_Vec3} _outCenter A vector to store the bounding
	/// sphere's center position to.
	///
	/// @return {Real} Returns the bounding sphere's radius.
	static get_bounding_sphere = function (_outCenter)
	{
		gml_pragma("forceinline");
		var _temp = btVector3_create();
		var _radius = btCollisionShape_getBoundingSphere(__ptr, _temp);
		_outCenter.Set(
			btVector3_getX(_temp),
			btVector3_getY(_temp),
			btVector3_getZ(_temp));
		btVector3_destroy(_temp);
		return _radius;
	};

	static destroy = function ()
	{
		gml_pragma("forceinline");
		btCollisionShape_destroy(__ptr);
		__ptr = pointer_null;
		return undefined;
	};
}
