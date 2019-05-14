Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C0E1C712
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2019 12:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfENKfT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 May 2019 06:35:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39838 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfENKfT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 May 2019 06:35:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EASxxM166348;
        Tue, 14 May 2019 10:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=Mtz7TOk9/dHPjCP0bgf7W4mHP8pl3KMDFf+b9lpWzqI=;
 b=uhfxa0hcPgsG26MiowYsI5QE1Nbh1nUIbX1TM9RUzzmqeQU5chsy4KtDHzKIAO52MGXe
 EXzfGkGZhRy48/wNahqTprNS9TJv2b0jHVF5tREecr/LpQ/NX3dLst9LsrjQBTScG7sv
 6bk+MLJy/xn2IuLle7N+qaa3Q1DPSTTS3EQhVQSXqeQOzG6yhRhoRFkDf9Ru3DZzVu+V
 jfE5fg6IWMLiA8QeHoyQVD+KDEHfz1BFNOwqW3sCsMVBV5pQVk34x0HP5B1SM10Alrwb
 oAYxn1MkwDguKBNeGPJhhmFgdRcESnmdalFFri2lOlynxEEWkSdhV5Efk7Wv0k5Z4zIs wQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2sdq1qcvmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 10:35:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EAXHId110991;
        Tue, 14 May 2019 10:35:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2sdmeb0e8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 10:35:00 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4EAYxcq019226;
        Tue, 14 May 2019 10:34:59 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 May 2019 03:34:58 -0700
Date:   Tue, 14 May 2019 13:34:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] KVM: selftests: Fix a condition in test_hv_cpuid()
Message-ID: <20190514103451.GA1694@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905140077
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905140077
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The code is trying to check that all the padding is zeroed out and it
does this:

    entry->padding[0] == entry->padding[1] == entry->padding[2] == 0

Assume everything is zeroed correctly, then the first comparison is
true, the next comparison is false and false is equal to zero so the
overall condition is true.  This bug doesn't affect run time very
badly, but the code should instead just check that all three paddings
are zero individually.

Also the error message was copy and pasted from an earlier error and it
wasn't correct.

Fixes: 7edcb7343327 ("KVM: selftests: Add hyperv_cpuid test")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
index 9a21e912097c..63b9fc3fdfbe 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c
@@ -58,9 +58,8 @@ static void test_hv_cpuid(struct kvm_cpuid2 *hv_cpuid_entries,
 		TEST_ASSERT(entry->flags == 0,
 			    ".flags field should be zero");
 
-		TEST_ASSERT(entry->padding[0] == entry->padding[1]
-			    == entry->padding[2] == 0,
-			    ".index field should be zero");
+		TEST_ASSERT(!entry->padding[0] && !entry->padding[1] &&
+			    !entry->padding[2], "padding should be zero");
 
 		/*
 		 * If needed for debug:
-- 
2.20.1

