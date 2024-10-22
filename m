Return-Path: <linux-kselftest+bounces-20390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4999AA206
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 14:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC8B1C215F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 12:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D1C19C558;
	Tue, 22 Oct 2024 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jy8Wb+a6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CB7146D78;
	Tue, 22 Oct 2024 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729599771; cv=none; b=RsqqbvABqEvx9JO4xH/MnR+lwhkFgbYm2dTWcXcNQAwcXFD1apn1/2HIiQri9CSadbYIpLelbYRFt1Sq3XgSXk4RHinAKH8GKSsTcq7iU/MDwmnUrMrv7bnMaZNn3fmeL0GHUmqDsLTciRQjOw5cxN5hS82pNOfVsH3MXcTaHyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729599771; c=relaxed/simple;
	bh=rJbleJQxI6miYx1TXF/6W93DeB7LRmc2OcUVp6DzVyM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VfvvWIB54zAqL9zFJxvmqFXxa21JE6/lterJxqu5IuZKxRIj4bVam9NC0ggLRT6wFTmW8lZImXHAjCBWMuzqlPLRIDNKK/SrFNvnbl+gbRlMYvrxKoWInEabrHctGI6tRzk4m+3yo9Ty6R63fF7sczWBjSlBt40Ozu+4z5qaI2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jy8Wb+a6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MC9x8C025868;
	Tue, 22 Oct 2024 12:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=cOI8qm3Kv36No/LbxhZZ0t2OrkaIE9xcy4eQD81YBUQ=; b=jy
	8Wb+a6Gv+nb3nG7w47zjBSdX1qBczDALPd47Us+sIV2eCmOZdesgz0yRG817+wqZ
	Pdmc2fZCk3jIl1HeCvGXr/yldWT6ln7r/dA990Rvo25qIsXmWktQOZNt01tInr3E
	fD6DNAb10ZegQxADcwZfHfO2QTWePsTxsMD90mmaa/aHShFD3etwV0JHBpQ6xoqn
	kQlAuFXXtjnAqAesFigm4qfR9l3r/hqKLTlwLB7iX1rAW2KBzG69cN33A36hlmSv
	YNvMm5/YklgasZn2Jak90aGKgCAtGbht1W9ux7TVMBARTUBbuXTKiyv7g5je1Pub
	ILkqLTVEVMRIvcGyn/Yg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ebtm8124-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 12:22:36 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49MCMZSd015860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 12:22:35 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 05:22:32 -0700
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <shuah@kernel.org>, <hannes@cmpxchg.org>, <surenb@google.com>,
        <quic_pintu@quicinc.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>
Subject: [PATCH] selftests/sched: add basic test for psi
Date: Tue, 22 Oct 2024 17:51:58 +0530
Message-ID: <20241022122158.2136-1-quic_pintu@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: L9znsB6kpUeXQlLomLTQu1eW2ZQPOqLw
X-Proofpoint-GUID: L9znsB6kpUeXQlLomLTQu1eW2ZQPOqLw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=969 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220079

There is a psi module that exists under kernel/sched/psi.
Add a basic test to test the psi.
This test just add the basic support to check cpu/memory/io interface.
Further test will be added on top of this.

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
---
 MAINTAINERS                              |  2 +
 tools/testing/selftests/sched/.gitignore |  1 +
 tools/testing/selftests/sched/Makefile   |  4 +-
 tools/testing/selftests/sched/config     |  1 +
 tools/testing/selftests/sched/psi_test.c | 85 ++++++++++++++++++++++++
 tools/testing/selftests/sched/run_psi.sh | 36 ++++++++++
 6 files changed, 127 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/sched/psi_test.c
 create mode 100755 tools/testing/selftests/sched/run_psi.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 84a73e90cfe8..d84ff9ca36a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18548,10 +18548,12 @@ F:	include/uapi/linux/pps.h
 PRESSURE STALL INFORMATION (PSI)
 M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Suren Baghdasaryan <surenb@google.com>
+M:	Pintu Kumar <quic_pintu@quicinc.com>
 R:	Peter Ziljstra <peterz@infradead.org>
 S:	Maintained
 F:	include/linux/psi*
 F:	kernel/sched/psi.c
+F:	tools/testing/selftests/sched/psi_test.c
 
 PRINTK
 M:	Petr Mladek <pmladek@suse.com>
diff --git a/tools/testing/selftests/sched/.gitignore b/tools/testing/selftests/sched/.gitignore
index 6996d4654d92..2b15c11b93e6 100644
--- a/tools/testing/selftests/sched/.gitignore
+++ b/tools/testing/selftests/sched/.gitignore
@@ -1 +1,2 @@
 cs_prctl_test
+psi_test
diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
index 099ee9213557..795f6613eb2c 100644
--- a/tools/testing/selftests/sched/Makefile
+++ b/tools/testing/selftests/sched/Makefile
@@ -8,7 +8,7 @@ CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -Wl,-rpath=./ \
 	  $(CLANG_FLAGS)
 LDLIBS += -lpthread
 
-TEST_GEN_FILES := cs_prctl_test
-TEST_PROGS := cs_prctl_test
+TEST_GEN_FILES := cs_prctl_test psi_test
+TEST_PROGS := cs_prctl_test run_psi.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/sched/config b/tools/testing/selftests/sched/config
index e8b09aa7c0c4..287cccd434fd 100644
--- a/tools/testing/selftests/sched/config
+++ b/tools/testing/selftests/sched/config
@@ -1 +1,2 @@
 CONFIG_SCHED_DEBUG=y
+CONFIG_PSI=y
diff --git a/tools/testing/selftests/sched/psi_test.c b/tools/testing/selftests/sched/psi_test.c
new file mode 100644
index 000000000000..eeba138d2b39
--- /dev/null
+++ b/tools/testing/selftests/sched/psi_test.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <string.h>
+#include <fcntl.h>
+
+
+struct load_avg {
+	float avg10;
+	float avg60;
+	float avg300;
+	unsigned long long total;
+};
+
+struct pressure {
+	struct load_avg some;
+	struct load_avg full;
+};
+
+
+int psi_get_data_from_proc_pressure(const char *path, struct pressure *p)
+{
+	FILE *fp;
+	int rc = -1;
+	int ret = 0;
+
+	if (path == NULL || p == NULL)
+		return -1;
+
+	fp = fopen(path, "r");
+	if (fp == NULL)
+		return -1;
+
+	while (!feof(fp)) {
+		rc = fscanf(fp, "some avg10=%f avg60=%f avg300=%f total=%llu\n",
+			&p->some.avg10, &p->some.avg60, &p->some.avg300, &p->some.total);
+		if (rc < 1) {
+			ret = -1;
+			break;
+		}
+
+		/* Note: In some cases (cpu) full may not exists */
+		rc = fscanf(fp, "full avg10=%f avg60=%f avg300=%f total=%llu\n",
+			&p->full.avg10, &p->full.avg60, &p->full.avg300, &p->full.total);
+		/* We don't care about full case. This is needed to avoid warnings */
+		rc = 0;
+	}
+
+	fclose(fp);
+
+	return ret;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret;
+	struct pressure rs = {0,};
+	char path[32];
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s <path>\n", argv[0]);
+		return -1;
+	}
+
+	memset(&rs, 0, sizeof(rs));
+	printf("Pressure data: %s\n", argv[1]);
+	snprintf(path, sizeof(path)-1, "/proc/pressure/%s", argv[1]);
+
+	ret = psi_get_data_from_proc_pressure(path, &rs);
+	if (ret < 0) {
+		printf("PSI <%s>: FAIL\n", argv[1]);
+		return -1;
+	}
+	printf("Some Avg10   = %5.2f\n", rs.some.avg10);
+	printf("Some Avg60   = %5.2f\n", rs.some.avg60);
+	printf("Some Avg300  = %5.2f\n", rs.some.avg300);
+	printf("Some Total  = %llu\n", rs.some.total);
+	printf("Full Avg10  = %5.2f\n", rs.full.avg10);
+	printf("Full Avg60  = %5.2f\n", rs.full.avg60);
+	printf("Full Avg300 = %5.2f\n", rs.full.avg300);
+	printf("Full Total  = %llu\n", rs.full.total);
+
+
+	return 0;
+}
diff --git a/tools/testing/selftests/sched/run_psi.sh b/tools/testing/selftests/sched/run_psi.sh
new file mode 100755
index 000000000000..d0b1c7ae3736
--- /dev/null
+++ b/tools/testing/selftests/sched/run_psi.sh
@@ -0,0 +1,36 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+# Just one node check is enough to detect psi
+if [ ! -e /proc/pressure/cpu ]; then
+	echo "PSI not present..."
+	exit $ksft_skip
+fi
+
+echo ""
+./psi_test cpu
+if [ $? -ne 0 ]; then
+	echo "CPU - [FAIL]"
+else
+	echo "CPU - [PASS]"
+fi
+
+echo ""
+./psi_test memory
+if [ $? -ne 0 ]; then
+	echo "MEMORY - [FAIL]"
+else
+	echo "MEMORY - [PASS]"
+fi
+
+echo ""
+./psi_test io
+if [ $? -ne 0 ]; then
+	echo "IO - [FAIL]"
+else
+	echo "IO - [PASS]"
+fi
-- 
2.17.1


