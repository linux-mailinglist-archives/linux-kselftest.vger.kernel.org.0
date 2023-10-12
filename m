Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3307C71DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 17:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjJLPxS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 11:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbjJLPxS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 11:53:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FAFC6;
        Thu, 12 Oct 2023 08:53:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CFhvCR015580;
        Thu, 12 Oct 2023 15:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=t1DYKhHZTfqr7i7SSmL8YEmuW/k4Tq42LmD0jvjmNUo=;
 b=pPZ4w11k9WuGc2l9kpU9Swba9/aQ9GRWDlkDfJ4wQYNg88tY7yD31IDSspqGz0WKTsmV
 Jt5A6N+/LqI7TO7zwQkY130CrfX49nluZ3uL1SROCSmH4vWfKf3hT/EcOc6ZAQV7kq3F
 URHXodrhAFwnZHIcsGPdLhcYo1YPRdL2FJRmTMMhDz1ALtoGVRBeuX95RC3sKgVB2DXQ
 kCnRdwmjqhWlh2xlUvZSIDDAoas5iMSdRZL9TqIHVTfGF33n3OfwMUpxH24UYRTsf7pV
 sWggJGgfwf2WCixh1bPcmpVW3LEEuztNc4tQ5Q0dkSUQb1iky/Li2GSoBZ+XaZ9EUhVj LQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh8a0gfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 15:53:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39CEXxjl006321;
        Thu, 12 Oct 2023 15:52:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsfva35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 15:52:59 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CFo0pZ008306;
        Thu, 12 Oct 2023 15:52:58 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3tjwsfva2e-1;
        Thu, 12 Oct 2023 15:52:58 +0000
From:   Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To:     akpm@linux-foundation.org, shuah@kernel.org,
        usama.anjum@collabora.com
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, samasth.norway.ananda@oracle.com
Subject: [PATCH v2] selftests/mm: include mman header to access MREMAP_DONTUNMAP identifier
Date:   Thu, 12 Oct 2023 08:52:57 -0700
Message-ID: <20231012155257.891776-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120131
X-Proofpoint-GUID: 6CytDmMlBPo3-yWodICHHpLORodjKGFa
X-Proofpoint-ORIG-GUID: 6CytDmMlBPo3-yWodICHHpLORodjKGFa
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Definition for MREMAP_DONTUNMAP is not present in glibc older than
2.32 thus throwing an undeclared error when running make on mm. Including
linux/mman.h solves the build error for people having older glibc.

Fixes: 0183d777c29a ("selftests: mm: remove duplicate unneeded defines")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/linux-mm/CA+G9fYvV-71XqpCr_jhdDfEtN701fBdG3q+=bafaZiGwUXy_aA@mail.gmail.com/
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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

