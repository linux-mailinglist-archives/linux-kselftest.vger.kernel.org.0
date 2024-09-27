Return-Path: <linux-kselftest+bounces-18459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A2B988331
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 13:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CC41C22185
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 11:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C6B18A6DB;
	Fri, 27 Sep 2024 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U/MWBFsZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50DB18A6AC;
	Fri, 27 Sep 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727436108; cv=none; b=BBKgh6k5OQi4+GxOmiVNH17c09ek6pRlkrMkeEQAVvy7v84lr18ODe3KKc8SNiIlkFyDpVj3UcYNdqwGKV09B6ConC/K/DF+6EG097cVfKUTdsBaIaP5oLZnWjTkP9JYVgyynin6EVUCTGEXtDMBBskyzk9FO/4/Fe5MYLvLYuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727436108; c=relaxed/simple;
	bh=7GTlEHcY6dMHDLK3ARwmyC/xIL/A0Tb/M3GwZTS+5Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtP2+acMcmWIO31HT1Q56Ubl5jmn10b4Jnz16fxSn+H7msL8yc/BxHNcquYI977XxluVVpqPUTHQROnQZ1T5j66SL3PEJ+6ng94nqWjmONWlfYZY1eSb63xOTVP1Y3SLM7yPi4w4ba4eWPx7Vr++7Ac/Zoewp3KFcdSb7xsqsQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U/MWBFsZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R6ujPA000899;
	Fri, 27 Sep 2024 11:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vxQnzf44rAnoFHft1NRPJGHA77wkfec+/Ol
	vyjpUv6M=; b=U/MWBFsZLMRUb/5g2SF5GuR2qIMCw5kfTIyZ0Luq9gZvR/JhVeb
	9/aZ2RSVLzpiJKrfgPJDdiFyYKrMip+F0yp75pdqnnamwperirMDTDYnGiUIlDSw
	aA+RYxjAS9eIfvi3OmeWyS9dNI6TR1muoP6KbEVGZyhcZFomr6KsyFspLZuovUHg
	g7PQCgZE2KnxbkpSC7Vf83abHm3JgEh2GyRWrGjk/fMvFAwHyjFnf7ZSvnefyxZG
	hHdrH1CbPLmUBEVsETLBkfMZRgGTPVZDvLAtsaF1TQZenDgKqZBVV4nQ2It4IYqS
	tgftFKplFzcm+uwvr78c60H9qefpMB2TNuA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sn3sjpcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 11:21:41 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48RBLaaM027877;
	Fri, 27 Sep 2024 11:21:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 41sq7mpp2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 11:21:36 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48RBLaMG027872;
	Fri, 27 Sep 2024 11:21:36 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-wasimn-hyd.qualcomm.com [10.147.246.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 48RBLZkO027871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 11:21:36 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 3944840)
	id EA8B8593; Fri, 27 Sep 2024 16:51:34 +0530 (+0530)
From: Wasim Nazir <quic_wasimn@quicinc.com>
To: Shuah Khan <shuah@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Wasim Nazir <quic_wasimn@quicinc.com>
Subject: [PATCH v2] selftest: remoteproc: Add basic test for start/stop sequence
Date: Fri, 27 Sep 2024 16:51:32 +0530
Message-ID: <20240927112132.3927298-1-quic_wasimn@quicinc.com>
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
X-Proofpoint-GUID: Inz7UtNqmv3vF4-dX_EBJdQnqCJlYjvS
X-Proofpoint-ORIG-GUID: Inz7UtNqmv3vF4-dX_EBJdQnqCJlYjvS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270081

This test includes:
    1) Start/stop test for each rproc instance sequencially
    2) Start/stop test for all rproc instances concurrently

Changes in v2:
- Update commit message
- Addressed start/stop flow

Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index a77770cd96b8..02ebad5ae790 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19596,6 +19596,7 @@ F:	Documentation/staging/remoteproc.rst
 F:	drivers/remoteproc/
 F:	include/linux/remoteproc.h
 F:	include/linux/remoteproc/
+F:	tools/testing/selftests/remoteproc/

 REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM
 M:	Bjorn Andersson <andersson@kernel.org>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index b38199965f99..0c8a0f427d01 100644
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
index 000000000000..589368285307
--- /dev/null
+++ b/tools/testing/selftests/remoteproc/remoteproc_test.sh
@@ -0,0 +1,134 @@
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
+rproc_instances=
+# Declare an array to save initial states of each instance
+org_instance_to_state=""
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
+ktap_print_header
+
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
+# Stop all instances
+rproc_stop_instances
+
+# Test 1
+ktap_print_msg "Testing rproc start/stop sequence for each instance sequencially"
+for instance in ${rproc_instances}; do
+	rproc_seq_test_instance_one $instance
+done
+
+# Test 2
+ktap_print_msg "Testing rproc start/stop sequence for all instances concurrently"
+rproc_seq_test_instances_concurrently
+
+# Restore all instances
+rproc_start_instances
+
+ktap_finished
--
2.46.1


