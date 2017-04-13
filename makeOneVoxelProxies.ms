-- Description: This script re-exports all VRayProxy objects in the scene so that the resulting .vrmesh files contain
-- only a single voxel. This may speed up rendering of instanced proxies (f.e. through ForestPro, MultiScatter) quite a bit.
-- the re-exported proxies are in the same folders as the original ones, but with the _oneVoxel suffix added to the file name.
-- Usage: Open your scene and run this script.
fn makeOneVoxelProxies = (
	proxies=getClassInstances VRayProxy
	for prxy in proxies do (
		local fileName=prxy.fileName
		local pathStr=getFileNamePath fileName
		local nameStr=getFileNameFile fileName
		local extStr=getFileNameType fileName
		
		local newFileName=pathStr+nameStr+"_oneVoxel"+extStr
		
		format "Orig name: %, new name: %\n" fileName newFileName
		local importedMesh=vrayMeshImport proxy:prxy weldVertices:1
		vrayMeshExport nodes:importedMesh autoCreateProxies:false animation:off meshFile:newFileName oneVoxelPerMesh:true exportMultiple:false
		
		prxy.fileName=newFileName
		delete importedMesh
	)
)
