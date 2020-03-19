Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8959418BCED
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Mar 2020 17:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgCSQnB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Mar 2020 12:43:01 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:36748 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgCSQmr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Mar 2020 12:42:47 -0400
Received: by mail-pj1-f74.google.com with SMTP id np18so1902549pjb.1
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Mar 2020 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xrj+8qNx0KoAn4W34u+9YgQgrTU26Dej+YkYnDk+H1c=;
        b=hdDV9H3LGLfw9B2j+rY32eFKH/QungX8UAevdSoATXhma0CpBUEEQUyIVStD1d/goi
         vxMe2D29lwWcohOOzgn8GaGyT8UXBOESTGPLl5PuE1zTnk6rMdrlVIU8N8XXvIuBGeJh
         4MaQVu+ARvZZXACt8TO1IybXdKM0h3mly2l7kpFrc57GUvLUNePANrUIFHwiYdOjNhze
         Uph5tqZreaTlr9sxV/CZogEQEz4tuSV/MSxfVfIdAtzM5yxzNlIBgCR9+5CFDfefn+iI
         hOLs1Un9z0uXs3FNLkpQF+L/XcNP7H75PB09b2mZCtE6OT7mnCCM9zFQTBnbYIclq9am
         muUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xrj+8qNx0KoAn4W34u+9YgQgrTU26Dej+YkYnDk+H1c=;
        b=k015UQyYF3HVjN/x0h2NcFKGmdM4NHpfunfqk/4R+QduEqpKuiWRrz0ar5cMc2q2hp
         U6qksZ/Ig9Q7pzHOHmrw0JbOCvKZ4jaGAkdxHBRw+tsODVtthugI8WtYY7XD5UOHKb5w
         ZkfBHfcGydE5SOw7hKVIzSIW+eOFkbLo4cPs1nB4LHypqyRJlp36Lp/H1+AQ25u7sqL6
         Cr9ZkvQIX4rk21yX0SkdxitpKoqkhVWQZncZUEQol4m4pjzZ1k9ZrDV9uyVs/aZX6Co3
         pCCdsYCJUQmEGJPGvqBTbr/Jt80ZLM9boU6n9vxhDAPgAyKgXJpwEAO9KPVEtNb1uiB5
         STHQ==
X-Gm-Message-State: ANhLgQ01PMsJCN5yQcJxYqJHImOxS8+AI8B++hKR1mO8VwW4WtmQl6Bk
        AMtJoe+HZMbU6YyB03JXI+b2W60tU62iG2mgnA4=
X-Google-Smtp-Source: ADFU+vvni+PtP80Ym72JDcL2wDY/IhrppRfbMtCdXXnSKQRu9nkusLnMWQK9sqqywJ7J/5+kEz+pKK25dtcp17twTvs=
X-Received: by 2002:a17:90a:628a:: with SMTP id d10mr4805164pjj.25.1584636166443;
 Thu, 19 Mar 2020 09:42:46 -0700 (PDT)
Date:   Thu, 19 Mar 2020 09:42:26 -0700
In-Reply-To: <20200319164227.87419-1-trishalfonso@google.com>
Message-Id: <20200319164227.87419-3-trishalfonso@google.com>
Mime-Version: 1.0
References: <20200319164227.87419-1-trishalfonso@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [RFC PATCH v2 2/3] KUnit: KASAN Integration
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
     	- Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
     	- Expected KASAN reports pass tests and are still printed when run
     	without kunit_tool (kunit_tool still bypasses the report due to the
	test passing)
     	- KUnit struct in current task used to keep track of the current test
     	from KASAN code

Make use of "[RFC PATCH kunit-next 1/2] kunit: generalize
kunit_resource API beyond allocated resources" and "[RFC PATCH
kunit-next 2/2] kunit: add support for named resources" from Alan
Maguire [1]
	- A named resource is added to a test when a KASAN report is
	 expected
        - This resource contains a struct for kasan_data containing
        booleans representing if a KASAN report is expected and if a
        KASAN report is found

[1] (https://lore.kernel.org/linux-kselftest/1583251361-12748-1-git-send-email-alan.maguire@oracle.com/T/#t)

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
---
 include/kunit/test.h | 10 ++++++++++
 lib/kunit/test.c     | 10 +++++++++-
 lib/test_kasan.c     | 37 +++++++++++++++++++++++++++++++++++++
 mm/kasan/report.c    | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 70ee581b19cd..2ab265f4f76c 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -19,9 +19,19 @@
 
 struct kunit_resource;
 
+#ifdef CONFIG_KASAN
+/* kasan_data struct is used in KUnit tests for KASAN expected failures */
+struct kunit_kasan_expectation {
+	bool report_expected;
+	bool report_found;
+};
+#endif /* CONFIG_KASAN */
+
 typedef int (*kunit_resource_init_t)(struct kunit_resource *, void *);
 typedef void (*kunit_resource_free_t)(struct kunit_resource *);
 
+void kunit_set_failure(struct kunit *test);
+
 /**
  * struct kunit_resource - represents a *test managed resource*
  * @data: for the user to store arbitrary data.
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 86a4d9ca0a45..3f927ef45827 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -10,11 +10,12 @@
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/sched/debug.h>
+#include <linux/sched.h>
 
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
-static void kunit_set_failure(struct kunit *test)
+void kunit_set_failure(struct kunit *test)
 {
 	WRITE_ONCE(test->success, false);
 }
@@ -237,6 +238,10 @@ static void kunit_try_run_case(void *data)
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
 
+#if (IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT))
+	current->kunit_test = test;
+#endif /* IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT) */
+
 	/*
 	 * kunit_run_case_internal may encounter a fatal error; if it does,
 	 * abort will be called, this thread will exit, and finally the parent
@@ -590,6 +595,9 @@ void kunit_cleanup(struct kunit *test)
 		spin_unlock(&test->lock);
 		kunit_remove_resource(test, res);
 	}
+#if (IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT))
+	current->kunit_test = NULL;
+#endif /* IS_ENABLED(CONFIG_KASAN) && IS_BUILTIN(CONFIG_KUNIT)*/
 }
 EXPORT_SYMBOL_GPL(kunit_cleanup);
 
diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 3872d250ed2c..cf73c6bee81b 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -23,6 +23,43 @@
 
 #include <asm/page.h>
 
+#include <kunit/test.h>
+
+struct kunit_resource resource;
+struct kunit_kasan_expectation fail_data;
+
+#define KUNIT_SET_KASAN_DATA(test) do { \
+	fail_data.report_expected = true; \
+	fail_data.report_found = false; \
+	kunit_add_named_resource(test, \
+				NULL, \
+				NULL, \
+				&resource, \
+				"kasan_data", &fail_data); \
+} while (0)
+
+#define KUNIT_DO_EXPECT_KASAN_FAIL(test, condition) do { \
+	struct kunit_resource *resource; \
+	struct kunit_kasan_expectation *kasan_data; \
+	condition; \
+	resource = kunit_find_named_resource(test, "kasan_data"); \
+	kasan_data = resource->data; \
+	KUNIT_EXPECT_EQ(test, \
+			kasan_data->report_expected, \
+			kasan_data->report_found); \
+	kunit_put_resource(resource); \
+} while (0)
+
+/**
+ * KUNIT_EXPECT_KASAN_FAIL() - Causes a test failure when the expression does
+ * not cause a KASAN error.
+ *
+ */
+#define KUNIT_EXPECT_KASAN_FAIL(test, condition) do { \
+	KUNIT_SET_KASAN_DATA(test); \
+	KUNIT_DO_EXPECT_KASAN_FAIL(test, condition); \
+} while (0)
+
 /*
  * Note: test functions are marked noinline so that their names appear in
  * reports.
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 5ef9f24f566b..ef3d0f54097e 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -32,6 +32,8 @@
 
 #include <asm/sections.h>
 
+#include <kunit/test.h>
+
 #include "kasan.h"
 #include "../slab.h"
 
@@ -455,12 +457,38 @@ static bool report_enabled(void)
 	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
 }
 
+#if IS_BUILTIN(CONFIG_KUNIT)
+void kasan_update_kunit_status(struct kunit *cur_test)
+{
+	struct kunit_resource *resource;
+	struct kunit_kasan_expectation *kasan_data;
+
+	if (kunit_find_named_resource(cur_test, "kasan_data")) {
+		resource = kunit_find_named_resource(cur_test, "kasan_data");
+		kasan_data = resource->data;
+		kasan_data->report_found = true;
+
+		if (!kasan_data->report_expected)
+			kunit_set_failure(current->kunit_test);
+		else
+			return;
+	} else
+		kunit_set_failure(current->kunit_test);
+}
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
+
 void kasan_report_invalid_free(void *object, unsigned long ip)
 {
 	unsigned long flags;
 	u8 tag = get_tag(object);
 
 	object = reset_tag(object);
+
+#if IS_BUILTIN(CONFIG_KUNIT)
+	if (current->kunit_test)
+		kasan_update_kunit_status(current->kunit_test);
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
+
 	start_report(&flags);
 	pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
 	print_tags(tag, object);
@@ -481,6 +509,11 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
 	if (likely(!report_enabled()))
 		return;
 
+#if IS_BUILTIN(CONFIG_KUNIT)
+	if (current->kunit_test)
+		kasan_update_kunit_status(current->kunit_test);
+#endif /* IS_BUILTIN(CONFIG_KUNIT) */
+
 	disable_trace_on_warning();
 
 	tagged_addr = (void *)addr;
-- 
2.25.1.696.g5e7596f4ac-goog

