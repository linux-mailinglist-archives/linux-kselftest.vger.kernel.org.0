Return-Path: <linux-kselftest+bounces-22610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 186759DC09C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 09:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D6ABB212EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 08:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7667165F16;
	Fri, 29 Nov 2024 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="akR4EM/h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C66B15A87C;
	Fri, 29 Nov 2024 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732869555; cv=none; b=YtJbjuji4zMDBjtoLCctBfJECYnnNTj9NZr65TllcY05OXVCk+l+xQyBLcnYNLU8ssda/vptOe7FRH9LMRR7dQCKZdL3yYAsyfMImc8ud6jMMfZ2SgVPoCaJsh+5z1JaYOPLngJU4CddjY7oUFjSULTqPT2OCg5KGxF2mQfaQJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732869555; c=relaxed/simple;
	bh=Ymeak364HqFk5cSk+zepi3oPCgN1yqHX9/SR9bkJGVk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qw3sBCB+jVKtl6zPc34jTzB6iCb6f0Ft2AkHIHnf8BrulZF8UBPPPNdam1e9yDRhoU43m2NogT2lsjLzFQOS2irxPtZ9PLJ7AwdRPpCjR0FMHi2G6IV9K31ZQjAtC936npk3zlDNHHG9YQM30Y2EFKcDrf46wIXTfUn0qhqSw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=akR4EM/h; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT0elD7006143;
	Fri, 29 Nov 2024 00:38:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=uXaTNcizPFtrjfJCKxSTpBX
	DXP7TU5grf9fdjWdXyTQ=; b=akR4EM/hAjhYqghMPgwENZjraaFNJIXHN/cG0dU
	oKfvZa4BdkM9UKLXMSeKIf1JuQ0yZllX/2PHxEOJSlTAMEXMp3eCcF3F0LFoe1C3
	JisSEQTPYvuyQBFBNIVXa6Wbh1lQ8mRfr/j8f5FlZH6B8y3v2h3fu/H8VhRUsZSo
	HDJpswaDP2OVzo+1VulkKAlylMNJdih3XuWJWJbl0mZCGp457iV208qLWjQn1Lg6
	1DPr5+zhUhrDgmWMuXO6XEp+ZVyXo9cX0e8afGLNJ2MY4yIQHAowo2KNb02DQN58
	CGYCiFynz/pXtKOSQhNByI7dJN9Zg5Wcmv3qNCVm/P1ck/Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4373908pem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 00:38:50 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 29 Nov 2024 00:38:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 29 Nov 2024 00:38:49 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 550025C68E3;
	Fri, 29 Nov 2024 00:38:46 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH] selftests: arm coresight: sysfsmode testing
Date: Fri, 29 Nov 2024 14:08:13 +0530
Message-ID: <20241129083813.3056909-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: fLBNjfFICIZSKiPtWRJvfwUFkCU59geJ
X-Proofpoint-ORIG-GUID: fLBNjfFICIZSKiPtWRJvfwUFkCU59geJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Add sysfs mode selftest for ARM Coresight hardware tracer.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
 .../drivers/hwtracing/coresight/Makefile      |   5 +
 .../hwtracing/coresight/sysfs_test_trace.sh   | 144 ++++++++++++++++++
 2 files changed, 149 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/hwtracing/coresight/Makefile
 create mode 100755 tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh

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
diff --git a/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh b/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
new file mode 100755
index 000000000000..0d6307fff1d2
--- /dev/null
+++ b/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
@@ -0,0 +1,144 @@
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
+	# means the device is a sink device.
+
+	if [ -e "$1/enable_sink" ]; then
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


