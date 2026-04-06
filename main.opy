
#!optimizeStrict
##!setupTags

# settings ###################
#!define editor_on false
#!define inspector_on true

#!define versionhere "0.1.0"



# includes ###################
#!include "settings.opy"
#!include "variables.opy"

divider(customization)
#!include "customize.opy"

divider(mapdata)
#!include "map_data.opy"

divider(code)
#!include "init.opy"
#!include "huds.opy"
#!include "racing.opy"

divider(editor)
#!include "editor.opy"