Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1881E2160E0
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jul 2020 23:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgGFVNQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 17:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFVNQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 17:13:16 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8BDC061755;
        Mon,  6 Jul 2020 14:13:16 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id o5so40819083iow.8;
        Mon, 06 Jul 2020 14:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CLjoKMeutODoP4Bv1WKkZd+zgs0/3Kf9t9fuv18bUww=;
        b=aHLP3YndNPGmVqwb7qRNFqPvs6AxnEfyiUU10DNzURzFeDGogpMQYLE9qN9yMa1lel
         wM8NmpsInYXCI5wPjaq0oZPzFM974kHV4v/pFDiAvWMwUJTSo0jf+DYsNuKdF7wanbrV
         KE2ko+12xpO//fYEW9TJdxnmidCFE6SGOa+FSf+3d9Bb3Y8/5I/7j5CDO7WKv72chKbU
         xkuWKMBvi+Mq0K/eeHhi1tXm6vKcFUn/78wsSFhvh2IBB+p+Fsuvv5B3lLb4Ck7kePe6
         NcBVRbHseshdeMP9N6B5hSfNJ/PfkUsotQU1M+G9x9F/vSUpV3LrpmWczyLQv2rk6mu2
         QaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLjoKMeutODoP4Bv1WKkZd+zgs0/3Kf9t9fuv18bUww=;
        b=Htt50NBgypmYp5wqFq1zSLCY0x5FJvHDnmIhgLx6iu9WU69u+tNfxFSj+usLnvETk3
         JTOSEdMKBnMpxXVR2o0Xpb0mR9dy0gRT9S/FbMHE7QHUs/lLcgF7WGWGazZ8gk8FYb2u
         cxzulPJQwQBIYnqJZsLefibua9iQLH3W6hkx5nH88WnFqcfgdG1S0VTKt+OoyUrwvnvo
         Wl1H+m97/SfzXDJoWByEw2lVf2FNaqVacct+YCR85en1b72XdMRLEieKPlHcg7YWCElF
         mYxJtcGsT9Iqjz6JBYxB2vDbAli23gGsODpt4s9t5Z63Fsyi5PQ99PVOikWSZdhIHr1Z
         MSZA==
X-Gm-Message-State: AOAM531kP5L5+6TwE6ZbEy4+3wdMdB5fjNIiN4JWaHa8GaNZ30t1AQUE
        15cmp/kji2iPDveWH1BPzc4=
X-Google-Smtp-Source: ABdhPJy8oPjIn/77gVzwujqXdDY29qUD5ZhQ01EdzZz/Uvpw2va3c6jWUyzsq818GBAjNDKScXCw0w==
X-Received: by 2002:a5e:8d11:: with SMTP id m17mr27748087ioj.171.1594069995699;
        Mon, 06 Jul 2020 14:13:15 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id i10sm1063652ild.14.2020.07.06.14.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 14:13:15 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org
Cc:     changbin.du@intel.com, rdunlap@infradead.org, masahiroy@kernel.org,
        0x7f454c46@gmail.com, urielguajardo@google.com, krzk@kernel.org,
        kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-mm@kvack.org
Subject: [PATCH 2/2] kunit: kmemleak integration
Date:   Mon,  6 Jul 2020 21:13:09 +0000
Message-Id: <20200706211309.3314644-3-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200706211309.3314644-1-urielguajardojr@gmail.com>
References: <20200706211309.3314644-1-urielguajardojr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Uriel Guajardo <urielguajardo@google.com>

Integrate kmemleak into the KUnit testing framework.

Kmemleak will now fail the currently running KUnit test case if it finds
any memory leaks.

The minimum object age for reporting is set to 0 msecs so that leaks are
not ignored if the test case finishes too quickly.

Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
---
 include/linux/kmemleak.h | 11 +++++++++++
 lib/Kconfig.debug        | 26 ++++++++++++++++++++++++++
 lib/kunit/test.c         | 36 +++++++++++++++++++++++++++++++++++-
 mm/kmemleak.c            | 27 +++++++++++++++++++++------
 4 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
index 34684b2026ab..0da427934462 100644
--- a/include/linux/kmemleak.h
+++ b/include/linux/kmemleak.h
@@ -35,6 +35,10 @@ extern void kmemleak_free_part_phys(phys_addr_t phys, size_t size) __ref;
 extern void kmemleak_not_leak_phys(phys_addr_t phys) __ref;
 extern void kmemleak_ignore_phys(phys_addr_t phys) __ref;
 
+extern ssize_t kmemleak_write(struct file *file,
+			      const char __user *user_buf,
+			      size_t size, loff_t *ppos);
+
 static inline void kmemleak_alloc_recursive(const void *ptr, size_t size,
 					    int min_count, slab_flags_t flags,
 					    gfp_t gfp)
@@ -120,6 +124,13 @@ static inline void kmemleak_ignore_phys(phys_addr_t phys)
 {
 }
 
+static inline ssize_t kmemleak_write(struct file *file,
+				     const char __user *user_buf,
+				     size_t size, loff_t *ppos)
+{
+	return -1;
+}
+
 #endif	/* CONFIG_DEBUG_KMEMLEAK */
 
 #endif	/* __KMEMLEAK_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 21d9c5f6e7ec..e9c492cb3f4d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -602,6 +602,32 @@ config DEBUG_KMEMLEAK_MEM_POOL_SIZE
 	  fully initialised, this memory pool acts as an emergency one
 	  if slab allocations fail.
 
+config DEBUG_KMEMLEAK_MAX_TRACE
+	int "Kmemleak stack trace length"
+	depends on DEBUG_KMEMLEAK
+	default 16
+
+config DEBUG_KMEMLEAK_MSECS_MIN_AGE
+	int "Minimum object age before reporting in msecs"
+	depends on DEBUG_KMEMLEAK
+	default 0 if KUNIT
+	default 5000
+
+config DEBUG_KMEMLEAK_SECS_FIRST_SCAN
+	int "Delay before first scan in secs"
+	depends on DEBUG_KMEMLEAK
+	default 60
+
+config DEBUG_KMEMLEAK_SECS_SCAN_WAIT
+	int "Delay before subsequent auto scans in secs"
+	depends on DEBUG_KMEMLEAK
+	default 600
+
+config DEBUG_KMEMLEAK_MAX_SCAN_SIZE
+	int "Maximum size of scanned block"
+	depends on DEBUG_KMEMLEAK
+	default 4096
+
 config DEBUG_KMEMLEAK_TEST
 	tristate "Simple test for the kernel memory leak detector"
 	depends on DEBUG_KMEMLEAK && m
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 8580ed831a8f..8d113a6a214b 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -11,6 +11,7 @@
 #include <linux/kref.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
+#include <linux/kmemleak.h>
 
 #include "debugfs.h"
 #include "string-stream.h"
@@ -277,6 +278,27 @@ static void kunit_run_case_cleanup(struct kunit *test,
 	kunit_case_internal_cleanup(test);
 }
 
+/*
+ * Manually scans for memory leaks using the kmemleak tool.
+ *
+ * Any leaks that occurred since the previous scan will be
+ * reported and will cause the currently running test to fail.
+ */
+static inline void kmemleak_scan(void)
+{
+	loff_t pos;
+	kmemleak_write(NULL, "scan", 5, &pos);
+}
+
+/*
+ * Turn off the background automatic scan that kmemleak performs upon starting
+ */
+static inline void kmemleak_automatic_scan_off(void)
+{
+	loff_t pos;
+	kmemleak_write(NULL, "scan=off", 9, &pos);
+}
+
 struct kunit_try_catch_context {
 	struct kunit *test;
 	struct kunit_suite *suite;
@@ -290,6 +312,12 @@ static void kunit_try_run_case(void *data)
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
 
+	/*
+	 * Clear any reported memory leaks since last scan, so that only the
+	 * leaks pertaining to the test case remain afterwards.
+	 */
+	kmemleak_scan();
+
 	current->kunit_test = test;
 
 	/*
@@ -298,7 +326,12 @@ static void kunit_try_run_case(void *data)
 	 * thread will resume control and handle any necessary clean up.
 	 */
 	kunit_run_case_internal(test, suite, test_case);
-	/* This line may never be reached. */
+
+	/* These lines may never be reached. */
+
+	/* Report any detected memory leaks that occurred in the test case */
+	kmemleak_scan();
+
 	kunit_run_case_cleanup(test, suite);
 }
 
@@ -388,6 +421,7 @@ static void kunit_init_suite(struct kunit_suite *suite)
 int __kunit_test_suites_init(struct kunit_suite **suites)
 {
 	unsigned int i;
+	kmemleak_automatic_scan_off();
 
 	for (i = 0; suites[i] != NULL; i++) {
 		kunit_init_suite(suites[i]);
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index e362dc3d2028..ad046c77e00c 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -99,15 +99,26 @@
 #include <linux/kasan.h>
 #include <linux/kmemleak.h>
 #include <linux/memory_hotplug.h>
+#include <kunit/test.h>
 
 /*
  * Kmemleak configuration and common defines.
  */
-#define MAX_TRACE		16	/* stack trace length */
-#define MSECS_MIN_AGE		5000	/* minimum object age for reporting */
-#define SECS_FIRST_SCAN		60	/* delay before the first scan */
-#define SECS_SCAN_WAIT		600	/* subsequent auto scanning delay */
-#define MAX_SCAN_SIZE		4096	/* maximum size of a scanned block */
+
+/* stack trace length */
+#define MAX_TRACE		CONFIG_DEBUG_KMEMLEAK_MAX_TRACE
+
+/* minimum object age for reporting */
+#define MSECS_MIN_AGE		CONFIG_DEBUG_KMEMLEAK_MSECS_MIN_AGE
+
+/* delay before the first scan */
+#define SECS_FIRST_SCAN		CONFIG_DEBUG_KMEMLEAK_SECS_FIRST_SCAN
+
+/* subsequent auto scanning delay */
+#define SECS_SCAN_WAIT		CONFIG_DEBUG_KMEMLEAK_SECS_SCAN_WAIT
+
+/* maximum size of a scanned lock */
+#define MAX_SCAN_SIZE		CONFIG_DEBUG_KMEMLEAK_MAX_SCAN_SIZE
 
 #define BYTES_PER_POINTER	sizeof(void *)
 
@@ -1490,6 +1501,7 @@ static void kmemleak_scan(void)
 	 * Check for new or unreferenced objects modified since the previous
 	 * scan and color them gray until the next scan.
 	 */
+#if (!IS_ENABLED(CONFIG_KUNIT))
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
 		raw_spin_lock_irqsave(&object->lock, flags);
@@ -1502,6 +1514,7 @@ static void kmemleak_scan(void)
 		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
+#endif
 
 	/*
 	 * Re-scan the gray list for modified unreferenced objects.
@@ -1534,6 +1547,8 @@ static void kmemleak_scan(void)
 	rcu_read_unlock();
 
 	if (new_leaks) {
+		kunit_fail_current_test();
+
 		kmemleak_found_leaks = true;
 
 		pr_info("%d new suspected memory leaks (see /sys/kernel/debug/kmemleak)\n",
@@ -1764,7 +1779,7 @@ static void __kmemleak_do_cleanup(void);
  *		  if kmemleak has been disabled.
  *   dump=...	- dump information about the object found at the given address
  */
-static ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
+ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
 			      size_t size, loff_t *ppos)
 {
 	char buf[64];
-- 
2.27.0.212.ge8ba1cc988-goog

