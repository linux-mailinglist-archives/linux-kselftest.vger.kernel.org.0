Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE7AFDB03
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2019 11:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfKOKR6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Nov 2019 05:17:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54784 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfKOKR5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Nov 2019 05:17:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFAEP70021065;
        Fri, 15 Nov 2019 10:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=da7iXdjbFIbuGZbasA5yd1nTh/1IQS1oVdExPz6PWJs=;
 b=JCacvAHonTpbbcZe/ABZkI5jbfAti28DtxC00XA9S78xKbuXokx8WDyZKAttGVll9cCl
 5u7C7DPandnmTOlkABKNKNGcgnPI8cgcJN+XZC01ly2pvmkQCKEEvdkLKkicqqeYzGq6
 wYapmLtn7kKNZ42QdrqCDv1xyuTx5prjSBA/kKXhogY39IG7s8dOdIIa3uXGgTuRcqJp
 r2TJ+V+k5ncO6EVv72wyOmn5q+JxYrq8T9mQ9/LTn9o5oFqAfObUzWk4mhm2V3x6bA3A
 cIanDRI56pY5fPYxnfLs8KnWrSer+HMTiWdSzhwaCyvmXvZOaPQCgmjM8dkkrC/OLYHW 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2w9gxpje1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 10:16:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFADEKU169388;
        Fri, 15 Nov 2019 10:16:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2w9h0k4d40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 10:16:33 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAFAGThO001589;
        Fri, 15 Nov 2019 10:16:29 GMT
Received: from dhcp-10-175-208-51.vpn.oracle.com (/10.175.208.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Nov 2019 02:16:28 -0800
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
Subject: [PATCH v4 linux-kselftest-test 1/6] kunit: move string-stream.h to lib/kunit
Date:   Fri, 15 Nov 2019 10:16:07 +0000
Message-Id: <1573812972-10529-2-git-send-email-alan.maguire@oracle.com>
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

string-stream interfaces are not intended for external use;
move them from include/kunit to lib/kunit accordingly.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 include/kunit/assert.h         |  3 ++-
 include/kunit/string-stream.h  | 51 ------------------------------------------
 lib/kunit/assert.c             |  2 ++
 lib/kunit/string-stream-test.c |  3 ++-
 lib/kunit/string-stream.c      |  3 ++-
 lib/kunit/string-stream.h      | 51 ++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/test.c               |  2 ++
 7 files changed, 61 insertions(+), 54 deletions(-)
 delete mode 100644 include/kunit/string-stream.h
 create mode 100644 lib/kunit/string-stream.h

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index db6a0fc..ad889b5 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -9,10 +9,11 @@
 #ifndef _KUNIT_ASSERT_H
 #define _KUNIT_ASSERT_H
 
-#include <kunit/string-stream.h>
 #include <linux/err.h>
+#include <linux/kernel.h>
 
 struct kunit;
+struct string_stream;
 
 /**
  * enum kunit_assert_type - Type of expectation/assertion.
diff --git a/include/kunit/string-stream.h b/include/kunit/string-stream.h
deleted file mode 100644
index fe98a00..0000000
--- a/include/kunit/string-stream.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * C++ stream style string builder used in KUnit for building messages.
- *
- * Copyright (C) 2019, Google LLC.
- * Author: Brendan Higgins <brendanhiggins@google.com>
- */
-
-#ifndef _KUNIT_STRING_STREAM_H
-#define _KUNIT_STRING_STREAM_H
-
-#include <linux/spinlock.h>
-#include <linux/types.h>
-#include <stdarg.h>
-
-struct string_stream_fragment {
-	struct kunit *test;
-	struct list_head node;
-	char *fragment;
-};
-
-struct string_stream {
-	size_t length;
-	struct list_head fragments;
-	/* length and fragments are protected by this lock */
-	spinlock_t lock;
-	struct kunit *test;
-	gfp_t gfp;
-};
-
-struct kunit;
-
-struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp);
-
-int __printf(2, 3) string_stream_add(struct string_stream *stream,
-				     const char *fmt, ...);
-
-int string_stream_vadd(struct string_stream *stream,
-		       const char *fmt,
-		       va_list args);
-
-char *string_stream_get_string(struct string_stream *stream);
-
-int string_stream_append(struct string_stream *stream,
-			 struct string_stream *other);
-
-bool string_stream_is_empty(struct string_stream *stream);
-
-int string_stream_destroy(struct string_stream *stream);
-
-#endif /* _KUNIT_STRING_STREAM_H */
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 86013d4..9aca71c 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -7,6 +7,8 @@
  */
 #include <kunit/assert.h>
 
+#include "string-stream.h"
+
 void kunit_base_assert_format(const struct kunit_assert *assert,
 			      struct string_stream *stream)
 {
diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 76cc05e..6c70dc8 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -6,10 +6,11 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
-#include <kunit/string-stream.h>
 #include <kunit/test.h>
 #include <linux/slab.h>
 
+#include "string-stream.h"
+
 static void string_stream_test_empty_on_creation(struct kunit *test)
 {
 	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index e6d17aa..3503920 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -6,11 +6,12 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
-#include <kunit/string-stream.h>
 #include <kunit/test.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 
+#include "string-stream.h"
+
 struct string_stream_fragment_alloc_context {
 	struct kunit *test;
 	int len;
diff --git a/lib/kunit/string-stream.h b/lib/kunit/string-stream.h
new file mode 100644
index 0000000..fe98a00
--- /dev/null
+++ b/lib/kunit/string-stream.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * C++ stream style string builder used in KUnit for building messages.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_STRING_STREAM_H
+#define _KUNIT_STRING_STREAM_H
+
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <stdarg.h>
+
+struct string_stream_fragment {
+	struct kunit *test;
+	struct list_head node;
+	char *fragment;
+};
+
+struct string_stream {
+	size_t length;
+	struct list_head fragments;
+	/* length and fragments are protected by this lock */
+	spinlock_t lock;
+	struct kunit *test;
+	gfp_t gfp;
+};
+
+struct kunit;
+
+struct string_stream *alloc_string_stream(struct kunit *test, gfp_t gfp);
+
+int __printf(2, 3) string_stream_add(struct string_stream *stream,
+				     const char *fmt, ...);
+
+int string_stream_vadd(struct string_stream *stream,
+		       const char *fmt,
+		       va_list args);
+
+char *string_stream_get_string(struct string_stream *stream);
+
+int string_stream_append(struct string_stream *stream,
+			 struct string_stream *other);
+
+bool string_stream_is_empty(struct string_stream *stream);
+
+int string_stream_destroy(struct string_stream *stream);
+
+#endif /* _KUNIT_STRING_STREAM_H */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c83c0fa..36ebf47 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -11,6 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/sched/debug.h>
 
+#include "string-stream.h"
+
 static void kunit_set_failure(struct kunit *test)
 {
 	WRITE_ONCE(test->success, false);
-- 
1.8.3.1

