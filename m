Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE4636CFD9
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 02:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbhD1AE2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Apr 2021 20:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbhD1AE2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Apr 2021 20:04:28 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED93C06175F
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Apr 2021 17:03:44 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b9so9338326iod.13
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Apr 2021 17:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=LomaoYdA4JHcXsWQE0atIks16rHPFFmkF24sVcit1hQ=;
        b=XM+OC9nNCnHNiC/TxXhFky41nIPMnoF3KvgRqATwSvaBcqmHqJT5Ia3g9v252eB5mg
         ynOubOpglWdhknKk0Ajq50b9bTLFVUZq1vizh80+6uSV8qtsIpM5E3sx81PlZXPA9YXt
         I8SluWYIs3DclFS5ksntEwz4GCKPsKwZHr/JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=LomaoYdA4JHcXsWQE0atIks16rHPFFmkF24sVcit1hQ=;
        b=peuzIDwmuvAysThzMgU506aSqwg5wciFOwnkONCcZSQJfE+b/MgSvLuz/8nybVEZEO
         5f5GsiuCjOE/COymtMCyv81bfPVFQ6ah3ZGb5LfcoSSWl5F/lx79ekvhyaFkZCCa1V6B
         nySi9eG1deRRevm1MXdmRG3AfiKuECdukQ38c4DZOPQnPoNR3PX+BwcIZVD3ssD/6tDq
         WbpH7eXKbYXub+/N2IgUWWy6tzbnxehFXa91XHaw5oD0xxNfyCxN2kV7yix0FDyx0/Cf
         p+G8FuBwXm4seC6a/CAtJTyFlPo/5Oi8iS2IlH5r8WxwZYoRPyjNPWOOekq3ewJnFZkg
         C1YA==
X-Gm-Message-State: AOAM5313mXI4stkkJwP6MVqAdiyhPqdMRYh9Z+9MtO4fuxxlFYqTxVwy
        0OccFMs9qe+tDpqitsdZf5HUcp8mHH3odg==
X-Google-Smtp-Source: ABdhPJxOFa4BJCU2h82YonBLadyDoBzES0O9r4re3a50gX/nDQSJ0BE/mwHM0x6pOhMRboK+vL4N2Q==
X-Received: by 2002:a05:6602:168d:: with SMTP id s13mr10085315iow.82.1619568223693;
        Tue, 27 Apr 2021 17:03:43 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v8sm2071270ilq.0.2021.04.27.17.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 17:03:43 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit update for Linux 5.13-rc1
Message-ID: <2ea97361-c509-d40e-5caf-ee17a4b41a77@linuxfoundation.org>
Date:   Tue, 27 Apr 2021 18:03:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------CE03919B804819922C3884E9"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------CE03919B804819922C3884E9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit update for Linux 5.13-rc1.

This KUnit update for Linux 5.13-rc1 consists of several fixes and
new feature to support failure from dynamic analysis tools such as
UBSAN and fake ops for testing.

- a fake ops struct for testing a "free" function to complain if it
   was called with an invalid argument, or caught a double-free. Most
   return void and have no normal means of signalling failure
   (e.g. super_operations, iommu_ops, etc.).

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-5.13-rc1

for you to fetch changes up to de2fcb3e62013738f22bbb42cbd757d9a242574e:

   Documentation: kunit: add tips for using current->kunit_test 
(2021-04-07 16:40:37 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-5.13-rc1

This KUnit update for Linux 5.13-rc1 consists of several fixes and
new feature to support failure from dynamic analysis tools such as
UBSAN and fake ops for testing.

- a fake ops struct for testing a "free" function to complain if it
   was called with an invalid argument, or caught a double-free. Most
   return void and have no normal means of signalling failure
   (e.g. super_operations, iommu_ops, etc.).

----------------------------------------------------------------
Daniel Latypov (4):
       kunit: make KUNIT_EXPECT_STREQ() quote values, don't print literals
       kunit: tool: make --kunitconfig accept dirs, add lib/kunit fragment
       kunit: fix -Wunused-function warning for __kunit_fail_current_test
       Documentation: kunit: add tips for using current->kunit_test

Lucas Stankus (1):
       kunit: Match parenthesis alignment to improve code readability

Uriel Guajardo (1):
       kunit: support failure from dynamic analysis tools

  Documentation/dev-tools/kunit/tips.rst | 78 
+++++++++++++++++++++++++++++++++-
  include/kunit/test-bug.h               | 29 +++++++++++++
  lib/kunit/.kunitconfig                 |  3 ++
  lib/kunit/assert.c                     | 61 ++++++++++++++++++--------
  lib/kunit/test.c                       | 39 +++++++++++++++--
  tools/testing/kunit/kunit.py           |  4 +-
  tools/testing/kunit/kunit_kernel.py    |  2 +
  tools/testing/kunit/kunit_tool_test.py |  6 +++
  8 files changed, 198 insertions(+), 24 deletions(-)
  create mode 100644 include/kunit/test-bug.h
  create mode 100644 lib/kunit/.kunitconfig
----------------------------------------------------------------

--------------CE03919B804819922C3884E9
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.13-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.13-rc1.diff"

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
diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
new file mode 100644
index 000000000000..5fc58081d511
--- /dev/null
+++ b/include/kunit/test-bug.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit API allowing dynamic analysis tools to interact with KUnit tests
+ *
+ * Copyright (C) 2020, Google LLC.
+ * Author: Uriel Guajardo <urielguajardo@google.com>
+ */
+
+#ifndef _KUNIT_TEST_BUG_H
+#define _KUNIT_TEST_BUG_H
+
+#define kunit_fail_current_test(fmt, ...) \
+	__kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
+
+#if IS_BUILTIN(CONFIG_KUNIT)
+
+extern __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
+						    const char *fmt, ...);
+
+#else
+
+static inline __printf(3, 4) void __kunit_fail_current_test(const char *file, int line,
+							    const char *fmt, ...)
+{
+}
+
+#endif
+
+#endif /* _KUNIT_TEST_BUG_H */
diff --git a/lib/kunit/.kunitconfig b/lib/kunit/.kunitconfig
new file mode 100644
index 000000000000..9235b7d42d38
--- /dev/null
+++ b/lib/kunit/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_KUNIT_TEST=y
+CONFIG_KUNIT_EXAMPLE_TEST=y
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index e0ec7d6fed6f..b972bda61c0c 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -25,7 +25,7 @@ void kunit_base_assert_format(const struct kunit_assert *assert,
 	}
 
 	string_stream_add(stream, "%s FAILED at %s:%d\n",
-			 expect_or_assert, assert->file, assert->line);
+			  expect_or_assert, assert->file, assert->line);
 }
 EXPORT_SYMBOL_GPL(kunit_base_assert_format);
 
@@ -48,8 +48,9 @@ EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
 void kunit_unary_assert_format(const struct kunit_assert *assert,
 			       struct string_stream *stream)
 {
-	struct kunit_unary_assert *unary_assert = container_of(
-			assert, struct kunit_unary_assert, assert);
+	struct kunit_unary_assert *unary_assert;
+
+	unary_assert = container_of(assert, struct kunit_unary_assert, assert);
 
 	kunit_base_assert_format(assert, stream);
 	if (unary_assert->expected_true)
@@ -67,8 +68,10 @@ EXPORT_SYMBOL_GPL(kunit_unary_assert_format);
 void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 				     struct string_stream *stream)
 {
-	struct kunit_ptr_not_err_assert *ptr_assert = container_of(
-			assert, struct kunit_ptr_not_err_assert, assert);
+	struct kunit_ptr_not_err_assert *ptr_assert;
+
+	ptr_assert = container_of(assert, struct kunit_ptr_not_err_assert,
+				  assert);
 
 	kunit_base_assert_format(assert, stream);
 	if (!ptr_assert->value) {
@@ -111,8 +114,10 @@ static bool is_literal(struct kunit *test, const char *text, long long value,
 void kunit_binary_assert_format(const struct kunit_assert *assert,
 				struct string_stream *stream)
 {
-	struct kunit_binary_assert *binary_assert = container_of(
-			assert, struct kunit_binary_assert, assert);
+	struct kunit_binary_assert *binary_assert;
+
+	binary_assert = container_of(assert, struct kunit_binary_assert,
+				     assert);
 
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
@@ -137,8 +142,10 @@ EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
 void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 				    struct string_stream *stream)
 {
-	struct kunit_binary_ptr_assert *binary_assert = container_of(
-			assert, struct kunit_binary_ptr_assert, assert);
+	struct kunit_binary_ptr_assert *binary_assert;
+
+	binary_assert = container_of(assert, struct kunit_binary_ptr_assert,
+				     assert);
 
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
@@ -156,11 +163,29 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
 }
 EXPORT_SYMBOL_GPL(kunit_binary_ptr_assert_format);
 
+/* Checks if KUNIT_EXPECT_STREQ() args were string literals.
+ * Note: `text` will have ""s where as `value` will not.
+ */
+static bool is_str_literal(const char *text, const char *value)
+{
+	int len;
+
+	len = strlen(text);
+	if (len < 2)
+		return false;
+	if (text[0] != '\"' || text[len - 1] != '\"')
+		return false;
+
+	return strncmp(text + 1, value, len - 2) == 0;
+}
+
 void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    struct string_stream *stream)
 {
-	struct kunit_binary_str_assert *binary_assert = container_of(
-			assert, struct kunit_binary_str_assert, assert);
+	struct kunit_binary_str_assert *binary_assert;
+
+	binary_assert = container_of(assert, struct kunit_binary_str_assert,
+				     assert);
 
 	kunit_base_assert_format(assert, stream);
 	string_stream_add(stream,
@@ -168,12 +193,14 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 			  binary_assert->left_text,
 			  binary_assert->operation,
 			  binary_assert->right_text);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %s\n",
-			  binary_assert->left_text,
-			  binary_assert->left_value);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %s",
-			  binary_assert->right_text,
-			  binary_assert->right_value);
+	if (!is_str_literal(binary_assert->left_text, binary_assert->left_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"\n",
+				  binary_assert->left_text,
+				  binary_assert->left_value);
+	if (!is_str_literal(binary_assert->right_text, binary_assert->right_value))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == \"%s\"",
+				  binary_assert->right_text,
+				  binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_str_assert_format);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index ec9494e914ef..2f6cc0123232 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/sched/debug.h>
@@ -16,6 +17,40 @@
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
+#if IS_BUILTIN(CONFIG_KUNIT)
+/*
+ * Fail the current test and print an error message to the log.
+ */
+void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
+{
+	va_list args;
+	int len;
+	char *buffer;
+
+	if (!current->kunit_test)
+		return;
+
+	kunit_set_failure(current->kunit_test);
+
+	/* kunit_err() only accepts literals, so evaluate the args first. */
+	va_start(args, fmt);
+	len = vsnprintf(NULL, 0, fmt, args) + 1;
+	va_end(args);
+
+	buffer = kunit_kmalloc(current->kunit_test, len, GFP_KERNEL);
+	if (!buffer)
+		return;
+
+	va_start(args, fmt);
+	vsnprintf(buffer, len, fmt, args);
+	va_end(args);
+
+	kunit_err(current->kunit_test, "%s:%d: %s", file, line, buffer);
+	kunit_kfree(current->kunit_test, buffer);
+}
+EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
+#endif
+
 /*
  * Append formatted message to log, size of which is limited to
  * KUNIT_LOG_SIZE bytes (including null terminating byte).
@@ -273,9 +308,7 @@ static void kunit_try_run_case(void *data)
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
 
-#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
 	current->kunit_test = test;
-#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
 
 	/*
 	 * kunit_run_case_internal may encounter a fatal error; if it does,
@@ -624,9 +657,7 @@ void kunit_cleanup(struct kunit *test)
 		spin_unlock(&test->lock);
 		kunit_remove_resource(test, res);
 	}
-#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
 	current->kunit_test = NULL;
-#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
 }
 EXPORT_SYMBOL_GPL(kunit_cleanup);
 
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index d5144fcb03ac..5da8fb3762f9 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -184,7 +184,9 @@ def add_common_opts(parser) -> None:
 			    help='Run all KUnit tests through allyesconfig',
 			    action='store_true')
 	parser.add_argument('--kunitconfig',
-			     help='Path to Kconfig fragment that enables KUnit tests',
+			     help='Path to Kconfig fragment that enables KUnit tests.'
+			     ' If given a directory, (e.g. lib/kunit), "/.kunitconfig" '
+			     'will get  automatically appended.',
 			     metavar='kunitconfig')
 
 def add_build_opts(parser) -> None:
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index f309a33256cd..89a7d4024e87 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -132,6 +132,8 @@ class LinuxSourceTree(object):
 			return
 
 		if kunitconfig_path:
+			if os.path.isdir(kunitconfig_path):
+				kunitconfig_path = os.path.join(kunitconfig_path, KUNITCONFIG_PATH)
 			if not os.path.exists(kunitconfig_path):
 				raise ConfigError(f'Specified kunitconfig ({kunitconfig_path}) does not exist')
 		else:
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 1ad3049e9069..2e809dd956a7 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -251,6 +251,12 @@ class LinuxSourceTreeTest(unittest.TestCase):
 		with tempfile.NamedTemporaryFile('wt') as kunitconfig:
 			tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=kunitconfig.name)
 
+	def test_dir_kunitconfig(self):
+		with tempfile.TemporaryDirectory('') as dir:
+			with open(os.path.join(dir, '.kunitconfig'), 'w') as f:
+				pass
+			tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
+
 	# TODO: add more test cases.
 
 

--------------CE03919B804819922C3884E9--
