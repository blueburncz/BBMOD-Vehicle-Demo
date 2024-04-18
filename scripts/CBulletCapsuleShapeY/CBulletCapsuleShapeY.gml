/// @func CBulletCapsuleShapeY()
///
/// @extends CBulletCollisionShape
///
/// @desc A Bullet physics capsule collision shape aligned to the Y axis.
function CBulletCapsuleShapeY()
	: CBulletCollisionShape() constructor
{
	/// @func create(_radius, _height)
	///
	/// @desc Creates the capsule shape. Must be called first before using other
	/// methods!
	///
	/// @param {Real} _radius The radius of the capsule.
	/// @param {Real} _height The height of the capsule.
	///
	/// @return {Struct.CBulletCapsuleShapeY} Returns `self`.
	static create = function (_radius, _height)
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__ptr = btCapsuleShape_create(_radius, _height);
		return self;
	};

	/// @func get_up_axis()
	///
	/// @desc Retreives the capsule's up axis as a vector.
	///
	/// @return {Struct.BBMOD_Vec3} The capsule's up axis.
	static get_up_axis = function ()
	{
		gml_pragma("forceinline");
		return (new BBMOD_Vec3()).SetIndex(btCapsuleShape_getUpAxis(__ptr), 1);
	};

	/// @func get_radius()
	///
	/// @desc Retreives the radius of the capsule.
	///
	/// @return {Real} The radius of the capsule.
	static get_radius = function ()
	{
		gml_pragma("forceinline");
		return btCapsuleShape_getRadius(__ptr);
	};

	/// @func get_height()
	///
	/// @desc Retreives the height of the capsule.
	///
	/// @return {Real} The height of the capsule.
	static get_height = function ()
	{
		gml_pragma("forceinline");
		return btCapsuleShape_getHalfHeight(__ptr) * 2;
	};
}

/// @func CBulletCapsuleShapeX()
///
/// @extends CBulletCapsuleShapeY
///
/// @desc A Bullet physics capsule collision aligned to the X axis.
function CBulletCapsuleShapeX()
	: CBulletCapsuleShapeY() constructor
{
	/// @func create(_radius, _height)
	///
	/// @desc Creates the capsule shape. Must be called first before using other
	/// methods!
	///
	/// @param {Real} _radius The radius of the capsule.
	/// @param {Real} _height The height of the capsule.
	///
	/// @return {Struct.CBulletCapsuleShapeX} Returns `self`.
	static create = function (_radius, _height)
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__ptr = btCapsuleShapeX_create(_radius, _height);
		return self;
	};
}

/// @func CBulletCapsuleShapeZ()
///
/// @extends CBulletCapsuleShapeY
///
/// @desc A Bullet physics capsule collision aligned to the Z axis.
function CBulletCapsuleShapeZ()
	: CBulletCapsuleShapeY() constructor
{
	/// @func create(_radius, _height)
	///
	/// @desc Creates the capsule shape. Must be called first before using other
	/// methods!
	///
	/// @param {Real} _radius The radius of the capsule.
	/// @param {Real} _height The height of the capsule.
	///
	/// @return {Struct.CBulletCapsuleShapeZ} Returns `self`.
	static create = function (_radius, _height)
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__ptr = btCapsuleShapeZ_create(_radius, _height);
		return self;
	};
}
