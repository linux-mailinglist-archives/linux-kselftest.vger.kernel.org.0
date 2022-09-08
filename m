Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F42A5B2513
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 19:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiIHRoC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 13:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiIHRn1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 13:43:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6AA2D1C5;
        Thu,  8 Sep 2022 10:41:11 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288GLMLY004064;
        Thu, 8 Sep 2022 17:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=SmSTj2/HdzqYj70y36yqizzCyVn5KVKz4ABjNdpPPK0=;
 b=DJsJt65OXxR4koGfezS0IQDxlrW6NwIjYRD1MWGWzM7VBc8wCBiTw+6zy1LuToucxk3D
 IkL8zu+ndC0KiXPdaP+e+wmg+OuzTsHnGddCYvf+jimNLL4mJBF2J4oP5BG2YZ1vmQ5w
 Eii7q8rAIurNYSd9r9ieYQ1KnBVchrEZhctyh5WOGoC6BEI8Xo6MD0PzhJJB6BbcYlZP
 PEbVmwUiGj5Jk5LHJpDwWha48tuOU/ajTfmb86JyIvAV4vieQNh/7ps60lIFvEZ2tEt7
 1nOtLn1Z4KCOnOtHppBXU9aIvGsrI/94+Q9LizcUAKpVSjAsxnPExFtkVNImLBdN1MOO 2Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jfku6ah5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 17:40:30 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 288HKOcP031828;
        Thu, 8 Sep 2022 17:40:28 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3jbxj8xwj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 17:40:28 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 288HePO121692888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Sep 2022 17:40:25 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1210F5204F;
        Thu,  8 Sep 2022 17:40:25 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.79.171])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8C4825204E;
        Thu,  8 Sep 2022 17:40:22 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     ltp@lists.linux.it, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        Tarun Sahu <tsahu@linux.ibm.com>
Subject: [RFC PATCH] Hugetlb: Migrating hugetlb tests from libhugetlbfs
Date:   Thu,  8 Sep 2022 23:09:47 +0530
Message-Id: <20220908173947.17956-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S5Nx9Kq0tV_sLB5rl_gKVTuSIszC-y5a
X-Proofpoint-GUID: S5Nx9Kq0tV_sLB5rl_gKVTuSIszC-y5a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_10,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=904
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Libhugetlbfs is not being maintained actively, and some distro is
dropping support for it. There are some tests that are good for testing
hugetlb functionality in kernel, which can be migrated to either kernel
kselftests or LTP.
I am submitting this patch to get comments from community on the
following
    1. The test framework in ltp is most suitable for the tests that are
    in libhugetlbfs/tests/ which follow similar test framework. And there
    is already a section for hugetlb specific tests in LTP. So it makes
    more sense and less effort to migrate the test to LTP. Though I
    recommend migrating these tests to LTP, I would like to discuss tests
    should be migrated to LTP or kselftests.
    2. Libhugetlbfs tests has license GNU Lesser GPL 2.1 or later, while
    kernel and LTP has license GPL2 or later, so can the test be
    migrated to kernel/kselftests or LTP.

The below patch is libhugetlbfs/tests/direct.c which has been migrated
to ltp/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c

Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 runtest/hugetlb                               |   2 +
 testcases/kernel/mem/.gitignore               |   1 +
 .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  | 106 ++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c

diff --git a/runtest/hugetlb b/runtest/hugetlb
index f719217ab..ee02835d3 100644
--- a/runtest/hugetlb
+++ b/runtest/hugetlb
@@ -3,6 +3,8 @@ hugemmap02 hugemmap02
 hugemmap04 hugemmap04
 hugemmap05 hugemmap05
 hugemmap06 hugemmap06
+hugemmap07 hugemmap07
+
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
index ff2910533..df5256ec8 100644
--- a/testcases/kernel/mem/.gitignore
+++ b/testcases/kernel/mem/.gitignore
@@ -4,6 +4,7 @@
 /hugetlb/hugemmap/hugemmap04
 /hugetlb/hugemmap/hugemmap05
 /hugetlb/hugemmap/hugemmap06
+/hugetlb/hugemmap/hugemmap07
 /hugetlb/hugeshmat/hugeshmat01
 /hugetlb/hugeshmat/hugeshmat02
 /hugetlb/hugeshmat/hugeshmat03
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
new file mode 100644
index 000000000..798735ed0
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
@@ -0,0 +1,106 @@
+/*
+ * License/Copyright Details
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sys/mount.h>
+#include <limits.h>
+#include <sys/param.h>
+#include <sys/types.h>
+
+#include "tst_test.h"
+
+#define P0 "ffffffff"
+#define IOSZ 4096
+char buf[IOSZ] __attribute__((aligned(IOSZ)));
+static int  fildes = -1, nfildes = -1;
+static char TEMPFILE[MAXPATHLEN];
+static char NTEMPFILE[MAXPATHLEN];
+
+void test_directio(void)
+{
+	long hpage_size;
+	void *p;
+	int ret;
+
+	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:");
+
+	fildes = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0600);
+	nfildes = SAFE_OPEN(NTEMPFILE, O_CREAT|O_EXCL|O_RDWR|O_DIRECT, 0600);
+
+	p = mmap(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fildes, 0);
+	if (p == MAP_FAILED)
+		tst_brk(TFAIL | TERRNO, "mmap() Failed on %s", TEMPFILE);
+
+	memcpy(p, P0, 8);
+
+	/* Direct write from huge page */
+	ret = write(nfildes, p, IOSZ);
+	if (ret == -1)
+		tst_brk(TFAIL | TERRNO, "Direct-IO write from huge page");
+	if (ret != IOSZ)
+		tst_brk(TFAIL, "Short direct-IO write from huge page");
+	if (lseek(nfildes, 0, SEEK_SET) == -1)
+		tst_brk(TFAIL | TERRNO, "lseek");
+
+	/* Check for accuracy */
+	ret = read(nfildes, buf, IOSZ);
+	if (ret == -1)
+		tst_brk(TFAIL | TERRNO, "Direct-IO read to normal memory");
+	if (ret != IOSZ)
+		tst_brk(TFAIL, "Short direct-IO read to normal memory");
+	if (memcmp(P0, buf, 8))
+		tst_brk(TFAIL, "Memory mismatch after Direct-IO write");
+	if (lseek(nfildes, 0, SEEK_SET) == -1)
+		tst_brk(TFAIL | TERRNO, "lseek");
+
+	/* Direct read to huge page */
+	memset(p, 0, IOSZ);
+	ret = read(nfildes, p, IOSZ);
+	if (ret == -1)
+		tst_brk(TFAIL | TERRNO, "Direct-IO read to huge page");
+	if (ret != IOSZ)
+		tst_brk(TFAIL, "Short direct-IO read to huge page");
+
+	/* Check for accuracy */
+	if (memcmp(p, P0, 8))
+		tst_brk(TFAIL, "Memory mismatch after Direct-IO read");
+	tst_res(TPASS, "Successfully tested Hugepage Direct I/O");
+}
+
+void setup(void)
+{
+	if (tst_hugepages == 0)
+		tst_brk(TCONF, "Not enough hugepages for testing.");
+
+	if (!Hopt)
+		Hopt = tst_get_tmpdir();
+	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
+
+	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
+	snprintf(NTEMPFILE, sizeof(NTEMPFILE), "%s/nmmapfile%d", "/home/", getpid());
+}
+
+void cleanup(void)
+{
+	close(fildes);
+	close(nfildes);
+	remove(TEMPFILE);
+	remove(NTEMPFILE);
+	umount2(Hopt, MNT_DETACH);
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.options = (struct tst_option[]) {
+		{"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H /var/hugetlbfs"},
+		{"s:", &nr_opt, "Set the number of the been allocated hugepages"},
+		{}
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = test_directio,
+	.hugepages = {2, TST_REQUEST},
+};
-- 
2.31.1

