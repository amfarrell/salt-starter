nginx-install:
  pkg.installed:
  - name: nginx

nginx-running:
  service.running:
    - name: nginx
    - enable: True
    - require:
      - pkg: nginx-install
