Return-Path: <linux-kselftest+bounces-18182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A71497D976
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 19:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E830282DBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A1717BEA4;
	Fri, 20 Sep 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aIKs9Bsr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1FDEBE;
	Fri, 20 Sep 2024 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726855139; cv=none; b=E1m6WlxaN3DTBMTu7U8f1WfJNkpcZ5yfIQEeMKNEfjmq5XPMOQaWIVEzp1YluHjaMOuIfG/mPEfLluABCDnfZldEpnPz2uyVdIrNKqE0DH3gSNrSaglDHUH9hdBgb8LjIwOo9IrdNMzDPu15auyVx8DnIWuTxq16iZ3s8xDk39s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726855139; c=relaxed/simple;
	bh=EgzZJ47TSIdqkV4mcxv5gtzJ3Wj3JkzqDsrjv7g373A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p61zmXfEHh77lNvibLxJjhuz5dbMXCpWZAAEVET5Kkx1QmHZV7n7XGrJpZzAPjwZHISAlIJjI2UEVDWwS8CDVwrYD2iaBtaXHxItnTmD1b7DQQyX2qq9QtUYkb1aTjlRYyakE9IYJqrlr/AVULpqqYqVFZHYUvskFXeMu9fCjxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aIKs9Bsr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KH9V4a018621;
	Fri, 20 Sep 2024 17:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=cSRhvZr/fyB5veM+2HidkMYMgaeq+nOW+Ry
	akyBC+io=; b=aIKs9BsrLx17EE4kEaLl4izaU7q8DyR+jCtuvi0wxjQy8vl48D8
	wtotgt3MGr4IJpW+hvrNRTvFJTQzP2fUXusNftv8oTuH6hKS/YERz7RSFHnQSkUm
	E2vaYRTVQD5FG3R5IGCUpxxIPC5C2B4PHJXtnTNjHwT6MxgTTf7e4DGjBGyPD1i4
	mYU14PGhic+MUzic4ec1y+RXXw88ovsbnpR1USKdyoFAoykkMs0KNCnzDNc8dSjF
	/6rUs+PhPRTr+3xaRVVc9UEd3FJNH5lwuDcQlordawnbcYExMDPFoy33GSm432ZS
	LjT5Hhw8UKJZDiJEs8DmH/dSMuoQiSYXvtA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4j72adg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 17:58:52 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 48KHwn1W021951;
	Fri, 20 Sep 2024 17:58:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 41n3jmue7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 17:58:49 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48KHwnZn021946;
	Fri, 20 Sep 2024 17:58:49 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-wasimn-hyd.qualcomm.com [10.147.246.180])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 48KHwmQq021945
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 17:58:49 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 3944840)
	id CFD8C58D; Fri, 20 Sep 2024 23:28:47 +0530 (+0530)
From: Wasim Nazir <quic_wasimn@quicinc.com>
To: Shuah Khan <shuah@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Wasim Nazir <quic_wasimn@quicinc.com>
Subject: [PATCH] selftest: remoteproc: Add basic test for start/stop sequence
Date: Fri, 20 Sep 2024 23:28:42 +0530
Message-ID: <20240920175842.388781-1-quic_wasimn@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ioa0oQ9z-sCsZtf1HP85eJTZLgChXZ8F
X-Proofpoint-GUID: ioa0oQ9z-sCsZtf1HP85eJTZLgChXZ8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409200131

Add new basic remoteproc test that check start/stop
sequence of all subsystems available.

diff --git a/MAINTAINERS b/MAINTAINERS
index e062b5328341..aff76edc4242 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18225,6 +18225,7 @@ F:	Documentation/staging/remoteproc.rst
 F:	drivers/remoteproc/
 F:	include/linux/remoteproc.h
 F:	include/linux/remoteproc/
+F:	tools/testing/selftests/remoteproc/

 REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM
 M:	Bjorn Andersson <andersson@kernel.org>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 697f13bbbc32..31db0311efdc 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -68,6 +68,7 @@ TARGETS += proc
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
index 000000000000..88c8f15d8406
--- /dev/null
+++ b/tools/testing/selftests/remoteproc/remoteproc_test.sh
@@ -0,0 +1,165 @@
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
+    source "$KTAP_HELPERS"
+else
+    echo -n "1..0 # SKIP $KTAP_HELPERS file not found"
+	exit 4
+fi
+
+RPROC_SYS=/sys/class/remoteproc
+RPROC_SEQ_SLEEP=5
+rproc_ss_files=
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
+rproc_seq_test_ss_one() {
+	ss=$1
+	rproc=${RPROC_SYS}/$ss
+	rproc_name=$(cat $rproc/name)
+	rproc_state=$(cat $rproc/state)
+	rproc_ssr=$(cat $rproc/recovery)
+	ktap_print_msg "Testing rproc sequence for $rproc_name"
+
+	# Reset test_err value
+	test_err=0
+	if [ "$rproc_ssr" != "enabled" ]; then
+		echo enabled > $rproc/recovery
+		check_error "$rproc_name SSR-enabled failed"
+	fi
+
+	if [ "$rproc_state" != "running" ]; then
+		echo start > "$rproc/state"
+		check_error "$rproc_name state-start failed"
+
+		sleep ${RPROC_SEQ_SLEEP}
+
+		echo stop > "$rproc/state"
+		check_error "$rproc_name state-stop failed"
+	else
+		echo stop > "$rproc/state"
+		check_error "$rproc_name state-stop failed"
+
+		sleep ${RPROC_SEQ_SLEEP}
+
+		echo start > "$rproc/state"
+		check_error "$rproc_name state-start failed"
+	fi
+
+	if [ $test_err -ne 0 ]; then
+		ktap_test_fail "$rproc_name"
+	else
+		ktap_test_pass "$rproc_name"
+	fi
+}
+
+rproc_seq_test_all_ss() {
+	# Declare an array to save initial states of each ss
+	org_ss_to_state=""
+
+	# Reset test_err value
+	test_err=0
+
+	for ss in ${rproc_ss_files}; do
+		rproc=${RPROC_SYS}/$ss
+		rproc_name=$(cat $rproc/name)
+		rproc_ssr=$(cat $rproc/recovery)
+
+		# Enable SSR-recovery support
+		if [ "$rproc_ssr" != "enabled" ]; then
+			echo enabled > $rproc/recovery
+			check_error "$rproc_name SSR-enabled failed"
+		fi
+	done
+
+	for ss in ${rproc_ss_files}; do
+		rproc=${RPROC_SYS}/$ss
+		rproc_name=$(cat $rproc/name)
+		rproc_state=$(cat $rproc/state)
+
+		# Save initial states for each ss
+		org_ss_to_state="$org_ss_to_state $rproc_state"
+
+		# Initiate start/stop sequence
+		if [ "$rproc_state" != "running" ]; then
+			echo start > "$rproc/state"
+			check_error "$rproc_name state-start failed"
+		else
+			echo stop > "$rproc/state"
+			check_error "$rproc_name state-stop failed"
+		fi
+		sleep ${RPROC_SEQ_SLEEP}
+	done
+
+	index=1
+	for ss in ${rproc_ss_files}; do
+		rproc=${RPROC_SYS}/$ss
+		rproc_name=$(cat $rproc/name)
+		rproc_state=$(cat $rproc/state)
+
+		ss_state=$(echo $org_ss_to_state | cut -d' ' -f$index)
+		# Terminate start/stop sequence
+		if [ "$ss_state" != "running" ]; then
+			echo stop > "$rproc/state"
+			check_error "$rproc_name state-stop failed"
+		else
+			echo start > "$rproc/state"
+			check_error "$rproc_name state-start failed"
+		fi
+		index=$((index+1))
+		sleep ${RPROC_SEQ_SLEEP}
+	done
+
+	if [ $test_err -ne 0 ]; then
+		ktap_test_fail "for any of $rproc_ss_files"
+	else
+		ktap_test_pass "for all $rproc_ss_files"
+	fi
+}
+
+ktap_print_header
+
+if [[ ! -d "${RPROC_SYS}" ]]; then
+	ktap_skip_all "${RPROC_SYS} doesn't exist."
+	exit "${KSFT_SKIP}"
+fi
+
+rproc_ss_files=$(find ${RPROC_SYS}/remoteproc* -maxdepth 1 -exec basename {} \;)
+num_tests=$(echo ${rproc_ss_files} | wc -w)
+if [[ "${num_tests}" -eq 0 ]]; then
+	ktap_skip_all "${RPROC_SYS}/remoteproc* doesn't exist."
+	exit "${KSFT_SKIP}"
+fi
+
+# Total tests will be:
+# 1) Seq tests for each subsystem sequencially
+# 2) Seq tests for all subsystems concurrently
+num_tests=$((num_tests+1))
+
+ktap_set_plan "${num_tests}"
+
+# Test 1
+ktap_print_msg "Testing rproc up/down sequence for each subsystem sequencially"
+for ss in ${rproc_ss_files}; do
+	rproc_seq_test_ss_one $ss
+done
+
+# Test 2
+ktap_print_msg "Testing rproc up/down sequence for all subsystems concurrently"
+rproc_seq_test_all_ss
+
+ktap_finished
--
2.46.1


