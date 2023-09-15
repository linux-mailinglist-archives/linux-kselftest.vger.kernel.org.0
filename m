Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE897A1E02
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 14:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjIOMEe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 08:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjIOMEd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 08:04:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8433A87;
        Fri, 15 Sep 2023 05:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694779422; x=1726315422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0aSOAVXV3pig4axO9+jHlML+tu/afJdMdghU/1L+h8Q=;
  b=LYnF/WXkwsqXg5q3WVKYknZVhocc3RVjBdRDL2kcRSDtNX4/da+tX257
   pAt6W13pGA8bdxdffCQTURqXVd4JJ/uPSZwEAS5R/IpubkuyDrpypBs8t
   m4x97iMWHSzJS9EFQsJNw6PUXXnnTMfK+0KohRKcL/+BDpWXZx74nEALM
   U2qWIlyp3e5EZOfKvcOafDJKDjEwFLTyiW+IrliP3acuIJtjegk+FkRKo
   jACKJ2dcQFeyqKnHeS8sjXwMlakvhl6ubBu/52m99VrpSD+/vHes8qqtO
   eSP6+WpUj7KBZ6qttBxwuY36wm1WdrySehQMsgfirnq/ND7KxChX3rHr5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="378146139"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="378146139"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 05:02:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="774293067"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="774293067"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 05:02:51 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 10/10] selftests/pcie_bwctrl: Create selftests
Date:   Fri, 15 Sep 2023 15:01:42 +0300
Message-Id: <20230915120142.32987-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230915120142.32987-1-ilpo.jarvinen@linux.intel.com>
References: <20230915120142.32987-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 32974417ad52..84e6687a646b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16575,6 +16575,7 @@ S:	Supported
 F:	drivers/pci/pcie/bwctrl.c
 F:	drivers/thermal/pcie_cooling.c
 F:	include/linux/pci-bwctrl.h
+F:	tools/testing/selftests/pcie_bwctrl/
 
 PCIE DRIVER FOR AMAZON ANNAPURNA LABS
 M:	Jonathan Chocron <jonnyc@amazon.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 42806add0114..18ad9acd440a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -59,6 +59,7 @@ TARGETS += net/mptcp
 TARGETS += net/openvswitch
 TARGETS += netfilter
 TARGETS += nsfs
+TARGETS += pcie_bwctrl
 TARGETS += perf_events
 TARGETS += pidfd
 TARGETS += pid_namespace
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
index 000000000000..3a8f91f0309e
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
+PCIEPORTTYPE="PCIe_Port_Link_Speed"
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
+	# Find the port with the highest PCIe Link Speed
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

