Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F262B131B5C
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2020 23:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgAFW3V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jan 2020 17:29:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58908 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFW3T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jan 2020 17:29:19 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 006MJGJe051730;
        Mon, 6 Jan 2020 22:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=K+A93ZAv9I878HBX82hzx7n9260RnjvxaGQwnMGdHIs=;
 b=FPNWtNSS7aOSP97Na2BssgVdTTIbTbnQcQPDrnow9xQ0PW+GQe7fyNrx44lseXsxvsfi
 xoW41zaFvvmvxQJ7p3VG1bToS+pApnQEykoDrtNigETV+l01i4VT5Djz8+QHbkkCImS3
 BntER7lMqIlrXAECZvXEHyHFxs/nYvPWZls8CqHScaabiOxHNxefE0s3ZAz4LkiuCI69
 g48j/z2HMirhR0unIOBjb1k2h5ARZn5niv5+0QOKkfi2yQoQau5RxChYGOkC6RNfE4Ig
 OfnTCVxjt1y71PH3720fcEnzAgMkuWplt0KTUGspcnv1K/xR9FYyHQATG/N6+UL5b53e Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xaj4tt4yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jan 2020 22:29:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 006MJeQh120782;
        Mon, 6 Jan 2020 22:29:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xb4v1swnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jan 2020 22:29:00 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 006MStjI005195;
        Mon, 6 Jan 2020 22:28:55 GMT
Received: from dhcp-10-175-162-40.vpn.oracle.com (/10.175.162.40)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 14:28:54 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     shuah@kernel.org, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org
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
Subject: [RESEND PATCH v7 linux-kselftest-test 2/6] kunit: hide unexported try-catch interface in try-catch-impl.h
Date:   Mon,  6 Jan 2020 22:28:19 +0000
Message-Id: <1578349703-15650-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578349703-15650-1-git-send-email-alan.maguire@oracle.com>
References: <1578349703-15650-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001060185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001060185
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

