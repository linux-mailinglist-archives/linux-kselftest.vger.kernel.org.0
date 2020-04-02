Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A1619CBDD
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Apr 2020 22:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbgDBUqt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Apr 2020 16:46:49 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:35880 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgDBUqs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Apr 2020 16:46:48 -0400
Received: by mail-pf1-f202.google.com with SMTP id h125so4048025pfg.3
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Apr 2020 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tYL+uQBZdi0KOgINSVQl+qIlWrLdwDRqpATJxQQU3LQ=;
        b=Eofb7qaxldrZ1ltx9KNk3F6GZmlgc350sUPlbN5syXdq7+4zcupUf0s0eo+bs8h8JT
         A1bZAzeDjIz+TCn5hCw5YirTmY4y4ETwB4KjrXb7rpbeNB2IxFmXU++oejJyL9k06taL
         4G4HtFIwZzIDHwebpXDwyzTXAIK+YAFMx9NaiePjh3fW7gCNrsLf2BjIex+9J5EOzZeZ
         2WZ2Gq/wi5SZwbFeDJvUAuQWbWlyWrG5oG/yiH0vrjd05IFKeCbEwi92hV3i3x2QqwYo
         U4GO5LyyciCUDcQZYy2VpIDtYgOK/a1gm2N/AV0LbpYjDhI5eHFND/wQEQ23JJDpPETe
         +Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tYL+uQBZdi0KOgINSVQl+qIlWrLdwDRqpATJxQQU3LQ=;
        b=jfvWQj+7mbiEVy20NZAkUIXg2UhnYnTnkh5sXtIszclk4Yj60FSOJ2C0hwm+iXZ6G7
         z9U7K6XhR5c0pcYfY8hr/3JaPe8ljUuHp6oQ7VbMMaELzTM4YYe4wDgSDnsJ1mDRFE4d
         hWGI5uzyaSdGdxZGl//DmJelnNHQzitHX2qPSlniiV+TkoIrjslccwbgTdxCzOgmjdY3
         ExTJLxQQRKgKva3PmVeZUzziTv7ZQq0Gtd6stiWFKk7/86EIr75v6di87sCt+7vf/yqz
         vEcuheVdm3A/x1yYEbj2b5hL88Nk/HddheFadGDpQ6L+y8s2eZdbgFjgQFvhWBGLLkJF
         vrCg==
X-Gm-Message-State: AGi0PuaTiPNgkQpLaXyUrQjMFb5ihd6tZNEbwaqkMD1FfT0uB6J4vAqx
        KJ3I/QXtkHFIzNQv7hvyHbKjnCpmhskRmWo5KEY=
X-Google-Smtp-Source: APiQypLFnUvW7r8hMkR9d7MyOnFOFGg2OlGKcgVxSWWGKZggczPBbdmkXymjtogdV+7Qyd5fLY3dFGeEORr182smCYg=
X-Received: by 2002:a17:90a:202f:: with SMTP id n44mr5857243pjc.150.1585860405766;
 Thu, 02 Apr 2020 13:46:45 -0700 (PDT)
Date:   Thu,  2 Apr 2020 13:46:36 -0700
In-Reply-To: <20200402204639.161637-1-trishalfonso@google.com>
Message-Id: <20200402204639.161637-2-trishalfonso@google.com>
Mime-Version: 1.0
References: <20200402204639.161637-1-trishalfonso@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v4 2/4] KUnit: KASAN Integration
From:   Patricia Alfonso <trishalfonso@google.com>
To:     davidgow@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Patricia Alfonso <trishalfonso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Integrate KASAN into KUnit testing framework.
        - Fail tests when KASAN reports an error that is not expected
        - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN
	tests
        - Expected KASAN reports pass tests and are still printed when run
        without kunit_tool (kunit_tool still bypasses the report due to the
        test passing)
        - KUnit struct in current task used to keep track of the current
	test from KASAN code

Make use of "[PATCH v3 kunit-next 1/2] kunit: generalize
kunit_resource API beyond allocated resources" and "[PATCH v3
kunit-next 2/2] kunit: add support for named resources" from Alan
Maguire [1]
        - A named resource is added to a test when a KASAN report is
         expected
        - This resource contains a struct for kasan_data containing
        booleans representing if a KASAN report is expected and if a
        KASAN report is found

[1] (https://lore.kernel.org/linux-kselftest/1583251361-12748-1-git-send-email-alan.maguire@oracle.com/T/#t)

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
---
 include/kunit/test.h  |  5 ++++
 include/linux/kasan.h |  6 +++++
 lib/kunit/test.c      | 13 ++++++----
 lib/test_kasan.c      | 56 +++++++++++++++++++++++++++++++++++++++----
 mm/kasan/report.c     | 30 +++++++++++++++++++++++
 5 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index ac59d18e6bab..1dc3d118f64b 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -225,6 +225,11 @@ struct kunit {
 	struct list_head resources; /* Protected by lock. */
 };
 
+static inline void kunit_set_failure(struct kunit *test)
+{
+	WRITE_ONCE(test->success, false);
+}
+
 void kunit_init_test(struct kunit *test, const char *name, char *log);
 
 int kunit_run_tests(struct kunit_suite *suite);
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 5cde9e7c2664..148eaef3e003 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -14,6 +14,12 @@ struct task_struct;
 #include <asm/kasan.h>
 #include <asm/pgtable.h>
 
+/* kasan_data struct is used in KUnit tests for KASAN expected failures */
+struct kunit_kasan_expectation {
+	bool report_expected;
+	bool report_found;
+};
+
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
 extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
 extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 2cb7c6220a00..030a3281591e 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -10,16 +10,12 @@
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/sched/debug.h>
+#include <linux/sched.h>
 
 #include "debugfs.h"
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
-static void kunit_set_failure(struct kunit *test)
-{
-	WRITE_ONCE(test->success, false);
-}
-
 static void kunit_print_tap_version(void)
 {
 	static bool kunit_has_printed_tap_version;
@@ -288,6 +284,10 @@ static void kunit_try_run_case(void *data)
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
 
+#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
+	current->kunit_test = test;
+#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
+
 	/*
 	 * kunit_run_case_internal may encounter a fatal error; if it does,
 	 * abort will be called, this thread will exit, and finally the parent
@@ -603,6 +603,9 @@ void kunit_cleanup(struct kunit *test)
 		spin_unlock(&test->lock);
 		kunit_remove_resource(test, res);
 	}
+#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
+	current->kunit_test = NULL;
+#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
 }
 EXPORT_SYMBOL_GPL(kunit_cleanup);
 
diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 3872d250ed2c..dbfa0875ee09 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -23,12 +23,60 @@
 
 #include <asm/page.h>
 
-/*
- * Note: test functions are marked noinline so that their names appear in
- * reports.
+#include <kunit/test.h>
+
+static struct kunit_resource resource;
+static struct kunit_kasan_expectation fail_data;
+static bool multishot;
+static int orig_panic_on_warn;
+
+static int kasan_test_init(struct kunit *test)
+{
+	/*
+	 * Temporarily enable multi-shot mode and set panic_on_warn=0.
+	 * Otherwise, we'd only get a report for the first case.
+	 */
+	multishot = kasan_save_enable_multi_shot();
+
+	orig_panic_on_warn = panic_on_warn;
+	panic_on_warn = 0;
+
+	return 0;
+}
+
+static void kasan_test_exit(struct kunit *test)
+{
+	kasan_restore_multi_shot(multishot);
+
+	/* Restore panic_on_warn */
+	panic_on_warn = orig_panic_on_warn;
+}
+
+/**
+ * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
+ * not cause a KASAN error. This uses a KUnit resource named "kasan_data." Do
+ * Do not use this name for a KUnit resource outside here.
+ *
  */
+#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do { \
+	struct kunit_resource *res; \
+	struct kunit_kasan_expectation *kasan_data; \
+	fail_data.report_expected = true; \
+	fail_data.report_found = false; \
+	kunit_add_named_resource(test, \
+				NULL, \
+				NULL, \
+				&resource, \
+				"kasan_data", &fail_data); \
+	condition; \
+	res = kunit_find_named_resource(test, "kasan_data"); \
+	kasan_data = res->data; \
+	KUNIT_EXPECT_EQ(test, \
+			kasan_data->report_expected, \
+			kasan_data->report_found); \
+	kunit_put_resource(res); \
+} while (0)
 
-static noinline void __init kmalloc_oob_right(void)
 {
 	char *ptr;
 	size_t size = 123;
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 5ef9f24f566b..497477c4b679 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -32,6 +32,8 @@
 
 #include <asm/sections.h>
 
+#include <kunit/test.h>
+
 #include "kasan.h"
 #include "../slab.h"
 
@@ -455,12 +457,35 @@ static bool report_enabled(void)
 	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
 }
 
+#if IS_ENABLED(CONFIG_KUNIT)
+void kasan_update_kunit_status(struct kunit *cur_test)
+{
+	struct kunit_resource *resource;
+	struct kunit_kasan_expectation *kasan_data;
+
+	if (!kunit_find_named_resource(cur_test, "kasan_data")) {
+		kunit_set_failure(cur_test);
+		return;
+	}
+
+	resource = kunit_find_named_resource(cur_test, "kasan_data");
+	kasan_data = resource->data;
+	kasan_data->report_found = true;
+}
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 void kasan_report_invalid_free(void *object, unsigned long ip)
 {
 	unsigned long flags;
 	u8 tag = get_tag(object);
 
 	object = reset_tag(object);
+
+#if IS_ENABLED(CONFIG_KUNIT)
+	if (current->kunit_test)
+		kasan_update_kunit_status(current->kunit_test);
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 	start_report(&flags);
 	pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
 	print_tags(tag, object);
@@ -481,6 +506,11 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
 	if (likely(!report_enabled()))
 		return;
 
+#if IS_ENABLED(CONFIG_KUNIT)
+	if (current->kunit_test)
+		kasan_update_kunit_status(current->kunit_test);
+#endif /* IS_ENABLED(CONFIG_KUNIT) */
+
 	disable_trace_on_warning();
 
 	tagged_addr = (void *)addr;
-- 
2.26.0.292.g33ef6b2f38-goog

