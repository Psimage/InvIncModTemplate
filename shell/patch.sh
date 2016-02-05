. shell/config

echo "Patching main.lua"

patch -u -F 3 "$LOCAL_MAIN_DEBUG_LUA" - <<EOF
--- old
+++ new
@@ -80,7 +80,7 @@

 ----------------------------------------------------------------

-MOAIFileSystem.mountVirtualDirectory( "game", "scripts.zip" )
+-- MOAIFileSystem.mountVirtualDirectory( "game", "scripts.zip" )
 dofile( string.format( "%s/client/include.lua", config.SRC_MEDIA ))

 ----------------------------------------------------------------
EOF

patch -u -F 3 "$LOCAL_MAIN_RELEASE_LUA" - <<EOF
--- old
+++ new
@@ -80,7 +80,7 @@

 ----------------------------------------------------------------

-MOAIFileSystem.mountVirtualDirectory( "game", "scripts.zip" )
+-- MOAIFileSystem.mountVirtualDirectory( "game", "scripts.zip" )
 dofile( string.format( "%s/client/include.lua", config.SRC_MEDIA ))

 ----------------------------------------------------------------
EOF

echo "Done"
