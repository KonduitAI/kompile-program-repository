
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
TSUBASA_GROUPS="ve-frontend nec-sdk-frontend nec-mpi-frontend"
/opt/nec/ve/sbin/TSUBASA-groups-remark.sh $TSUBASA_GROUPS
yum group install $TSUBASA_GROUPS

#VEDA/AVEO source build environment
yum  -y -q install  systemd-devel libsysve-devel.x86_64 glibc-ve-devel kheaders-ve  veos-devel veos-headers libgcc-ve-static.x86_64 aurlic-lib binutils-ve binutils-ve.src
 yum -y -q install aurlic-lib
wget https://raw.githubusercontent.com/eclipse/deeplearning4j/master/libnd4j/build_ve_prerequisites.sh -O /kompile/build_ve_prerequisites.sh
wget https://raw.githubusercontent.com/eclipse/deeplearning4j/master/libnd4j/vednn_mergian.patch -O /kompile/vednn_mergian.patch
sed -i 's|sudo||' /kompile/build_ve_prerequisites.sh
sed -i 's|../vednn_mergian.patch|/kompile/vednn_mergian.patch|' /kompile/build_ve_prerequisites.sh
#patch to force the installation of the LLVME
sed -i 's|isLLVMVE=|isLLVMVE="is not installed" #|' /kompile/build_ve_prerequisites.sh
cd /kompile && bash build_ve_prerequisites.sh
