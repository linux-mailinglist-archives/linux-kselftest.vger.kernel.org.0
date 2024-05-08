Return-Path: <linux-kselftest+bounces-9705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CB08BFF7D
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 15:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8A01F2B5F6
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552B279DD4;
	Wed,  8 May 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIOIDary"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B321A2C11;
	Wed,  8 May 2024 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176200; cv=none; b=IHITbBpaXt8oXszTDN25izmh/fdT0XbDEBxqq/c5MxvE6DVjq/LgtnJJWAGKlREtIVwN7b/lYA7h/498VSm2+kfftv3vY7csOMxydRtKoh2qjbvg7MVDxcTCVwdo7txHbCRwZhVjJJ6YG3L4BFlALapHtxRgYxP4Q1XKh3Yy064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176200; c=relaxed/simple;
	bh=z1bEIZI1MNH9EenT73hgXO8ZkeN9edr3Kn7/hFxax9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6pFUO7DJ9w9+YI8g4gDlNMblbMoV7aoYQ5+HgQ0C5x95C6uAOqZXoDQJLR2MDPwPS9otpORsfMEWdRpAcT+HhABXvuN9tIvwee2z+MfE3pbrQyp8dG+6NdxZzR9hWUcWHguzMSsr5JPpaODMIhxkIhq+lHr1WeugsIlSNIOGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIOIDary; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715176198; x=1746712198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z1bEIZI1MNH9EenT73hgXO8ZkeN9edr3Kn7/hFxax9s=;
  b=LIOIDarymB4NiIwh9KfyA/C8mImnq/+AXXvi1FTG7APeM++Y2L2AJNfc
   hNW0O5Ve0jIOxBci3S/N1K82QoiYT1snPcnIHiV/DIZt17znoYSF6CLBG
   FM/YpYJiQfZbbQOwT42iVvdkAuKmWWWNIVYasc0Smr7WduQUyx9ygaS6R
   d8rn9u1GMSjJKh7xfQqvpt7pQ+qIvSKW95Zk0vVZAV8aHvKZ6QoXBMgaX
   PdsHCjfuCWrjw2Fx+jVWzc0VE/jjayHhUW0ciKEXPBXYeHGAYvvCQPmh8
   qFk+3EqU6RkTcl3D4LDRI7ncg/wHEiF8i6WiMrc4IEeM0eY9ccYYLG6Ki
   g==;
X-CSE-ConnectionGUID: pn8JSyZXQImQCgMN6td/Vg==
X-CSE-MsgGUID: GbP2u5LsRrS8G+52bBi3yA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10906704"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10906704"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:49:43 -0700
X-CSE-ConnectionGUID: YQXKHuBjRF2jRCIHJ8tR9w==
X-CSE-MsgGUID: C7Lqb68eT8iGRXzNVoD2UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28855409"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.80])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:49:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v5 8/8] selftests/pcie_bwctrl: Create selftests
Date: Wed,  8 May 2024 16:47:44 +0300
Message-Id: <20240508134744.52134-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508134744.52134-1-ilpo.jarvinen@linux.intel.com>
References: <20240508134744.52134-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create selftests for PCIe BW control through the PCIe cooling device
sysfs interface.

First, the BW control selftest finds the PCIe Port to test with. By
default, the PCIe Port with the highest Link Speed is selected but
another PCIe Port can be provided with -d parameter.

The actual test steps the cur_state of the cooling device one-by-one
from max_state to what the cur_state was initially. The speed change
is confirmed by observing the current_link_speed for the corresponding
PCIe Port.

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
index 3a94ae81b13f..5a3b69515256 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17106,6 +17106,7 @@ S:	Supported
 F:	drivers/pci/pcie/bwctrl.c
 F:	drivers/thermal/pcie_cooling.c
 F:	include/linux/pci-bwctrl.h
+F:	tools/testing/selftests/pcie_bwctrl/
 
 PCIE DRIVER FOR AMAZON ANNAPURNA LABS
 M:	Jonathan Chocron <jonnyc@amazon.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index e1504833654d..ac0bc8af4123 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -65,6 +65,7 @@ TARGETS += net/openvswitch
 TARGETS += net/tcp_ao
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
index 000000000000..9df606552af3
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
+	fi
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
2.39.2


