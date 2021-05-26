Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9706A391219
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 10:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhEZINN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 04:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhEZIM4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 04:12:56 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E01C061756
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 01:11:23 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c126-20020ae9ed840000b02903a69f28eea6so147690qkg.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TccYnAk92fbSMDbrufKidZyWvSdAcbuvQv0kTQ1sGd8=;
        b=VheGPqmZczRMJo0WtEivSffIheup6wkGynTDJekzs8b5Tt8q08spRx9OtZFPaBHs5q
         RswMXFjNfYUKwGlKaGcehJFMAoRn1g/Kp7FPSZU3WBPr7gqE7RNkG2umXsIQ0VOHKqFP
         ecCEpcltPV8uxwGa/eZpl3DCRQoH+zlrhD9vJeMyIQqvfxdZj6kjtEcQyxojLcmGj/14
         UwaumwBFlCFja5Kbkpbet17r6Zzx5pD4xcobnhcx8wRSJEFHXWaiWEYUkYgjMJB9SD9G
         RXtdLvzV6Lb1m0w7FWu3c5oCC/YRdIfvdgURP4nzbPO8QhwrZOJjTJwzcVNk4sxEwi4h
         me0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TccYnAk92fbSMDbrufKidZyWvSdAcbuvQv0kTQ1sGd8=;
        b=oVvKyhbobpCgSBglb802u2u0fGgJeJjJTheUuVJWPUXJmDNoLAcTyqDYFsDjfapiG/
         d6YgGnLql+UVQJ/yOZLUZjouB0EwOUMHy6QoGxS1WUyNQued/iqym6HDa9hi6TR7xmLE
         WBRlJn1PzBVFzh0OKuA+9zs7THpg01t/toj2YJVJThVeasDzfxKdilfm4kSYR3Oykbx2
         5+8R/pjPaJ96xUDnQYKxINf+4oy05ObFbeA6JYC5LpdbqmqQYmIK/CQRT+c9SBo3FQ/r
         Q7RCbBOAKCpEBCGXtynDchy0GcxWMLbCqD1JqcDQ90CcXfPlPyEBLj5JHIqPamqfSqFd
         TlcQ==
X-Gm-Message-State: AOAM530srxX7Gmw5hU4dBtUroeXUbRxi71cM/BI/m5RmnthermLlTHWh
        AAayRROTWuSAU2VzWr/1K/AzHvDE00/Vzw==
X-Google-Smtp-Source: ABdhPJzKkc7JGP0aLpTZCrFpaH9wmzrc4ve+tjeCGjrAE2LRaTwUEwBe+4IKUbl+Mq6J1pHmq1zCHAqpqGW1rA==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:90cb:eafc:a44d:da3d])
 (user=davidgow job=sendgmr) by 2002:a0c:edcf:: with SMTP id
 i15mr42224753qvr.10.1622016682848; Wed, 26 May 2021 01:11:22 -0700 (PDT)
Date:   Wed, 26 May 2021 01:11:12 -0700
In-Reply-To: <20210526081112.3652290-1-davidgow@google.com>
Message-Id: <20210526081112.3652290-3-davidgow@google.com>
Mime-Version: 1.0
References: <20210526081112.3652290-1-davidgow@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 3/3] kunit: test: Add example_skip test suite which is always skipped
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new KUnit test suite which contains tests which are always
skipped. This is used as an example for how to write tests which are
skipped, and to demonstrate the difference between kunit_skip() and
kunit_mark_skipped().

Because these tests do not pass (they're skipped), they are not enabled
by default, or by the KUNIT_ALL_TESTS config option: they must be
enabled explicitly by setting CONFIG_KUNIT_EXAMPLE_SKIP_TEST=y in either
a .config or .kunitconfig file.

Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/Kconfig                   | 15 +++++++++
 lib/kunit/Makefile                  |  2 ++
 lib/kunit/kunit-example-skip-test.c | 52 +++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 lib/kunit/kunit-example-skip-test.c

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 0b5dfb001bac..399fe5f789f7 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -45,6 +45,21 @@ config KUNIT_EXAMPLE_TEST
 	  is intended for curious hackers who would like to understand how to
 	  use KUnit for kernel development.
 
+config KUNIT_EXAMPLE_SKIP_TEST
+	tristate "Skipped test example for KUnit"
+	default n
+	help
+	  Enables an example unit test that is always skipped.
+
+	  This test only exists to help new users understand what KUnit is and
+	  how it is used. Please refer to the example test itself,
+	  lib/kunit/example-test.c, for more information. This option is
+	  intended for curious hackers who would like to understand how to use
+	  KUnit for kernel development.
+
+	  Because this test does not pass, it is not enabled by
+	  CONFIG_KUNIT_ALL_TESTS
+
 config KUNIT_ALL_TESTS
 	tristate "All KUnit tests with satisfied dependencies"
 	help
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index c49f4ffb6273..8a99ff2f83bd 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -18,3 +18,5 @@ obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
 endif
 
 obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test.o
+
+obj-$(CONFIG_KUNIT_EXAMPLE_SKIP_TEST) +=	kunit-example-skip-test.o
diff --git a/lib/kunit/kunit-example-skip-test.c b/lib/kunit/kunit-example-skip-test.c
new file mode 100644
index 000000000000..5395ee0be485
--- /dev/null
+++ b/lib/kunit/kunit-example-skip-test.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Example KUnit test which is always skipped.
+ *
+ * Copyright (C) 2021, Google LLC.
+ * Author: David Gow <davidgow@google.com>
+ */
+
+#include <kunit/test.h>
+
+/*
+ * This test should always be skipped.
+ */
+
+static void example_skip_test(struct kunit *test)
+{
+	/* This line should run */
+	kunit_log(KERN_INFO, test, "You should not see a line below.");
+
+	/* Skip (and abort) the test */
+	kunit_skip(test, "this test should be skipped");
+
+	/* This line should not execute */
+	kunit_log(KERN_INFO, test, "You should not see this line.");
+}
+
+static void example_mark_skipped_test(struct kunit *test)
+{
+	/* This line should run */
+	kunit_log(KERN_INFO, test, "You should see a line below.");
+
+	/* Skip (but do not abort) the test */
+	kunit_mark_skipped(test, "this test should be skipped");
+
+	/* This line should run */
+	kunit_log(KERN_INFO, test, "You should see this line.");
+}
+
+static struct kunit_case example_skip_test_cases[] = {
+	KUNIT_CASE(example_skip_test),
+	KUNIT_CASE(example_mark_skipped_test),
+	{}
+};
+
+static struct kunit_suite example_skip_test_suite = {
+	.name = "example_skip",
+	.test_cases = example_skip_test_cases,
+};
+
+kunit_test_suites(&example_skip_test_suite);
+
+MODULE_LICENSE("GPL v2");
-- 
2.31.1.818.g46aad6cb9e-goog

