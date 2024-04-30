Return-Path: <linux-kselftest+bounces-9105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF878B68C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 05:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1641C20A7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 03:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2372315E96;
	Tue, 30 Apr 2024 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fb0zkyY2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1542011733;
	Tue, 30 Apr 2024 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447891; cv=none; b=FIaegW31bkUh1L3NgrAUS1oGgwTGmZhkUnU1+1f9P8qR7/lAGma1KpJxpLJ9izCtzqoXOfqSW+MvAnYSnI6DS+VKBWVaZ2mbQDee9gxsNSU4UUymO+xAJUKB0veYUr5Mo50BI4l4PVLzpnLEXg0vraBDsHTVN9WuDh3ezlhFHpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447891; c=relaxed/simple;
	bh=fd+G6OGLz8S4kkn4I/eFWE5sjfuiyw7aT7853vqCYds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScEEGS6DjaVYNpxFnpf/kMk51NCHOhgEIQXiK4xbUDHrOuV33GHH4hYRJ5PgrapNkpGqyOPpSKTh3ltqimJ1iAx7iqKDFLW/7z0fnLgTMWwfn8wRaiygE9DeRX09fKjrbzy6XPjSS5Yaaolx8ZlOJZRiF2nrX1aA9QdL7Aisdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fb0zkyY2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714447889; x=1745983889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fd+G6OGLz8S4kkn4I/eFWE5sjfuiyw7aT7853vqCYds=;
  b=fb0zkyY2HtmszyHBMjYNljMGPeDBZ71cXNp2T0WTlW+Po9CgqbJcgXr/
   ihYj7SiQJkImfK1i7IrG/q3qOzO9FW5s0L5moHvtJz2M1ypSqkgSryqly
   xBu0QrNzatiLK22C2iHCklvbMXI+Zg0d5KdfBwBKbJihPO43OJ7UdesAH
   wr7awBvgSYQ9T79ZcBpbbtQvkbIOaB5EUxtAhzxRaDL5pOq+0r8+fYVtj
   A2W2A6KXpe8cayCcPZKd3lFY7Ijqj5MHAKbyKDMttbw6P0BHwTrVEtSQO
   gAdxeifr+suPhHwa7+LE8W/GzYrRsUWvz7g3aiY3aFSfpn3QMzkEQFaxP
   A==;
X-CSE-ConnectionGUID: z3ulGxTPQf68JYuWN1qPyg==
X-CSE-MsgGUID: +1Q8WBFwQtaPSHr4SORfiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21284180"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21284180"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 20:31:29 -0700
X-CSE-ConnectionGUID: EVDuu0iWT9yHkO8nMZFz2g==
X-CSE-MsgGUID: BPioWqPaRbyRa4oveRmxbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26820001"
Received: from xpf.sh.intel.com ([10.239.182.130])
  by orviesa007.jf.intel.com with ESMTP; 29 Apr 2024 20:31:26 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	shuah@kernel.org,
	linux-kselftest <linux-kselftest@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	jithu.joseph@intel.com,
	Pengfei Xu <pengfei.xu@intel.com>,
	ashok.raj@intel.com,
	sathyanarayanan.kuppuswamy@intel.com
Subject: [PATCH v1 1/4] selftests: ifs: verify test interfaces are created by the driver
Date: Tue, 30 Apr 2024 11:31:45 +0800
Message-ID: <d966c895ce33663ce897b431835cec768189a865.1714447026.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714447026.git.pengfei.xu@intel.com>
References: <cover.1714447026.git.pengfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IFS (In Field Scan) driver exposes its functionality via sysfs interfaces.
Applications prepare and exercise the tests by interacting with the
aforementioned sysfs files.

Verify that the necessary sysfs entries are created after loading the IFS
driver.

Initialize test variables needed for building subsequent kself-test cases.

Reviewed-by: Jithu Joseph <jithu.joseph@intel.com>
Co-developed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 .../drivers/platform/x86/intel/ifs/Makefile   |   6 +
 .../platform/x86/intel/ifs/test_ifs.sh        | 181 ++++++++++++++++++
 4 files changed, 189 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/platform/x86/intel/ifs/Makefile
 create mode 100755 tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index f6dc90559341..2eb18207dfac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10951,6 +10951,7 @@ R:	Tony Luck <tony.luck@intel.com>
 S:	Maintained
 F:	drivers/platform/x86/intel/ifs
 F:	include/trace/events/intel_ifs.h
+F:	tools/testing/selftests/drivers/platform/x86/intel/ifs/
 
 INTEL INTEGRATED SENSOR HUB DRIVER
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index e1504833654d..adc023641502 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -19,6 +19,7 @@ TARGETS += drivers/dma-buf
 TARGETS += drivers/s390x/uvdevice
 TARGETS += drivers/net/bonding
 TARGETS += drivers/net/team
+TARGETS += drivers/platform/x86/intel/ifs
 TARGETS += dt
 TARGETS += efivarfs
 TARGETS += exec
diff --git a/tools/testing/selftests/drivers/platform/x86/intel/ifs/Makefile b/tools/testing/selftests/drivers/platform/x86/intel/ifs/Makefile
new file mode 100644
index 000000000000..03d0449d307c
--- /dev/null
+++ b/tools/testing/selftests/drivers/platform/x86/intel/ifs/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for ifs(In Field Scan) selftests
+
+TEST_PROGS := test_ifs.sh
+
+include ../../../../../lib.mk
diff --git a/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh b/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
new file mode 100755
index 000000000000..54466d452b2f
--- /dev/null
+++ b/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
@@ -0,0 +1,181 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test the functionality of the Intel IFS(In Field Scan) driver.
+#
+
+# Matched with kselftest framework: tools/testing/selftests/kselftest.h
+readonly KSFT_PASS=0
+readonly KSFT_FAIL=1
+readonly KSFT_XFAIL=2
+readonly KSFT_SKIP=4
+
+readonly IFS_SCAN_MODE="0"
+readonly IFS_PATH="/sys/devices/virtual/misc/intel_ifs"
+readonly IFS_SCAN_SYSFS_PATH="${IFS_PATH}_${IFS_SCAN_MODE}"
+readonly PASS="PASS"
+readonly FAIL="FAIL"
+readonly INFO="INFO"
+readonly XFAIL="XFAIL"
+readonly SKIP="SKIP"
+readonly IFS_NAME="intel_ifs"
+
+# Matches arch/x86/include/asm/intel-family.h and
+# drivers/platform/x86/intel/ifs/core.c requirement as follows
+readonly SAPPHIRERAPIDS_X="8f"
+readonly EMERALDRAPIDS_X="cf"
+
+readonly INTEL_FAM6="06"
+
+FML=""
+MODEL=""
+
+TRUE="true"
+FALSE="false"
+RESULT=$KSFT_PASS
+export INTERVAL_TIME=1
+# For IFS cleanup tags
+ORIGIN_IFS_LOADED=""
+IFS_LOG="/tmp/ifs_logs.$$"
+
+append_log()
+{
+	echo -e "$1" | tee -a "$IFS_LOG"
+}
+
+ifs_scan_result_summary()
+{
+	local failed_info pass_num skip_num fail_num
+
+	if [[ -e "$IFS_LOG" ]]; then
+		failed_info=$(grep ^"\[${FAIL}\]" "$IFS_LOG")
+		fail_num=$(grep -c ^"\[${FAIL}\]" "$IFS_LOG")
+		skip_num=$(grep -c ^"\[${SKIP}\]" "$IFS_LOG")
+		pass_num=$(grep -c ^"\[${PASS}\]" "$IFS_LOG")
+
+		if [[ "$fail_num" -ne 0 ]]; then
+			RESULT=$KSFT_FAIL
+			echo "[$INFO] IFS test failure summary:"
+			echo "$failed_info"
+		elif [[ "$skip_num" -ne 0 ]]; then
+			RESULT=$KSFT_SKIP
+		fi
+			echo "[$INFO] IFS test pass:$pass_num, skip:$skip_num, fail:$fail_num"
+	else
+		echo "[$INFO] No file $IFS_LOG for IFS scan summary"
+	fi
+}
+
+ifs_cleanup()
+{
+	lsmod | grep -q "$IFS_NAME" && [[ "$ORIGIN_IFS_LOADED" == "$FALSE" ]] && {
+		echo "[$INFO] modprobe -r $IFS_NAME"
+		modprobe -r "$IFS_NAME"
+	}
+
+	ifs_scan_result_summary
+	[[ -e "$IFS_LOG" ]] && rm -rf "$IFS_LOG"
+
+	echo "[RESULT] IFS test exit with $RESULT"
+	exit "$RESULT"
+}
+
+test_exit()
+{
+	local info=$1
+	RESULT=$2
+
+	declare -A EXIT_MAP
+	EXIT_MAP[$KSFT_PASS]=$PASS
+	EXIT_MAP[$KSFT_FAIL]=$FAIL
+	EXIT_MAP[$KSFT_XFAIL]=$XFAIL
+	EXIT_MAP[$KSFT_SKIP]=$SKIP
+
+	append_log "[${EXIT_MAP[$RESULT]}] $info"
+	ifs_cleanup
+}
+
+get_cpu_fms()
+{
+	FML=$(grep -m 1 "family" /proc/cpuinfo | awk -F ":" '{printf "%02x",$2;}')
+	MODEL=$(grep -m 1 "model" /proc/cpuinfo | awk -F ":" '{printf "%02x",$2;}')
+}
+
+check_cpu_ifs_support_interval_time()
+{
+	get_cpu_fms
+
+	if [[ "$FML" != "$INTEL_FAM6" ]]; then
+		test_exit "CPU family:$FML does not support IFS" "$KSFT_SKIP"
+	fi
+
+	# Ucode has time interval requirement for IFS scan on same CPU as follows:
+	case $MODEL in
+		"$SAPPHIRERAPIDS_X")
+			INTERVAL_TIME=180;
+			;;
+		"$EMERALDRAPIDS_X")
+			INTERVAL_TIME=30;
+			;;
+		*)
+			# Set default interval time for other platforms
+			INTERVAL_TIME=1;
+			append_log "[$INFO] CPU FML:$FML model:0x$MODEL, default: 1s interval time"
+			;;
+	esac
+}
+
+check_ifs_loaded()
+{
+	local ifs_info=""
+
+	ifs_info=$(lsmod | grep "$IFS_NAME")
+	if [[ -z "$ifs_info" ]]; then
+		append_log "[$INFO] modprobe $IFS_NAME"
+		modprobe "$IFS_NAME" || {
+			test_exit "Check if CONFIG_INTEL_IFS is set to m or \
+platform doesn't support ifs" "$KSFT_SKIP"
+		}
+		ifs_info=$(lsmod | grep "$IFS_NAME")
+		[[ -n "$ifs_info" ]] || test_exit "No ifs module listed by lsmod" "$KSFT_FAIL"
+	fi
+}
+
+test_ifs_scan_entry()
+{
+	local ifs_info=""
+	local ifs_entry=""
+
+	ifs_info=$(lsmod | grep "$IFS_NAME")
+
+	if [[ -z "$ifs_info" ]]; then
+		ORIGIN_IFS_LOADED="$FALSE"
+		check_ifs_loaded
+	else
+		ORIGIN_IFS_LOADED="$TRUE"
+		append_log "[$INFO] Module $IFS_NAME is already loaded"
+	fi
+
+	ifs_entry=$(ls "$IFS_SCAN_SYSFS_PATH" 2>/dev/null)
+	if [[ -z "$ifs_entry" ]]; then
+		test_exit "No sysfs entry in $IFS_SCAN_SYSFS_PATH" "$KSFT_FAIL"
+	else
+		append_log "[$PASS] IFS sysfs $IFS_SCAN_SYSFS_PATH entry is created\n"
+	fi
+}
+
+prepare_ifs_test_env()
+{
+	check_cpu_ifs_support_interval_time
+}
+
+test_ifs()
+{
+	prepare_ifs_test_env
+
+	test_ifs_scan_entry
+}
+
+trap ifs_cleanup SIGTERM SIGINT
+test_ifs
+ifs_cleanup
-- 
2.43.0


