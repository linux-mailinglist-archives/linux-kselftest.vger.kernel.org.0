Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35B9646906
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 07:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLHGTG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 01:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLHGS6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 01:18:58 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D5F9D2D7
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 22:18:57 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id j21-20020a63fc15000000b00476d6932baeso411878pgi.23
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Dec 2022 22:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dixzBTqR6W2lf2lGg4zzNK1qhk/3AaEd5DQKmAdu8So=;
        b=C6USAdKHXsrbV+nVcbBs84pLoSjrTraU/I0n0WC9VfqSIlRkdC2CCAiT4w/IvSzZ12
         FvyXEanNx0F/xfDh8006b7OModo1euXWJK+UHCOm4U7zAEuikAt3TGVhWUI0402ZkM5N
         Es54vXnc/dM/9Z1NKXJHkX+Aa8s7cmAosAyWr9BRGmq0eMpWxG52BX6AvdWPmXdcP9xw
         9KzrxIshlDiQKlQpzwKiKsW24QPN0ZHxlMv4b0uqbtdh+1mJDt4xwkuloD8GANrJ9mGh
         oqkHNYGCH0VuGnAjFvUoqFIUcrDNBt4y9EwepDWgtjHlVjLQq6j8I/ZIqaIP6tzU4c4f
         17CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dixzBTqR6W2lf2lGg4zzNK1qhk/3AaEd5DQKmAdu8So=;
        b=osk+/9ypJbybd6Nz04jcJTSLrVocruz5qlO7PHXvtGjr6z5TLVL5sFtszmfmPWZ3i4
         e1ds9Bd8o5gOegCKPBMwgVGc7mauXTwHf17JvoaFghh0YVZcsvI+JoftCFM6ZkhcZKgJ
         eE1JtI6SqGCYrDTX5Sqh+LHZeZA7PPInVsv+zLUfULyAREUkGzwFsVhSWZyR43KKRZua
         FmyDucyXOba0JMwYCj9iFaNafEIXlvkE4uwwHFyyhqeKApcWZ1X+ooY+HmXy3sQsuJCD
         0Mrc72KPIY7Q/JxguJQafd4SHavmMlK5kEQ6CdxQuULdNThkO6pGXqNcj3iqono9BRGQ
         XY0w==
X-Gm-Message-State: ANoB5pmCKncc+k4WgOkGR27G5UYZ5jshTsZl3DyEMVmOZwvQVDkfHx4H
        x0uU3q9bmbxvSWoaIJg2upgaaGX1tRctXA==
X-Google-Smtp-Source: AA0mqf59koQdDw+judIns5F4v45fcJArw3/Rsb1sWhGt0Zkjs3aCSaqicc3HkvJkZyIwaglYqWwEUreXAsUDQw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:5317:b0:213:34f7:fb14 with SMTP
 id x23-20020a17090a531700b0021334f7fb14mr104602681pjh.25.1670480336794; Wed,
 07 Dec 2022 22:18:56 -0800 (PST)
Date:   Thu,  8 Dec 2022 14:18:41 +0800
In-Reply-To: <20221208061841.2186447-1-davidgow@google.com>
Mime-Version: 1.0
References: <20221208061841.2186447-1-davidgow@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221208061841.2186447-3-davidgow@google.com>
Subject: [PATCH 2/2] Documentation: Add Function Redirection API docs
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Fradley <joefradley@google.com>,
        Steve Muckle <smuckle@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Sadiya Kazi <sadiyakazi@google.com>

Added a new page (functionredirection.rst) that describes the Function
Redirection (static stubbing) API. This page will be expanded if we add,
for example, ftrace-based stubbing.

In addition,
1. Updated the api/index.rst page to create an entry for function
   redirection api
2. Updated the toctree to be hidden, reducing redundancy on the
   generated page.

Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Note that this patch is new to v1 of the series, and wasn't included in
the previous RFCs.

---
 .../kunit/api/functionredirection.rst         | 162 ++++++++++++++++++
 Documentation/dev-tools/kunit/api/index.rst   |  13 +-
 2 files changed, 172 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/api/functionredirection.rst

diff --git a/Documentation/dev-tools/kunit/api/functionredirection.rst b/Documentation/dev-tools/kunit/api/functionredirection.rst
new file mode 100644
index 000000000000..fc7644dfea65
--- /dev/null
+++ b/Documentation/dev-tools/kunit/api/functionredirection.rst
@@ -0,0 +1,162 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Function Redirection API
+========================
+
+Overview
+========
+
+When writing unit tests, it's important to be able to isolate the code being
+tested from other parts of the kernel. This ensures the reliability of the test
+(it won't be affected by external factors), reduces dependencies on specific
+hardware or config options (making the test easier to run), and protects the
+stability of the rest of the system (making it less likely for test-specific
+state to interfere with the rest of the system).
+
+While for some code (typically generic data structures, helpers, and toher
+"pure function") this is trivial, for others (like device drivers, filesystems,
+core subsystems) the code is heavily coupled with other parts of the kernel.
+
+This often involves global state in some way: be it global lists of devices,
+the filesystem, or hardware state, this needs to be either carefully managed,
+isolated, and restored, or avoided altogether by replacing access to and
+mutation of this state with a "fake" or "mock" variant.
+
+This can be done by refactoring the code to abstract out access to such state,
+by introducing a layer of indirection which can use or emulate a separate set of
+test state. However, such refactoring comes with its own costs (and undertaking
+significant refactoring before being able to write tests is suboptimal).
+
+A simpler way to intercept some of the function calls is to use function
+redirection via static stubs.
+
+
+Static Stubs
+============
+
+Static stubs are a way of redirecting calls to one function (the "real"
+function) to another function (the "replacement" function).
+
+It works by adding a macro to the "real" function which checks to see if a test
+is running, and if a replacement function is available. If so, that function is
+called in place of the original.
+
+Using static stubs is pretty straightforward:
+
+1. Add the KUNIT_STATIC_STUB_REDIRECT() macro to the start of the "real"
+   function.
+
+   This should be the first statement in the function, after any variable
+   declarations. KUNIT_STATIC_STUB_REDIRECT() takes the name of the
+   function, followed by all of the arguments passed to the real function.
+
+   For example:
+
+   .. code-block:: c
+
+	void send_data_to_hardware(const char *str)
+	{
+		KUNIT_STATIC_STUB_REDIRECT(send_data_to_hardware, str);
+		/* real implementation */
+	}
+
+2. Write one or more replacement functions.
+
+   These functions should have the same function signature as the real function.
+   In the event they need to access or modify test-specific state, they can use
+   kunit_get_current_test() to get a struct kunit pointer. This can then
+   be passed to the expectation/assertion macros, or used to look up KUnit
+   resources.
+
+   For example:
+
+   .. code-block:: c
+
+	void fake_send_data_to_hardware(const char *str)
+	{
+		struct kunit *test = kunit_get_current_test();
+		KUNIT_EXPECT_STREQ(test, str, "Hello World!");
+	}
+
+3. Activate the static stub from your test.
+
+   From within a test, the redirection can be enabled with
+   kunit_activate_static_stub(), which accepts a struct kunit pointer,
+   the real function, and the replacement function. You can call this several
+   times with different replacement functions to swap out implementations of the
+   function.
+
+   In our example, this would be
+
+   .. code-block:: c
+
+        kunit_activate_static_stub(test,
+                                   send_data_to_hardware,
+                                   fake_send_data_to_hardware);
+
+4. Call (perhaps indirectly) the real function.
+
+   Once the redirection is activated, any call to the real function will call
+   the replacement function instead. Such calls may be buried deep in the
+   implementation of another function, but must occur from the test's kthread.
+
+   For example:
+
+   .. code-block:: c
+
+        send_data_to_hardware("Hello World!"); /* Succeeds */
+        send_data_to_hardware("Something else"); /* Fails the test. */
+
+5. (Optionally) disable the stub.
+
+   When you no longer need it, the redirection can be disabled (and hence the
+   original behaviour of the 'real' function resumed) using
+   kunit_deactivate_static_stub(). If the stub is not manually deactivated, it
+   will nevertheless be disabled when the test finishes.
+
+   For example:
+
+   .. code-block:: c
+
+        kunit_deactivate_static_stub(test, send_data_to_hardware);
+
+
+It's also possible to use these replacement functions to test to see if a
+function is called at all, for example:
+
+.. code-block:: c
+
+	void send_data_to_hardware(const char *str)
+	{
+		KUNIT_STATIC_STUB_REDIRECT(send_data_to_hardware, str);
+		/* real implementation */
+	}
+
+	/* In test file */
+	int times_called = 0;
+	void fake_send_data_to_hardware(const char *str)
+	{
+		/* fake implementation */
+		times_called++;
+	}
+	...
+	/* In the test case, redirect calls for the duration of the test */
+	kunit_activate_static_stub(test, send_data_to_hardware, fake_send_data_to_hardware);
+
+	send_data_to_hardware("hello");
+	KUNIT_EXPECT_EQ(test, times_called, 1);
+
+	/* Can also deactivate the stub early, if wanted */
+	kunit_deactivate_static_stub(test, send_data_to_hardware);
+
+	send_data_to_hardware("hello again");
+	KUNIT_EXPECT_EQ(test, times_called, 1);
+
+
+
+API Reference
+=============
+
+.. kernel-doc:: include/kunit/static_stub.h
+   :internal:
diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
index 45ce04823f9f..2d8f756aab56 100644
--- a/Documentation/dev-tools/kunit/api/index.rst
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -4,17 +4,24 @@
 API Reference
 =============
 .. toctree::
+	:hidden:
 
 	test
 	resource
+	functionredirection
 
-This section documents the KUnit kernel testing API. It is divided into the
+
+This page documents the KUnit kernel testing API. It is divided into the
 following sections:
 
 Documentation/dev-tools/kunit/api/test.rst
 
- - documents all of the standard testing API
+ - Documents all of the standard testing API
 
 Documentation/dev-tools/kunit/api/resource.rst
 
- - documents the KUnit resource API
+ - Documents the KUnit resource API
+
+Documentation/dev-tools/kunit/api/functionredirection.rst
+
+ - Documents the KUnit Function Redirection API
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

