# Essay Manager

For the people who want to write essays (or anything) in nvim.

Sometimes a window taking up your whole screen is too wide and makes your essay look really weird.  Sometimes you want somewhere to put clippings and ideas.  This plugin solves those problems!
It splits the window into 3 vertical screens: a central essay screen and two for random things.
These 3 screens each have their files, which are in turn contained in directories.  This plugin can open the directories in the three-screen format; this is its main functionality.
It also remembers the directory paths in a file you can easily re-open them.

But, one might ask, why not use a session manager?  The answer is that it's too clunky.  You could, but this is just more seamless.  There's a reason I wrote it, after all.

## Installation:

Put this in your lazy.nvim plugin table:
```
{ "L3eC"/myplugin },
```

and make sure to put 
```
local essaymanager = require("myplugin")
essaymanager.setup("[YOUR PATH TO WHERE YOU WANT THE DIRECTORY PATHS FILE TO GO WITHOUT SQUARE BRACKETS]")
```
in your init.lua.

The default keybinding is \<leader\>mk to open the known essays.  It won't be configurable until I become not the only user of this plugin, in which case you can just tell me that you're using it.  Use :OpenEssayDir to open an essay directory.

Please let me know if you have any questions, issues, or requests!

