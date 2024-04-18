/// @func CBulletMeshShape()
///
/// @extends CBulletCollisionShape
///
/// @desc A Bullet physics mesh collision shape.
function CBulletMeshShape()
	: CBulletCollisionShape() constructor
{
	static BulletCollisionShape_destroy = destroy;

	/// @var {Pointer}
	/// @private
	__mesh = pointer_null;

	/// @func create(_mesh)
	///
	/// @desc Creates the mesh shape. Must be called first before using other
	/// methods!
	///
	/// @param {Struct.BBMOD_Mesh} _mesh The mesh to create the shape from. Must
	/// not be frozen!
	///
	/// @return {Struct.CBulletMeshShape} Returns `self`.
	static create = function (_mesh)
	{
		gml_pragma("forceinline");
		bbmod_assert(__ptr == pointer_null, "Method create can be called only once!");
		var _buffer = buffer_create_from_vertex_buffer(_mesh.VertexBuffer, buffer_fixed, 1);
		var _stride = _mesh.VertexFormat.get_byte_size();
		var _numVerts = vertex_get_number(_mesh.VertexBuffer);
		__mesh = btTriangleMesh_create(true, false);
		btTriangleMesh_addTrianglesFromBuffer(__mesh, _buffer, 0, _stride, _numVerts);
		__ptr = btBvhTriangleMeshShape_create(__mesh, false, true);
		return self;
	};

	static destroy = function ()
	{
		gml_pragma("forceinline");
		BulletCollisionShape_destroy();
		btTriangleMesh_destroy(__mesh);
		return undefined;
	};
}
