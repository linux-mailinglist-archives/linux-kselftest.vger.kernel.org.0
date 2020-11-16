Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688222B40D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 11:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgKPKTV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 05:19:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728860AbgKPKSc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:32 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D468A24658;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521909;
        bh=KrbcrIZgcxW+rREWaEUdg/0/VoW51DX5o5w2uAPasYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xMlrUiGu7a0GKfnKVjBU2qRtINhOeEaU0n8OS5M9roYly/ItJvbnkWdn8KBPZVQwf
         BU7Letufvw/POxpH+9BmW36ADdXLlUcZZly12vR9ESWe7bZUpiSs0EazRXCYdQTrhZ
         K79aoZd6XLp96I8cC+Naf/FJqLXX3Nag2afSvxzo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwEw-OC; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v4 26/27] selftests: kselftest_harness.h: partially fix kernel-doc markups
Date:   Mon, 16 Nov 2020 11:18:22 +0100
Message-Id: <f48f149282a06f1c9f401d76b518b794da65bfcb.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kernel-doc markups on this file are weird: they don't
follow what's specified at:

	Documentation/doc-guide/kernel-doc.rst

In particular, markups should use this format:
        identifier - description

and not this:
	identifier(args)

The way the definitions are inside this file cause the
parser to completely miss the identifier name of each
function.

This prevents improving the script to do some needed validation
tests.

Address this part. Yet, furter changes are needed in order
for it to fully follow the specs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 22 ++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index edce85420d19..99920466076a 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -62,301 +62,301 @@
 #include <string.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
 
 #include "kselftest.h"
 
 #define TEST_TIMEOUT_DEFAULT 30
 
 /* Utilities exposed to the test definitions */
 #ifndef TH_LOG_STREAM
 #  define TH_LOG_STREAM stderr
 #endif
 
 #ifndef TH_LOG_ENABLED
 #  define TH_LOG_ENABLED 1
 #endif
 
 /**
- * TH_LOG(fmt, ...)
+ * TH_LOG()
  *
  * @fmt: format string
  * @...: optional arguments
  *
  * .. code-block:: c
  *
  *     TH_LOG(format, ...)
  *
  * Optional debug logging function available for use in tests.
  * Logging may be enabled or disabled by defining TH_LOG_ENABLED.
  * E.g., #define TH_LOG_ENABLED 1
  *
  * If no definition is provided, logging is enabled by default.
  *
  * If there is no way to print an error message for the process running the
  * test (e.g. not allowed to write to stderr), it is still possible to get the
  * ASSERT_* number for which the test failed.  This behavior can be enabled by
  * writing `_metadata->no_print = true;` before the check sequence that is
  * unable to print.  When an error occur, instead of printing an error message
  * and calling `abort(3)`, the test process call `_exit(2)` with the assert
  * number as argument, which is then printed by the parent process.
  */
 #define TH_LOG(fmt, ...) do { \
 	if (TH_LOG_ENABLED) \
 		__TH_LOG(fmt, ##__VA_ARGS__); \
 } while (0)
 
 /* Unconditional logger for internal use. */
 #define __TH_LOG(fmt, ...) \
 		fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
 			__FILE__, __LINE__, _metadata->name, ##__VA_ARGS__)
 
 /**
- * SKIP(statement, fmt, ...)
+ * SKIP()
  *
  * @statement: statement to run after reporting SKIP
  * @fmt: format string
  * @...: optional arguments
  *
  * This forces a "pass" after reporting why something is being skipped
  * and runs "statement", which is usually "return" or "goto skip".
  */
 #define SKIP(statement, fmt, ...) do { \
 	snprintf(_metadata->results->reason, \
 		 sizeof(_metadata->results->reason), fmt, ##__VA_ARGS__); \
 	if (TH_LOG_ENABLED) { \
 		fprintf(TH_LOG_STREAM, "#      SKIP      %s\n", \
 			_metadata->results->reason); \
 	} \
 	_metadata->passed = 1; \
 	_metadata->skip = 1; \
 	_metadata->trigger = 0; \
 	statement; \
 } while (0)
 
 /**
- * TEST(test_name) - Defines the test function and creates the registration
+ * TEST() - Defines the test function and creates the registration
  * stub
  *
  * @test_name: test name
  *
  * .. code-block:: c
  *
  *     TEST(name) { implementation }
  *
  * Defines a test by name.
  * Names must be unique and tests must not be run in parallel.  The
  * implementation containing block is a function and scoping should be treated
  * as such.  Returning early may be performed with a bare "return;" statement.
  *
  * EXPECT_* and ASSERT_* are valid in a TEST() { } context.
  */
 #define TEST(test_name) __TEST_IMPL(test_name, -1)
 
 /**
- * TEST_SIGNAL(test_name, signal)
+ * TEST_SIGNAL()
  *
  * @test_name: test name
  * @signal: signal number
  *
  * .. code-block:: c
  *
  *     TEST_SIGNAL(name, signal) { implementation }
  *
  * Defines a test by name and the expected term signal.
  * Names must be unique and tests must not be run in parallel.  The
  * implementation containing block is a function and scoping should be treated
  * as such.  Returning early may be performed with a bare "return;" statement.
  *
  * EXPECT_* and ASSERT_* are valid in a TEST() { } context.
  */
 #define TEST_SIGNAL(test_name, signal) __TEST_IMPL(test_name, signal)
 
 #define __TEST_IMPL(test_name, _signal) \
 	static void test_name(struct __test_metadata *_metadata); \
 	static inline void wrapper_##test_name( \
 		struct __test_metadata *_metadata, \
 		struct __fixture_variant_metadata *variant) \
 	{ \
 		test_name(_metadata); \
 	} \
 	static struct __test_metadata _##test_name##_object = \
 		{ .name = #test_name, \
 		  .fn = &wrapper_##test_name, \
 		  .fixture = &_fixture_global, \
 		  .termsig = _signal, \
 		  .timeout = TEST_TIMEOUT_DEFAULT, }; \
 	static void __attribute__((constructor)) _register_##test_name(void) \
 	{ \
 		__register_test(&_##test_name##_object); \
 	} \
 	static void test_name( \
 		struct __test_metadata __attribute__((unused)) *_metadata)
 
 /**
- * FIXTURE_DATA(datatype_name) - Wraps the struct name so we have one less
+ * FIXTURE_DATA() - Wraps the struct name so we have one less
  * argument to pass around
  *
  * @datatype_name: datatype name
  *
  * .. code-block:: c
  *
  *     FIXTURE_DATA(datatype_name)
  *
  * Almost always, you want just FIXTURE() instead (see below).
  * This call may be used when the type of the fixture data
  * is needed.  In general, this should not be needed unless
  * the *self* is being passed to a helper directly.
  */
 #define FIXTURE_DATA(datatype_name) struct _test_data_##datatype_name
 
 /**
- * FIXTURE(fixture_name) - Called once per fixture to setup the data and
+ * FIXTURE() - Called once per fixture to setup the data and
  * register
  *
  * @fixture_name: fixture name
  *
  * .. code-block:: c
  *
  *     FIXTURE(fixture_name) {
  *       type property1;
  *       ...
  *     };
  *
  * Defines the data provided to TEST_F()-defined tests as *self*.  It should be
  * populated and cleaned up using FIXTURE_SETUP() and FIXTURE_TEARDOWN().
  */
 #define FIXTURE(fixture_name) \
 	FIXTURE_VARIANT(fixture_name); \
 	static struct __fixture_metadata _##fixture_name##_fixture_object = \
 		{ .name =  #fixture_name, }; \
 	static void __attribute__((constructor)) \
 	_register_##fixture_name##_data(void) \
 	{ \
 		__register_fixture(&_##fixture_name##_fixture_object); \
 	} \
 	FIXTURE_DATA(fixture_name)
 
 /**
- * FIXTURE_SETUP(fixture_name) - Prepares the setup function for the fixture.
+ * FIXTURE_SETUP() - Prepares the setup function for the fixture.
  * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
  *
  * @fixture_name: fixture name
  *
  * .. code-block:: c
  *
  *     FIXTURE_SETUP(fixture_name) { implementation }
  *
  * Populates the required "setup" function for a fixture.  An instance of the
  * datatype defined with FIXTURE_DATA() will be exposed as *self* for the
  * implementation.
  *
  * ASSERT_* are valid for use in this context and will prempt the execution
  * of any dependent fixture tests.
  *
  * A bare "return;" statement may be used to return early.
  */
 #define FIXTURE_SETUP(fixture_name) \
 	void fixture_name##_setup( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
 		const FIXTURE_VARIANT(fixture_name) \
 			__attribute__((unused)) *variant)
 
 /**
- * FIXTURE_TEARDOWN(fixture_name)
+ * FIXTURE_TEARDOWN()
  * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
  *
  * @fixture_name: fixture name
  *
  * .. code-block:: c
  *
  *     FIXTURE_TEARDOWN(fixture_name) { implementation }
  *
  * Populates the required "teardown" function for a fixture.  An instance of the
  * datatype defined with FIXTURE_DATA() will be exposed as *self* for the
  * implementation to clean up.
  *
  * A bare "return;" statement may be used to return early.
  */
 #define FIXTURE_TEARDOWN(fixture_name) \
 	void fixture_name##_teardown( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
 
 /**
- * FIXTURE_VARIANT(fixture_name) - Optionally called once per fixture
+ * FIXTURE_VARIANT() - Optionally called once per fixture
  * to declare fixture variant
  *
  * @fixture_name: fixture name
  *
  * .. code-block:: c
  *
  *     FIXTURE_VARIANT(fixture_name) {
  *       type property1;
  *       ...
  *     };
  *
  * Defines type of constant parameters provided to FIXTURE_SETUP() and TEST_F()
  * as *variant*. Variants allow the same tests to be run with different
  * arguments.
  */
 #define FIXTURE_VARIANT(fixture_name) struct _fixture_variant_##fixture_name
 
 /**
- * FIXTURE_VARIANT_ADD(fixture_name, variant_name) - Called once per fixture
+ * FIXTURE_VARIANT_ADD() - Called once per fixture
  * variant to setup and register the data
  *
  * @fixture_name: fixture name
  * @variant_name: name of the parameter set
  *
  * .. code-block:: c
  *
  *     FIXTURE_VARIANT_ADD(fixture_name, variant_name) {
  *       .property1 = val1,
  *       ...
  *     };
  *
  * Defines a variant of the test fixture, provided to FIXTURE_SETUP() and
  * TEST_F() as *variant*. Tests of each fixture will be run once for each
  * variant.
  */
 #define FIXTURE_VARIANT_ADD(fixture_name, variant_name) \
 	extern FIXTURE_VARIANT(fixture_name) \
 		_##fixture_name##_##variant_name##_variant; \
 	static struct __fixture_variant_metadata \
 		_##fixture_name##_##variant_name##_object = \
 		{ .name = #variant_name, \
 		  .data = &_##fixture_name##_##variant_name##_variant}; \
 	static void __attribute__((constructor)) \
 		_register_##fixture_name##_##variant_name(void) \
 	{ \
 		__register_fixture_variant(&_##fixture_name##_fixture_object, \
 			&_##fixture_name##_##variant_name##_object);	\
 	} \
 	FIXTURE_VARIANT(fixture_name) \
 		_##fixture_name##_##variant_name##_variant =
 
 /**
- * TEST_F(fixture_name, test_name) - Emits test registration and helpers for
+ * TEST_F() - Emits test registration and helpers for
  * fixture-based test cases
  *
  * @fixture_name: fixture name
  * @test_name: test name
  *
  * .. code-block:: c
  *
  *     TEST_F(fixture, name) { implementation }
  *
  * Defines a test that depends on a fixture (e.g., is part of a test case).
  * Very similar to TEST() except that *self* is the setup instance of fixture's
  * datatype exposed for use by the implementation.
  *
  * Warning: use of ASSERT_* here will skip TEARDOWN.
  */
 /* TODO(wad) register fixtures on dedicated test lists. */
 #define TEST_F(fixture_name, test_name) \
 	__TEST_F_IMPL(fixture_name, test_name, -1, TEST_TIMEOUT_DEFAULT)
 
 #define TEST_F_SIGNAL(fixture_name, test_name, signal) \
-- 
2.28.0

