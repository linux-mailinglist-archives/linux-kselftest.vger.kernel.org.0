Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7674810FD4F
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 13:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfLCMIu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 07:08:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40640 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfLCMIt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 07:08:49 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3Bs9O0152679;
        Tue, 3 Dec 2019 12:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=K+A93ZAv9I878HBX82hzx7n9260RnjvxaGQwnMGdHIs=;
 b=cGOFKxiG6RKOtSLbM4YKIUDT6Untzs6/tcGSC9KFC86MQKq0T+VAGlnuYXETr/TqnvcO
 JL6NNHiY1flX+Hhtn2pGkiVQGWUtRZQBjxKv9a8Y0uiqXlF8whCTNzW2RpKIwC8D+eHN
 a35Bxs0pMmcksytA6tIWOs/R8kqrDc/h6sZNoxfFElizfVKHQ1lvWjKl8lWPG426WvQa
 ys8shMT2cRW5OofrxVrtCUN0bOSC37sq3nYq738zcFmrCYYlBlN3uB88jfVl4EtRyVXl
 JRuLjtmSZ6SCjkt3eG3OkWgLmA6DzoTlp5mntnqwa18qQ5Y+HQX//FtAT2RQxQl+871W +w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wkfuu7aku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 12:08:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB3BsXJD161861;
        Tue, 3 Dec 2019 12:08:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wn4qpup04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 12:08:27 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB3C8QPf024578;
        Tue, 3 Dec 2019 12:08:26 GMT
Received: from dhcp-10-175-211-120.vpn.oracle.com (/10.175.211.120)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Dec 2019 04:08:26 -0800
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
Subject: [PATCH v5 linux-kselftest-test 2/6] kunit: hide unexported try-catch interface in try-catch-impl.h
Date:   Tue,  3 Dec 2019 12:07:44 +0000
Message-Id: <1575374868-32601-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com>
References: <1575374868-32601-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030096
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Define function as static inline in try-catch-impl.h to allow it to
be used in kunit itself and tests.  Also remove unused
kunit_generic_try_catch

Co-developed-by: Knut Omang <knut.omang@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/try-catch.h  | 10 ----------
 lib/kunit/test-test.c      |  2 ++
 lib/kunit/test.c           |  2 +-
 lib/kunit/try-catch-impl.h | 27 +++++++++++++++++++++++++++
 lib/kunit/try-catch.c      | 13 ++-----------
 5 files changed, 32 insertions(+), 22 deletions(-)
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
index 0000000..203ba6a
--- /dev/null
+++ b/lib/kunit/try-catch-impl.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Internal kunit try catch implementation to be shared with tests.
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

