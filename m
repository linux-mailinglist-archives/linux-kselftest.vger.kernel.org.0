Return-Path: <linux-kselftest+bounces-10987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642DE8D5C19
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 09:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881971C21E8C
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 07:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6BD77110;
	Fri, 31 May 2024 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z48kPJMo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618E745F0;
	Fri, 31 May 2024 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717142015; cv=none; b=qjFFXucfwNmF/Zuld21Foh6hATEie1mh4sw/belJRheNkY0n5VVWvoOkViUZmqnBEjgF3XXg/fMLc5rnz5VKLNJLOwTssy8PBL4vAyl2cMf9hfe1WugQIIpgh9LbIcqxTVA2ZRqGvozSd1IML10zh4dPi/wztZhvi6zchdtqOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717142015; c=relaxed/simple;
	bh=Y2Pdb5m3R+o6qe2/2KqduU+VnqRCNfGLA572dfNYqI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xh6CaBpW0Sy+vsgrK9LrgHIV/EtzefgcRhWXWNaxCxqPnDAMg6iFy9C6QmsjdyvGSOqMMhiLejyQPOCwMpekL6AIYcT3swFFSd8ppDitcXIYnNPE7ulJrfbPVV3IiVMYm620NjlizYC2yrKmFZD7408wsHeLCsExYd/x1elb/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z48kPJMo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717142011; x=1748678011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y2Pdb5m3R+o6qe2/2KqduU+VnqRCNfGLA572dfNYqI4=;
  b=Z48kPJMojk9TbK0rSAuRYVt171blVzj5DBgcED2AWjmzaF5EaS3oaG8b
   f1q1qNAhPb87WJgl6Tu51PtMCEix+my4xhwJDNG0N1OPacxKFzutbla76
   CduQk3onHAFCFLbJlFWPZc7jmRjvMz1kS8hdxI3t3EXc2bv2TztywW2oG
   rMqnoQHsvKNiGA71gmlY5GOqB6mUoLcOUn3VYmhyH0lQRyn8IOnKyb8V2
   Z3uQkXOcSw2dpiQUzciK3iArfpNhyx7djGRl+TBkyelQt40a1Y8tBgBKP
   FpxMWZp4+1a6Lbc2LSa78st/KAegj65HRwTE9x/Lbm4D76ofCWqAuL35+
   A==;
X-CSE-ConnectionGUID: eStKFyfURmSumdjZWNpXTA==
X-CSE-MsgGUID: WBXXo7TTQem36I5HP5cRvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24336926"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="24336926"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 00:53:31 -0700
X-CSE-ConnectionGUID: jgEskKJARjqxOG0U6SNUxg==
X-CSE-MsgGUID: +5Xf9ZJTSY2q9MRD1JB+SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36081090"
Received: from xpf.sh.intel.com ([10.239.182.130])
  by fmviesa008.fm.intel.com with ESMTP; 31 May 2024 00:53:27 -0700
From: Pengfei Xu <pengfei.xu@intel.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	shuah@kernel.org,
	linux-kselftest <linux-kselftest@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	jithu.joseph@intel.com,
	Pengfei Xu <pengfei.xu@intel.com>,
	ashok.raj@intel.com,
	sathyanarayanan.kuppuswamy@intel.com
Subject: [PATCH v2 1/4] selftests: ifs: verify test interfaces are created by the driver
Date: Fri, 31 May 2024 15:53:47 +0800
Message-ID: <1de309da0eb6379cf6c675f15a1e11e2a42217b9.1717137348.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1717137348.git.pengfei.xu@intel.com>
References: <cover.1717137348.git.pengfei.xu@intel.com>
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
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Co-developed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 .../drivers/platform/x86/intel/ifs/Makefile   |   6 +
 .../platform/x86/intel/ifs/test_ifs.sh        | 179 ++++++++++++++++++
 4 files changed, 187 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/platform/x86/intel/ifs/Makefile
 create mode 100755 tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..c7b4eb218eed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11144,6 +11144,7 @@ R:	Tony Luck <tony.luck@intel.com>
 S:	Maintained
 F:	drivers/platform/x86/intel/ifs
 F:	include/trace/events/intel_ifs.h
+F:	tools/testing/selftests/drivers/platform/x86/intel/ifs/
 
 INTEL INTEGRATED SENSOR HUB DRIVER
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9039f3709aff..06eed383fdc0 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -21,6 +21,7 @@ TARGETS += drivers/net
 TARGETS += drivers/net/bonding
 TARGETS += drivers/net/team
 TARGETS += drivers/net/virtio_net
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
index 000000000000..90d099578199
--- /dev/null
+++ b/tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
@@ -0,0 +1,179 @@
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
+	if [[ -d "$IFS_SCAN_SYSFS_PATH" ]]; then
+		append_log "[$PASS] IFS sysfs $IFS_SCAN_SYSFS_PATH entry is created\n"
+	else
+		test_exit "No sysfs entry in $IFS_SCAN_SYSFS_PATH" "$KSFT_FAIL"
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


