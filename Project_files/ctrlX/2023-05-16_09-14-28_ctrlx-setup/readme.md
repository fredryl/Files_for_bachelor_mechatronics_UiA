# ctrlx-setup Readme

This document contains hints for editing ctrlx-setup.zip archives.

The primary file of a setup is ctrlx-setup.json located in the root folder of the setup archive. Other files are
referenced as resource files via "$path" properties. Only referenced files or folders are used during a setup.

The ctrlx-setup.json file can be used stand-alone if no resource files are required, e.g. for dateTime settings.

The setup archive also contains a JSON schema file (setup.v1.schema.json). Place the schema file and the ctrlx-setup.json
in the same directory to get editing support, e.g. with Visual Studio Code.

## File naming rules

- File and folder names should be lower-case
- Resource files are looked up case-insensitive

## Referencing files from ctrlx-setup.json

Resource files are typically used for settings exchanged as file content.

Examples:

- Certificates and key files
- App binaries
- Configuration contents

## $path

The "$path" property is used to reference a resource file from an element in the ctrlx-setup.json file.

- Absolute paths start with "/"
- The path separator is "/"
- A relative path uses the parent path as its base path; in case of an app, e.g., the base path is `/packagemanagement/installedapps`

```json
{ 
    "packageManagement": {
        "installedApps": {
            "rexroth-setup": {
                "enabled": true,
                "version": "1.16.0",
                "$path": "foo.app"
            }
        }
    }
}
```

In this example, the binary file is expected at `/packagemanagement/installedapps/foo.app`.
