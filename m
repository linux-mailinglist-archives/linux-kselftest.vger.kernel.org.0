Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C565355F17
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Apr 2021 00:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbhDFWvh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Apr 2021 18:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344565AbhDFWvX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Apr 2021 18:51:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E51DC061760
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Apr 2021 15:51:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t5so21700741ybc.18
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Apr 2021 15:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IOyxvbKPk8Cp2/x/ErG6esc4l62olFKQEwMahR274MA=;
        b=XCHcGFbcOvLlG/lOAuH+0uqAFmHoJwDmht8Gi7oHEOyMA5J6LGk9F8B/cBR2kxyN2x
         Di9uawIPvx/9VyjQ/1k8ESjrXI9lGgAqn8JLYOU1qjCR8xi7i9Ja2I/6Y6+r76aNe5Hl
         Mi4yCic5y8LqkicvOm6ukbk7q9/fCqcECAr5IgG8LGx/QZR2bM7fXCo407vPXLob7Ixx
         HcjFOi4IXHrg6iQ8AIQGAOEk2OPlMKkMahluiAO/wXtOXpS1DLafmZhkJge3NnzqCWun
         XIvu8qh5gt0WDSXRVtj8kuLBZ2tcAU94LduA9Yfbt+o3Ei5+mw7KHgjxQO61CfPSkb4v
         DG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IOyxvbKPk8Cp2/x/ErG6esc4l62olFKQEwMahR274MA=;
        b=AoUF6Qm2LG7Serhak+dpBemd+YVSccZY63Ger5WqarpWdgoqjqZEZWJJRvzFHOsczk
         aSM7Ck0Iru/YxX1NsSt2UrCn5z+6NfsjMNcnKGYWZ3U+0eB6brjvEg5lOL+y0bGylQUW
         h+Ov8Zqqfjj/LDDay3tr4pwf+YEemNfLlb97NRBLHzs5TTrbj/bMp8fy3BWQxz/SHZhD
         AmiuL+nadd9KSNMMq9/Lg8YORVySI7nBqy6U7o4CK26gSjteySh2sz7KcCLu4p5JBsJY
         EvqKoA4ceGAbTF3aFgS+gkj2ypP9ygZ1hRBoP7Fwj2XOpVeDpnCyxTfOrulc/a2QNUTX
         2ktQ==
X-Gm-Message-State: AOAM532QLFpszxMW+5ij/NKm4NfdOcrVnPfwuXurAw5oxDlIe80Z52yz
        RPNM4SKHdeTfADtNOQe8AhjhAjCD/G/dwg==
X-Google-Smtp-Source: ABdhPJygI4Xj2Dospmg+WnEam96QXYzVpORvi3AWLIbVogXWJ1fJKf5Q5OJ9ORU9Bv3CXFpi/p74y3eFrotJaA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:f46d:9fde:7b0b:e01a])
 (user=dlatypov job=sendgmr) by 2002:a25:492:: with SMTP id
 140mr556876ybe.150.1617749473305; Tue, 06 Apr 2021 15:51:13 -0700 (PDT)
Date:   Tue,  6 Apr 2021 15:51:00 -0700
Message-Id: <20210406225100.1883967-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH] Documentation: kunit: add tips for using current->kunit_test
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As of commit 359a376081d4 ("kunit: support failure from dynamic analysis
tools"), we can use current->kunit_test to find the current kunit test.

Mention this in tips.rst and give an example of how this can be used in
conjunction with `test->priv` to pass around state and specifically
implement something like mocking.
There's a lot more we could go into on that topic, but given that
example is already longer than every other "tip" on this page, we just
point to the API docs and leave filling in the blanks as an exercise to
the reader.

Also give an example of kunit_fail_current_test().

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/tips.rst | 78 +++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kunit/tips.rst b/Documentation/dev-tools/kunit/tips.rst
index a6ca0af14098..8d8c238f7f79 100644
--- a/Documentation/dev-tools/kunit/tips.rst
+++ b/Documentation/dev-tools/kunit/tips.rst
@@ -78,8 +78,82 @@ Similarly to the above, it can be useful to add test-specific logic.
 	void test_only_hook(void) { }
 	#endif
 
-TODO(dlatypov@google.com): add an example of using ``current->kunit_test`` in
-such a hook when it's not only updated for ``CONFIG_KASAN=y``.
+This test-only code can be made more useful by accessing the current kunit
+test, see below.
+
+Accessing the current test
+--------------------------
+
+In some cases, you need to call test-only code from outside the test file, e.g.
+like in the example above or if you're providing a fake implementation of an
+ops struct.
+There is a ``kunit_test`` field in ``task_struct``, so you can access it via
+``current->kunit_test``.
+
+Here's a slightly in-depth example of how one could implement "mocking":
+
+.. code-block:: c
+
+	#include <linux/sched.h> /* for current */
+
+	struct test_data {
+		int foo_result;
+		int want_foo_called_with;
+	};
+
+	static int fake_foo(int arg)
+	{
+		struct kunit *test = current->kunit_test;
+		struct test_data *test_data = test->priv;
+
+		KUNIT_EXPECT_EQ(test, test_data->want_foo_called_with, arg);
+		return test_data->foo_result;
+	}
+
+	static void example_simple_test(struct kunit *test)
+	{
+		/* Assume priv is allocated in the suite's .init */
+		struct test_data *test_data = test->priv;
+
+		test_data->foo_result = 42;
+		test_data->want_foo_called_with = 1;
+
+		/* In a real test, we'd probably pass a pointer to fake_foo somewhere
+		 * like an ops struct, etc. instead of calling it directly. */
+		KUNIT_EXPECT_EQ(test, fake_foo(1), 42);
+	}
+
+
+Note: here we're able to get away with using ``test->priv``, but if you wanted
+something more flexible you could use a named ``kunit_resource``, see :doc:`api/test`.
+
+Failing the current test
+------------------------
+
+But sometimes, you might just want to fail the current test. In that case, we
+have ``kunit_fail_current_test(fmt, args...)`` which is defined in ``<kunit/test-bug.h>`` and
+doesn't require pulling in ``<kunit/test.h>``.
+
+E.g. say we had an option to enable some extra debug checks on some data structure:
+
+.. code-block:: c
+
+	#include <kunit/test-bug.h>
+
+	#ifdef CONFIG_EXTRA_DEBUG_CHECKS
+	static void validate_my_data(struct data *data)
+	{
+		if (is_valid(data))
+			return;
+
+		kunit_fail_current_test("data %p is invalid", data);
+
+		/* Normal, non-KUnit, error reporting code here. */
+	}
+	#else
+	static void my_debug_function(void) { }
+	#endif
+
 
 Customizing error messages
 --------------------------

base-commit: 0a50438c84363bd37fe18fe432888ae9a074dcab
-- 
2.31.0.208.g409f899ff0-goog

