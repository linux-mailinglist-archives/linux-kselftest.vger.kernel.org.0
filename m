Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 174AEDB591
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 20:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395536AbfJQSJI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 14:09:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34960 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395417AbfJQSJH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 14:09:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HI4Bwo161294;
        Thu, 17 Oct 2019 18:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=7JKg8okzpJWNJf5zujaC24NrMGYE1iKIoSUN+NfOr9k=;
 b=bBWA1ouRm0Zv+mrXzl8hiJ8pQAQIU6s68VzExj8x532Qw0VTasA9G9zHFtW8sUJU+bpR
 /birDGwj5EW7n2Km8Tp+Hu4b3dLohncIfR3KyiSi4gXZv9EqZUZZx/akxR7ieUQ01xMB
 Lw/cFP7Bkq7dY6PfxLHR2Y5rJOQgrUrlGPSkqvFk8oag0waGeOn1ZNyNBQG8NQQGIike
 xwF/hz+U1X5jpwFnNhXJDxZbaN2ajENk5uka/S4l40g0LOXjeku7u79xUqZw1876VTpX
 HdfxnMPLerQKsWK+aPbV2YoCbRn0Ts0F8FjkSg8lA8ZKrOQ7vqhlsqpSSntOuynMD7uY Rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vk68v0518-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:07:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HI3NG5165386;
        Thu, 17 Oct 2019 18:07:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vpcm3bve7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:07:41 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9HI7epS029041;
        Thu, 17 Oct 2019 18:07:40 GMT
Received: from dhcp-10-175-161-223.vpn.oracle.com (/10.175.161.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 18:07:39 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
Subject: [PATCH v3 linux-kselftest-test 1/6] kunit: move string-stream.h to lib/kunit/string-stream-impl.h
Date:   Thu, 17 Oct 2019 19:07:14 +0100
Message-Id: <1571335639-21675-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com>
References: <1571335639-21675-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170163
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

string stream interfaces are not intended for external use;
move them from include/kunit to lib/kunit/string-stream-impl.h accordingly.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 include/kunit/assert.h         |  3 ++-
 include/kunit/string-stream.h  | 51 ------------------------------------------
 lib/kunit/assert.c             |  1 +
 lib/kunit/string-stream-impl.h | 51 ++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/string-stream-test.c |  2 +-
 lib/kunit/string-stream.c      |  3 ++-
 lib/kunit/test.c               |  1 +
 7 files changed, 58 insertions(+), 54 deletions(-)
 delete mode 100644 include/kunit/string-stream.h
 create mode 100644 lib/kunit/string-stream-impl.h

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
index 86013d4..d8ae94e 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -6,6 +6,7 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 #include <kunit/assert.h>
+#include "string-stream-impl.h"
 
 void kunit_base_assert_format(const struct kunit_assert *assert,
 			      struct string_stream *stream)
diff --git a/lib/kunit/string-stream-impl.h b/lib/kunit/string-stream-impl.h
new file mode 100644
index 0000000..0fe4100
--- /dev/null
+++ b/lib/kunit/string-stream-impl.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * C++ stream style string builder used in KUnit for building messages.
+ *
+ * Copyright (C) 2019, Google LLC.
+ * Author: Brendan Higgins <brendanhiggins@google.com>
+ */
+
+#ifndef _KUNIT_STRING_STREAM_IMPL_H
+#define _KUNIT_STRING_STREAM_IMPL_H
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
+#endif /* _KUNIT_STRING_STREAM_IMPL_H */
diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 76cc05e..25b2cf3 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -6,9 +6,9 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
-#include <kunit/string-stream.h>
 #include <kunit/test.h>
 #include <linux/slab.h>
+#include "string-stream-impl.h"
 
 static void string_stream_test_empty_on_creation(struct kunit *test)
 {
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index e6d17aa..a1e005d 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -6,11 +6,12 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
-#include <kunit/string-stream.h>
 #include <kunit/test.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 
+#include "string-stream-impl.h"
+
 struct string_stream_fragment_alloc_context {
 	struct kunit *test;
 	int len;
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c83c0fa..017d4fb 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -10,6 +10,7 @@
 #include <kunit/try-catch.h>
 #include <linux/kernel.h>
 #include <linux/sched/debug.h>
+#include "string-stream-impl.h"
 
 static void kunit_set_failure(struct kunit *test)
 {
-- 
1.8.3.1

