Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33DA31E369
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Feb 2021 01:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhBRALi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Feb 2021 19:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBRALf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Feb 2021 19:11:35 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F253FC061756
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Feb 2021 16:10:53 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id n14so247356iog.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Feb 2021 16:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=1aYNhtm3FjfPwminuiyiusPJX76aQVdl3aHteWWTwfg=;
        b=U8mQkaAn/U5FFRKcjVp2EJGP0UNvzqbvOzPk5raEyQI8lRAOz1zYopPA+Pfjg+E+ST
         j5HiyPrGH2gBZTKei2WVQtD9dVUf9O5FH/YzvSlqL+aJnAEBOe/dEOZUg22+sdAhy6sR
         B2WUEa2UU1zzAnCgxJfaocafXWcjrpKsNbIQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=1aYNhtm3FjfPwminuiyiusPJX76aQVdl3aHteWWTwfg=;
        b=pktPA4yKO3Md39PmjM+H/+sdQXT95g+YDs9sdfYhtLVVblovlOo7Y5XliX6buFQUI5
         0qS5Raeg+Meiimm16d7OEp40nwtSJelRQBi/OcvfrSdiVIrW+Kmt3yoywBXifi91muFr
         BCrudrpXwhXlW0pjen2M6RYI0O4+pDy5tkpgpYSaT1NS+TA5FU5oN6TIJ0TzqWwMrryf
         NcfL1goPV18d/QV1pIqqlz7mqvXDIcBjEYH04qm2JvmmSAPx2Exz5TYV1CnN+mnKGmw/
         xOmF0iKFF/0G2s/P7YJSnwiqJOeh4Snn7kTeEgTvRfoiQHEuzJLjrCTnSxy6RJQMFQj5
         i7+w==
X-Gm-Message-State: AOAM5339HPLrTj1LbK6RVgx7txMAmd979wcgapzgN/4oxJ4WBOOXKuCa
        DOtE7XO++a3F5HhdE80Z3df4LP+YHFoqyQ==
X-Google-Smtp-Source: ABdhPJyM2qkGkydoL548/5QU/zXqUMWo21dc+4OFGuqlHsFRGo7Xe48QRAMNJME5lHDCX5dsbmBB9g==
X-Received: by 2002:a5d:9ec7:: with SMTP id a7mr1323395ioe.126.1613607053186;
        Wed, 17 Feb 2021 16:10:53 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t2sm2935536iob.6.2021.02.17.16.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 16:10:52 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit update for Linux 5.12-rc1
Message-ID: <482cb3f4-2ede-0369-922b-dd326b100873@linuxfoundation.org>
Date:   Wed, 17 Feb 2021 17:10:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------B7958C190DEDF87EF6A89C58"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------B7958C190DEDF87EF6A89C58
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit update for Linux 5.12-rc1.

This KUnit update for Linux 5.12-rc1 consists of consists of:

-- support for filtering test suites using glob from Daniel Latypov.

    "kunit_filter.glob" command line option is passed to the UML
    kernel, which currently only supports filtering by suite name.
    This support allows running different subsets of tests, e.g.

    $ ./tools/testing/kunit/kunit.py build
    $ ./tools/testing/kunit/kunit.py exec 'list*'
    $ ./tools/testing/kunit/kunit.py exec 'kunit*'

-- several fixes and cleanups also from Daniel Latypov.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

   Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-5.12-rc1

for you to fetch changes up to 7af29141a31a2a2350589471c8979ff5f22fb9b7:

   kunit: tool: fix unintentional statefulness in run_kernel() 
(2021-02-08 16:10:22 -0700)

----------------------------------------------------------------
linux-kselftest-kunit-5.12-rc1

This KUnit update for Linux 5.12-rc1 consists of consists of:

-- support for filtering test suites using glob from Daniel Latypov.

    "kunit_filter.glob" command line option is passed to the UML
    kernel, which currently only supports filtering by suite name.
    This support allows running different subsets of tests, e.g.

    $ ./tools/testing/kunit/kunit.py build
    $ ./tools/testing/kunit/kunit.py exec 'list*'
    $ ./tools/testing/kunit/kunit.py exec 'kunit*'

-- several fixes and cleanups also from Daniel Latypov.

----------------------------------------------------------------
Daniel Latypov (12):
       kunit: tool: fix unit test cleanup handling
       kunit: tool: stop using bare asserts in unit test
       kunit: tool: use `with open()` in unit test
       minor: kunit: tool: fix unit test so it can run from non-root dir
       kunit: tool: simplify kconfig is_subset_of() logic
       KUnit: Docs: make start.rst example Kconfig follow style.rst
       Documentation: kunit: add tips.rst for small examples
       kunit: make kunit_tool accept optional path to .kunitconfig fragment
       kunit: don't show `1 == 1` in failed assertion messages
       kunit: add kunit.filter_glob cmdline option to filter suites
       kunit: tool: add support for filtering suites by glob
       kunit: tool: fix unintentional statefulness in run_kernel()

  Documentation/dev-tools/kunit/index.rst |   2 +
  Documentation/dev-tools/kunit/start.rst |   7 +-
  Documentation/dev-tools/kunit/tips.rst  | 115 ++++++++++++++++++
  lib/kunit/Kconfig                       |   1 +
  lib/kunit/assert.c                      |  39 +++++-
  lib/kunit/executor.c                    |  93 +++++++++++++--
  tools/testing/kunit/kunit.py            |  30 +++--
  tools/testing/kunit/kunit_config.py     |  13 +-
  tools/testing/kunit/kunit_kernel.py     |  18 ++-
  tools/testing/kunit/kunit_tool_test.py  | 204 
+++++++++++++++++---------------
  10 files changed, 390 insertions(+), 132 deletions(-)
  create mode 100644 Documentation/dev-tools/kunit/tips.rst

----------------------------------------------------------------

--------------B7958C190DEDF87EF6A89C58
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.12-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.12-rc1.diff"

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
index 454f307813ea..0e65cabe08eb 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -196,8 +196,9 @@ Now add the following to ``drivers/misc/Kconfig``:
 .. code-block:: kconfig
 
 	config MISC_EXAMPLE_TEST
-		bool "Test for my example"
+		tristate "Test for my example" if !KUNIT_ALL_TESTS
 		depends on MISC_EXAMPLE && KUNIT=y
+		default KUNIT_ALL_TESTS
 
 and the following to ``drivers/misc/Makefile``:
 
@@ -233,5 +234,7 @@ Congrats! You just wrote your first KUnit test!
 
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
diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 00909e6a2443..0b5dfb001bac 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -4,6 +4,7 @@
 
 menuconfig KUNIT
 	tristate "KUnit - Enable support for unit tests"
+	select GLOB if KUNIT=y
 	help
 	  Enables support for kernel unit tests (KUnit), a lightweight unit
 	  testing and mocking framework for the Linux kernel. These tests are
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 33acdaa28a7d..e0ec7d6fed6f 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -85,6 +85,29 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 }
 EXPORT_SYMBOL_GPL(kunit_ptr_not_err_assert_format);
 
+/* Checks if `text` is a literal representing `value`, e.g. "5" and 5 */
+static bool is_literal(struct kunit *test, const char *text, long long value,
+		       gfp_t gfp)
+{
+	char *buffer;
+	int len;
+	bool ret;
+
+	len = snprintf(NULL, 0, "%lld", value);
+	if (strlen(text) != len)
+		return false;
+
+	buffer = kunit_kmalloc(test, len+1, gfp);
+	if (!buffer)
+		return false;
+
+	snprintf(buffer, len+1, "%lld", value);
+	ret = strncmp(buffer, text, len) == 0;
+
+	kunit_kfree(test, buffer);
+	return ret;
+}
+
 void kunit_binary_assert_format(const struct kunit_assert *assert,
 				struct string_stream *stream)
 {
@@ -97,12 +120,16 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
 			  binary_assert->left_text,
 			  binary_assert->operation,
 			  binary_assert->right_text);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
-			  binary_assert->left_text,
-			  binary_assert->left_value);
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
-			  binary_assert->right_text,
-			  binary_assert->right_value);
+	if (!is_literal(stream->test, binary_assert->left_text,
+			binary_assert->left_value, stream->gfp))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
+				  binary_assert->left_text,
+				  binary_assert->left_value);
+	if (!is_literal(stream->test, binary_assert->right_text,
+			binary_assert->right_value, stream->gfp))
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
+				  binary_assert->right_text,
+				  binary_assert->right_value);
 	kunit_assert_print_msg(assert, stream);
 }
 EXPORT_SYMBOL_GPL(kunit_binary_assert_format);
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index a95742a4ece7..15832ed44668 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <kunit/test.h>
+#include <linux/glob.h>
+#include <linux/moduleparam.h>
 
 /*
  * These symbols point to the .kunit_test_suites section and are defined in
@@ -11,14 +13,81 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
-static void kunit_print_tap_header(void)
+static char *filter_glob;
+module_param(filter_glob, charp, 0);
+MODULE_PARM_DESC(filter_glob,
+		"Filter which KUnit test suites run at boot-time, e.g. list*");
+
+static struct kunit_suite * const *
+kunit_filter_subsuite(struct kunit_suite * const * const subsuite)
+{
+	int i, n = 0;
+	struct kunit_suite **filtered;
+
+	n = 0;
+	for (i = 0; subsuite[i] != NULL; ++i) {
+		if (glob_match(filter_glob, subsuite[i]->name))
+			++n;
+	}
+
+	if (n == 0)
+		return NULL;
+
+	filtered = kmalloc_array(n + 1, sizeof(*filtered), GFP_KERNEL);
+	if (!filtered)
+		return NULL;
+
+	n = 0;
+	for (i = 0; subsuite[i] != NULL; ++i) {
+		if (glob_match(filter_glob, subsuite[i]->name))
+			filtered[n++] = subsuite[i];
+	}
+	filtered[n] = NULL;
+
+	return filtered;
+}
+
+struct suite_set {
+	struct kunit_suite * const * const *start;
+	struct kunit_suite * const * const *end;
+};
+
+static struct suite_set kunit_filter_suites(void)
+{
+	int i;
+	struct kunit_suite * const **copy, * const *filtered_subsuite;
+	struct suite_set filtered;
+
+	const size_t max = __kunit_suites_end - __kunit_suites_start;
+
+	if (!filter_glob) {
+		filtered.start = __kunit_suites_start;
+		filtered.end = __kunit_suites_end;
+		return filtered;
+	}
+
+	copy = kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
+	filtered.start = copy;
+	if (!copy) { /* won't be able to run anything, return an empty set */
+		filtered.end = copy;
+		return filtered;
+	}
+
+	for (i = 0; i < max; ++i) {
+		filtered_subsuite = kunit_filter_subsuite(__kunit_suites_start[i]);
+		if (filtered_subsuite)
+			*copy++ = filtered_subsuite;
+	}
+	filtered.end = copy;
+	return filtered;
+}
+
+static void kunit_print_tap_header(struct suite_set *suite_set)
 {
 	struct kunit_suite * const * const *suites, * const *subsuite;
 	int num_of_suites = 0;
 
-	for (suites = __kunit_suites_start;
-	     suites < __kunit_suites_end;
-	     suites++)
+	for (suites = suite_set->start; suites < suite_set->end; suites++)
 		for (subsuite = *suites; *subsuite != NULL; subsuite++)
 			num_of_suites++;
 
@@ -30,12 +99,18 @@ int kunit_run_all_tests(void)
 {
 	struct kunit_suite * const * const *suites;
 
-	kunit_print_tap_header();
+	struct suite_set suite_set = kunit_filter_suites();
+
+	kunit_print_tap_header(&suite_set);
+
+	for (suites = suite_set.start; suites < suite_set.end; suites++)
+		__kunit_test_suites_init(*suites);
 
-	for (suites = __kunit_suites_start;
-	     suites < __kunit_suites_end;
-	     suites++)
-			__kunit_test_suites_init(*suites);
+	if (filter_glob) { /* a copy was made of each array */
+		for (suites = suite_set.start; suites < suite_set.end; suites++)
+			kfree(*suites);
+		kfree(suite_set.start);
+	}
 
 	return 0;
 }
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e808a47c839b..d5144fcb03ac 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -28,12 +28,12 @@ KunitBuildRequest = namedtuple('KunitBuildRequest',
 			       ['jobs', 'build_dir', 'alltests',
 				'make_options'])
 KunitExecRequest = namedtuple('KunitExecRequest',
-			      ['timeout', 'build_dir', 'alltests'])
+			      ['timeout', 'build_dir', 'alltests', 'filter_glob'])
 KunitParseRequest = namedtuple('KunitParseRequest',
 			       ['raw_output', 'input_data', 'build_dir', 'json'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
-					   'build_dir', 'alltests', 'json',
-					   'make_options'])
+					   'build_dir', 'alltests', 'filter_glob',
+					   'json', 'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -93,6 +93,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree,
 	test_start = time.time()
 	result = linux.run_kernel(
 		timeout=None if request.alltests else request.timeout,
+                filter_glob=request.filter_glob,
 		build_dir=request.build_dir)
 
 	test_end = time.time()
@@ -149,7 +150,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 		return build_result
 
 	exec_request = KunitExecRequest(request.timeout, request.build_dir,
-					request.alltests)
+					request.alltests, request.filter_glob)
 	exec_result = exec_tests(linux, exec_request)
 	if exec_result.status != KunitStatus.SUCCESS:
 		return exec_result
@@ -182,6 +183,9 @@ def add_common_opts(parser) -> None:
 	parser.add_argument('--alltests',
 			    help='Run all KUnit tests through allyesconfig',
 			    action='store_true')
+	parser.add_argument('--kunitconfig',
+			     help='Path to Kconfig fragment that enables KUnit tests',
+			     metavar='kunitconfig')
 
 def add_build_opts(parser) -> None:
 	parser.add_argument('--jobs',
@@ -197,6 +201,14 @@ def add_exec_opts(parser) -> None:
 			    type=int,
 			    default=300,
 			    metavar='timeout')
+	parser.add_argument('filter_glob',
+			    help='maximum number of seconds to allow for all tests '
+			    'to run. This does not include time taken to build the '
+			    'tests.',
+			    type=str,
+			    nargs='?',
+			    default='',
+			    metavar='filter_glob')
 
 def add_parse_opts(parser) -> None:
 	parser.add_argument('--raw_output', help='don\'t format output from kernel',
@@ -256,13 +268,14 @@ def main(argv, linux=None):
 			os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
 
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
 				       cli_args.jobs,
 				       cli_args.build_dir,
 				       cli_args.alltests,
+				       cli_args.filter_glob,
 				       cli_args.json,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
@@ -274,7 +287,7 @@ def main(argv, linux=None):
 			os.mkdir(cli_args.build_dir)
 
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
 
 		request = KunitConfigRequest(cli_args.build_dir,
 					     cli_args.make_options)
@@ -286,7 +299,7 @@ def main(argv, linux=None):
 			sys.exit(1)
 	elif cli_args.subcommand == 'build':
 		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir)
+			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir, kunitconfig_path=cli_args.kunitconfig)
 
 		request = KunitBuildRequest(cli_args.jobs,
 					    cli_args.build_dir,
@@ -304,7 +317,8 @@ def main(argv, linux=None):
 
 		exec_request = KunitExecRequest(cli_args.timeout,
 						cli_args.build_dir,
-						cli_args.alltests)
+						cli_args.alltests,
+						cli_args.filter_glob)
 		exec_result = exec_tests(linux, exec_request)
 		parse_request = KunitParseRequest(cli_args.raw_output,
 						  exec_result.result,
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index bdd60230764b..0b550cbd667d 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -41,15 +41,14 @@ class Kconfig(object):
 		self._entries.append(entry)
 
 	def is_subset_of(self, other: 'Kconfig') -> bool:
+		other_dict = {e.name: e.value for e in other.entries()}
 		for a in self.entries():
-			found = False
-			for b in other.entries():
-				if a.name != b.name:
+			b = other_dict.get(a.name)
+			if b is None:
+				if a.value == 'n':
 					continue
-				if a.value != b.value:
-					return False
-				found = True
-			if a.value != 'n' and found == False:
+				return False
+			elif a.value != b:
 				return False
 		return True
 
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 2076a5a2d060..f309a33256cd 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -123,7 +123,7 @@ def get_outfile_path(build_dir) -> str:
 class LinuxSourceTree(object):
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
-	def __init__(self, build_dir: str, load_config=True, defconfig=DEFAULT_KUNITCONFIG_PATH) -> None:
+	def __init__(self, build_dir: str, load_config=True, kunitconfig_path='') -> None:
 		signal.signal(signal.SIGINT, self.signal_handler)
 
 		self._ops = LinuxSourceTreeOperations()
@@ -131,9 +131,13 @@ class LinuxSourceTree(object):
 		if not load_config:
 			return
 
-		kunitconfig_path = get_kunitconfig_path(build_dir)
-		if not os.path.exists(kunitconfig_path):
-			shutil.copyfile(defconfig, kunitconfig_path)
+		if kunitconfig_path:
+			if not os.path.exists(kunitconfig_path):
+				raise ConfigError(f'Specified kunitconfig ({kunitconfig_path}) does not exist')
+		else:
+			kunitconfig_path = get_kunitconfig_path(build_dir)
+			if not os.path.exists(kunitconfig_path):
+				shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, kunitconfig_path)
 
 		self._kconfig = kunit_config.Kconfig()
 		self._kconfig.read_from_file(kunitconfig_path)
@@ -199,8 +203,12 @@ class LinuxSourceTree(object):
 			return False
 		return self.validate_config(build_dir)
 
-	def run_kernel(self, args=[], build_dir='', timeout=None) -> Iterator[str]:
+	def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
+		if not args:
+			args = []
 		args.extend(['mem=1G', 'console=tty'])
+		if filter_glob:
+			args.append('kunit.filter_glob='+filter_glob)
 		self._ops.linux_bin(args, timeout, build_dir)
 		outfile = get_outfile_path(build_dir)
 		subprocess.call(['stty', 'sane'])
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index b593f4448e83..1ad3049e9069 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -12,6 +12,7 @@ from unittest import mock
 import tempfile, shutil # Handling test_tmpdir
 
 import json
+import signal
 import os
 
 import kunit_config
@@ -21,16 +22,18 @@ import kunit_json
 import kunit
 
 test_tmpdir = ''
+abs_test_data_dir = ''
 
 def setUpModule():
-	global test_tmpdir
+	global test_tmpdir, abs_test_data_dir
 	test_tmpdir = tempfile.mkdtemp()
+	abs_test_data_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), 'test_data'))
 
 def tearDownModule():
 	shutil.rmtree(test_tmpdir)
 
-def get_absolute_path(path):
-	return os.path.join(os.path.dirname(__file__), path)
+def test_data_path(path):
+	return os.path.join(abs_test_data_dir, path)
 
 class KconfigTest(unittest.TestCase):
 
@@ -46,8 +49,7 @@ class KconfigTest(unittest.TestCase):
 
 	def test_read_from_file(self):
 		kconfig = kunit_config.Kconfig()
-		kconfig_path = get_absolute_path(
-			'test_data/test_read_from_file.kconfig')
+		kconfig_path = test_data_path('test_read_from_file.kconfig')
 
 		kconfig.read_from_file(kconfig_path)
 
@@ -98,21 +100,18 @@ class KUnitParserTest(unittest.TestCase):
 			str(needle) + '" not found in "' + str(haystack) + '"!')
 
 	def test_output_isolated_correctly(self):
-		log_path = get_absolute_path(
-			'test_data/test_output_isolated_correctly.log')
-		file = open(log_path)
-		result = kunit_parser.isolate_kunit_output(file.readlines())
+		log_path = test_data_path('test_output_isolated_correctly.log')
+		with open(log_path) as file:
+			result = kunit_parser.isolate_kunit_output(file.readlines())
 		self.assertContains('TAP version 14', result)
 		self.assertContains('	# Subtest: example', result)
 		self.assertContains('	1..2', result)
 		self.assertContains('	ok 1 - example_simple_test', result)
 		self.assertContains('	ok 2 - example_mock_test', result)
 		self.assertContains('ok 1 - example', result)
-		file.close()
 
 	def test_output_with_prefix_isolated_correctly(self):
-		log_path = get_absolute_path(
-			'test_data/test_pound_sign.log')
+		log_path = test_data_path('test_pound_sign.log')
 		with open(log_path) as file:
 			result = kunit_parser.isolate_kunit_output(file.readlines())
 		self.assertContains('TAP version 14', result)
@@ -141,61 +140,51 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertContains('ok 3 - string-stream-test', result)
 
 	def test_parse_successful_test_log(self):
-		all_passed_log = get_absolute_path(
-			'test_data/test_is_test_passed-all_passed.log')
-		file = open(all_passed_log)
-		result = kunit_parser.parse_run_tests(file.readlines())
+		all_passed_log = test_data_path('test_is_test_passed-all_passed.log')
+		with open(all_passed_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
 		self.assertEqual(
 			kunit_parser.TestStatus.SUCCESS,
 			result.status)
-		file.close()
 
 	def test_parse_failed_test_log(self):
-		failed_log = get_absolute_path(
-			'test_data/test_is_test_passed-failure.log')
-		file = open(failed_log)
-		result = kunit_parser.parse_run_tests(file.readlines())
+		failed_log = test_data_path('test_is_test_passed-failure.log')
+		with open(failed_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
 		self.assertEqual(
 			kunit_parser.TestStatus.FAILURE,
 			result.status)
-		file.close()
 
 	def test_no_tests(self):
-		empty_log = get_absolute_path(
-			'test_data/test_is_test_passed-no_tests_run.log')
-		file = open(empty_log)
-		result = kunit_parser.parse_run_tests(
-			kunit_parser.isolate_kunit_output(file.readlines()))
+		empty_log = test_data_path('test_is_test_passed-no_tests_run.log')
+		with open(empty_log) as file:
+			result = kunit_parser.parse_run_tests(
+				kunit_parser.isolate_kunit_output(file.readlines()))
 		self.assertEqual(0, len(result.suites))
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
 			result.status)
-		file.close()
 
 	def test_no_kunit_output(self):
-		crash_log = get_absolute_path(
-			'test_data/test_insufficient_memory.log')
-		file = open(crash_log)
+		crash_log = test_data_path('test_insufficient_memory.log')
 		print_mock = mock.patch('builtins.print').start()
-		result = kunit_parser.parse_run_tests(
-			kunit_parser.isolate_kunit_output(file.readlines()))
+		with open(crash_log) as file:
+			result = kunit_parser.parse_run_tests(
+				kunit_parser.isolate_kunit_output(file.readlines()))
 		print_mock.assert_any_call(StrContains('no tests run!'))
 		print_mock.stop()
 		file.close()
 
 	def test_crashed_test(self):
-		crashed_log = get_absolute_path(
-			'test_data/test_is_test_passed-crash.log')
-		file = open(crashed_log)
-		result = kunit_parser.parse_run_tests(file.readlines())
+		crashed_log = test_data_path('test_is_test_passed-crash.log')
+		with open(crashed_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
 		self.assertEqual(
 			kunit_parser.TestStatus.TEST_CRASHED,
 			result.status)
-		file.close()
 
 	def test_ignores_prefix_printk_time(self):
-		prefix_log = get_absolute_path(
-			'test_data/test_config_printk_time.log')
+		prefix_log = test_data_path('test_config_printk_time.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -204,8 +193,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_ignores_multiple_prefixes(self):
-		prefix_log = get_absolute_path(
-			'test_data/test_multiple_prefixes.log')
+		prefix_log = test_data_path('test_multiple_prefixes.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -214,8 +202,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_prefix_mixed_kernel_output(self):
-		mixed_prefix_log = get_absolute_path(
-			'test_data/test_interrupted_tap_output.log')
+		mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
 		with open(mixed_prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -224,7 +211,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_prefix_poundsign(self):
-		pound_log = get_absolute_path('test_data/test_pound_sign.log')
+		pound_log = test_data_path('test_pound_sign.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -233,7 +220,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_kernel_panic_end(self):
-		panic_log = get_absolute_path('test_data/test_kernel_panic_interrupt.log')
+		panic_log = test_data_path('test_kernel_panic_interrupt.log')
 		with open(panic_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -242,7 +229,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_pound_no_prefix(self):
-		pound_log = get_absolute_path('test_data/test_pound_no_prefix.log')
+		pound_log = test_data_path('test_pound_no_prefix.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -250,10 +237,27 @@ class KUnitParserTest(unittest.TestCase):
 				result.status)
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
+class LinuxSourceTreeTest(unittest.TestCase):
+
+	def setUp(self):
+		mock.patch.object(signal, 'signal').start()
+		self.addCleanup(mock.patch.stopall)
+
+	def test_invalid_kunitconfig(self):
+		with self.assertRaisesRegex(kunit_kernel.ConfigError, 'nonexistent.* does not exist'):
+			kunit_kernel.LinuxSourceTree('', kunitconfig_path='/nonexistent_file')
+
+	def test_valid_kunitconfig(self):
+		with tempfile.NamedTemporaryFile('wt') as kunitconfig:
+			tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=kunitconfig.name)
+
+	# TODO: add more test cases.
+
+
 class KUnitJsonTest(unittest.TestCase):
 
 	def _json_for(self, log_file):
-		with(open(get_absolute_path(log_file))) as file:
+		with open(test_data_path(log_file)) as file:
 			test_result = kunit_parser.parse_run_tests(file)
 			json_obj = kunit_json.get_json_result(
 				test_result=test_result,
@@ -263,22 +267,19 @@ class KUnitJsonTest(unittest.TestCase):
 		return json.loads(json_obj)
 
 	def test_failed_test_json(self):
-		result = self._json_for(
-			'test_data/test_is_test_passed-failure.log')
+		result = self._json_for('test_is_test_passed-failure.log')
 		self.assertEqual(
 			{'name': 'example_simple_test', 'status': 'FAIL'},
 			result["sub_groups"][1]["test_cases"][0])
 
 	def test_crashed_test_json(self):
-		result = self._json_for(
-			'test_data/test_is_test_passed-crash.log')
+		result = self._json_for('test_is_test_passed-crash.log')
 		self.assertEqual(
 			{'name': 'example_simple_test', 'status': 'ERROR'},
 			result["sub_groups"][1]["test_cases"][0])
 
 	def test_no_tests_json(self):
-		result = self._json_for(
-			'test_data/test_is_test_passed-no_tests_run.log')
+		result = self._json_for('test_is_test_passed-no_tests_run.log')
 		self.assertEqual(0, len(result['sub_groups']))
 
 class StrContains(str):
@@ -287,106 +288,104 @@ class StrContains(str):
 
 class KUnitMainTest(unittest.TestCase):
 	def setUp(self):
-		path = get_absolute_path('test_data/test_is_test_passed-all_passed.log')
-		file = open(path)
-		all_passed_log = file.readlines()
-		self.print_patch = mock.patch('builtins.print')
-		self.print_mock = self.print_patch.start()
+		path = test_data_path('test_is_test_passed-all_passed.log')
+		with open(path) as file:
+			all_passed_log = file.readlines()
+
+		self.print_mock = mock.patch('builtins.print').start()
+		self.addCleanup(mock.patch.stopall)
+
 		self.linux_source_mock = mock.Mock()
 		self.linux_source_mock.build_reconfig = mock.Mock(return_value=True)
 		self.linux_source_mock.build_um_kernel = mock.Mock(return_value=True)
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=all_passed_log)
 
-	def tearDown(self):
-		self.print_patch.stop()
-		pass
-
 	def test_config_passes_args_pass(self):
 		kunit.main(['config', '--build_dir=.kunit'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
-		assert self.linux_source_mock.run_kernel.call_count == 0
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
 	def test_build_passes_args_pass(self):
 		kunit.main(['build'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 0
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
 		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, '.kunit', None)
-		assert self.linux_source_mock.run_kernel.call_count == 0
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
 	def test_exec_passes_args_pass(self):
 		kunit.main(['exec'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 0
-		assert self.linux_source_mock.run_kernel.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit', timeout=300)
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			build_dir='.kunit', filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_pass(self):
 		kunit.main(['run'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
-		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='.kunit', timeout=300)
+			build_dir='.kunit', filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_exec_passes_args_fail(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		with self.assertRaises(SystemExit) as e:
 			kunit.main(['exec'], self.linux_source_mock)
-		assert type(e.exception) == SystemExit
-		assert e.exception.code == 1
+		self.assertEqual(e.exception.code, 1)
 
 	def test_run_passes_args_fail(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		with self.assertRaises(SystemExit) as e:
 			kunit.main(['run'], self.linux_source_mock)
-		assert type(e.exception) == SystemExit
-		assert e.exception.code == 1
-		assert self.linux_source_mock.build_reconfig.call_count == 1
-		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.assertEqual(e.exception.code, 1)
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.print_mock.assert_any_call(StrContains(' 0 tests run'))
 
 	def test_exec_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		kunit.main(['exec', '--raw_output'], self.linux_source_mock)
-		assert self.linux_source_mock.run_kernel.call_count == 1
-		for kall in self.print_mock.call_args_list:
-			assert kall != mock.call(StrContains('Testing complete.'))
-			assert kall != mock.call(StrContains(' 0 tests run'))
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
+		for call in self.print_mock.call_args_list:
+			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
+			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
 
 	def test_run_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		kunit.main(['run', '--raw_output'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
-		assert self.linux_source_mock.run_kernel.call_count == 1
-		for kall in self.print_mock.call_args_list:
-			assert kall != mock.call(StrContains('Testing complete.'))
-			assert kall != mock.call(StrContains(' 0 tests run'))
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
+		for call in self.print_mock.call_args_list:
+			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
+			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
 
 	def test_exec_timeout(self):
 		timeout = 3453
 		kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit', timeout=timeout)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			build_dir='.kunit', filter_glob='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_timeout(self):
 		timeout = 3453
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='.kunit', timeout=timeout)
+			build_dir='.kunit', filter_glob='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_builddir(self):
 		build_dir = '.kunit'
 		kunit.main(['run', '--build_dir=.kunit'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir=build_dir, timeout=300)
+			build_dir=build_dir, filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_config_builddir(self):
 		build_dir = '.kunit'
 		kunit.main(['config', '--build_dir', build_dir], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 
 	def test_build_builddir(self):
 		build_dir = '.kunit'
@@ -396,8 +395,23 @@ class KUnitMainTest(unittest.TestCase):
 	def test_exec_builddir(self):
 		build_dir = '.kunit'
 		kunit.main(['exec', '--build_dir', build_dir], self.linux_source_mock)
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, timeout=300)
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			build_dir=build_dir, filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
+	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
+	def test_run_kunitconfig(self, mock_linux_init):
+		mock_linux_init.return_value = self.linux_source_mock
+		kunit.main(['run', '--kunitconfig=mykunitconfig'])
+		# Just verify that we parsed and initialized it correctly here.
+		mock_linux_init.assert_called_once_with('.kunit', kunitconfig_path='mykunitconfig')
+
+	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
+	def test_config_kunitconfig(self, mock_linux_init):
+		mock_linux_init.return_value = self.linux_source_mock
+		kunit.main(['config', '--kunitconfig=mykunitconfig'])
+		# Just verify that we parsed and initialized it correctly here.
+		mock_linux_init.assert_called_once_with('.kunit', kunitconfig_path='mykunitconfig')
+
 if __name__ == '__main__':
 	unittest.main()

--------------B7958C190DEDF87EF6A89C58--
