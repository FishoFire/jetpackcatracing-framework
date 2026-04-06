
#!optimizeStrict
##!setupTags

# settings ###################
#!define versionhere "0.1.0"

#!define editor_on false
#!define inspector_on true

# testscripts disable: ##, enable: #
#!define test_script #


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

test_script!include "test_scripts.opy" 