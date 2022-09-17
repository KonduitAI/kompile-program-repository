cp -rf /aurora/TSUBASA-repo.repo /etc/yum.repos.d/
cp -rf /aurora/TSUBASA-restricted.repo /etc/yum.repos.d/
export RELEASE_RPM=/aurora/TSUBASA-soft-release-*.noarch.rpm
cp -rf   /aurora/license.dat /opt/nec/aur_license/license.dat
cp -rf /aurora/aur_license.conf /opt/nec/aur_license/aur_license.conf

RUN yum -y  install $RELEASE_RPM
RUN yum  clean all
RUN yum clean expire-cache
RUN yum -y  group install ve-container nec-sdk-devel
#VEDA/AVEO source build environment
RUN yum  -y -q install  systemd-devel libsysve-devel.x86_64 glibc-ve-devel kheaders-ve  veos-devel veos-headers libgcc-ve-static.x86_64 aurlic-lib
RUN  yum -y -q install aurlic-lib
