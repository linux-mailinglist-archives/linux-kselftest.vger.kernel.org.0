Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C69277F650
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 14:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350751AbjHQMSi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 08:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350788AbjHQMSL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 08:18:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC58B2136;
        Thu, 17 Aug 2023 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692274689; x=1723810689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R7GbZtMP0HvzCsiSFRt9ERnrFTV1Mg3gulQq+1nKZ7c=;
  b=H3H+IFni2g27vLV8QOsiK4vMERkq14vZgVbqwBJrYnmjv8MTKFUj7ahX
   MlMz3B/+ZyBH5aVCi3LebdrRonAlw8ibuwiWR1BYVGtx2xT2if/YZh2q+
   dwqAs7USDz0HcfF/k1rBq0IVfEzGLpP5+B6ECCpWaaGP9zSAdETm1Wrqs
   uNcdg1dGLtNDtUhuUW2nRJXW9JsuYb9ivbvkC/CQW2bSdNPyzJOLHkEiR
   Frz7dff1Wf3Xh6/4NQVR+AYdTfvomalpPDlaV2vkDCUnfKaM/mEMmSPCw
   tPg4JAplo4kPleCOB1nv81vV1q0Nq8/kUYc3ixSA2MteIFFcuhuhqb+fP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436696865"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="436696865"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:18:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848873202"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="848873202"
Received: from lababeix-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.212.52])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:18:05 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 10/10] selftests/pcie_bwctrl: Create selftests
Date:   Thu, 17 Aug 2023 15:17:08 +0300
Message-Id: <20230817121708.53213-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
References: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create selftests for PCIe BW control through the PCIe cooling device
sysfs interface.

First, the BW control selftest finds the PCIe port to test with. By
default, the PCIe port with the highest bus speed is selected but
another PCIe port can be provided with -d parameter.

The actual test steps the cur_state of the cooling device one-by-one
from max_state to what the cur_state was initially. The speed change
is confirmed by observing the current_link_speed for the corresponding
PCIe port.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/pcie_bwctrl/Makefile  |   2 +
 .../pcie_bwctrl/set_pcie_cooling_state.sh     | 122 ++++++++++++++++++
 .../selftests/pcie_bwctrl/set_pcie_speed.sh   |  67 ++++++++++
 5 files changed, 193 insertions(+)
 create mode 100644 tools/testing/selftests/pcie_bwctrl/Makefile
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_cooling_state.sh
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_speed.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index a0b40253fd5a..10146eba993f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16423,6 +16423,7 @@ S:	Supported
 F:	drivers/pci/pcie/bwctrl.c
 F:	drivers/thermal/pcie_cooling.c
 F:	include/linux/pci-bwctrl.h
+F:	tools/testing/selftests/pcie_bwctrl/
 
 PCIE DRIVER FOR AMAZON ANNAPURNA LABS
 M:	Jonathan Chocron <jonnyc@amazon.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 666b56f22a41..b8ebc324186e 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -56,6 +56,7 @@ TARGETS += net/mptcp
 TARGETS += net/openvswitch
 TARGETS += netfilter
 TARGETS += nsfs
+TARGETS += pcie_bwctrl
 TARGETS += pidfd
 TARGETS += pid_namespace
 TARGETS += powerpc
diff --git a/tools/testing/selftests/pcie_bwctrl/Makefile b/tools/testing/selftests/pcie_bwctrl/Makefile
new file mode 100644
index 000000000000..3e84e26341d1
--- /dev/null
+++ b/tools/testing/selftests/pcie_bwctrl/Makefile
@@ -0,0 +1,2 @@
+TEST_PROGS = set_pcie_cooling_state.sh
+include ../lib.mk
diff --git a/tools/testing/selftests/pcie_bwctrl/set_pcie_cooling_state.sh b/tools/testing/selftests/pcie_bwctrl/set_pcie_cooling_state.sh
new file mode 100755
index 000000000000..6edea316befd
--- /dev/null
+++ b/tools/testing/selftests/pcie_bwctrl/set_pcie_cooling_state.sh
@@ -0,0 +1,122 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+SYSFS=
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+retval=0
+skipmsg="skip all tests:"
+
+PCIEPORTTYPE="PCIe_Port"
+
+prerequisite()
+{
+	local ports
+
+	if [ $UID != 0 ]; then
+		echo $skipmsg must be run as root >&2
+		exit $ksft_skip
+	fi
+
+	SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
+
+	if [ ! -d "$SYSFS" ]; then
+		echo $skipmsg sysfs is not mounted >&2
+		exit $ksft_skip
+	fi
+
+	if ! ls $SYSFS/class/thermal/cooling_device* > /dev/null 2>&1; then
+		echo $skipmsg thermal cooling devices missing >&2
+		exit $ksft_skip
+        fi
+
+	ports=`grep -e "^$PCIEPORTTYPE" $SYSFS/class/thermal/cooling_device*/type | wc -l`
+	if [ $ports -eq 0 ]; then
+		echo $skipmsg pcie cooling devices missing >&2
+		exit $ksft_skip
+	fi
+}
+
+testport=
+find_pcie_port()
+{
+	local patt="$1"
+	local pcieports
+	local max
+	local cur
+	local delta
+	local bestdelta=-1
+
+	pcieports=`grep -l -F -e "$patt" /sys/class/thermal/cooling_device*/type`
+	if [ -z "$pcieports" ]; then
+		return
+	fi
+	pcieports=${pcieports//\/type/}
+	# Find the port with highest PCIe bus speed
+	for port in $pcieports; do
+		max=`cat $port/max_state`
+		cur=`cat $port/cur_state`
+		delta=$((max-cur))
+		if [ $delta -gt $bestdelta ]; then
+			testport="$port"
+			bestdelta=$delta
+		fi
+	done
+}
+
+sysfspcidev=
+find_sysfs_pci_dev()
+{
+	local typefile="$1/type"
+	local pcidir
+
+	pcidir="$SYSFS/bus/pci/devices/`sed -e "s|^${PCIEPORTTYPE}_||g" $typefile`"
+
+	if [ -r "$pcidir/current_link_speed" ]; then
+		sysfspcidev="$pcidir/current_link_speed"
+	fi
+}
+
+usage()
+{
+	echo "Usage $0 [ -d dev ]"
+	echo -e "\t-d: PCIe port BDF string (e.g., 0000:00:04.0)"
+}
+
+pattern="$PCIEPORTTYPE"
+parse_arguments()
+{
+	while getopts d:h opt; do
+		case $opt in
+			h)
+				usage "$0"
+				exit 0
+				;;
+			d)
+				pattern="$PCIEPORTTYPE_$OPTARG"
+				;;
+			*)
+				usage "$0"
+				exit 0
+				;;
+		esac
+	done
+}
+
+parse_arguments "$@"
+prerequisite
+find_pcie_port "$pattern"
+if [ -z "$testport" ]; then
+	echo $skipmsg "pcie cooling device not found from sysfs" >&2
+	exit $ksft_skip
+fi
+find_sysfs_pci_dev "$testport"
+if [ -z "$sysfspcidev" ]; then
+	echo $skipmsg "PCIe port device not found from sysfs" >&2
+	exit $ksft_skip
+fi
+
+./set_pcie_speed.sh "$testport" "$sysfspcidev"
+retval=$?
+
+exit $retval
diff --git a/tools/testing/selftests/pcie_bwctrl/set_pcie_speed.sh b/tools/testing/selftests/pcie_bwctrl/set_pcie_speed.sh
new file mode 100755
index 000000000000..584596949312
--- /dev/null
+++ b/tools/testing/selftests/pcie_bwctrl/set_pcie_speed.sh
@@ -0,0 +1,67 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -e
+
+TESTNAME=set_pcie_speed
+
+declare -a PCIELINKSPEED=(
+	"2.5 GT/s PCIe"
+	"5.0 GT/s PCIe"
+	"8.0 GT/s PCIe"
+	"16.0 GT/s PCIe"
+	"32.0 GT/s PCIe"
+	"64.0 GT/s PCIe"
+)
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+retval=0
+
+coolingdev="$1"
+statefile="$coolingdev/cur_state"
+maxfile="$coolingdev/max_state"
+linkspeedfile="$2"
+
+oldstate=`cat $statefile`
+maxstate=`cat $maxfile`
+
+set_state()
+{
+	local state=$1
+	local linkspeed
+	local expected_linkspeed
+
+	echo $state > $statefile
+
+	sleep 1
+
+	linkspeed="`cat $linkspeedfile`"
+	expected_linkspeed=$((maxstate-state))
+	expected_str="${PCIELINKSPEED[$expected_linkspeed]}"
+	if [ ! "${expected_str}" = "${linkspeed}" ]; then
+		echo "$TESTNAME failed: expected: ${expected_str}; got ${linkspeed}"
+		retval=1
+	fi
+}
+
+cleanup_skip ()
+{
+	set_state $oldstate
+	exit $ksft_skip
+}
+
+trap cleanup_skip EXIT
+
+echo "$TESTNAME: testing states $maxstate .. $oldstate with $coolingdev"
+for i in $(seq $maxstate -1 $oldstate); do
+	set_state "$i"
+done
+
+trap EXIT
+if [ $retval -eq 0 ]; then
+	echo "$TESTNAME [PASS]"
+else
+	echo "$TESTNAME [FAIL]"
+fi
+exit $retval
-- 
2.30.2

