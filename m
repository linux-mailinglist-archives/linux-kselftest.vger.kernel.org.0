Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396DE425064
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 11:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbhJGJxf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 05:53:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:46353 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240771AbhJGJxd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 05:53:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="287094699"
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="287094699"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 02:51:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="624185478"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Oct 2021 02:51:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0D9AA291; Thu,  7 Oct 2021 12:51:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-media@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/4] kernel.h: Split out container_of() and typeof_member() macros
Date:   Thu,  7 Oct 2021 12:51:27 +0300
Message-Id: <20211007095129.22037-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007095129.22037-1-andriy.shevchenko@linux.intel.com>
References: <20211007095129.22037-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kernel.h is being used as a dump for all kinds of stuff for a long time.
Here is the attempt cleaning it up by splitting out container_of() and
typeof_member() macros.

At the same time convert users in the header and other folders to use it.
Though for time being include new header back to kernel.h to avoid twisted
indirected includes for existing users.

Note, there are _a lot_ of headers and modules that include kernel.h solely
for one of these macros and this allows to unburden compiler for the twisted
inclusion paths and to make new code cleaner in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/kunit/test.h         |  2 ++
 include/linux/container_of.h | 37 ++++++++++++++++++++++++++++++++++++
 include/linux/kernel.h       | 31 +-----------------------------
 include/linux/kobject.h      |  1 +
 include/linux/list.h         |  6 ++++--
 include/linux/llist.h        |  4 +++-
 include/linux/plist.h        |  5 ++++-
 include/media/media-entity.h |  3 ++-
 lib/radix-tree.c             |  6 +++++-
 lib/rhashtable.c             |  1 +
 10 files changed, 60 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/container_of.h

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 24b40e5c160b..4d498f496790 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -11,6 +11,8 @@
 
 #include <kunit/assert.h>
 #include <kunit/try-catch.h>
+
+#include <linux/container_of.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
diff --git a/include/linux/container_of.h b/include/linux/container_of.h
new file mode 100644
index 000000000000..f6ee1be0e784
--- /dev/null
+++ b/include/linux/container_of.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CONTAINER_OF_H
+#define _LINUX_CONTAINER_OF_H
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
index d416fe3165cb..ad9fdcce9dcf 100644
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
@@ -482,36 +483,6 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
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
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index efd56f990a46..bf8371e58b17 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -15,6 +15,7 @@
 #ifndef _KOBJECT_H_
 #define _KOBJECT_H_
 
+#include <linux/container_of.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/sysfs.h>
diff --git a/include/linux/list.h b/include/linux/list.h
index f2af4b4aa4e9..5dc679b373da 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -2,11 +2,13 @@
 #ifndef _LINUX_LIST_H
 #define _LINUX_LIST_H
 
+#include <linux/container_of.h>
+#include <linux/const.h>
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/poison.h>
-#include <linux/const.h>
-#include <linux/kernel.h>
+
+#include <asm/barrier.h>
 
 /*
  * Circular doubly linked list implementation.
diff --git a/include/linux/llist.h b/include/linux/llist.h
index 24f207b0190b..85bda2d02d65 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -49,7 +49,9 @@
  */
 
 #include <linux/atomic.h>
-#include <linux/kernel.h>
+#include <linux/container_of.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 
 struct llist_head {
 	struct llist_node *first;
diff --git a/include/linux/plist.h b/include/linux/plist.h
index 66bab1bca35c..0f352c1d3c80 100644
--- a/include/linux/plist.h
+++ b/include/linux/plist.h
@@ -73,8 +73,11 @@
 #ifndef _LINUX_PLIST_H_
 #define _LINUX_PLIST_H_
 
-#include <linux/kernel.h>
+#include <linux/container_of.h>
 #include <linux/list.h>
+#include <linux/types.h>
+
+#include <asm/bug.h>
 
 struct plist_head {
 	struct list_head node_list;
diff --git a/include/media/media-entity.h b/include/media/media-entity.h
index 09737b47881f..fea489f03d57 100644
--- a/include/media/media-entity.h
+++ b/include/media/media-entity.h
@@ -13,10 +13,11 @@
 
 #include <linux/bitmap.h>
 #include <linux/bug.h>
+#include <linux/container_of.h>
 #include <linux/fwnode.h>
-#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/media.h>
+#include <linux/types.h>
 
 /* Enums used internally at the media controller to represent graphs */
 
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index b3afafe46fff..a0f346a095df 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -12,19 +12,21 @@
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
+#include <linux/container_of.h>
 #include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/idr.h>
 #include <linux/init.h>
-#include <linux/kernel.h>
 #include <linux/kmemleak.h>
+#include <linux/math.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>		/* in_interrupt() */
 #include <linux/radix-tree.h>
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/types.h>
 #include <linux/xarray.h>
 
 /*
@@ -285,6 +287,8 @@ radix_tree_node_alloc(gfp_t gfp_mask, struct radix_tree_node *parent,
 	return ret;
 }
 
+extern void radix_tree_node_rcu_free(struct rcu_head *head);
+
 void radix_tree_node_rcu_free(struct rcu_head *head)
 {
 	struct radix_tree_node *node =
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index e12bbfb240b8..a422c7dd9126 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/container_of.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/log2.h>
-- 
2.33.0

