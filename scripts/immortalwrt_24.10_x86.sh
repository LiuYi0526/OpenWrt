# File name: immortalwrt_24.10_x86.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Modify default IP
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate
#
##### 移除要替换的包
# 删除老argon
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
rm -rf feeds/luci/applications/luci-app-passwall
#rm -rf feeds/luci/applications/luci-app-netdata
##### Git稀疏克隆
# 参数1是分支名, 参数2是仓库地址, 参数3是子目录，同一个仓库下载多个文件夹直接在后面跟文件名或路径，空格分开
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

##### Themes
# 拉取argon主题
git clone --depth=1 -b master https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone --depth=1 -b master https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

##### 添加额外插件
# 拉取中文版netdata
#git clone --depth=1 -b master https://github.com/sirpdboy/luci-app-netdata package/luci-app-netdata
# 添加Lucky
git clone --depth=1 -b main https://github.com/gdy666/luci-app-lucky package/lucky
# 添加系统高级设置
git clone --depth=1 -b master https://github.com/sirpdboy/luci-app-advanced package/luci-app-advanced
# 拉取定时设置
git clone --depth=1 https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset
# 设备关机功能
git clone --depth=1 https://github.com/sirpdboy/luci-app-poweroffdevice package/luci-app-poweroffdevice
# 添加adguardhome,bypass，文件管理助手等
#luci-app-adguardhome luci-app-homeproxy
#git_sparse_clone main https://github.com/kenzok8/small-package luci-app-bypass luci-app-fileassistant luci-app-filebrowser luci-app-timecontrol luci-app-control-timewol
# 添加nikki
git clone --depth=1 -b main https://github.com/nikkinikki-org/OpenWrt-nikki package/OpenWrt-nikki
# 添加istore
git_sparse_clone main https://github.com/linkease/istore-ui app-store-ui
git_sparse_clone main https://github.com/linkease/istore luci
# 添加ssrplus
#git clone --depth=1 -b master https://github.com/fw876/helloworld package/luci-app-ssr-plus
git clone --depth=1 -b main https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
git clone --depth=1 -b main https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
#git clone --depth=1 -b main https://github.com/xiaorouji/openwrt-passwall2 package/luci-app-passwall2
# 添加应用管理
#git clone --depth=1 -b master https://github.com/destan19/OpenAppFilter package/OpenAppFilter
