Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3821EF626
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jun 2020 13:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgFELID (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Jun 2020 07:08:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48084 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgFELID (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Jun 2020 07:08:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055B6fAo030623;
        Fri, 5 Jun 2020 11:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=DWdZJiAoSkzSBRrQkC9u7xM53dpdlyqE37xadceBSB8=;
 b=vY84+X7SG4MDS7SB3lpoL5edWX3UJ6FobfudSxVmXSNhUhl35DawPKbmekbYf9oio6T0
 1M2BCaqeUv3VTtlG0iEDMHYvptyS1TDU/WQED8rg9e9oINI87sLTmGfDIaM0VZ4EWoNN
 v3ltvvonKFsXkNaTgfPBQO2YKnkC1/GxjyiEoW933O1DzQyeGduUp63NtzvdHaubin4h
 bctLU/DFHEwiIXO5EdhDRbsj++TZfZ9IQBKvV5PD9Z4SNXcN+isQ3tFuIvgXln3ZyOeL
 VEqLCVZHLqhqS0vXHvh4acHEXuWMjweddQkzsQMuQmO0APiLPIcPNLxTJtLcZxNkemBB lQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31f91dtbdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 11:07:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 055B7R40039911;
        Fri, 5 Jun 2020 11:07:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31f92sm38y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 11:07:47 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 055B7iE6030772;
        Fri, 5 Jun 2020 11:07:45 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 04:07:44 -0700
Date:   Fri, 5 Jun 2020 14:07:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shuah Khan <shuah@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Zi Yan <ziy@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] khugepaged: selftests: fix timeout condition in
 wait_for_scan()
Message-ID: <20200605110736.GH978434@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006050086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 cotscore=-2147483648 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050086
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The loop exits with "timeout" set to -1 and not to 0 so the test needs
to be fixed.

Fixes: e7b592f6caca ("khugepaged: add self test")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/testing/selftests/vm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
index 51b89cedd09d1..8b75821302a79 100644
--- a/tools/testing/selftests/vm/khugepaged.c
+++ b/tools/testing/selftests/vm/khugepaged.c
@@ -502,7 +502,7 @@ static bool wait_for_scan(const char *msg, char *p)
 
 	madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
 
-	return !timeout;
+	return timeout == -1;
 }
 
 static void alloc_at_fault(void)
-- 
2.26.2

