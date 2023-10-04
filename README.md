# bobbycar

## build
```
podman build -t quay.io/tnk4on/bobbycar:amd64 --platform linux/amd64 .
podman build -t quay.io/tnk4on/bobbycar:arm64 --platform linux/arm64 --env ARCH=arm64 .
podman manifest create quay.io/tnk4on/bobbycar
podman manifest add quay.io/tnk4on/bobbycar containers-storage:quay.io/tnk4on/bobbycar:amd64
podman manifest add quay.io/tnk4on/bobbycar containers-storage:quay.io/tnk4on/bobbycar:arm64
podman manifest push -f oci --all quay.io/tnk4on/bobbycar
```

## install

```
git clone https://github.com/sa-mw-dach/bobbycar
cd bobbycar
vi install_cleanup_vars.sh
```
Add parameter to `APP_DOMAIN=`,`API_DOMAIN=`.

```
podman run -d --name bobbycar quay.io/tnk4on/bobbycar sleep inf
podman cp install_cleanup_vars.sh bobbycar:install_cleanup_vars.sh
podman exec -it bobbycar bash
```

(inside container)
```
./install.sh
```