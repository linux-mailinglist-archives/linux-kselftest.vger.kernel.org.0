Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B544CF144
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Mar 2022 06:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiCGFpU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Mar 2022 00:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiCGFpT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Mar 2022 00:45:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687EF4A3F2
        for <linux-kselftest@vger.kernel.org>; Sun,  6 Mar 2022 21:44:26 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2275TGMc018727;
        Mon, 7 Mar 2022 05:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ti3f8Ky6IPa0GFH54YUCkDxcUy+GzAy2l2rTZTwg1nU=;
 b=ImvC1kEoukG47gXY3cWCKoCtrprpMf+74I/9FrsyHV4d63VZHTgtujl2L+MwAzhHc3g7
 p1qSviHY5kHsS0tR0W/ssa3x1If5L3s+7Nz0k6FAmdvw/ltWfS1ZJrEr9csa60KdwpeS
 fI0MnSw/aM6GTmvCEhspY6nFDn6kZjm1bYgzMpPJA/AW6E/5idI9+T+q8gcIGhBAEE2c
 +ww9HFVaZizNwWkxlFNClW66CotNO93FugHfWUHSXlirAxLjKNI15y/ebys3F1TFCknq
 s+NCGUvji1Ay2wii8pMySG7O9t01d3mUvq91ThV1Sq+bpRBbptHKGqFDY863x//Cf3+d nA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3emtmwchjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 05:44:15 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2275eEwC012510;
        Mon, 7 Mar 2022 05:44:15 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 3ekyg9bja1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 05:44:15 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2275iEVS47382888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Mar 2022 05:44:14 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4124F12405E;
        Mon,  7 Mar 2022 05:44:14 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8F33124052;
        Mon,  7 Mar 2022 05:44:10 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.89.15])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  7 Mar 2022 05:44:10 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v4 2/2] selftest/vm: add helpers to detect PAGE_SIZE and PAGE_SHIFT
Date:   Mon,  7 Mar 2022 11:13:55 +0530
Message-Id: <20220307054355.149820-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307054355.149820-1-aneesh.kumar@linux.ibm.com>
References: <20220307054355.149820-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DazFF_TSArwjCJBK-unF4_o-WT1pD-Yf
X-Proofpoint-ORIG-GUID: DazFF_TSArwjCJBK-unF4_o-WT1pD-Yf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_01,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 mlxlogscore=997 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070033
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mike Rapoport <rppt@kernel.org>

PAGE_SIZE is not 4096 in many configurations, particularly ppc64 uses
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

