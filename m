Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC2F60C391
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 07:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJYF7A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 01:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJYF67 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 01:58:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539CCCAE73
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Oct 2022 22:58:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m66-20020a257145000000b006c23949ec98so11068834ybc.4
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Oct 2022 22:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=43JnGaSmU9P6ZBvWvLMP1pUgKjTWqRmMdR5LIqZN3qg=;
        b=S4FIphM9prlXum6vIeOxIroffCESQSRcZaH1GLxXGbFjzWXf5cVkCAX/ZJI4yvFKTT
         xDPrNs3PZNw5pJwiU0acuDKRIgeX6NgSLdt4cs+fet+U64zGJ4m1heu32GvM7uFo6r9g
         PtCAUcB1+VklxsDRWWP7SuaKsincZvhUrpcbFQxZEGbxk2Pt2gf5f78DMqPnnc6kpSGy
         0UQfNnzOcWLBFz2rxFs4CFlV9EZW+4ht16MqF7aZ82uiSafHSch+X7Z3WkJvEX5PR7sx
         H26rXP+ptqi38PrmryrSLFhVrcOSBsELuhBKJMj89iMhaRTDAAS+VhMWjT3qVQKGOLqE
         zNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43JnGaSmU9P6ZBvWvLMP1pUgKjTWqRmMdR5LIqZN3qg=;
        b=V73YUDhfGxwEDk0j2KN00tvq5oGePz7EGZ1kR4e2goqD2H0wvePe6T/8QVR1fJkH8S
         i07JOW1tcoRhky7O/8RPMN4vVuEOOzwveJh2YNlwHh3VKG+2VO1CGTTXtYxBkZKM2M6P
         avUeNR+SPOsjWkjhxzRP/lxcyVW0bYkjN+JKpPDxxKh0M7/SZIGJS/3C0J9ts2pWGyz2
         FPkM0RKTi98ctnO4kc/fx00KLsFBDsuEISKZQyvfa7YDBPEplgbsHhQgAXQjmMm7PU1D
         0vkKlHqtboKGPPwTGF2AxVW4kBtXNc6KuZ2DdQI96ZzLsgzAzeVBj7ouKE3mc9oDtlxv
         Q3bA==
X-Gm-Message-State: ACrzQf0nx50RIUM7luQGZpKBGbEiOaEvAtBzW42SW8yZfb/WXsAuo/Dt
        I+uSwowj+hXU0XdJstdr65eiRLHum80OBw==
X-Google-Smtp-Source: AMsMyM5gXQvSYyq6afqFjQhWPqDHR2nuVKuscFng+2bBfPawO5G4cc1QmSa2SlQS5PeHLKJfYvBFnGMRYmpJVQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:9c01:0:b0:6af:4a89:26b3 with SMTP id
 c1-20020a259c01000000b006af4a8926b3mr34164356ybo.190.1666677537630; Mon, 24
 Oct 2022 22:58:57 -0700 (PDT)
Date:   Tue, 25 Oct 2022 13:58:45 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221025055844.1231592-1-davidgow@google.com>
Subject: [PATCH] Documentation: kunit: Remove redundant 'tips.rst' page
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The contents of 'tips.rst' was included in 'usage.rst' way back in
commit 953574390634 ("Documentation: KUnit: Rework writing page to focus on writing tests"),
but the tips page remained behind as well.

Therefore, delete 'tips.rst'

While I regret breaking any links to 'tips' which might exist
externally, it's confusing to have two subtly different versions of the
same content around.

Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kunit/index.rst |   1 -
 Documentation/dev-tools/kunit/tips.rst  | 190 ------------------------
 2 files changed, 191 deletions(-)
 delete mode 100644 Documentation/dev-tools/kunit/tips.rst

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index f5d13f1d37be..d5629817cd72 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -16,7 +16,6 @@ KUnit - Linux Kernel Unit Testing
 	api/index
 	style
 	faq
-	tips
 	running_tips
 
 This section details the kernel unit testing framework.
diff --git a/Documentation/dev-tools/kunit/tips.rst b/Documentation/dev-tools/kunit/tips.rst
deleted file mode 100644
index 492d2ded2f5a..000000000000
--- a/Documentation/dev-tools/kunit/tips.rst
+++ /dev/null
@@ -1,190 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-============================
-Tips For Writing KUnit Tests
-============================
-
-Exiting early on failed expectations
-------------------------------------
-
-``KUNIT_EXPECT_EQ`` and friends will mark the test as failed and continue
-execution.  In some cases, it's unsafe to continue and you can use the
-``KUNIT_ASSERT`` variant to exit on failure.
-
-.. code-block:: c
-
-	void example_test_user_alloc_function(struct kunit *test)
-	{
-		void *object = alloc_some_object_for_me();
-
-		/* Make sure we got a valid pointer back. */
-		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, object);
-		do_something_with_object(object);
-	}
-
-Allocating memory
------------------
-
-Where you would use ``kzalloc``, you should prefer ``kunit_kzalloc`` instead.
-KUnit will ensure the memory is freed once the test completes.
-
-This is particularly useful since it lets you use the ``KUNIT_ASSERT_EQ``
-macros to exit early from a test without having to worry about remembering to
-call ``kfree``.
-
-Example:
-
-.. code-block:: c
-
-	void example_test_allocation(struct kunit *test)
-	{
-		char *buffer = kunit_kzalloc(test, 16, GFP_KERNEL);
-		/* Ensure allocation succeeded. */
-		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
-
-		KUNIT_ASSERT_STREQ(test, buffer, "");
-	}
-
-
-Testing static functions
-------------------------
-
-If you don't want to expose functions or variables just for testing, one option
-is to conditionally ``#include`` the test file at the end of your .c file, e.g.
-
-.. code-block:: c
-
-	/* In my_file.c */
-
-	static int do_interesting_thing();
-
-	#ifdef CONFIG_MY_KUNIT_TEST
-	#include "my_kunit_test.c"
-	#endif
-
-Injecting test-only code
-------------------------
-
-Similarly to the above, it can be useful to add test-specific logic.
-
-.. code-block:: c
-
-	/* In my_file.h */
-
-	#ifdef CONFIG_MY_KUNIT_TEST
-	/* Defined in my_kunit_test.c */
-	void test_only_hook(void);
-	#else
-	void test_only_hook(void) { }
-	#endif
-
-This test-only code can be made more useful by accessing the current kunit
-test, see below.
-
-Accessing the current test
---------------------------
-
-In some cases, you need to call test-only code from outside the test file, e.g.
-like in the example above or if you're providing a fake implementation of an
-ops struct.
-There is a ``kunit_test`` field in ``task_struct``, so you can access it via
-``current->kunit_test``.
-
-Here's a slightly in-depth example of how one could implement "mocking":
-
-.. code-block:: c
-
-	#include <linux/sched.h> /* for current */
-
-	struct test_data {
-		int foo_result;
-		int want_foo_called_with;
-	};
-
-	static int fake_foo(int arg)
-	{
-		struct kunit *test = current->kunit_test;
-		struct test_data *test_data = test->priv;
-
-		KUNIT_EXPECT_EQ(test, test_data->want_foo_called_with, arg);
-		return test_data->foo_result;
-	}
-
-	static void example_simple_test(struct kunit *test)
-	{
-		/* Assume priv is allocated in the suite's .init */
-		struct test_data *test_data = test->priv;
-
-		test_data->foo_result = 42;
-		test_data->want_foo_called_with = 1;
-
-		/* In a real test, we'd probably pass a pointer to fake_foo somewhere
-		 * like an ops struct, etc. instead of calling it directly. */
-		KUNIT_EXPECT_EQ(test, fake_foo(1), 42);
-	}
-
-
-Note: here we're able to get away with using ``test->priv``, but if you wanted
-something more flexible you could use a named ``kunit_resource``, see
-Documentation/dev-tools/kunit/api/test.rst.
-
-Failing the current test
-------------------------
-
-But sometimes, you might just want to fail the current test. In that case, we
-have ``kunit_fail_current_test(fmt, args...)`` which is defined in ``<kunit/test-bug.h>`` and
-doesn't require pulling in ``<kunit/test.h>``.
-
-E.g. say we had an option to enable some extra debug checks on some data structure:
-
-.. code-block:: c
-
-	#include <kunit/test-bug.h>
-
-	#ifdef CONFIG_EXTRA_DEBUG_CHECKS
-	static void validate_my_data(struct data *data)
-	{
-		if (is_valid(data))
-			return;
-
-		kunit_fail_current_test("data %p is invalid", data);
-
-		/* Normal, non-KUnit, error reporting code here. */
-	}
-	#else
-	static void my_debug_function(void) { }
-	#endif
-
-
-Customizing error messages
---------------------------
-
-Each of the ``KUNIT_EXPECT`` and ``KUNIT_ASSERT`` macros have a ``_MSG`` variant.
-These take a format string and arguments to provide additional context to the automatically generated error messages.
-
-.. code-block:: c
-
-	char some_str[41];
-	generate_sha1_hex_string(some_str);
-
-	/* Before. Not easy to tell why the test failed. */
-	KUNIT_EXPECT_EQ(test, strlen(some_str), 40);
-
-	/* After. Now we see the offending string. */
-	KUNIT_EXPECT_EQ_MSG(test, strlen(some_str), 40, "some_str='%s'", some_str);
-
-Alternatively, one can take full control over the error message by using ``KUNIT_FAIL()``, e.g.
-
-.. code-block:: c
-
-	/* Before */
-	KUNIT_EXPECT_EQ(test, some_setup_function(), 0);
-
-	/* After: full control over the failure message. */
-	if (some_setup_function())
-		KUNIT_FAIL(test, "Failed to setup thing for testing");
-
-Next Steps
-==========
-*   Optional: see the Documentation/dev-tools/kunit/usage.rst page for a more
-    in-depth explanation of KUnit.
-- 
2.38.0.135.g90850a2211-goog

