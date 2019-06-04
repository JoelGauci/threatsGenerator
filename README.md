# threatsGenerator

This threats generator lets you generate XML and JSON threats in order, for instance to test XML and JSON Threat Protection on the Apigee Edge platform.
To get the list of available commands, please execute:

```bash
$ curl --insecure https://{organization.name}-{environment.name}.apigee.net/threats/commands
```

Here is a response example:

```code
{
  "commands": {
    "xml": "curl --insecure 'https://{organization.name}-{environment.name}.apigee.net/threats/xml?elements=1&amp;attributes=1&amp;depth=5' -v",
    "json": "curl  --insecure 'https://{organization.name}-{environment.name}.apigee.net/threats/json?elements=1&amp;attributes=1&amp;depth=5' -v"
  },
  "test": {
    "xml": "curl --insecure  --data-binary @threat.xml -H 'Content-Type: text/xml'  'https://{organization.name}-{environment.name}.apigee.net/threats/test'",
    "json": "curl --insecure --data-binary @threat.json -H 'Content-Type: application/json'  'https://{organization.name}-{environment.name}.apigee.net/threats/test'"
  }
}
```

From there, you can generate XML and JSON threats using dedicated commands, but you can also test these files and verify your API Proxy detects and rejects specific threats.
