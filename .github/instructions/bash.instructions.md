---
applyTo: '**/*.sh,**/*.bash'
---

## Shell Scripting Instructions

- Use `bash` for writing scripts.
- Put all script files in the `scripts` directory.
- Script name must be prefixed by `ap_`.
- Use underscore `_` to separate words in the script name.

- The shebang line must be `#!/usr/bin/env bash`.
- All variables must have a prefix `ap_`.
- All exported variables or constants must be UPPERCASE and have a prefix `AP_`.
- Use `"${VAR}"` instead of `$VAR` for variables.
