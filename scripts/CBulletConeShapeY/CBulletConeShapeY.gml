/// @func CBulletConeShapeY()
///
/// @extends CBulletCollisionShape
///
/// @desc A Bullet physics cone collision shape aligned to the Y axis.
function CBulletConeShapeY()
	: CBulletCollisionShape() constructor
{
	/// @func create(_radius, _height)
	///
	/// @desc Creates the cone shape. Must be called first before using other
	/// methods!
	///
	/// @param {Real} _radius The radius of the cone.
	/// @param {Real} _height The height of the cone.
	///
	/// @return {Struct.CBulletConeShapeY} Returns `self`.
	static create = function (_radius, _height)
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__ptr = btConeShape_create(_radius, _height);
		return self;
	};

	/// @func get_up_axis()
	///
	/// @desc Retreives the cone's up axis as a vector.
	///
	/// @return {Struct.BBMOD_Vec3} The cone's up axis.
	static get_up_axis = function ()
	{
		gml_pragma("forceinline");
		return (new BBMOD_Vec3()).SetIndex(btConeShape_getConeUpIndex(__ptr), 1);
	};

	/// @func get_radius()
	///
	/// @desc Retreives the radius of the cone.
	///
	/// @return {Real} The radius of the cone.
	static get_radius = function ()
	{
		gml_pragma("forceinline");
		return btConeShape_getRadius(__ptr);
	};

	/// @func get_height()
	///
	/// @desc Retreives the height of the cone.
	///
	/// @return {Real} The height of the cone.
	static get_height = function ()
	{
		gml_pragma("forceinline");
		return btConeShape_getHeight(__ptr);
	};
}

/// @func CBulletConeShapeX()
///
/// @extends CBulletConeShapeY
///
/// @desc A Bullet physics cone collision shape aligned to the X axis.
function CBulletConeShapeX()
	: CBulletConeShapeY() constructor
{
	/// @func create(_radius, _height)
	///
	/// @desc Creates the cone shape. Must be called first before using other
	/// methods!
	///
	/// @param {Real} _radius The radius of the cone.
	/// @param {Real} _height The height of the cone.
	///
	/// @return {Struct.CBulletConeShapeX} Returns `self`.
	static create = function (_radius, _height)
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__ptr = btConeShapeX_create(_radius, _height);
		return self;
	};
}

/// @func CBulletConeShapeZ()
///
/// @extends CBulletConeShapeY
///
/// @desc A Bullet physics cone collision shape aligned to the Z axis.
function CBulletConeShapeZ()
	: CBulletConeShapeY() constructor
{
	/// @func create(_radius, _height)
	///
	/// @desc Creates the cone shape. Must be called first before using other
	/// methods!
	///
	/// @param {Real} _radius The radius of the cone.
	/// @param {Real} _height The height of the cone.
	///
	/// @return {Struct.CBulletConeShapeZ} Returns `self`.
	static create = function (_radius, _height)
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__ptr = btConeShapeZ_create(_radius, _height);
		return self;
	};
}
