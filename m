Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E678112E5E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 16:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfLDP2f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Dec 2019 10:28:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35786 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfLDP2f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Dec 2019 10:28:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4FO9Hi121424;
        Wed, 4 Dec 2019 15:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=IBHUrbxXeC6DnYcqeaqy5UWhmDj6nIM5i+OhyMX8NaM=;
 b=Js+H1OzAY3SrE0PSbS1CbZkalQfGzgDhb2N3ksUv8l+ZDR/rjdupFXZtbYN3ba0bmhr1
 i/b5USjF/esaxVhROjWBvUghIfNn3yaSVvCAOmNxHqScZ5AxifOxR8W7ytE4rRQ71bwM
 ysQBGAXnXtIMsSAKk5yv1Dk3L2z5YDR4ru79WWTt9WQequNqEBL8NYswC+IUBkRi8z3f
 dKL3Gz8PypBDoXQgPY99zmrwTaDwhHefJMcD2OiQL/qLZE5vTJLvyuHRnPFyT9GcPFni
 5mSVi3jYmclJ/FFdjdQhOHuYzHiAP7CoMn00vtDHr+8Oxn/smPabNqBTKZs92j/u38IB wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wkfuufa2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 15:28:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4FOC0c049755;
        Wed, 4 Dec 2019 15:28:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wp20c5wfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 15:28:14 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB4FSCoD015435;
        Wed, 4 Dec 2019 15:28:12 GMT
Received: from dhcp-10-175-179-22.vpn.oracle.com (/10.175.179.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Dec 2019 07:28:12 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        davidgow@google.com, adilger.kernel@dilger.ca, tytso@mit.edu,
        mcgrof@kernel.org, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
Subject: [PATCH v6 linux-kselftest-test 4/6] kunit: remove timeout dependence on sysctl_hung_task_timeout_seconds
Date:   Wed,  4 Dec 2019 15:27:12 +0000
Message-Id: <1575473234-5443-5-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575473234-5443-1-git-send-email-alan.maguire@oracle.com>
References: <1575473234-5443-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912040128
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

Co-developed-by: Knut Omang <knut.omang@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
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

