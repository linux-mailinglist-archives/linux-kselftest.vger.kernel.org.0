Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95223662E36
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jan 2023 19:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjAISKD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Jan 2023 13:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbjAISIv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Jan 2023 13:08:51 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91FD3D9F6
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Jan 2023 10:07:46 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309HJXMg029484;
        Mon, 9 Jan 2023 18:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=b0omC51hQ9dIzKK7x5A+V5ONEtf1YUmVCXFhs5tfw2Q=;
 b=dZrh9QNB+KBEdlutI+rvAAWK4AOJAUzgjXaR5PHtSKfR0FvPzVm1rp1GUk7+w36B2xrI
 4pHVqixvmpDxpw2NofEdsO1sTexI6+OmEG0sgs58WBkGkchGGxkJXmWzgPJshR/fq6mn
 t1xd/UnsJRZFLdO0HW/sBkuo33kjKyDwX/kW2ZKsTzTuXwrwGN/yzGfNop2SoWDahTb0
 F6987njhRIZULT5D+J6xXL4BplG4ssCPGTo5Xz4KvcCJDOvutYTCzl6s3meay++sLAQa
 h6NbSfb6ug01lqM/e6BKlgwaNu5M/ZJRI8IzgtfzMeeCxDSPiyAQkg7V39jA5/9W+KZW Qw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3myjk7meua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 18:07:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3098vsjJ000654;
        Mon, 9 Jan 2023 18:07:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3my0c6kahm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 18:07:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 309I7MZv52560326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jan 2023 18:07:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A66720043;
        Mon,  9 Jan 2023 18:07:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9B8320049;
        Mon,  9 Jan 2023 18:07:21 +0000 (GMT)
Received: from dilbert5.fritz.box (unknown [9.171.48.140])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jan 2023 18:07:21 +0000 (GMT)
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Xiang Chen <chenxiang66@hisilicon.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH] selftests:dma: Fix compile error in user-space tool
Date:   Mon,  9 Jan 2023 19:07:21 +0100
Message-Id: <20230109180721.187324-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 42Jb_o16O5jOZ8ExxC93aJlM8fsnyZpv
X-Proofpoint-GUID: 42Jb_o16O5jOZ8ExxC93aJlM8fsnyZpv
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_11,2023-01-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since [1] the user-space program dma_map_benchmark shares the header file
linux/map_benchmark.h with the kernel driver in kernel/dma/map_benchmark.c.
With latest kernel version this does not compile anymore.

While https://kernelnewbies.org/KernelHeaders suggests otherwise, allow it
to use kernel headers through the uapi/ include directory. I assume we can
do so safely, since the controlling user-space program is distributed with
the kernel.

With this change dma_map_benchmark compiles with just the obvious warning
about uapi usage on ARCH=x86, arm64, and s390 and runs on ARCH=s390.

[1] commit 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header
file for map_benchmark definition")

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
Acked-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index 5c997f17fcbd..d49d7ea6a63e 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -10,7 +10,7 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
-#include <linux/types.h>
+#include <uapi/linux/types.h>
 #include <linux/map_benchmark.h>
 
 #define NSEC_PER_MSEC	1000000L

base-commit: 1fe4fd6f5cad346e598593af36caeadc4f5d4fa9
-- 
2.39.0

