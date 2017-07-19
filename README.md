# ansible-role-nginx

Manages `nginx`.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `nginx_user` | user of `nginx` | `{{ __nginx_user }}` |
| `nginx_group` | group of `nginx` | `{{ __nginx_group }}` |
| `nginx_log_dir` | path to log directory | `{{ __nginx_log_dir }}` |
| `nginx_service` | service name of `nginx` | `nginx` |
| `nginx_package` | package name of `nginx` | `{{ __nginx_package }}` |
| `nginx_conf_dir` | path to configuration directory | `{{ __nginx_conf_dir }}` |
| `nginx_conf_fragments_dir` | path to optional configuration fragment directory | `{{ nginx_conf_dir }}/conf.d` |
| `nginx_conf_file` | path to `nginx.conf` | `{{ nginx_conf_dir }}/nginx.conf` |
| `nginx_flags` | optional flags to command `nginx` | `""` |
| `nginx_validate_enable` | when `yes` enable `nginx.conf` validation. note that all the path in all configuration files must be absolute. set to `no` if relative path must be used | `yes` |
| `nginx_config` | string of `nginx.conf` content | `""` |
| `nginx_config_fragments` | list of optional configuration fragments in `nginx_conf_fragments_dir` (see below) | `[]` |

## `nginx_config_fragments`

This variable is a list of dict. Keys and values are explained below.

| Key | Value | Mandatory? |
|-----|-------|------------|
| `name` | file name | yes |
| `config` | the content of the file | yes |
| `state` | the state of the file, created if `present` or removed if `absent` | yes |

## FreeBSD

| Variable | Default |
|----------|---------|
| `__nginx_user` | `www` |
| `__nginx_group` | `www` |
| `__nginx_package` | `nginx` |
| `__nginx_log_dir` | `/var/log/nginx` |
| `__nginx_conf_dir` | `/usr/local/etc/nginx` |


# Dependencies

None

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - ansible-role-nginx
  vars:
    nginx_flags: -q
    nginx_config: |
      worker_processes 1;
      events {
        worker_connections 1024;
      }
      http {
        include {{ nginx_conf_dir }}/mime.types;
        include {{ nginx_conf_fragments_dir }}/foo.conf;
        default_type application/octet-stream;
        sendfile on;
        keepalive_timeout 65;
        server {
          listen 80;
          server_name localhost;
          location / {
            root /usr/local/www/nginx;
            index index.html;
          }
          error_page 500 502 503 504 /50x.html;
          location = /50x.html {
            root   /usr/local/www/nginx-dist;
          }
        }
      }
    nginx_config_fragments:
      - name: foo.conf
        config: "# FOO"
        state: present
```

# License

```
Copyright (c) 2017 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

This README was created by [qansible](https://github.com/trombik/qansible)
