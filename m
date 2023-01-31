Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279A66824D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 07:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjAaGsP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 01:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjAaGsN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 01:48:13 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3D43F293
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 22:47:36 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-50e79ffba49so103882847b3.9
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 22:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uyVDT9hNRxOyIsJIBjKV9Q9oIt4VPBRQYD4t43TiWdc=;
        b=tYXjU+Ya2DqfSC7Lkxmg+htkRCcX+8wR8Q/19YLsaelK8vXl6f875cfh430R19F/FC
         Fut0d+1SBLTIUyoB6sSrgmlpvs9CDXvb/smSrWcq44nZFTvb2R6i/6beOejYcuYkZH4p
         A+FSN8szb/+R21sypxqRO/qHN/fZRp+EGFi2CcGztbN2kpVmZWEqskjoP+XaLO3mQ33l
         JUlIoqBfLkQvYU1OPsQDAfN4hBw0i8N6sIu/hz0Z/hNZTW5+3ZJiaYu10E5DDu0XU/JO
         Vhsc/EKupKBE/lEPizDFqd0TZ+CvsispckvFfEZlFSeL4omnYAtWnEJKRV5RkYzSBWZ6
         e6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyVDT9hNRxOyIsJIBjKV9Q9oIt4VPBRQYD4t43TiWdc=;
        b=qDllwu4IloueMFbHlxvD/c2eAtmVfVfzalCqRH+7g3AXtnJhZOn2PLGkRX3mhPBuAk
         /LmiWoDgajEZ1xoSOIhAUwGNbDdeiGN5gdszh5m+/AM7kW4jvlrjTX/7vsd5ho+YBwEj
         sBC1JiitJUEPRDRZu1qCRGp5HZqbMoZXBdN35hh0ZtNcSExiIuClXSTmklfpk1eaPszq
         0S1+R49955JFu+nMS5J7Zt6sBTvY2dRx6Tp64sY5SO/rblEF2Z+E6GE9F2lXM+F+JfBf
         QldrgVYG4A+u3gmoGX+4Glnds97ix+BsEw1gST4QsEA2gz3WOmxv5eNli2KnLqw13IdP
         AeKw==
X-Gm-Message-State: AO0yUKWBZfTkpGMwtS5fUfmKy7vi+4diU4cbhVu6qp31v4HKO9MwSZRo
        6bpgGXoTKsjjqowHKisUYj4/QJSB0il7sA==
X-Google-Smtp-Source: AK7set+vJXe4+f8Sh+J/oa3KG4/osfk1EV+A6j04S0uXCps+/7JGg5Ed2Y/xgT8XRtyKMoTiywWFDiF2k2MBEA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1189:b0:80b:6760:dc8f with SMTP
 id m9-20020a056902118900b0080b6760dc8fmr875246ybu.108.1675147614014; Mon, 30
 Jan 2023 22:46:54 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:46:41 +0800
In-Reply-To: <20230131064641.1912756-1-davidgow@google.com>
Mime-Version: 1.0
References: <20230131064641.1912756-1-davidgow@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230131064641.1912756-2-davidgow@google.com>
Subject: [PATCH v3 2/2] Documentation: Add Function Redirection API docs
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Fradley <joefradley@google.com>,
        Steve Muckle <smuckle@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
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
Co-developed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---

Note that this document reworks some elements of the KUnit website's "mocking"
page at http://kunit.dev/mocking.html written by Daniel Latypov, and used with
his permission.

No changes since v2:
https://lore.kernel.org/linux-kselftest/20230128074918.1180523-2-davidgow@google.com/

Changes since v1:
https://lore.kernel.org/all/20221208061841.2186447-3-davidgow@google.com/
- Fix a bunch of typos (Thanks, Daniel)
- Remove a redundant comment (Thanks, Daniel)
- Reword a few things to be clearer, especially about global state.

---
 .../kunit/api/functionredirection.rst         | 162 ++++++++++++++++++
 Documentation/dev-tools/kunit/api/index.rst   |  13 +-
 2 files changed, 172 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/dev-tools/kunit/api/functionredirection.rst

diff --git a/Documentation/dev-tools/kunit/api/functionredirection.rst b/Documentation/dev-tools/kunit/api/functionredirection.rst
new file mode 100644
index 000000000000..3791efc2fcca
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
+While for some code (typically generic data structures, helpers, and other
+"pure functions") this is trivial, for others (like device drivers,
+filesystems, core subsystems) the code is heavily coupled with other parts of
+the kernel.
+
+This coupling is often due to global state in some way: be it a global list of
+devices, the filesystem, or some hardware state. Tests need to either carefully
+manage, isolate, and restore state, or they can avoid it altogether by
+replacing access to and mutation of this state with a "fake" or "mock" variant.
+
+By refactoring access to such state, such as by introducing a layer of
+indirection which can use or emulate a separate set of test state. However,
+such refactoring comes with its own costs (and undertaking significant
+refactoring before being able to write tests is suboptimal).
+
+A simpler way to intercept and replace some of the function calls is to use
+function redirection via static stubs.
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
+	kunit_activate_static_stub(test,
+				   send_data_to_hardware,
+				   fake_send_data_to_hardware);
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
+	send_data_to_hardware("Hello World!"); /* Succeeds */
+	send_data_to_hardware("Something else"); /* Fails the test. */
+
+5. (Optionally) disable the stub.
+
+   When you no longer need it, disable the redirection (and hence resume the
+   original behaviour of the 'real' function) using
+   kunit_deactivate_static_stub(). Otherwise, it will be automatically disabled
+   when the test exits.
+
+   For example:
+
+   .. code-block:: c
+
+	kunit_deactivate_static_stub(test, send_data_to_hardware);
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
2.39.1.456.gfc5497dd1b-goog

