127.0.0.1  localhost {{ ansible.vmName }} {{ ansible.vmName | regex_replace('^([a-zA-Z0-9]+)\.(.*)$', '\\1') }}
::1        localhost {{ ansible.vmName }} {{ ansible.vmName | regex_replace('^([a-zA-Z0-9]+)\.(.*)$', '\\1') }}