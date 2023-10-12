Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107207C65C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 08:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjJLGlC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 02:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbjJLGlB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 02:41:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACA8C9;
        Wed, 11 Oct 2023 23:41:00 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BKSwtA012765;
        Thu, 12 Oct 2023 06:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=n0TLwEL98fn7ookMRf7+1+Dad/ghQuV6H54GoWPDmHw=;
 b=Q9ADJqmasrKLphCPFmBIbgQxPgj8o/G9ADjov7svxzodoknVO9QX8D1J2oS5T6U+tulm
 MqXasPKGkP9B5SrGqe7OojETVQbZh5Z0FcDW+domc6VNOUOBFe00sTsdrtZucoTE+HqQ
 /sl1kSU/F6Vl1NIbajkAU2wqny5zdu3DqVgo/H9+XTIRYoX4VrMVaabsReRuIcTRnVGo
 2pYyzTadKzTUhdnQqisSNb8cAXYJaXtZJDxfI6CEdA5a28QyIdAVtu8dyvoyXKGLxTmK
 1I9jXOe170fQS8sBHu2uudIvkVDfWiv0v/fCJXgkrNFzFpTI2C0fCyYUiuUTCkFK8d90 Kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdt0qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 06:40:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39C59TlQ019707;
        Thu, 12 Oct 2023 06:40:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws9u9nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 06:40:50 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39C6bT53011784;
        Thu, 12 Oct 2023 06:40:50 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tjws9u9nd-1;
        Thu, 12 Oct 2023 06:40:50 +0000
From:   Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To:     akpm@linux-foundation.org, shuah@kernel.org,
        usama.anjum@collabora.com
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, samasth.norway.ananda@oracle.com
Subject: [PATCH  1/1] selftests/mm: include mman header to access MREMAP_DONTUNMAP identifier
Date:   Wed, 11 Oct 2023 23:40:48 -0700
Message-ID: <20231012064048.433346-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_02,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=970 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120056
X-Proofpoint-ORIG-GUID: Ag4CSe5MK_kypB543P9QNUQUHXh3srhH
X-Proofpoint-GUID: Ag4CSe5MK_kypB543P9QNUQUHXh3srhH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Definition for MREMAP_DONTUNMAP not present in the selftest for
mremap_dontunmap thus throwing an undeclared error when running make
on mm.

Fixes: 0183d777c29a ("selftests: mm: remove duplicate unneeded defines")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/linux-mm/CA+G9fYvV-71XqpCr_jhdDfEtN701fBdG3q+=bafaZiGwUXy_aA@mail.gmail.com/
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 tools/testing/selftests/mm/mremap_dontunmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/mremap_dontunmap.c b/tools/testing/selftests/mm/mremap_dontunmap.c
index ca2359835e75..a06e73ec8568 100644
--- a/tools/testing/selftests/mm/mremap_dontunmap.c
+++ b/tools/testing/selftests/mm/mremap_dontunmap.c
@@ -7,6 +7,7 @@
  */
 #define _GNU_SOURCE
 #include <sys/mman.h>
+#include <linux/mman.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.42.0

