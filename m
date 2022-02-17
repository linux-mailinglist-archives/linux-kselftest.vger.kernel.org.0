Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1354B9DA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 11:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbiBQKyA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 05:54:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239349AbiBQKx6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 05:53:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC452294118;
        Thu, 17 Feb 2022 02:53:43 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21H9fcQC003505;
        Thu, 17 Feb 2022 10:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vY3aqzTyxwibnZZHQr6hwj82kzqUtFjsj1aMPDrhsPg=;
 b=n+4vsorm95ZlRQrZkJwIHK2bWOJT1xQ2TK4uTb293pmY9dZInKQ8B1oHdZv/M4pysCvx
 34zmREwuHTvb6UOX4eekrbnO7MF0Cfb+NOh/32tSeWpGbeQQ6ONPZdj1qqCfjygw9CIN
 ivpPBXJmEfeN3UnLElCFRgQGng9LeZpOSwC9oCpfgIsM80LhJ05B3QLeQR/nbqUgzjyJ
 qQIvn+H25u5h5ghW3KgCUEGg71+RXWNEPqGbxy7T55KamUJYsozVg8y0Ou8MOulVcTVL
 OZFNQaaQn9f9LFMftIFF0Ga3MkmeLM6FGog4GiEEpbZvf0QPGMxgm7KwFBgMsKR0SIIw TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9ky1hf4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 10:53:38 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21HAr0Mg005560;
        Thu, 17 Feb 2022 10:53:37 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9ky1hf47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 10:53:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21HAmfFF007118;
        Thu, 17 Feb 2022 10:53:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3e64hagwd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 10:53:35 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21HArWmX45089078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 10:53:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46D5DA406D;
        Thu, 17 Feb 2022 10:53:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EBC5A404D;
        Thu, 17 Feb 2022 10:53:29 +0000 (GMT)
Received: from pratiks-thinkpad.ibm.com (unknown [9.43.63.58])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Feb 2022 10:53:29 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     mpe@ellerman.id.au, shuah@kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        psampat@linux.ibm.com, pratik.r.sampat@gmail.com
Subject: [PATCH v9 2/2] selftest/powerpc: Add PAPR sysfs attributes sniff test
Date:   Thu, 17 Feb 2022 16:23:21 +0530
Message-Id: <20220217105321.52941-3-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217105321.52941-1-psampat@linux.ibm.com>
References: <20220217105321.52941-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aW2Jdo3pQCCx8QDiesHI1GidS9isjGnY
X-Proofpoint-ORIG-GUID: lPFbRH7Rc0vCK2OwF-0CphyiHUgzr629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_04,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 000000000000..d5f42b6d9e99
--- /dev/null
+++ b/tools/testing/selftests/powerpc/papr_attributes/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+attr_test
diff --git a/tools/testing/selftests/powerpc/papr_attributes/Makefile b/tools/testing/selftests/powerpc/papr_attributes/Makefile
new file mode 100644
index 000000000000..e899712d49db
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
\ No newline at end of file
diff --git a/tools/testing/selftests/powerpc/papr_attributes/attr_test.c b/tools/testing/selftests/powerpc/papr_attributes/attr_test.c
new file mode 100644
index 000000000000..bab0dc06e90b
--- /dev/null
+++ b/tools/testing/selftests/powerpc/papr_attributes/attr_test.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PAPR Energy attributes sniff test
+ * This checks if the papr folders and contents are populated relating to
+ * the energy and frequency attributes
+ *
+ * Copyright 2022, Pratik Rajesh Sampat, IBM Corp.
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
+	switch (id) {
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
+int verify_energy_info(void)
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
+		if (strcmp(entry->d_name, ".") == 0 ||
+		    strcmp(entry->d_name, "..") == 0)
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
2.34.1

