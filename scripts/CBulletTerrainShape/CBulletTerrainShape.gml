/// @func CBulletTerrainShape()
///
/// @extends CBulletCollisionShape
///
/// @desc A Bullet physics terrain collision shape.
function CBulletTerrainShape()
	: CBulletCollisionShape() constructor
{
	static BulletCollisionShape_destroy = destroy;

	/// @var {Real}
	/// @private
	__min = 0;

	/// @var {Real}
	/// @private
	__max = 0;

	/// @var {Id.Buffer, Undefined}
	/// @private
	__heightfield = undefined;

	/// @func create(_terrain)
	///
	/// @desc Creates the terrain shape. Must be called first before using
	/// other methods!
	///
	/// @param {Struct.BBMOD_Terrain} _terrain The terrain to create the shape
	/// from.
	///
	/// @return {Struct.CBulletTerrainShape} Returns `self`.
	static create = function (_terrain)
	{
		//gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");

		var _terrainWidth = _terrain.Size.X;
		var _terrainHeight = _terrain.Size.Y;
		__heightfield = buffer_create(_terrainWidth * _terrainHeight, buffer_fast, 1);

		var _j = 0;
		repeat (_terrainHeight)
		{
			var _i = 0;
			repeat (_terrainWidth)
			{
				var _val = _terrain.get_height_index(_i, _j);
				buffer_write(__heightfield, buffer_u8, _val);
				++_i;
			}
			++_j;
		}

		__ptr = btHeightfieldTerrainShape_createU8(_terrainHeight, _terrainWidth, __heightfield, 1, 0, 255, 2, true);
		btHeightfieldTerrainShape_setFlipTriangleWinding(__ptr, true);
		btHeightfieldTerrainShape_buildAccelerator(__ptr);

		return self;
	};

	static destroy = function ()
	{
		gml_pragma("forceinline");
		BulletCollisionShape_destroy();
		buffer_delete(__heightfield);
	};
}
