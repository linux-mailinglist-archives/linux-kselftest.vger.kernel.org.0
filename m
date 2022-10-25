Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F3660D087
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 17:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiJYP1U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiJYP1T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 11:27:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45EF2B262;
        Tue, 25 Oct 2022 08:27:18 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PEr5a8021511;
        Tue, 25 Oct 2022 15:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=GGFbsnWykh4fbfGryO7D4Cga+is61229sObN4S+/oX0=;
 b=bcCjSX83agkBJcPPBpR37y7efTEqxZZh53yevmVNe6AMdYnJ9HPT3wME5cduJrx3BRzE
 TBWAXw3vsvbDrxKuLzz0I5f/CytfQlW88MC1vdyFPmsquLVR/LyyRHA/1vRDCzGx2KDG
 lGG15qyaA7sCjthcwmkyL+8/88jcHIqnTroBPLlbn3YWGh+L/FLgC6hex18lY4ldd36r
 UsGX9NGI9rd4y3jnn8/3C7cl/9hFEfGgocVxJyHVVoP2ysstRhcaBYHZsOtoDwG6lMKc
 u6XTUfRtoYqYA9n82UGy2yhRxvNbOfpiWT/bUK8rrwKPv6D5pj7V8ZgZwiYEcGT0IrbB dA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kee362q41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 15:27:11 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29PFPPso002042;
        Tue, 25 Oct 2022 15:27:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3kc7sj5utx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Oct 2022 15:27:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29PFR7c445482344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Oct 2022 15:27:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CE9D42045;
        Tue, 25 Oct 2022 15:27:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B266642041;
        Tue, 25 Oct 2022 15:27:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Oct 2022 15:27:06 +0000 (GMT)
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: [PATCH] selftests: vm: use 1 MB hugepage size for s390
Date:   Tue, 25 Oct 2022 17:26:10 +0200
Message-Id: <20221025152610.3439102-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tCPza0spCnqBsDU9_hqvLwgFi3o8ihpQ
X-Proofpoint-GUID: tCPza0spCnqBsDU9_hqvLwgFi3o8ihpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_08,2022-10-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=664
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210250086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

hugepage-vmemmap test fails for s390 because it assumes a hugepagesize
of 2 MB, while we have 1 MB on s390. This results in iterating over two
hugepages. If they are consecutive in memory, check_page_flags() will
stumble over the additional head page. Otherwise, it will stumble over
non-huge pageflags, after crossing the first 1 MB hugepage.

Fix this by using 1 MB MAP_LENGTH for s390.

Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 tools/testing/selftests/vm/hugepage-vmemmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/vm/hugepage-vmemmap.c b/tools/testing/selftests/vm/hugepage-vmemmap.c
index 557bdbd4f87e..a4695f138cec 100644
--- a/tools/testing/selftests/vm/hugepage-vmemmap.c
+++ b/tools/testing/selftests/vm/hugepage-vmemmap.c
@@ -11,7 +11,14 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 
+/*
+ * 1 MB hugepage size for s390
+ */
+#if defined(__s390x__)
+#define MAP_LENGTH		(1UL * 1024 * 1024)
+#else
 #define MAP_LENGTH		(2UL * 1024 * 1024)
+#endif
 
 #ifndef MAP_HUGETLB
 #define MAP_HUGETLB		0x40000	/* arch specific */
-- 
2.34.1

