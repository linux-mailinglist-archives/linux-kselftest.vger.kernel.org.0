Return-Path: <linux-kselftest+bounces-20547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B079AE9C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 17:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6101F21500
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8317C1EABAE;
	Thu, 24 Oct 2024 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jtM2Kcjn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C981B983F;
	Thu, 24 Oct 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782341; cv=none; b=qSgKFpTlzO3TrbJqkJKw1vple6lDeOk0RaaSsie2jJkgZZdBH421M8v4IF8fJNw5qXPp+p+Pm8pjqO+Z8kyfPz2qQeYkQ1SK8jS/PZgDu8lAg8+gjTFb4lCogc8OUKW/WDRm92qrO/1kL0JPAeBgzHYMuQt5kd+xgH+q/1j0N7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782341; c=relaxed/simple;
	bh=PEQ1QWu3pvku7u4JDiIPHuakSqYqP2l9xHPA6y1y3gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aO/U2UXJQiQzLDS3ko7w3hxmIFMPgfkGe6jruq9MaLuYOeYHPZBbUG3oyKj32ilGmHVl6g7fk2ZmFw0fIdD0t28aglTBvtdr+yViOlXm7yLlDMidlcov5DCQtQWi7DX0WxuzYAuFN8k3DGE5bziJSdn7WUBRoYBUIFEdZsqyYX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jtM2Kcjn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O9uElQ032158;
	Thu, 24 Oct 2024 15:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=UD6tTEkLajguDRwaJgV750ggvgiKjGiKpbF
	kzqOOtzc=; b=jtM2KcjniKCLeI6SlqENneS9MfwOkPs6ZMU/lEvqdM4Lz268OEz
	C/fDtIE+JIBluKYNx+WqB8+JZj0wWRNQrVvCyfGQ2H7OCEHSHDsge79sidHHX3ki
	27qSpiJdlNEY6NnwUuFNIbofyjfw/mcIDIbVAeAihd1T7Ozil/NcKBLTya9Gq+yh
	fA86XIP/K/tEd3zOpCwGx/TyELgxgR7ce2kj8PO2a+IAkR71RJgku20CbSQfT3Hf
	2zBT4qDufr8kbOG9ImI38EJZRuDpJIOAkrVx/xvTyCV3YotRoD5XWkKSjNd+immr
	XQVPc1ZYTxfTo1nYVkzMhEJ5BvmHVAU8HZw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3vx4sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 15:05:33 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 49OF5DkQ007765;
	Thu, 24 Oct 2024 15:05:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 42cq6abpbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 15:05:13 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49OF5Da9007760;
	Thu, 24 Oct 2024 15:05:13 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-wasimn-hyd.qualcomm.com [10.147.246.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 49OF5DvR007744
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 15:05:13 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 3944840)
	id 21C3D589; Thu, 24 Oct 2024 20:35:12 +0530 (+0530)
From: Wasim Nazir <quic_wasimn@quicinc.com>
To: Shuah Khan <shuah@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Wasim Nazir <quic_wasimn@quicinc.com>
Subject: [PATCH v3] selftest: remoteproc: Add test for start/stop sequence
Date: Thu, 24 Oct 2024 20:35:05 +0530
Message-ID: <20241024150505.988479-1-quic_wasimn@quicinc.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uGtnkimSQIED6QNNHj1MKZq8iPGrbebS
X-Proofpoint-ORIG-GUID: uGtnkimSQIED6QNNHj1MKZq8iPGrbebS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240124

Add test to validate end-to-end start/stop sequence for
each remoteproc instances available on target.

Add first test sequence to validated each instance sequencially
to identify any issue while booting each instance.
Add second test sequence to validate all instances concurrently
to identify any race scenario within instances doing bootup.

Additional user argument (--seqdelay) is available to add
delay is seconds, between start/stop sequence. This is added
as different target might have different threshold to start
any instance (default is 5 secs).

Running tests:
	./remoteproc_test.sh --seqdelay 10

Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/remoteproc/Makefile   |   4 +
 tools/testing/selftests/remoteproc/config     |   1 +
 .../selftests/remoteproc/remoteproc_test.sh   | 157 ++++++++++++++++++
 5 files changed, 164 insertions(+)
 create mode 100644 tools/testing/selftests/remoteproc/Makefile
 create mode 100644 tools/testing/selftests/remoteproc/config
 create mode 100644 tools/testing/selftests/remoteproc/remoteproc_test.sh


Test output with 4 remoteproc instances:

TAP version 13
1..5
# Testing rproc start/stop sequence for each instance sequencially
# Testing rproc sequence for 4080000.remoteproc
ok 1 4080000.remoteproc
# Testing rproc sequence for 3700000.remoteproc
ok 2 3700000.remoteproc
# Testing rproc sequence for 8a00000.remoteproc
ok 3 8a00000.remoteproc
# Testing rproc sequence for a300000.remoteproc
ok 4 a300000.remoteproc
# Testing rproc start/stop sequence for all instances concurrently
ok 5 for all remoteproc0 remoteproc1 remoteproc2 remoteproc3
# Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0

Changes in v3:
	- Add user argument for sequence delay (--sedelay).
	- Update commit & add comments.
	- v2: https://lore.kernel.org/all/20240927112132.3927298-1-quic_wasimn@quicinc.com/

diff --git a/MAINTAINERS b/MAINTAINERS
index e9659a5a7fb3..1f8182473be1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19481,6 +19481,7 @@ F:	Documentation/staging/remoteproc.rst
 F:	drivers/remoteproc/
 F:	include/linux/remoteproc.h
 F:	include/linux/remoteproc/
+F:	tools/testing/selftests/remoteproc/

 REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM
 M:	Bjorn Andersson <andersson@kernel.org>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 363d031a16f7..78669153be90 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -82,6 +82,7 @@ TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
 TARGETS += openat2
+TARGETS += remoteproc
 TARGETS += resctrl
 TARGETS += riscv
 TARGETS += rlimits
diff --git a/tools/testing/selftests/remoteproc/Makefile b/tools/testing/selftests/remoteproc/Makefile
new file mode 100644
index 000000000000..a84b3934fd36
--- /dev/null
+++ b/tools/testing/selftests/remoteproc/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_PROGS := remoteproc_test.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/remoteproc/config b/tools/testing/selftests/remoteproc/config
new file mode 100644
index 000000000000..a5c237d2f3b4
--- /dev/null
+++ b/tools/testing/selftests/remoteproc/config
@@ -0,0 +1 @@
+CONFIG_REMOTEPROC=y
diff --git a/tools/testing/selftests/remoteproc/remoteproc_test.sh b/tools/testing/selftests/remoteproc/remoteproc_test.sh
new file mode 100644
index 000000000000..d58c1e10005c
--- /dev/null
+++ b/tools/testing/selftests/remoteproc/remoteproc_test.sh
@@ -0,0 +1,157 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+#
+
+DIR="$(dirname $(readlink -f "$0"))"
+
+KTAP_HELPERS="${DIR}/../kselftest/ktap_helpers.sh"
+if [ -e "$KTAP_HELPERS" ]; then
+    . "$KTAP_HELPERS"
+else
+    echo -n "1..0 # SKIP $KTAP_HELPERS file not found"
+    exit 4
+fi
+
+RPROC_SYS=/sys/class/remoteproc
+RPROC_SEQ_SLEEP=5
+
+rproc_instances=
+num_tests=0
+test_err=0
+
+check_error() {
+	if [ $? -ne 0 ]; then
+		test_err=$((test_err+1))
+		ktap_print_msg "$@"
+	fi
+}
+
+parse_args() {
+	script=${0##*/}
+
+	if [ $# -eq 2 ] && [ "$1" = "--seqdelay" ]; then
+		shift || true
+		RPROC_SEQ_SLEEP=$1
+	else
+		ktap_print_msg "Usage: ${script} --seqdelay <time in secs>"
+		ktap_print_msg "Proceed with default sequence delay = $RPROC_SEQ_SLEEP"
+	fi
+}
+
+rproc_stop_instances() {
+	for instance in ${rproc_instances}; do
+		rproc=${RPROC_SYS}/$instance
+		rproc_name=$(cat $rproc/name)
+		rproc_state=$(cat $rproc/state)
+
+		echo stop > "$rproc/state"
+		check_error "$rproc_name state-stop failed at state $rproc_state"
+	done
+	sleep ${RPROC_SEQ_SLEEP}
+}
+
+rproc_start_instances() {
+	for instance in ${rproc_instances}; do
+		rproc=${RPROC_SYS}/$instance
+		rproc_name=$(cat $rproc/name)
+		rproc_state=$(cat $rproc/state)
+
+		echo start > "$rproc/state"
+		check_error "$rproc_name state-start failed at state $rproc_state"
+	done
+	sleep ${RPROC_SEQ_SLEEP}
+}
+
+rproc_seq_test_instance_one() {
+	instance=$1
+	rproc=${RPROC_SYS}/$instance
+	rproc_name=$(cat $rproc/name)
+	rproc_state=$(cat $rproc/state)
+	ktap_print_msg "Testing rproc sequence for $rproc_name"
+
+	# Reset test_err value
+	test_err=0
+
+	# Begin start/stop sequence
+	echo start > "$rproc/state"
+	check_error "$rproc_name state-start failed at state $rproc_state"
+
+	sleep ${RPROC_SEQ_SLEEP}
+
+	echo stop > "$rproc/state"
+	check_error "$rproc_name state-stop failed at state $rproc_state"
+
+	if [ $test_err -ne 0 ]; then
+		ktap_test_fail "$rproc_name"
+	else
+		ktap_test_pass "$rproc_name"
+	fi
+}
+
+rproc_seq_test_instances_concurrently() {
+	# Reset test_err value
+	test_err=0
+
+	rproc_start_instances
+
+	rproc_stop_instances
+
+	if [ $test_err -ne 0 ]; then
+		ktap_test_fail "for any of $rproc_instances"
+	else
+		ktap_test_pass "for all $rproc_instances"
+	fi
+}
+
+#################################
+### Test starts here
+#################################
+
+ktap_print_header
+
+# Parse user arguments
+parse_args $@
+
+# Check for required sysfs entries
+if [ ! -d "${RPROC_SYS}" ]; then
+	ktap_skip_all "${RPROC_SYS} doesn't exist."
+	exit "${KSFT_SKIP}"
+fi
+
+rproc_instances=$(find ${RPROC_SYS}/remoteproc* -maxdepth 1 -exec basename {} \;)
+num_tests=$(echo ${rproc_instances} | wc -w)
+if [ "${num_tests}" -eq 0 ]; then
+	ktap_skip_all "${RPROC_SYS}/remoteproc* doesn't exist."
+	exit "${KSFT_SKIP}"
+fi
+
+# Total tests will be:
+# 1) Seq tests for each instance sequencially
+# 2) Seq tests for all instances concurrently
+num_tests=$((num_tests+1))
+
+ktap_set_plan "${num_tests}"
+
+### Stop all instances
+#
+# Intention is to stop all running instances. If any instances are not yet
+# started it will be don't care case as test_err is not checked.
+# NOTE: Assuming no instances are in crashed state
+rproc_stop_instances
+
+### Test 1
+ktap_print_msg "Testing rproc start/stop sequence for each instance sequencially"
+for instance in ${rproc_instances}; do
+	rproc_seq_test_instance_one $instance
+done
+
+### Test 2
+ktap_print_msg "Testing rproc start/stop sequence for all instances concurrently"
+rproc_seq_test_instances_concurrently
+
+### Restore all instances
+rproc_start_instances
+
+ktap_finished
--
2.46.1


