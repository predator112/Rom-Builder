# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android.git -b 12.1 -g default,-mips,-darwin,-notdefault
git clone https://github.com/NFS-projects/local_manifest --depth 1 -b crdroid-12 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch lineage_rosy-userdebug
export TZ=Asia/Jakarta
export USE_NFSparts=true
export NFS_BUILD_VARIANT=overclock
curl -s -X POST "https://api.telegram.org/bot${tg_token}/sendMessage" -d chat_id="${tg_id}" -d "disable_web_page_preview=true" -d "parse_mode=html" -d text="===================================%0A<b>$device</b> Starting Building Rom%0A<b>$rom_name</b>%0A<b>VIP</b>$(echo "${var_cache_report_config}")"
brunch rosy

# end
