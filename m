Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1932242C72E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 19:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbhJMRG1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 13:06:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:4028 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237704AbhJMRG0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 13:06:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227766326"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="227766326"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 10:04:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="486973571"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 13 Oct 2021 10:04:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A53BD367; Wed, 13 Oct 2021 20:04:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        jic23@kernel.org, linux@rasmusvillemoes.dk,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [PATCH v5 2/7] kernel.h: Split out container_of() and typeof_member() macros
Date:   Wed, 13 Oct 2021 20:04:12 +0300
Message-Id: <20211013170417.87909-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013170417.87909-1-andriy.shevchenko@linux.intel.com>
References: <20211013170417.87909-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kernel.h is being used as a dump for all kinds of stuff for a long time.
Here is the attempt cleaning it up by splitting out container_of() and
typeof_member() macros.

For time being include new header back to kernel.h to avoid twisted
indirected includes for existing users.

Note, there are _a lot_ of headers and modules that include kernel.h solely
for one of these macros and this allows to unburden compiler for the twisted
inclusion paths and to make new code cleaner in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/container_of.h | 40 ++++++++++++++++++++++++++++++++++++
 include/linux/kernel.h       | 33 +----------------------------
 2 files changed, 41 insertions(+), 32 deletions(-)
 create mode 100644 include/linux/container_of.h

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
new file mode 100644
index 000000000000..dd56019838c6
--- /dev/null
+++ b/include/linux/container_of.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CONTAINER_OF_H
+#define _LINUX_CONTAINER_OF_H
+
+#include <linux/build_bug.h>
+#include <linux/err.h>
+
+#define typeof_member(T, m)	typeof(((T*)0)->m)
+
+/**
+ * container_of - cast a member of a structure out to the containing structure
+ * @ptr:	the pointer to the member.
+ * @type:	the type of the container struct this is embedded in.
+ * @member:	the name of the member within the struct.
+ *
+ */
+#define container_of(ptr, type, member) ({				\
+	void *__mptr = (void *)(ptr);					\
+	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
+			 !__same_type(*(ptr), void),			\
+			 "pointer type mismatch in container_of()");	\
+	((type *)(__mptr - offsetof(type, member))); })
+
+/**
+ * container_of_safe - cast a member of a structure out to the containing structure
+ * @ptr:	the pointer to the member.
+ * @type:	the type of the container struct this is embedded in.
+ * @member:	the name of the member within the struct.
+ *
+ * If IS_ERR_OR_NULL(ptr), ptr is returned unchanged.
+ */
+#define container_of_safe(ptr, type, member) ({				\
+	void *__mptr = (void *)(ptr);					\
+	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
+			 !__same_type(*(ptr), void),			\
+			 "pointer type mismatch in container_of()");	\
+	IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :			\
+		((type *)(__mptr - offsetof(type, member))); })
+
+#endif	/* _LINUX_CONTAINER_OF_H */
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d1e74f684aa0..24df51162e3e 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -9,6 +9,7 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/container_of.h>
 #include <linux/bitops.h>
 #include <linux/kstrtox.h>
 #include <linux/log2.h>
@@ -52,8 +53,6 @@
 }					\
 )
 
-#define typeof_member(T, m)	typeof(((T*)0)->m)
-
 #define _RET_IP_		(unsigned long)__builtin_return_address(0)
 #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
 
@@ -481,36 +480,6 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 #define __CONCAT(a, b) a ## b
 #define CONCATENATE(a, b) __CONCAT(a, b)
 
-/**
- * container_of - cast a member of a structure out to the containing structure
- * @ptr:	the pointer to the member.
- * @type:	the type of the container struct this is embedded in.
- * @member:	the name of the member within the struct.
- *
- */
-#define container_of(ptr, type, member) ({				\
-	void *__mptr = (void *)(ptr);					\
-	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
-			 !__same_type(*(ptr), void),			\
-			 "pointer type mismatch in container_of()");	\
-	((type *)(__mptr - offsetof(type, member))); })
-
-/**
- * container_of_safe - cast a member of a structure out to the containing structure
- * @ptr:	the pointer to the member.
- * @type:	the type of the container struct this is embedded in.
- * @member:	the name of the member within the struct.
- *
- * If IS_ERR_OR_NULL(ptr), ptr is returned unchanged.
- */
-#define container_of_safe(ptr, type, member) ({				\
-	void *__mptr = (void *)(ptr);					\
-	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
-			 !__same_type(*(ptr), void),			\
-			 "pointer type mismatch in container_of()");	\
-	IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :			\
-		((type *)(__mptr - offsetof(type, member))); })
-
 /* Rebuild everything on CONFIG_FTRACE_MCOUNT_RECORD */
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 # define REBUILD_DUE_TO_FTRACE_MCOUNT_RECORD
-- 
2.33.0

