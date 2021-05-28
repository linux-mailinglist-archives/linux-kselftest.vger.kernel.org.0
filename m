Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ACF393E53
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 May 2021 10:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbhE1IDI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 May 2021 04:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbhE1ICq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 May 2021 04:02:46 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF12C0613CE
        for <linux-kselftest@vger.kernel.org>; Fri, 28 May 2021 00:59:43 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l19-20020a0ce5130000b02901b6795e3304so2133910qvm.2
        for <linux-kselftest@vger.kernel.org>; Fri, 28 May 2021 00:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZVsL0xI+MNjBw01D+JVaz82ZRFgWO1ddYEa/9upJxL4=;
        b=pgq7gcrZJKRjimn63n10cJk935lNwsJSXduCUcjGzLdJK8H9+9goftJxsImrongwJr
         shHCXoRf70Q2a+KqOPIzNt0GBackUHPbAIWiQ2+QsfjLwcC1/tjSI/i9ZhAoEXETP3+2
         YQb57Lk6qrfXgbZWp3PEKBZASasVApVSDYo3NPIRQUssFKz+1YK3njIuZeoTE1m1lppy
         2mn/5MlqeDpKoB4tltBINzMzolXbGtfXMzWhGOBxqhZFezsZNDuFFhnBAHt4jycNkKsE
         KWZ0qkfOO0Rg13aldKesdXPYahX5m9OMOymVwXwUONwKwZQGiQ5XwIT+qjWXhgaakcY+
         rJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZVsL0xI+MNjBw01D+JVaz82ZRFgWO1ddYEa/9upJxL4=;
        b=JAJncJxSrXFgLl+iu8NmRAqa5UNAccqVZA3qVT3QqS5nhjLkKS8wgGbjFQ3SADUxm6
         IsKp/DoC2BpjTGmvGbQ0Tiw//3QFFacQyPYrIpvggiqwWRtsEAvgdhvMXl5Xbg0HQmI9
         dHYnzrvNyvpnWZmUAT7Ki1mi4YVkpqyMGK6LDgyb/2GPtVx0z2mvt9bpOAhywKZUN/kt
         AKEEHsk/SVmXbhnU/iT0r0JAx0uHyTP2/c4BW3w+MrTtGYn3uaW6EfCMHAJZxlpKhLvg
         pCaMxILfiOWcf6iZDeqBX7wAd9QvY4cT6Qrepe3gYZu/N1ctwjUmXGJqw/ItwopSfmSP
         n35g==
X-Gm-Message-State: AOAM533Z6Y694y06L1N+KVKgSZHfnn72V/U9CfOOaOGua7vc8OBgUnVc
        +2t1WUs5jKjUjjH79EdGdPLRlfowJGwnrA==
X-Google-Smtp-Source: ABdhPJxxiN4v7zKhCwrB7qzBSSMmurQalRTEXeJ8UpduC2whOy52EgasAL/vIHvs/xdTe7xPousgbYg1+Wn8Fw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:621b:e8e2:f86a:41f])
 (user=davidgow job=sendgmr) by 2002:a05:6214:902:: with SMTP id
 dj2mr2645213qvb.11.1622188782300; Fri, 28 May 2021 00:59:42 -0700 (PDT)
Date:   Fri, 28 May 2021 00:59:31 -0700
In-Reply-To: <20210528075932.347154-1-davidgow@google.com>
Message-Id: <20210528075932.347154-3-davidgow@google.com>
Mime-Version: 1.0
References: <20210528075932.347154-1-davidgow@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH v2 3/4] kunit: test: Add example tests which are always skipped
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add two new tests to the example test suite, both of which are always
skipped. This is used as an example for how to write tests which are
skipped, and to demonstrate the difference between kunit_skip() and
kunit_mark_skipped().

Note that these tests are enabled by default, so a default run of KUnit
will have two skipped tests.

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20210526081112.3652290-3-davidgow@google.com/
- These tests are now part of the example test suite.
- Use kunit_info() instead of kunit_log(KERN_INFO, ...)
- Use KUNIT_FAIL() to assert the test is not executing for skip_test

 lib/kunit/kunit-example-test.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index be1164ecc476..51099b0ca29c 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -40,6 +40,35 @@ static int example_test_init(struct kunit *test)
 	return 0;
 }
 
+/*
+ * This test should always be skipped.
+ */
+static void example_skip_test(struct kunit *test)
+{
+	/* This line should run */
+	kunit_info(test, "You should not see a line below.");
+
+	/* Skip (and abort) the test */
+	kunit_skip(test, "this test should be skipped");
+
+	/* This line should not execute */
+	KUNIT_FAIL(test, "You should not see this line.");
+}
+
+/*
+ * This test should always be marked skipped.
+ */
+static void example_mark_skipped_test(struct kunit *test)
+{
+	/* This line should run */
+	kunit_info(test, "You should see a line below.");
+
+	/* Skip (but do not abort) the test */
+	kunit_mark_skipped(test, "this test should be skipped");
+
+	/* This line should run */
+	kunit_info(test, "You should see this line.");
+}
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -52,6 +81,8 @@ static struct kunit_case example_test_cases[] = {
 	 * test suite.
 	 */
 	KUNIT_CASE(example_simple_test),
+	KUNIT_CASE(example_skip_test),
+	KUNIT_CASE(example_mark_skipped_test),
 	{}
 };
 
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

