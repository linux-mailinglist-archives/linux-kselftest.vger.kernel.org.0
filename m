Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B202A6429DA
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Dec 2022 14:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiLENuz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 08:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiLENuy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 08:50:54 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFF411813
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Dec 2022 05:50:52 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5D34cM001534;
        Mon, 5 Dec 2022 13:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Gar5tXuTfD1lToKDdcBfr0QHgoPNTDWznDy4JQjMwlc=;
 b=nvihAj+Aozo8g//Nsg2ulnnb3Y+Ukd2e8na7TV2IyLt/BjGsVjX9sqY52zeXPBCHaCQY
 cMZVwsTe/HwZLJUUPzEIA6roTVCnz6Q6haxYBy4iWm2DgVvNBqHCB5beIcyRi0+P6Jxn
 /stxiZl4W+bw4Fm7idhZDm0hy4PFl6hy4hOn9AgyHi/KErWUbGDYWjaNLFNEKIMduE1v
 RV3m4mQxgSoeCajbylh/kn9S05OOXH00j+MdY0MgnjT8drcruhKs1Hrvvqq/mTORJbsc
 m2kEgf7OUwWMuEGF3ZAZmOH26GbROridpH1nZ1OQTN5aqd8Fgio4VDbb9z8GkkE3NPmB 0w== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m8g9qd626-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 13:50:32 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B5Dnsk0019208;
        Mon, 5 Dec 2022 13:50:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04fra.de.ibm.com with ESMTP id 3m7x38t3s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 13:50:30 +0000
Received: from d06av22.portsmouth.uk.ibm.com ([9.149.105.58])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B5DoQcU30802276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Dec 2022 13:50:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B90374C04E;
        Mon,  5 Dec 2022 13:50:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5706D4C040;
        Mon,  5 Dec 2022 13:50:26 +0000 (GMT)
Received: from dilbert5.fritz.box (unknown [9.179.1.85])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Dec 2022 13:50:26 +0000 (GMT)
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Barry Song <song.bao.hua@hisilicon.com>,
        Xiang Chen <chenxiang66@hisilicon.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Shuah Khan <shuah@kernel.org>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH] dma-mapping: benchmark: Fix compile error in user-space tool
Date:   Mon,  5 Dec 2022 14:50:22 +0100
Message-Id: <20221205135022.49708-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O9rtH_AlfBkPDKhSGQsVNLT3O7u05Per
X-Proofpoint-ORIG-GUID: O9rtH_AlfBkPDKhSGQsVNLT3O7u05Per
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050110
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
With latest kernel version this does not compile any more.

While https://kernelnewbies.org/KernelHeaders suggests otherwise, allow it
to use of kernel headers through the uapi/ include direcotry. I assume we can
do so safely, since the controlling user-space program is distributed with
the kernel.

With this change dma_map_benchmark compiles with just the obvious warning
about uapi usage on ARCH=x86 and s390 and runs on ARCH=s390.

[1] commit 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
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

base-commit: 8abacb3356e68261ccd3a2ad74ed6042363e5d0f
-- 
2.38.1

