/// @func CBulletCylinderShapeY()
///
/// @extends CBulletCollisionShape
///
/// @desc A Bullet physics cylinder collision shape aligned to the Y axis.
function CBulletCylinderShapeY()
	: CBulletCollisionShape() constructor
{
	/// @var {Real}
	/// @private
	__height = 0;

	/// @func create(_radius, _height)
	///
	/// @desc Creates the cylinder shape. Must be called first before using
	/// other methods!
	///
	/// @param {Real} _radius The radius of the cylinder.
	/// @param {Real} _height The height of the cylinder.
	///
	/// @return {Struct.CBulletCylinderShapeY} Returns `self`.
	static create = function (_radius, _height)
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__ptr = btCylinderShape_createXYZ(_radius, _height * 0.5, _radius);
		__height = _height;
		return self;
	};

	/// @func get_up_axis()
	///
	/// @desc Retreives the cylinder's up axis as a vector.
	///
	/// @return {Struct.BBMOD_Vec3} The cylinder's up axis.
	static get_up_axis = function ()
	{
		gml_pragma("forceinline");
		return (new BBMOD_Vec3()).SetIndex(btCylinderShape_getUpAxis(__ptr), 1);
	};

	/// @func get_radius()
	///
	/// @desc Retreives the radius of the cylinder.
	///
	/// @return {Real} The radius of the cylinder.
	static get_radius = function ()
	{
		gml_pragma("forceinline");
		return btCylinderShape_getRadius(__ptr);
	};

	/// @func get_height()
	///
	/// @desc Retreives the height of the cylinder.
	///
	/// @return {Real} The height of the cylinder.
	static get_height = function ()
	{
		gml_pragma("forceinline");
		return __height;
	};
}

/// @func CBulletCylinderShapeX()
///
/// @extends CBulletCylinderShapeY
///
/// @desc A Bullet physics cylinder collision shape aligned to the X axis.
function CBulletCylinderShapeX()
	: CBulletCylinderShapeY() constructor
{
	/// @func create(_radius, _height)
	///
	/// @desc Creates the cylinder shape. Must be called first before using
	/// other methods!
	///
	/// @param {Real} _radius The radius of the cylinder.
	/// @param {Real} _height The height of the cylinder.
	///
	/// @return {Struct.CBulletCylinderShapeX} Returns `self`.
	static create = function (_radius, _height)
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__ptr = btCylinderShapeX_createXYZ(_height * 0.5, _radius, _radius);
		return self;
	};
}

/// @func CBulletCylinderShapeZ()
///
/// @extends CBulletCylinderShapeY
///
/// @desc A Bullet physics cylinder collision shape aligned to the Z axis.
function CBulletCylinderShapeZ()
	: CBulletCylinderShapeY() constructor
{
	/// @func create(_radius, _height)
	///
	/// @desc Creates the cylinder shape. Must be called first before using
	/// other methods!
	///
	/// @param {Real} _radius The radius of the cylinder.
	/// @param {Real} _height The height of the cylinder.
	///
	/// @return {Struct.CBulletCylinderShapeZ} Returns `self`.
	static create = function (_radius, _height)
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__ptr = btCylinderShapeZ_createXYZ(_radius, _radius, _height * 0.5);
		return self;
	};
}
