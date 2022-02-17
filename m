Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DB54B9B9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 10:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbiBQJAy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 04:00:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiBQJAy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 04:00:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9B72AA3B2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 01:00:40 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21H6c0qt004946;
        Thu, 17 Feb 2022 09:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BRH8/hPmnYLemZuOdV9CLbrNv0huV3N9TGHlCrcBBfQ=;
 b=PzY5xiq4j8XImamNfgPa6CsGyGKqFAZnRp4/xLZ6v9NFZSclX/8kfGR1054rlk5nyuVx
 k2G/aO9UEceWZ6VeMYLXD9zj2Z/tI8EcoZJZ04S4LM6Vvs8O0cuDzM0DDAfOJlQQwzY9
 yrxgMRpLQfjNVxFpVrSICZxjLoBLaiwpoNv10Lj/X1IA43eMKzco6BnLWckCKQnzUH0a
 x8HwEJyBVLj88Fy7orMVf4UyJfzrDN/w9AtRsoLwEqv5VP/NBbgiGSYbzFjA24O1bfUi
 xcQljsoOh22xDvBSA725zmdmKDWwgyvNrLjUtzEzG9672+jJKpXjYi2cKcf+REWD4FX6 yw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9c4ag2q8-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 09:00:30 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21H8aNae031126;
        Thu, 17 Feb 2022 08:36:29 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 3e64hc20t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 08:36:29 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21H8aRB729753740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 08:36:27 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87D3378074;
        Thu, 17 Feb 2022 08:36:27 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 936D27806E;
        Thu, 17 Feb 2022 08:36:23 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.122.166])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 17 Feb 2022 08:36:23 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 2/2] selftest/vm: add helpers to detect PAGE_SIZE and PAGE_SHIFT
Date:   Thu, 17 Feb 2022 14:05:37 +0530
Message-Id: <20220217083537.374160-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217083537.374160-1-aneesh.kumar@linux.ibm.com>
References: <20220217083537.374160-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2nbtO2aNPASkgP3no9dQgqpry4zY-afA
X-Proofpoint-GUID: 2nbtO2aNPASkgP3no9dQgqpry4zY-afA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_03,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 spamscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mike Rapoport <rppt@kernel.org>

PAGE_SIZE is not 4096 in many configurations, particularily ppc64 uses
64K pages in majority of cases.

Add helpers to detect PAGE_SIZE and PAGE_SHIFT dynamically.

Without this tests are broken w.r.t reading /proc/self/pagemap

    if (pread(pagemap_fd, ent, sizeof(ent),
              (uintptr_t)ptr >> (PAGE_SHIFT - 3)) != sizeof(ent))
              err(2, "read pagemap");

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 tools/testing/selftests/vm/gup_test.c |  3 ++-
 tools/testing/selftests/vm/util.h     | 27 ++++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
index fe043f67798b..cda837a14736 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -10,8 +10,9 @@
 #include <assert.h>
 #include "../../../../mm/gup_test.h"
 
+#include "util.h"
+
 #define MB (1UL << 20)
-#define PAGE_SIZE sysconf(_SC_PAGESIZE)
 
 /* Just the flags we need, copied from mm.h: */
 #define FOLL_WRITE	0x01	/* check pte is writable */
diff --git a/tools/testing/selftests/vm/util.h b/tools/testing/selftests/vm/util.h
index 0f0a0f345d76..b27d26199334 100644
--- a/tools/testing/selftests/vm/util.h
+++ b/tools/testing/selftests/vm/util.h
@@ -6,11 +6,32 @@
 #include <stdint.h>
 #include <sys/mman.h>
 #include <err.h>
+#include <string.h> /* ffsl() */
+#include <unistd.h> /* _SC_PAGESIZE */
 
-#define PAGE_SHIFT	12
-#define HPAGE_SHIFT	21
+static unsigned int __page_size;
+static unsigned int __page_shift;
 
-#define PAGE_SIZE (1 << PAGE_SHIFT)
+static inline unsigned int page_size(void)
+{
+	if (!__page_size)
+		__page_size = sysconf(_SC_PAGESIZE);
+	return __page_size;
+}
+
+static inline unsigned int page_shift(void)
+{
+	if (!__page_shift)
+		__page_shift = (ffsl(page_size()) - 1);
+	return __page_shift;
+}
+
+#define PAGE_SHIFT	(page_shift())
+#define PAGE_SIZE	(page_size())
+/*
+ * On ppc64 this will only work with radix 2M hugepage size
+ */
+#define HPAGE_SHIFT 21
 #define HPAGE_SIZE (1 << HPAGE_SHIFT)
 
 #define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
-- 
2.35.1

