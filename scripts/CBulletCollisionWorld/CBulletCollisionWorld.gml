/// @func CBulletCollisionWorld()
///
/// @desc A Bullet physics collision world.
function CBulletCollisionWorld() constructor
{
	/// @var {Pointer}
	/// @private
	__ptr = pointer_null;

	/// @var {Pointer}
	/// @private
	__collisionConfiguration = pointer_null;

	/// @var {Pointer}
	/// @private
	__dispatcher = pointer_null;

	/// @var {Pointer}
	/// @private
	__pairCache = pointer_null;

	/// @var {Pointer}
	/// @private
	__debugDraw = pointer_null;

	/// @var {Id.Buffer}
	/// @private
	__debugDrawBuffer = buffer_create(1, buffer_grow, 1);

	/// @var {Id.DsList<Struct.CBulletCollisionObject}
	/// @private
	__collisionObjects = ds_list_create();

	/// @var {Id.DsMap<Pointer, Struct.CBulletCollisionObject>}
	/// @private
	__objectMap = ds_map_create();

	/// @func __create_debug_draw()
	///
	/// @private
	static __create_debug_draw = function ()
	{
		__debugDraw = btDebugDrawInMemory_create();
		var _debugDrawMode = (0
			| btDebugDrawModes.DBG_DrawWireframe
			//| btDebugDrawModes.DBG_DrawContactPoints
			//| btDebugDrawModes.DBG_DrawNormals
		);
		btIDebugDraw_setDebugMode(__debugDraw, _debugDrawMode);
		btCollisionWorld_setDebugDrawer(__ptr, __debugDraw);
	};

	/// @func create()
	///
	/// @desc Creates the Bullet physics collision world. Must be called first
	/// before using other methods!
	///
	/// @return {Struct.CBulletCollisionWorld} Returns `self`.
	static create = function ()
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		__collisionConfiguration = btDefaultCollisionConfiguration_create();
		__dispatcher = btCollisionDispatcher_create(__collisionConfiguration);
		__pairCache = btDbvtBroadphase_create();
		__ptr = btCollisionWorld_create(__dispatcher, __pairCache, __collisionConfiguration);
		__create_debug_draw();
		return self;
	};

	/// @func create_box_shape(_halfExtents)
	///
	/// @desc Creates a new box collision shape.
	///
	/// @param {Struct.BBMOD_Vec3} _halfExtents The half extents of the box.
	///
	/// @return {Struct.CBulletBoxShape} The created box shape.
	static create_box_shape = function (_halfExtents)
	{
		gml_pragma("forceinline");
		return (new CBulletBoxShape()).create(_halfExtents);
	};

	/// @func create_capsule_shape_x(_radius, _height)
	///
	/// @desc Creates a new capsule collision shape aligned to the X axis.
	///
	/// @param {Real} _radius The radius of the capsule.
	/// @param {Real} _height The height of the capsule.
	///
	/// @return {Struct.CBulletCapsuleShapeX} The created capsule shape.
	static create_capsule_shape_x = function (_radius, _height)
	{
		gml_pragma("forceinline");
		return (new CBulletCapsuleShapeX()).create(_radius, _height);
	};

	/// @func create_capsule_shape_y(_radius, _height)
	///
	/// @desc Creates a new capsule collision shape aligned to the Y axis.
	///
	/// @param {Real} _radius The radius of the capsule.
	/// @param {Real} _height The height of the capsule.
	///
	/// @return {Struct.CBulletCapsuleShapeY} The created capsule shape.
	static create_capsule_shape_y = function (_radius, _height)
	{
		gml_pragma("forceinline");
		return (new CBulletCapsuleShapeY()).create(_radius, _height);
	};

	/// @func create_capsule_shape_z(_radius, _height)
	///
	/// @desc Creates a new capsule collision shape aligned to the Z axis.
	///
	/// @param {Real} _radius The radius of the capsule.
	/// @param {Real} _height The height of the capsule.
	///
	/// @return {Struct.CBulletCapsuleShapeZ} The created capsule shape.
	static create_capsule_shape_z = function (_radius, _height)
	{
		gml_pragma("forceinline");
		return (new CBulletCapsuleShapeZ()).create(_radius, _height);
	};

	/// @func create_cone_shape_x(_radius, _height)
	///
	/// @desc Creates a new cone collision shape aligned to the X axis.
	///
	/// @param {Real} _radius The radius of the cone.
	/// @param {Real} _height The height of the cone.
	///
	/// @return {Struct.CBulletConeShapeX} The created cone shape.
	static create_cone_shape_x = function (_radius, _height)
	{
		gml_pragma("forceinline");
		return (new CBulletConeShapeX()).create(_radius, _height);
	};

	/// @func create_cone_shape_y(_radius, _height)
	///
	/// @desc Creates a new cone collision shape aligned to the Y axis.
	///
	/// @param {Real} _radius The radius of the cone.
	/// @param {Real} _height The height of the cone.
	///
	/// @return {Struct.CBulletConeShapeY} The created cone shape.
	static create_cone_shape_y = function (_radius, _height)
	{
		gml_pragma("forceinline");
		return (new CBulletConeShapeY()).create(_radius, _height);
	};

	/// @func create_cone_shape_z(_radius, _height)
	///
	/// @desc Creates a new cone collision shape aligned to the Z axis.
	///
	/// @param {Real} _radius The radius of the cone.
	/// @param {Real} _height The height of the cone.
	///
	/// @return {Struct.CBulletConeShapeZ} The created cone shape.
	static create_cone_shape_z = function (_radius, _height)
	{
		gml_pragma("forceinline");
		return (new CBulletConeShapeZ()).create(_radius, _height);
	};

	/// @func create_cylinder_shape_x(_radius, _height)
	///
	/// @desc Creates a new cylinder collision shape aligned to the X axis.
	///
	/// @param {Real} _radius The radius of the cylinder.
	/// @param {Real} _height The height of the cylinder.
	///
	/// @return {Struct.CBulletCylinderShapeX} The created cylinder shape.
	static create_cylinder_shape_x = function (_radius, _height)
	{
		gml_pragma("forceinline");
		return (new CBulletCylinderShapeX()).create(_radius, _height);
	};

	/// @func create_cylinder_shape_y(_radius, _height)
	///
	/// @desc Creates a new cylinder collision shape aligned to the Y axis.
	///
	/// @param {Real} _radius The radius of the cylinder.
	/// @param {Real} _height The height of the cylinder.
	///
	/// @return {Struct.CBulletCylinderShapeY} The created cylinder shape.
	static create_cylinder_shape_y = function (_radius, _height)
	{
		gml_pragma("forceinline");
		return (new CBulletCylinderShapeY()).create(_radius, _height);
	};

	/// @func create_cylinder_shape_z(_radius, _height)
	///
	/// @desc Creates a new cylinder collision shape aligned to the Z axis.
	///
	/// @param {Real} _radius The radius of the cylinder.
	/// @param {Real} _height The height of the cylinder.
	///
	/// @return {Struct.CBulletCylinderShapeZ} The created cylinder shape.
	static create_cylinder_shape_z = function (_radius, _height)
	{
		gml_pragma("forceinline");
		return (new CBulletCylinderShapeZ()).create(_radius, _height);
	};

	/// @func create_mesh_shape(_mesh)
	///
	/// @desc Creates a new mesh collision shape.
	///
	/// @param {Struct.BBMOD_Mesh} _mesh The mesh to create a collider from.
	/// Must not be frozen!
	///
	/// @return {Struct.CBulletMeshShape} The created mesh shape.
	static create_mesh_shape = function (_mesh)
	{
		gml_pragma("forceinline");
		return (new CBulletMeshShape()).create(_mesh);
	};

	/// @func create_sphere_shape(_radius)
	///
	/// @desc Creates a new sphere collision shape.
	///
	/// @param {Real} _radius The radius of the sphere.
	///
	/// @return {Struct.CBulletSphereShape} The created sphere shape.
	static create_sphere_shape = function (_radius)
	{
		gml_pragma("forceinline");
		return (new CBulletSphereShape()).create(_radius);
	};

	/// @func create_terrain_shape(_terrain)
	///
	/// @desc Creates a new terrain collision shape.
	///
	/// @param {Struct.BBMOD_Terrain} _terrain The terrain to create the shape
	/// from.
	///
	/// @return {Struct.CBulletTerrainShape} The created terrain shape.
	static create_terrain_shape = function (_terrain)
	{
		gml_pragma("forceinline");
		return (new CBulletTerrainShape()).create(_terrain);
	};

	/// @func create_collision_object(_shape)
	///
	/// @desc Creates a new collision object with given collision shape.
	///
	/// @param {Struct.CBulletCollisionShape} _shape The collision shape.
	///
	/// @return {Struct.CBulletCollisionObject} The created collision objet.
	static create_collision_object = function (_shape)
	{
		gml_pragma("forceinline");
		return (new CBulletCollisionObject()).create(_shape);
	};

	/// @func add_collision_object(_collisionObject)
	///
	/// @desc Adds a collision object to the collision world.
	///
	/// @param {Struct.CBulletCollisionObject} _collisionObject The
	/// collision object to add.
	/// @param {Real} [_group] The collision filter group. Defaults to 1.
	/// @param {Real} [_mask] The collision filter mask. Defaults to -1.
	///
	/// @return {Struct.CBulletCollisionWorld} Returns `self`.
	static add_collision_object = function (_collisionObject, _group=1, _mask=-1)
	{
		gml_pragma("forceinline");
		bbmod_assert(_collisionObject.__world == undefined, "The collision object is already added to a collision world!");
		btCollisionWorld_addCollisionObject(__ptr, _collisionObject.__ptr, _group, _mask);
		ds_list_add(__collisionObjects, _collisionObject);
		__objectMap[? _collisionObject.__ptr] = _collisionObject;
		_collisionObject.__world = self;
		return self;
	};

	/// @func get_rigid_bodies()
	///
	/// @desc Retrieves a read-only list of collision objects added to this
	/// collision world.
	///
	/// @return {Id.DsList<Struct.CBulletCollisionObject>} The list of
	/// collision objects added to this collision world.
	static get_collision_objects = function ()
	{
		gml_pragma("forceinline");
		return __collisionObjects;
	};

	/// @func has_collision_object(_collisionObject)
	///
	/// @desc Checks whether given collision object is added to this collision
	/// world.
	///
	/// @param {Struct.CBulletCollisionObject} _collisionObject The
	/// collision object check.
	///
	/// @return {Bool} Returns `true` if the collision object is added to this
	/// collision world.
	static has_collision_object = function (_collisionObject)
	{
		gml_pragma("forceinline");
		return (_collisionObject.__world == self);
	};

	/// @func remove_collision_object(_collisionObject)
	///
	/// @desc Removes a collision object from the collision world.
	///
	/// @param {Struct.CBulletCollisionObject} _collisionObject The
	/// collision object to be removed from the collision world.
	///
	/// @return {Struct.CBulletPhysicsWorld} Returns `self`.
	static remove_collision_object = function (_collisionObject)
	{
		gml_pragma("forceinline");
		bbmod_assert(_collisionObject.__world == self, "The collision object is not added to this collision world!");
		btCollisionWorld_removeCollisionObject(__ptr, _collisionObject.__ptr);
		ds_list_delete(__collisionObjects, ds_list_find_index(__collisionObjects, _collisionObject));
		ds_map_delete(__objectMap, _collisionObject.__ptr);
		return self;
	};

	/// @func ray_test(_from, _to[, _group[, _mask[, _ignoreObject]]])
	///
	/// @desc Performs a ray test in the collision world and returns the closest
	/// hit.
	///
	/// @param {Struct.BBMOD_Vec3} _from The ray's starting point.
	/// @param {Struct.BBMOD_Vec3} _to The ray's end point.
	/// @param {Real} [_group] A collision group to ray test. Defaults to 1.
	/// @param {Real} [_mask] A collision mask to use during the ray test.
	/// Defaults to -1.
	/// @param {Struct.CBulletCollisionObject} [_ignoreObject] An object to
	/// ignore in the ray test or `undefined`.
	///
	/// @return {Struct.CBulletRayResult} The result of the ray test.
	static ray_test = function (_from, _to, _group=1, _mask=-1, _ignoreObject=undefined)
	{
		//gml_pragma("forceinline");

		var _tempResult;
		if (_ignoreObject == undefined)
		{
			_tempResult = btClosestRayResultCallback_createXYZ(_from.X, _from.Y, _from.Z, _to.X, _to.Y, _to.Z)
		}
		else
		{
			var _tempFrom = btVector3_create(_from.X, _from.Y, _from.Z);
			var _tempTo = btVector3_create(_to.X, _to.Y, _to.Z);
			_tempResult = btClosestNotMeRayResultCallback_create(_tempFrom, _tempTo, _ignoreObject.__ptr);
			btVector3_destroy(_tempFrom);
			btVector3_destroy(_tempTo);
		}
		btRayResultCallback_setCollisionFilterGroup(_tempResult, _group);
		btRayResultCallback_setCollisionFilterMask(_tempResult, _mask);
		btCollisionWorld_rayTestXYZ(__ptr, _from.X, _from.Y, _from.Z, _to.X, _to.Y, _to.Z, _tempResult);

		var _rayResult = new CBulletRayResult();
		_rayResult.HasHit = btRayResultCallback_hasHit(_tempResult);
		_rayResult.HitFraction = btRayResultCallback_getClosestHitFraction(_tempResult);
		var _tempArray = array_create(3);
		btClosestRayResultCallback_getHitPointWorldArray(_tempResult, _tempArray);
		_rayResult.Point.FromArray(_tempArray);
		btClosestRayResultCallback_getHitNormalWorldArray(_tempResult, _tempArray);
		_rayResult.Normal.FromArray(_tempArray);
		if (_rayResult.HasHit)
		{
			_rayResult.Object = __objectMap[? btRayResultCallback_getCollisionObject(_tempResult)];
		}

		btClosestRayResultCallback_destroy(_tempResult);

		return _rayResult;
	};

	/// @func ray_test(_shape, _from, _to[, _group[, _mask]])
	///
	/// @desc Performs a sweep test in the collision world and returns the
	/// closest hit.
	///
	/// @param {Struct.CBulletCollisionShape} _shape The shape to test
	/// collisions with.
	/// @param {Struct.BBMOD_Vec3} _from The starting point of the sweep test.
	/// @param {Struct.BBMOD_Vec3} _to The end point of the sweep test.
	/// @param {Real} [_group] A collision group to sweep test. Defaults to 1.
	/// @param {Real} [_mask] A collision mask to use during the sweep test.
	/// Defaults to -1.
	///
	/// @return {Struct.CBulletSweepResult} The result of the sweep test.
	static sweep_test = function (_shape, _from, _to, _group=1, _mask=-1)
	{
		//gml_pragma("forceinline");

		var _tempResult = btClosestConvexResultCallback_createXYZ(_from.X, _from.Y, _from.Z, _to.X, _to.Y, _to.Z);
		btConvexResultCallback_setCollisionFilterGroup(_tempResult, _group);
		btConvexResultCallback_setCollisionFilterMask(_tempResult, _mask);

		var _tempFrom = btVector3_create(_from.X, _from.Y, _from.Z);
		var _tempTo = btVector3_create(_to.X, _to.Y, _to.Z);
		btCollisionWorld_convexSweepTest(__ptr, _shape.__ptr, _tempFrom, _tempTo, _tempResult);
		btVector3_destroy(_tempFrom);
		btVector3_destroy(_tempTo);

		var _sweepResult = new CBulletSweepResult();
		_sweepResult.HasHit = btConvexResultCallback_hasHit(__ptr);
		_sweepResult.HitFraction = btConvexResultCallback_getClosestHitFraction(__ptr);
		var _tempArray = array_create(3);
		btClosestConvexResultCallback_getHitPointWorldArray(_tempResult, _tempArray);
		_sweepResult.Point.FromArray(_tempArray);
		btClosestConvexResultCallback_getHitNormalWorldArray(_tempResult, _tempArray);
		_sweepResult.Normal.FromArray(_tempArray);
		if (_sweepResult.HasHit)
		{
			_sweepResult.Object = __objectMap[? btClosestConvexResultCallback_getHitCollisionObject(_tempResult)];
		}

		btClosestConvexResultCallback_destroy(_tempResult);

		return _sweepResult;
	};

	/// @func draw_debug()
	///
	/// @desc Draws a wireframe debug view of the collision world.
	///
	/// @return {Struct.CBulletCollisionWorld} Returns `self`.
	static draw_debug = function ()
	{
		btCollisionWorld_debugDrawWorld(__ptr);
		var _size = btDebugDrawInMemory_getSize(__debugDraw);
		if (_size > 0)
		{
			if (buffer_get_size(__debugDrawBuffer) < _size)
			{
				buffer_resize(__debugDrawBuffer, _size);
			}
			btDebugDrawInMemory_toBuffer(__debugDraw, __debugDrawBuffer);
			buffer_set_used_size(__debugDrawBuffer, _size);
			var _vbuffer = vertex_create_buffer_from_buffer(__debugDrawBuffer, btGetDebugDrawVertexFormat());
			vertex_freeze(_vbuffer);
			shader_set(btShDebugDraw);
			vertex_submit(_vbuffer, pr_linelist, -1);
			shader_reset();
			vertex_delete_buffer(_vbuffer);
		}
		return self;
	};

	/// @func draw_debug_object(_collisionObject)
	///
	/// @desc Draws a wireframe debug view of given collision object in the
	/// collision world.
	///
	/// @param {Struct.CBulletCollisionObject} _collisionObject The object
	/// to debug.
	///
	/// @return {Struct.CBulletCollisionWorld} Returns `self`.
	static draw_debug_object = function (_collisionObject)
	{
		var _transform = btCollisionObject_getWorldTransform(_collisionObject.__ptr);
		var _shape = _collisionObject.__shape.__ptr;
		var _color = btVector3_create(1, 1, 1);
		btCollisionWorld_debugDrawObject(__ptr, _transform, _shape, _color);
		btVector3_destroy(_color);
		var _size = btDebugDrawInMemory_getSize(__debugDraw);
		if (_size > 0)
		{
			if (buffer_get_size(__debugDrawBuffer) < _size)
			{
				buffer_resize(__debugDrawBuffer, _size);
			}
			btDebugDrawInMemory_toBuffer(__debugDraw, __debugDrawBuffer);
			buffer_set_used_size(__debugDrawBuffer, _size);
			var _vbuffer = vertex_create_buffer_from_buffer(__debugDrawBuffer, btGetDebugDrawVertexFormat());
			shader_set(btShDebugDraw);
			vertex_submit(_vbuffer, pr_linelist, -1);
			shader_reset();
			vertex_delete_buffer(_vbuffer);
		}
		return self;
	};

	/// @func align_terrain(_terrain, _collisionObject)
	///
	/// @desc Aligns a Bullet terrain collision object and its shape with a
	/// BBMOD terrain.
	///
	/// @param {Struct.BBMOD_Terrain} _terrain The terrain to align the collider
	/// to.
	/// @param {Struct.CBulletCollisionObject} _collisionObject The Bullet
	/// collision object to align with the terrain.
	///
	/// @return {Struct.CBulletCollisionWorld} Returns `self`.
	static align_terrain = function (_terrain, _collisionObject)
	{
		gml_pragma("forceinline");
		var _collisionShape = _collisionObject.get_collision_shape();
		_collisionObject.set_transform(matrix_build(
			_terrain.Position.X + (_terrain.Size.X - 1) * _terrain.Scale.X * 0.5,
			_terrain.Position.Y + (_terrain.Size.Y - 1) * _terrain.Scale.Y * 0.5,
			_terrain.Position.Z + 255 * _terrain.Scale.Z * 0.5,
			0, 0, 0, 1, 1, 1));
		_collisionShape.set_scaling(_terrain.Scale);
		return self;
	};

	static destroy = function ()
	{
		gml_pragma("forceinline");

		for (var i = ds_list_size(__collisionObjects) - 1; i >= 0; --i)
		{
			__collisionObjects[| i].destroy();
		}
		ds_list_destroy(__collisionObjects);
		ds_map_destroy(__objectMap);

		btCollisionWorld_destroy(__ptr);
		btDbvtBroadphase_destroy(__pairCache);
		btCollisionDispatcher_destroy(__dispatcher);
		btDefaultCollisionConfiguration_destroy(__collisionConfiguration);
		btDebugDrawInMemory_destroy(__debugDraw);
		buffer_delete(__debugDrawBuffer);

		__ptr = pointer_null;

		return undefined;
	};
}
