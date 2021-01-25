Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348823047AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Jan 2021 20:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbhAZF6u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Jan 2021 00:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbhAYSy0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 13:54:26 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5DDC061756
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 10:53:45 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id e10so1416727qvp.22
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jan 2021 10:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Oos6Cbunyu96oTH36OiSBwJE5Z8pPZWjNBRUMHsJrek=;
        b=CFPWfcJwitv3RohHIoGj2BqdQ7Pp+2rd5GeLW343a9K5r8G/MEZyAi84WH7+E8M//w
         dlde5D9NEUrz8xC+XaXU5QDjNFAdVyeQErT27jBm77GsmbVFgDRFo4NY2eBYptiotlb4
         qd7Fa9wAx5Zm4GSABaYbAFPoua2SnPPUWD+KrBZapv/HaM6kW3gnvA60wZgmMNowP4Qe
         Qur9cLKgmfb9Y/ZBk6WwuYGiwTPgpE2hFT8BTgOG4L51RTI19z+XRpxnPYYnvALctiLS
         oL1ld/X8v+o78xBQBeyiZll6/azAQ/IViHMT5/ipa33PAwX07rZHYJVHdaeF6LbICNdB
         lrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Oos6Cbunyu96oTH36OiSBwJE5Z8pPZWjNBRUMHsJrek=;
        b=adVlUzl2u9GllNoUA6UeckFc5UIMSKW01pm/KVZGiUL0dSk24ISCZeMqByYfH53bFw
         Q4jYQZHrBpELPqy2/nz3MDmpzw6TIyNc5+spBvvGlprGF6blWczVcCrZaKZL6l9SI+Vv
         K4C2oZs7fsXMliTOZvQv0LztV8JZ4ZsUbk+Tmb/M2tdC9eJtqWA4Jna0rBfLxzCUjzdg
         fZMKQkafPwfc8kol57OlqmwXyrjM8xDFhsJ4oJHG+gHyEPgCSL3KBNjQWXI5E2lIsV5Y
         ookUtpzwqtHg58ncl4nf5XEmV3cSM0CkBApbX9oEQXdPyBrhZOW9PYZkAnR9hggMArtW
         tSNg==
X-Gm-Message-State: AOAM532uRuczdf2X9Stkf1T4FPVW2C7ThNfaTvvcMftpOax4XRbDBcu2
        0Hv6RSc4jp8wVExfOTprzeAufLmb1J5u/g==
X-Google-Smtp-Source: ABdhPJxtO63kE7j6Bzw86L0veOyHkWfcllNJBpprW+SNRmPOrzQ/V/OYAcXNigUxrRgIeKZrjRqn8/iPfdGCQA==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a0c:eb0a:: with SMTP id
 j10mr2116242qvp.56.1611600825024; Mon, 25 Jan 2021 10:53:45 -0800 (PST)
Date:   Mon, 25 Jan 2021 10:53:33 -0800
Message-Id: <20210125185333.3337463-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH] Documentation: kunit: add tips.rst for small examples
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

./usage.rst contains fairly long examples and explanations of things
like how to fake a class and how to use parameterized tests (and how you
could do table-driven tests yourself).

It's not exactly necessary information, so we add a new page with more
digestible tips like "use kunit_kzalloc() instead of kzalloc() so you
don't have to worry about calling kfree() yourself" and the like.

Change start.rst to point users to this new page first and let them know
that usage.rst is more of optional further reading.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/index.rst |   2 +
 Documentation/dev-tools/kunit/start.rst |   4 +-
 Documentation/dev-tools/kunit/tips.rst  | 115 ++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/dev-tools/kunit/tips.rst

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index c234a3ab3c34..848478838347 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -13,6 +13,7 @@ KUnit - Unit Testing for the Linux Kernel
 	api/index
 	style
 	faq
+	tips
 
 What is KUnit?
 ==============
@@ -88,6 +89,7 @@ How do I use it?
 ================
 
 *   :doc:`start` - for new users of KUnit
+*   :doc:`tips` - for short examples of best practices
 *   :doc:`usage` - for a more detailed explanation of KUnit features
 *   :doc:`api/index` - for the list of KUnit APIs used for testing
 *   :doc:`kunit-tool` - for more information on the kunit_tool helper script
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 454f307813ea..c09e2747c958 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -233,5 +233,7 @@ Congrats! You just wrote your first KUnit test!
 
 Next Steps
 ==========
-*   Check out the :doc:`usage` page for a more
+*   Check out the :doc:`tips` page for tips on
+    writing idiomatic KUnit tests.
+*   Optional: see the :doc:`usage` page for a more
     in-depth explanation of KUnit.
diff --git a/Documentation/dev-tools/kunit/tips.rst b/Documentation/dev-tools/kunit/tips.rst
new file mode 100644
index 000000000000..a6ca0af14098
--- /dev/null
+++ b/Documentation/dev-tools/kunit/tips.rst
@@ -0,0 +1,115 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Tips For Writing KUnit Tests
+============================
+
+Exiting early on failed expectations
+------------------------------------
+
+``KUNIT_EXPECT_EQ`` and friends will mark the test as failed and continue
+execution.  In some cases, it's unsafe to continue and you can use the
+``KUNIT_ASSERT`` variant to exit on failure.
+
+.. code-block:: c
+
+	void example_test_user_alloc_function(struct kunit *test)
+	{
+		void *object = alloc_some_object_for_me();
+
+		/* Make sure we got a valid pointer back. */
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, object);
+		do_something_with_object(object);
+	}
+
+Allocating memory
+-----------------
+
+Where you would use ``kzalloc``, you should prefer ``kunit_kzalloc`` instead.
+KUnit will ensure the memory is freed once the test completes.
+
+This is particularly useful since it lets you use the ``KUNIT_ASSERT_EQ``
+macros to exit early from a test without having to worry about remembering to
+call ``kfree``.
+
+Example:
+
+.. code-block:: c
+
+	void example_test_allocation(struct kunit *test)
+	{
+		char *buffer = kunit_kzalloc(test, 16, GFP_KERNEL);
+		/* Ensure allocation succeeded. */
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
+
+		KUNIT_ASSERT_STREQ(test, buffer, "");
+	}
+
+
+Testing static functions
+------------------------
+
+If you don't want to expose functions or variables just for testing, one option
+is to conditionally ``#include`` the test file at the end of your .c file, e.g.
+
+.. code-block:: c
+
+	/* In my_file.c */
+
+	static int do_interesting_thing();
+
+	#ifdef CONFIG_MY_KUNIT_TEST
+	#include "my_kunit_test.c"
+	#endif
+
+Injecting test-only code
+------------------------
+
+Similarly to the above, it can be useful to add test-specific logic.
+
+.. code-block:: c
+
+	/* In my_file.h */
+
+	#ifdef CONFIG_MY_KUNIT_TEST
+	/* Defined in my_kunit_test.c */
+	void test_only_hook(void);
+	#else
+	void test_only_hook(void) { }
+	#endif
+
+TODO(dlatypov@google.com): add an example of using ``current->kunit_test`` in
+such a hook when it's not only updated for ``CONFIG_KASAN=y``.
+
+Customizing error messages
+--------------------------
+
+Each of the ``KUNIT_EXPECT`` and ``KUNIT_ASSERT`` macros have a ``_MSG`` variant.
+These take a format string and arguments to provide additional context to the automatically generated error messages.
+
+.. code-block:: c
+
+	char some_str[41];
+	generate_sha1_hex_string(some_str);
+
+	/* Before. Not easy to tell why the test failed. */
+	KUNIT_EXPECT_EQ(test, strlen(some_str), 40);
+
+	/* After. Now we see the offending string. */
+	KUNIT_EXPECT_EQ_MSG(test, strlen(some_str), 40, "some_str='%s'", some_str);
+
+Alternatively, one can take full control over the error message by using ``KUNIT_FAIL()``, e.g.
+
+.. code-block:: c
+
+	/* Before */
+	KUNIT_EXPECT_EQ(test, some_setup_function(), 0);
+
+	/* After: full control over the failure message. */
+	if (some_setup_function())
+		KUNIT_FAIL(test, "Failed to setup thing for testing");
+
+Next Steps
+==========
+*   Optional: see the :doc:`usage` page for a more
+    in-depth explanation of KUnit.

base-commit: 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04
-- 
2.30.0.280.ga3ce27912f-goog

