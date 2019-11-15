Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A87E9FDB0A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2019 11:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfKOKR4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Nov 2019 05:17:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54770 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfKOKR4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Nov 2019 05:17:56 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFAERfJ021074;
        Fri, 15 Nov 2019 10:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=GEUb/C//sxYHWwJHoIqtobWLRbr5DWDL/Y95mcw7Fwo=;
 b=P1ueIpeh15zw3ZM4/jxR26XteBfIbiBKxcjSHoal6HvAxkxasRvVATDNV+VpyLTnL9ec
 w0rNIxEzblpngOovKSv1rBjhT9LUPbg6MBsGfY3LB8y82bEHTgm2VJH1eXEZm1MWBD6d
 5QYMgKHAgVHfj75nvK/FGTw9pgh0nTcMwOw4Q5rIpqIeFl4k2V12I0whp6YSAmtep3a8
 Wmu8skTTvdAMiw61YzF/4LY3XtznpcUwIpcc6F/lIIncJMfcPCMWF6pgyPCLM6lGmYyJ
 pBgbeVrglALi18yEcx5HqRu0zWlmetu5YSxamnzkeJUI9D1aO+if3ae04pW0GaFkudAz DQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2w9gxpje1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 10:16:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFADF2H169520;
        Fri, 15 Nov 2019 10:16:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2w9h0k4d8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 10:16:35 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAFAGWmT016310;
        Fri, 15 Nov 2019 10:16:32 GMT
Received: from dhcp-10-175-208-51.vpn.oracle.com (/10.175.208.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Nov 2019 02:16:32 -0800
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
        sboyd@kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 linux-kselftest-test 2/6] kunit: hide unexported try-catch interface in try-catch-impl.h
Date:   Fri, 15 Nov 2019 10:16:08 +0000
Message-Id: <1573812972-10529-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com>
References: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150096
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Define function as static inline in try-catch-impl.h to allow it to
be used in kunit itself and tests.  Also remove unused
kunit_generic_try_catch

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 include/kunit/try-catch.h  | 10 ----------
 lib/kunit/test-test.c      |  2 ++
 lib/kunit/test.c           |  2 +-
 lib/kunit/try-catch-impl.h | 28 ++++++++++++++++++++++++++++
 lib/kunit/try-catch.c      | 13 ++-----------
 5 files changed, 33 insertions(+), 22 deletions(-)
 create mode 100644 lib/kunit/try-catch-impl.h

diff --git a/include/kunit/try-catch.h b/include/kunit/try-catch.h
index 404f336..c507dd4 100644
--- a/include/kunit/try-catch.h
+++ b/include/kunit/try-catch.h
@@ -53,11 +53,6 @@ struct kunit_try_catch {
 	void *context;
 };
 
-void kunit_try_catch_init(struct kunit_try_catch *try_catch,
-			  struct kunit *test,
-			  kunit_try_catch_func_t try,
-			  kunit_try_catch_func_t catch);
-
 void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context);
 
 void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch);
@@ -67,9 +62,4 @@ static inline int kunit_try_catch_get_result(struct kunit_try_catch *try_catch)
 	return try_catch->try_result;
 }
 
-/*
- * Exposed for testing only.
- */
-void kunit_generic_try_catch_init(struct kunit_try_catch *try_catch);
-
 #endif /* _KUNIT_TRY_CATCH_H */
diff --git a/lib/kunit/test-test.c b/lib/kunit/test-test.c
index 5ebe059..5a6cc04 100644
--- a/lib/kunit/test-test.c
+++ b/lib/kunit/test-test.c
@@ -7,6 +7,8 @@
  */
 #include <kunit/test.h>
 
+#include "try-catch-impl.h"
+
 struct kunit_try_catch_test_context {
 	struct kunit_try_catch *try_catch;
 	bool function_called;
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 36ebf47..58a6227 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -7,11 +7,11 @@
  */
 
 #include <kunit/test.h>
-#include <kunit/try-catch.h>
 #include <linux/kernel.h>
 #include <linux/sched/debug.h>
 
 #include "string-stream.h"
+#include "try-catch-impl.h"
 
 static void kunit_set_failure(struct kunit *test)
 {
diff --git a/lib/kunit/try-catch-impl.h b/lib/kunit/try-catch-impl.h
new file mode 100644
index 0000000..e308d5c
--- /dev/null
+++ b/lib/kunit/try-catch-impl.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * An API to allow a function, that may fail, to be executed, and recover in a
+ * controlled manner.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_TRY_CATCH_IMPL_H
+#define _KUNIT_TRY_CATCH_IMPL_H
+
+#include <kunit/try-catch.h>
+#include <linux/types.h>
+
+struct kunit;
+
+static inline void kunit_try_catch_init(struct kunit_try_catch *try_catch,
+					struct kunit *test,
+					kunit_try_catch_func_t try,
+					kunit_try_catch_func_t catch)
+{
+	try_catch->test = test;
+	try_catch->try = try;
+	try_catch->catch = catch;
+}
+
+#endif /* _KUNIT_TRY_CATCH_IMPL_H */
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 55686839..4a66d16 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -8,12 +8,13 @@
  */
 
 #include <kunit/test.h>
-#include <kunit/try-catch.h>
 #include <linux/completion.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/sched/sysctl.h>
 
+#include "try-catch-impl.h"
+
 void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
 {
 	try_catch->try_result = -EFAULT;
@@ -106,13 +107,3 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 
 	try_catch->catch(try_catch->context);
 }
-
-void kunit_try_catch_init(struct kunit_try_catch *try_catch,
-			  struct kunit *test,
-			  kunit_try_catch_func_t try,
-			  kunit_try_catch_func_t catch)
-{
-	try_catch->test = test;
-	try_catch->try = try;
-	try_catch->catch = catch;
-}
-- 
1.8.3.1

