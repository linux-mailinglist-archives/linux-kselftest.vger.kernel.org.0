Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC8E4112E5A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 16:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfLDP2T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Dec 2019 10:28:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44224 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbfLDP2T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Dec 2019 10:28:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4FOJ5A104595;
        Wed, 4 Dec 2019 15:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=K+A93ZAv9I878HBX82hzx7n9260RnjvxaGQwnMGdHIs=;
 b=lkUY9Dav4kerOEC9KMY/P5GvVCdxbcYyPXIylmma9ps4uZqMqxeIsinlazMZ6GigtVMB
 Klm0Y23rrAnJN3uAqr1YOd4wKC55zK9ygezu3D+lxEUFIuYwjo3iTPUtZKfyqbDJZw3v
 xEIoBq0h5J1DA0aoMYcI7+d/8o/b2LUOtfDBe6fXk/iprZye9wefBEg/RL3ReKmmzAI0
 srDIlMlP+YQu3S5Bqzc01i0++Dyar8a+H5PZ4ByCQQDF7J893anVlpXQdrNJw9QDfsBy
 WWGi+bZyUiHrXbgJ3fLcV0c26WxWO3ffYDpOXrnElhWqSitwGD6SbCyhph/WtY/zVuyV Kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wkh2rf080-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 15:27:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB4FOBUu049700;
        Wed, 4 Dec 2019 15:27:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2wp20c5vwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Dec 2019 15:27:58 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB4FRuWh018538;
        Wed, 4 Dec 2019 15:27:56 GMT
Received: from dhcp-10-175-179-22.vpn.oracle.com (/10.175.179.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Dec 2019 07:27:56 -0800
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
Subject: [PATCH v6 linux-kselftest-test 2/6] kunit: hide unexported try-catch interface in try-catch-impl.h
Date:   Wed,  4 Dec 2019 15:27:10 +0000
Message-Id: <1575473234-5443-3-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575473234-5443-1-git-send-email-alan.maguire@oracle.com>
References: <1575473234-5443-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912040128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912040128
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

