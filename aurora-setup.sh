
export RELEASE_RPM=/kompile/TSUBASA-soft-release-*.noarch.rpm
mkdir -p /opt/nec/ve/sbin/
cp -rf /aurora/*.sh /opt/nec/ve/sbin

cp -rf /aurora/* /kompile
cp -rf /aurora/TSUBASA-repo.repo /etc/yum.repos.d/
cp -rf /aurora/TSUBASA-restricted.repo /etc/yum.repos.d/
mkdir -p /opt/nec/aur_license
cp -rf   /kompile/license.dat /opt/nec/aur_license/license.dat
cp -rf /kompile/aur_license.conf /opt/nec/aur_license/aur_license.conf

yum -y  install $RELEASE_RPM
 yum  clean all
yum clean expire-cache
TSUBASA_GROUPS="ve-frontend ve-devel nec-sdk-frontend"
/opt/nec/ve/sbin/TSUBASA-groups-remark.sh $TSUBASA_GROUPS
yum group install $TSUBASA_GROUPS


#VEDA/AVEO source build environment 
yum  -y install python2 systemd-devel libsysve-devel.x86_64 glibc-ve-devel kheaders-ve nec-nfort-3.5.1.x86_64 nec-nfort-shared-devel-3.5.1.x86_64 nec-nfort-shared-3.5.1.x86_64 nec-nfort-runtime.x86_64  veos-devel veos-headers nec-nc++-shared-3.5.1.x86_64    nec-nc++-shared-devel-3.5.1.x86_64 nec-veperf-devel.x86_64 nec-veperf-bin.x86_64 nec-veperf-libs.x86_64 libgcc-ve-static.x86_64 aurlic-lib nec-nc++-shared-3.5.1.x86_64 nec-nc++-3.5.1.x86_64 binutils-ve veoffload-aveo veosinfo.x86_64 aurlic-lib
ln -s /opt/nec/ve/bin/nc++-3.5.1 /opt/nec/ve/bin/nc++
ln -s /opt/nec/ve/bin/nfort-3.5.1 /opt/nec/ve/bin/nfort
ln -s /opt/nec/ve/bin/nc++-3.5.1 /opt/nec/ve/bin/ncc
ln -s /usr/bin/python2 /usr/bin/python
wget https://raw.githubusercontent.com/eclipse/deeplearning4j/master/libnd4j/build_ve_prerequisites.sh -O /kompile/build_ve_prerequisites.sh
wget https://raw.githubusercontent.com/eclipse/deeplearning4j/master/libnd4j/vednn_mergian.patch -O /kompile/vednn_mergian.patch
sed -i 's|sudo||' /kompile/build_ve_prerequisites.sh
sed -i 's|../vednn_mergian.patch|/kompile/vednn_mergian.patch|' /kompile/build_ve_prerequisites.sh
#patch to force the installation of the LLVME
sed -i 's|isLLVMVE=|isLLVMVE="is not installed" #|' /kompile/build_ve_prerequisites.sh
export VEDNN_ROOT=/kompile/vednn_lib/
cp -rf /kompile/aurora/veda/src/*.h ${VEDNN_ROOT}/include
cp -rf /kompile/aurora/veda/src/*ve/.h ${VEDNN_ROOT}/include

cd /kompile && bash build_ve_prerequisites.sh
