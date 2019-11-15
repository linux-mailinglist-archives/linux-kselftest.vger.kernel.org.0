Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92702FDB0C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2019 11:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfKOKSF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Nov 2019 05:18:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47718 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfKOKSE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Nov 2019 05:18:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFAEITt047434;
        Fri, 15 Nov 2019 10:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=P+HiVSl1jyeAKRlbuhH0mupiRsIP0/UxZq92oAfDDa0=;
 b=iDXjXEt1yuowJ4YIPk8xoU6oq4qYiEeje0rFnIEyBHg+KTaZb66llIpBGdJy7pc2MgHK
 r5OZp2TUZ2yi0cKrAtEYbBaSA8jcEtR/Opcfgla9om84hvTZG0jagJoEJEqWE3o+Zbjj
 tS7VoTgh5xdaAuDH/ubM78mlyt90N+1tcHMKim9WmsMbIKNKENXUKfIb48++SWIo2uJ/
 w4zLXpJgqcFa3B8Ui5rOR8UEwg+SiitObUXpwJb8Ws1fDzpzAbRui7pm5d0BQmFDXrcT
 1ggG8Cc9OK53K3/dwEDjYd1GuZ+X7HXCtyDiyXctKtiGWevZhicEJfxvfb1MTPhMOboZ Jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w9gxpje6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 10:16:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFADDL3007920;
        Fri, 15 Nov 2019 10:16:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2w9h148ff4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 10:16:42 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAFAGe8p016353;
        Fri, 15 Nov 2019 10:16:40 GMT
Received: from dhcp-10-175-208-51.vpn.oracle.com (/10.175.208.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Nov 2019 02:16:40 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, tytso@mit.edu, adilger.kernel@dilger.ca,
        mcgrof@kernel.org, changbin.du@intel.com,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
Subject: [PATCH v4 linux-kselftest-test 4/6] kunit: remove timeout dependence on sysctl_hung_task_timeout_seconds
Date:   Fri, 15 Nov 2019 10:16:10 +0000
Message-Id: <1573812972-10529-5-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com>
References: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150096
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In discussion of how to handle timeouts, it was noted that if
sysctl_hung_task_timeout_seconds is exceeded for a kunit test,
the test task will be killed and an oops generated.  This should
suffice as a means of debugging such timeout issues for now.

Hence remove use of sysctl_hung_task_timeout_secs, which has the
added benefit of avoiding the need to export that symbol from
the core kernel.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 lib/kunit/try-catch.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 0247a28..0dd434e 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -11,7 +11,6 @@
 #include <linux/completion.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
-#include <linux/sched/sysctl.h>
 
 #include "try-catch-impl.h"
 
@@ -33,8 +32,6 @@ static int kunit_generic_run_threadfn_adapter(void *data)
 
 static unsigned long kunit_test_timeout(void)
 {
-	unsigned long timeout_msecs;
-
 	/*
 	 * TODO(brendanhiggins@google.com): We should probably have some type of
 	 * variable timeout here. The only question is what that timeout value
@@ -51,22 +48,11 @@ static unsigned long kunit_test_timeout(void)
 	 *
 	 * For more background on this topic, see:
 	 * https://mike-bland.com/2011/11/01/small-medium-large.html
+	 *
+	 * If tests timeout due to exceeding sysctl_hung_task_timeout_secs,
+	 * the task will be killed and an oops generated.
 	 */
-	if (sysctl_hung_task_timeout_secs) {
-		/*
-		 * If sysctl_hung_task is active, just set the timeout to some
-		 * value less than that.
-		 *
-		 * In regards to the above TODO, if we decide on variable
-		 * timeouts, this logic will likely need to change.
-		 */
-		timeout_msecs = (sysctl_hung_task_timeout_secs - 1) *
-				MSEC_PER_SEC;
-	} else {
-		timeout_msecs = 300 * MSEC_PER_SEC; /* 5 min */
-	}
-
-	return timeout_msecs;
+	return 300 * MSEC_PER_SEC; /* 5 min */
 }
 
 void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
-- 
1.8.3.1

