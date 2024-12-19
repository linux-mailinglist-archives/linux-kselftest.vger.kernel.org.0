Return-Path: <linux-kselftest+bounces-23587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F38D9F7D12
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6DA188CB06
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 14:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6549E2253F8;
	Thu, 19 Dec 2024 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XiYgSb1e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AB1805E;
	Thu, 19 Dec 2024 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618334; cv=none; b=LY01xuh1rGgasLv2enZ9F9Jta5akRvA0lPNQRmjsi7nEJN5zDHtZo5MtyM8y7TxqfuK3hen7gZbaNpxnNow8s1K0u4IPhCohdD09L0qsM7JMxEvuF/zG3G4MetFjf+K+9JayQ+MyjY8KAsPgFCg1YejrH6KKJz3hk6I8jn6HvO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618334; c=relaxed/simple;
	bh=mVU3TLMjNw6Ii9o4LnmOsBoifMtHa1ObfuFj+5j9sJo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rNqJjW2/Rc/4SncvEqsVRIu/gU3n2VmVilwSIBA6LuuN2MwrqPFej4I5klibvEBE2dkFdzL317AKvweqIUNegV+RB2JT6lc9h/YJL/xAGr1bZYhv43fwqndfOxb9p4YYD+GaXriGZVY8+LM4D/+ZDcCH7K9Eu0q5idtlSuaf/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XiYgSb1e; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJDSgEP008832;
	Thu, 19 Dec 2024 06:25:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=/eHr0PaiGQ2sS1UxM1MdyUx
	CdpaxnD74HMz+fDhjD6s=; b=XiYgSb1e0NKNOBd1TJsGaq0tD7V2j7q73aNVe6c
	55aKQzIw6y1hEKI0L9aCOK4eh20Kx8oXzUXeKTX++qzS7x+fAoESQwUPDbnkerRC
	vdtzpiCkvCjY0OTNOzHs9ir5IQBnqtgO1F9KAjRy9FUJ3jQlXvVDfQRaWn5qyL0w
	GcC2iXj82AvKUPjDUYuVyMKiY2I+GtZcTjvVMTj7Ds5sc++WYRBZNxTBKfeDIpkF
	/5Fjh/X47EKV2EqDpG3Jn+Fmt8GoBya09QTRURkHHKmBTJ+eeB9s2vDw1uoNGz4F
	qg+ICaFohNsoPHycRU733NyoItwcgc1uiO7E3pYEM9h+EfQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 43mmdf039a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 06:25:08 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 19 Dec 2024 06:25:06 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 19 Dec 2024 06:25:06 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id EF0AF5B6DC1;
	Thu, 19 Dec 2024 06:25:02 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v2] selftests: arm coresight: sysfsmode testing
Date: Thu, 19 Dec 2024 19:54:56 +0530
Message-ID: <20241219142456.3474879-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UWsjZAguFfkB_e1KdjHJm-Hb8myvNo5o
X-Proofpoint-GUID: UWsjZAguFfkB_e1KdjHJm-Hb8myvNo5o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Add sysfs mode selftest for ARM Coresight hardware tracer.

The test will run below sequence for all possible sinks for every
trace source available on the system.
1. Enable source and sink device to start tracing in sysfs mode
3. Run a standard dd command to be traced
4. Stop tracing
5. Readback tracedata

- Test case is pass if the readback of tracedata is success else
failure.
- In case of ETR sink, the test is run with both default buffer mode and
reserved buffer mode(if available).

Sample output:

 selftests: drivers/hwtracing/coresight: sysfs_test_trace.sh
 Running sysfs trace with default settings
 64+0 records in
 64+0 records out
 67108864 bytes (67 MB, 64 MiB) copied, 0.196945 s, 341 MB/s
 32+0 records in
 32+0 records out
 16384 bytes (16 kB, 16 KiB) copied, 0.000805288 s, 20.3 MB/s
 CoreSight path testing (CPU0 -> tmc_etf0): PASS

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v1:
- Added test description in commit message suggested by Shuah
- Added config dependency file suggested by Shuah 
- Added TARGETS as suggested by James
- Skipped TPIU as suggested by James 
- Added Reviewed-by tag


 tools/testing/selftests/Makefile              |   1 +
 .../drivers/hwtracing/coresight/Makefile      |   5 +
 .../drivers/hwtracing/coresight/config        |   7 +
 .../hwtracing/coresight/sysfs_test_trace.sh   | 146 ++++++++++++++++++
 4 files changed, 159 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/hwtracing/coresight/Makefile
 create mode 100644 tools/testing/selftests/drivers/hwtracing/coresight/config
 create mode 100755 tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 363d031a16f7..15788c32de6b 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -18,6 +18,7 @@ TARGETS += devices/error_logs
 TARGETS += devices/probe
 TARGETS += dmabuf-heaps
 TARGETS += drivers/dma-buf
+TARGETS += drivers/hwtracing/coresight
 TARGETS += drivers/s390x/uvdevice
 TARGETS += drivers/net
 TARGETS += drivers/net/bonding
diff --git a/tools/testing/selftests/drivers/hwtracing/coresight/Makefile b/tools/testing/selftests/drivers/hwtracing/coresight/Makefile
new file mode 100644
index 000000000000..7dc68ae1c0a9
--- /dev/null
+++ b/tools/testing/selftests/drivers/hwtracing/coresight/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_PROGS = sysfs_test_trace.sh
+
+include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/hwtracing/coresight/config b/tools/testing/selftests/drivers/hwtracing/coresight/config
new file mode 100644
index 000000000000..47e9256957d3
--- /dev/null
+++ b/tools/testing/selftests/drivers/hwtracing/coresight/config
@@ -0,0 +1,7 @@
+CONFIG_CORESIGHT=y
+CONFIG_CORESIGHT_LINKS_AND_SINKS=y
+CONFIG_CORESIGHT_LINK_AND_SINK_TMC=y
+CONFIG_CORESIGHT_SINK_ETBV10
+CONFIG_CORESIGHT_SOURCE_ETM3X
+CONFIG_CORESIGHT_SOURCE_ETM4X=y
+CONFIG_CORESIGHT_TRBE=y
diff --git a/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh b/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
new file mode 100755
index 000000000000..1939bbede1af
--- /dev/null
+++ b/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
@@ -0,0 +1,146 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 Marvell.
+
+# Test Arm CoreSight trace capture in sysfs mode
+# Based on tools/perf/tests/shell/test_arm_coresight.sh
+
+glb_err=0
+
+arm_cs_report() {
+	if [ $2 != 0 ]; then
+		echo "$1: FAIL"
+		glb_err=$2
+	else
+		echo "$1: PASS"
+	fi
+}
+
+is_device_sink() {
+	# If the node of "enable_sink" is existed under the device path, this
+	# means the device is a sink device. Need to exclude 'tpiu' since it
+	# doesn't have a readable file.
+	echo "$1" | grep -E -q -v "tpiu"
+
+	if [ $? -eq 0 ] && [ -e "$1/enable_sink" ]; then
+
+		return 0
+	else
+		return 1
+	fi
+}
+
+# Configure sink for buffer mode
+cfg_sink_buf_mode() {
+	sink_dev=$1
+	mode=$2
+	# Set buffer mode if supported
+	if [ -e "$sink_dev/buf_modes_available" ]; then
+		cat $sink_dev/buf_modes_available | grep -E -q $mode
+		if [ $? -eq 0 ]; then
+			echo $mode > $sink_dev/buf_mode_preferred
+			return 0
+		fi
+	fi
+
+	return 1
+}
+
+run_app() {
+
+	taskset -c $1 dd if=/dev/urandom  of=/dev/null bs=1M count=64
+}
+
+sysfs_trace() {
+	src_dev=$1
+	sink_dev=$2
+	cpu=$3
+
+	# Enable sink device
+	echo 1 > $sink_dev/enable_sink
+	# Enable source device
+	echo 1 > $src_dev/enable_source
+
+	# Run app to be traced
+	run_app $cpu
+
+	# Read back trace data
+	dd if=/dev/$sink_dev_name of=/tmp/tracedata
+
+	# Verify if read is successful
+	err=$?
+
+	# Disable source device
+	echo 0 > $src_dev/enable_source
+
+	# Diskable sink device
+	echo 0 > $sink_dev/enable_sink
+
+	arm_cs_report "CoreSight path testing (CPU$cpu -> $sink_dev_name)" $err
+}
+
+try_sysfs_trace_resrv_buf() {
+	src_dev=$1
+	sink_dev=$2
+	cpu=$3
+
+	# Configure the resrved buffer mode if available
+	cfg_sink_buf_mode $sink_dev "resrv"
+	if [ $? -eq 0 ]; then
+		echo "Running sysfs trace with resrv buf mode"
+		sysfs_trace $src_dev $sink_dev $cpu
+		# Restore buffer mode
+		cfg_sink_buf_mode $sink_dev "auto"
+		if [ $? -eq 1 ]; then
+			echo "Failed to restore default buf mode"
+		fi
+	fi
+}
+
+arm_cs_iterate_devices() {
+	src_dev=$1
+	cpu=$3
+	for cdev in $2/connections/out\:*; do
+
+		# Skip testing if it's not a directory
+		! [ -d $cdev ] && continue;
+
+		# Read out its symbol link file name
+		sink_dev=`readlink -f $cdev`
+
+		# Extract device name from path, e.g.
+		#   sink_dev = '/sys/devices/platform/20010000.etf/tmc_etf0'
+		#     `> sink_dev_name = 'tmc_etf0'
+		sink_dev_name=$(basename $sink_dev)
+
+		if is_device_sink $sink_dev; then
+			# Run trace with resrv buf mode (if available)
+			try_sysfs_trace_resrv_buf $src_dev $sink_dev $cpu
+
+			# Run the default mode
+			echo "Running sysfs trace with default settings"
+			sysfs_trace $src_dev $sink_dev $cpu
+		fi
+
+		arm_cs_iterate_devices $src_dev $cdev $cpu
+
+	done
+}
+
+arm_cs_etm_traverse_path_test() {
+	# Iterate for every ETM device
+	for dev in /sys/bus/event_source/devices/cs_etm/cpu*; do
+		# Canonicalize the path
+		dev=`readlink -f $dev`
+
+		# Find the ETM device belonging to which CPU
+		cpu=`cat $dev/cpu`
+
+		# Use depth-first search (DFS) to iterate outputs
+		arm_cs_iterate_devices $dev $dev $cpu
+	done
+}
+
+arm_cs_etm_traverse_path_test
+
+exit $glb_err
-- 
2.34.1


