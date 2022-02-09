## Release 1.4.0

* f0385c3 bugfix: QA
* 2ea064b ci: add ansible-lint to CI
* b599c63 feat: support Fedora
* 719228c ci: remove ansible_vault_password_file
* 40c2b97 ci: add kitchen workflow to CI

## Release 1.3.5

* 670d72f bugfix: update gems
* 5909591 bugfix: support Devuan

## Release 1.3.4

* 5aac162 ci: add workaround to x509
* 5d14392 bugfix: use package name instead of origin
* 921ba02 bugfix: `ansible.builtin`-fy
* ce04b57 bugfix: update kitchen-ansible for collections support
* e7a8ca4 bugfix: prevent service from running on Ubuntu
* f0be610 bugfix: QA

## Release 1.3.3

* 0c77f13 bugfix: fix test case for OpenBSD 6.8
* a6551ef bugfix: update box versions

## Release 1.3.2

* 00fc263 bugfix: update boxes, and a TLS test
* e622f2f bugfix: update python 3.x

## Release 1.3.1

* 619e0a1 bugfix: update gems, sync .travis.yml

## Release 1.3.0

* e4e7fb3 feature: support nginx_extra_packages
* 03e31cb bugfix: wrong name
* d1fd359 bugfix: QA
* 26c36b7 bugfix: QA
* 0cf966a bugfix: update gems
* aa2c230 feature: support htpasswd
* 4d0b286 bugfix: QA

## Release 1.2.4

* aeded38 bugfix: restart the service upon changes in configuration

## Release 1.2.3

* ac09832 QA

## Release 1.2.2

* f878463 bugfix: openssl in FreeBSD 12.0 outputs in different format
* 0fd5822 QA
* 0ba7639 bugfix: rename redhat-repo with redhat_repo
* dba33e0 bugfix: replace `trombik.x509-certificate` with `trombik.x509_certificate`
* 061264f bugfix: QA
* c6481f0 [bugfix] QA (#3)
* bf80de1 [bugfix] Update rubocop to the latest (#1)

## Release 1.2.1

* bb2862f [bugfix] Update rubocop to the latest

## Release 1.2.0

* 3524097 [feature] support FreeBSD 11.1 and OpenBSD 6.2 (#12)
* 7046758 [feature] introduce nginx_access_log_file (#11)
* 8806959 [documentation] document hidden-dependency (#9)

## Release 1.1.0

* ac08c26 [feature] introduce nginx_include_x509_certificate (#6)
* e77ef40 [bugfix] s/xeinal/xenial/ (#5)

## Release 1.0.0

* Initial release
