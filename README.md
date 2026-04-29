# 自用openwrt
```bash
git clone -b openwrt-24.10 --single-branch --filter=blob:none https://github.com/immortalwrt/immortalwrt 24.10
```
cd
```bash
./scripts/feeds update -a
./scripts/feeds install -a
```
```bash
make menuconfig
```
```bash
make download -j8
```
```bash
make V=s -j1
```

二次
cd
```bash
git pull
```
```bash
./scripts/feeds update -a
./scripts/feeds install -a
```
```bash
make defconfig
```
```bash
make download -j8
```
```bash
make V=s -j$(nproc)
```

重新配置
```bash
rm -rf .config
```
```bash
make menuconfig
```
```bash
make V=s -j$(nproc)
```
