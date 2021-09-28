Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95F441AE2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Sep 2021 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbhI1LxY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Sep 2021 07:53:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240440AbhI1LxT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Sep 2021 07:53:19 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SAF2l4026529;
        Tue, 28 Sep 2021 07:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+5dr6xlj8qoY79+JHA0sHze00da8FJpvRmaJ5NEFTms=;
 b=BD72vPloAVscujrAxd91mbGQIItaT8m1CilLIpKjXFG37I1rTcos+BhrWGZUGO9DohOA
 hTle0g8rmuBzJ1PJeqj9ebkhhKb9HcV93sXnnfRTyIzcfq/BO27OHLnlgEmAYy1Szsrt
 cc+9O1kRwU9BQkEpZjgrikhACs4QOM7YmjtbFJ3N9wNj8gA5UUlo7It8beHfNcI2VkUd
 pOiXFkapbLsFhvKGYjwb2kNQ/SU8n9TqoioXmNM9mn0mTrPNMBQFxjVtNRxS5o7rSLDz
 lSDs7yRaouwpPtVWnvQIjbZavzdhLW/RJHT2Go8zrvJBHTc7JW+iuYMtb20UrRYx8a2X hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bbxq7d0ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 07:51:24 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18SBDlVU034986;
        Tue, 28 Sep 2021 07:51:24 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bbxq7d0sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 07:51:24 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18SBhKI8021670;
        Tue, 28 Sep 2021 11:51:21 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3b9ud9na6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 11:51:21 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18SBpHlB40829314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 11:51:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC68E11C04A;
        Tue, 28 Sep 2021 11:51:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7BF211C054;
        Tue, 28 Sep 2021 11:51:13 +0000 (GMT)
Received: from pratiks-thinkpad.ibm.com (unknown [9.43.58.127])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Sep 2021 11:51:13 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        shuah@kernel.org, farosas@linux.ibm.com, kjain@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        psampat@linux.ibm.com, pratik.r.sampat@gmail.com
Subject: [PATCH v8 2/2] selftest/powerpc: Add PAPR sysfs attributes sniff test
Date:   Tue, 28 Sep 2021 17:21:02 +0530
Message-Id: <20210928115102.57117-3-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928115102.57117-1-psampat@linux.ibm.com>
References: <20210928115102.57117-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _iqWDJ0KI134p2VWX7lrRNns_6aIVbRL
X-Proofpoint-GUID: ayVoehO3e9g6cw3yyVAlfzIEaWY7AFgN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280065
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Include a testcase to check if the sysfs files for energy and frequency
related have its related attribute files exist and populated

Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
---
 tools/testing/selftests/powerpc/Makefile      |   1 +
 .../powerpc/papr_attributes/.gitignore        |   2 +
 .../powerpc/papr_attributes/Makefile          |   7 ++
 .../powerpc/papr_attributes/attr_test.c       | 107 ++++++++++++++++++
 4 files changed, 117 insertions(+)
 create mode 100644 tools/testing/selftests/powerpc/papr_attributes/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/papr_attributes/Makefile
 create mode 100644 tools/testing/selftests/powerpc/papr_attributes/attr_test.c

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 0830e63818c1..c68c872efb23 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -30,6 +30,7 @@ SUB_DIRS = alignment		\
 	   eeh			\
 	   vphn         \
 	   math		\
+	   papr_attributes	\
 	   ptrace	\
 	   security
 
diff --git a/tools/testing/selftests/powerpc/papr_attributes/.gitignore b/tools/testing/selftests/powerpc/papr_attributes/.gitignore
new file mode 100644
index 000000000000..9c8cb54c8b28
--- /dev/null
+++ b/tools/testing/selftests/powerpc/papr_attributes/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+attr_test
\ No newline at end of file
diff --git a/tools/testing/selftests/powerpc/papr_attributes/Makefile b/tools/testing/selftests/powerpc/papr_attributes/Makefile
new file mode 100644
index 000000000000..135886f200ad
--- /dev/null
+++ b/tools/testing/selftests/powerpc/papr_attributes/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_GEN_PROGS := attr_test
+
+top_srcdir = ../../../../..
+include ../../lib.mk
+
+$(TEST_GEN_PROGS): ../harness.c ../utils.c
diff --git a/tools/testing/selftests/powerpc/papr_attributes/attr_test.c b/tools/testing/selftests/powerpc/papr_attributes/attr_test.c
new file mode 100644
index 000000000000..905e2cbb3863
--- /dev/null
+++ b/tools/testing/selftests/powerpc/papr_attributes/attr_test.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PAPR Energy attributes sniff test
+ * This checks if the papr folders and contents are populated relating to
+ * the energy and frequency attributes
+ *
+ * Copyright 2021, Pratik Rajesh Sampat, IBM Corp.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <dirent.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <stdlib.h>
+
+#include "utils.h"
+
+enum energy_freq_attrs {
+	POWER_PERFORMANCE_MODE = 1,
+	IDLE_POWER_SAVER_STATUS = 2,
+	MIN_FREQ = 3,
+	STAT_FREQ = 4,
+	MAX_FREQ = 6,
+	PROC_FOLDING_STATUS = 8
+};
+
+enum type {
+	INVALID,
+	STR_VAL,
+	NUM_VAL
+};
+
+int value_type(int id)
+{
+	int val_type;
+
+	switch(id) {
+	case POWER_PERFORMANCE_MODE:
+	case IDLE_POWER_SAVER_STATUS:
+		val_type = STR_VAL;
+		break;
+	case MIN_FREQ:
+	case STAT_FREQ:
+	case MAX_FREQ:
+	case PROC_FOLDING_STATUS:
+		val_type = NUM_VAL;
+		break;
+	default:
+		val_type = INVALID;
+	}
+
+	return val_type;
+}
+
+int verify_energy_info()
+{
+	const char *path = "/sys/firmware/papr/energy_scale_info";
+	struct dirent *entry;
+	struct stat s;
+	DIR *dirp;
+
+	if (stat(path, &s) || !S_ISDIR(s.st_mode))
+		return -1;
+	dirp = opendir(path);
+
+	while ((entry = readdir(dirp)) != NULL) {
+		char file_name[64];
+		int id, attr_type;
+		FILE *f;
+
+		if (strcmp(entry->d_name,".") == 0 ||
+		    strcmp(entry->d_name,"..") == 0)
+			continue;
+
+		id = atoi(entry->d_name);
+		attr_type = value_type(id);
+		if (attr_type == INVALID)
+			return -1;
+
+		/* Check if the files exist and have data in them */
+		sprintf(file_name, "%s/%d/desc", path, id);
+		f = fopen(file_name, "r");
+		if (!f || fgetc(f) == EOF)
+			return -1;
+
+		sprintf(file_name, "%s/%d/value", path, id);
+		f = fopen(file_name, "r");
+		if (!f || fgetc(f) == EOF)
+			return -1;
+
+		if (attr_type == STR_VAL) {
+			sprintf(file_name, "%s/%d/value_desc", path, id);
+			f = fopen(file_name, "r");
+			if (!f || fgetc(f) == EOF)
+				return -1;
+		}
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(verify_energy_info, "papr_attributes");
+}
-- 
2.31.1

