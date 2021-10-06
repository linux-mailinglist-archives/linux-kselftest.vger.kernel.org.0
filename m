Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9771D4234D3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Oct 2021 02:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbhJFAQI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 20:16:08 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33562 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhJFAQG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 20:16:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 4AFF61F442E2
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        lucmaga@gmail.com, David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v6 1/1] lib: Convert UUID runtime test to KUnit
Date:   Tue,  5 Oct 2021 21:13:45 -0300
Message-Id: <20211006001345.73898-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006001345.73898-1-andrealmeid@collabora.com>
References: <20211006001345.73898-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove custom functions for testing and use KUnit framework. Keep the
tested functions and test data the same.

Current test threat (g/u)uid_parse and (g/u)uid_equal as different test
cases. Make both functions being part of the same test case, given the
dependency regarding their results. This reduces the tests cases from 6
cases to 4, while keeping the test coverage the same. Given that we have
3 strings for each test case, current test output notifies 18 tests
results, and the KUnit output announces 12 results.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 lib/Kconfig.debug |   8 ++-
 lib/Makefile      |   2 +-
 lib/test_uuid.c   | 137 +++++++++++++++++++---------------------------
 3 files changed, 64 insertions(+), 83 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2a9b6dcdac4f..b60f35d38dd2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2188,8 +2188,12 @@ config TEST_BITMAP
 
 	  If unsure, say N.
 
-config TEST_UUID
-	tristate "Test functions located in the uuid module at runtime"
+config UUID_KUNIT_TEST
+	tristate "Unit test for UUID" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Tests parsing functions for UUID/GUID strings.
 
 config TEST_XARRAY
 	tristate "Test the XArray code at runtime"
diff --git a/lib/Makefile b/lib/Makefile
index 5efd1b435a37..f9bb316f8511 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -86,7 +86,6 @@ obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_SCANF) += test_scanf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
-obj-$(CONFIG_TEST_UUID) += test_uuid.o
 obj-$(CONFIG_TEST_XARRAY) += test_xarray.o
 obj-$(CONFIG_TEST_PARMAN) += test_parman.o
 obj-$(CONFIG_TEST_KMOD) += test_kmod.o
@@ -358,5 +357,6 @@ obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
 obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
 obj-$(CONFIG_SLUB_KUNIT_TEST) += slub_kunit.o
+obj-$(CONFIG_UUID_KUNIT_TEST) += test_uuid.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
diff --git a/lib/test_uuid.c b/lib/test_uuid.c
index cd819c397dc7..30f350301e6d 100644
--- a/lib/test_uuid.c
+++ b/lib/test_uuid.c
@@ -1,21 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 /*
- * Test cases for lib/uuid.c module.
+ * Unit tests for lib/uuid.c module.
+ *
+ * Copyright 2016 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+ * Copyright 2021 André Almeida <andrealmeid@riseup.net>
  */
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/string.h>
+#include <kunit/test.h>
 #include <linux/uuid.h>
 
-struct test_uuid_data {
+struct test_data {
 	const char *uuid;
 	guid_t le;
 	uuid_t be;
 };
 
-static const struct test_uuid_data test_uuid_test_data[] = {
+static const struct test_data correct_data[] = {
 	{
 		.uuid = "c33f4995-3701-450e-9fbf-206a2e98e576",
 		.le = GUID_INIT(0xc33f4995, 0x3701, 0x450e, 0x9f, 0xbf, 0x20, 0x6a, 0x2e, 0x98, 0xe5, 0x76),
@@ -33,101 +32,79 @@ static const struct test_uuid_data test_uuid_test_data[] = {
 	},
 };
 
-static const char * const test_uuid_wrong_data[] = {
+static const char * const wrong_data[] = {
 	"c33f4995-3701-450e-9fbf206a2e98e576 ",	/* no hyphen(s) */
 	"64b4371c-77c1-48f9-8221-29f054XX023b",	/* invalid character(s) */
 	"0cb4ddff-a545-4401-9d06-688af53e",	/* not enough data */
 };
 
-static unsigned total_tests __initdata;
-static unsigned failed_tests __initdata;
-
-static void __init test_uuid_failed(const char *prefix, bool wrong, bool be,
-				    const char *data, const char *actual)
+static void uuid_correct_le(struct kunit *test)
 {
-	pr_err("%s test #%u %s %s data: '%s'\n",
-	       prefix,
-	       total_tests,
-	       wrong ? "passed on wrong" : "failed on",
-	       be ? "BE" : "LE",
-	       data);
-	if (actual && *actual)
-		pr_err("%s test #%u actual data: '%s'\n",
-		       prefix,
-		       total_tests,
-		       actual);
-	failed_tests++;
+	guid_t le;
+	const struct test_data *data = test->param_value;
+
+	KUNIT_ASSERT_EQ_MSG(test, guid_parse(data->uuid, &le), 0,
+			    "failed to parse '%s'", data->uuid);
+	KUNIT_EXPECT_TRUE_MSG(test, guid_equal(&data->le, &le),
+			      "'%s' should be equal to %pUl", data->uuid, &le);
 }
 
-static void __init test_uuid_test(const struct test_uuid_data *data)
+static void uuid_correct_be(struct kunit *test)
 {
-	guid_t le;
 	uuid_t be;
-	char buf[48];
-
-	/* LE */
-	total_tests++;
-	if (guid_parse(data->uuid, &le))
-		test_uuid_failed("conversion", false, false, data->uuid, NULL);
-
-	total_tests++;
-	if (!guid_equal(&data->le, &le)) {
-		sprintf(buf, "%pUl", &le);
-		test_uuid_failed("cmp", false, false, data->uuid, buf);
-	}
-
-	/* BE */
-	total_tests++;
-	if (uuid_parse(data->uuid, &be))
-		test_uuid_failed("conversion", false, true, data->uuid, NULL);
-
-	total_tests++;
-	if (!uuid_equal(&data->be, &be)) {
-		sprintf(buf, "%pUb", &be);
-		test_uuid_failed("cmp", false, true, data->uuid, buf);
-	}
+	const struct test_data *data = test->param_value;
+
+	KUNIT_ASSERT_EQ_MSG(test, uuid_parse(data->uuid, &be), 0,
+			    "failed to parse '%s'", data->uuid);
+	KUNIT_EXPECT_TRUE_MSG(test, uuid_equal(&data->be, &be),
+			      "'%s' should be equal to %pUl", data->uuid, &be);
 }
 
-static void __init test_uuid_wrong(const char *data)
+static void uuid_wrong_le(struct kunit *test)
 {
 	guid_t le;
-	uuid_t be;
-
-	/* LE */
-	total_tests++;
-	if (!guid_parse(data, &le))
-		test_uuid_failed("negative", true, false, data, NULL);
+	const char * const *data = test->param_value;
 
-	/* BE */
-	total_tests++;
-	if (!uuid_parse(data, &be))
-		test_uuid_failed("negative", true, true, data, NULL);
+	KUNIT_ASSERT_NE_MSG(test, guid_parse(*data, &le), 0,
+			    "parsing of '%s' should've failed", *data);
 }
 
-static int __init test_uuid_init(void)
+static void uuid_wrong_be(struct kunit *test)
 {
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(test_uuid_test_data); i++)
-		test_uuid_test(&test_uuid_test_data[i]);
-
-	for (i = 0; i < ARRAY_SIZE(test_uuid_wrong_data); i++)
-		test_uuid_wrong(test_uuid_wrong_data[i]);
+	uuid_t be;
+	const char * const *data = test->param_value;
 
-	if (failed_tests == 0)
-		pr_info("all %u tests passed\n", total_tests);
-	else
-		pr_err("failed %u out of %u tests\n", failed_tests, total_tests);
+	KUNIT_ASSERT_NE_MSG(test, uuid_parse(*data, &be), 0,
+			    "parsing of '%s' should've failed", *data);
+}
 
-	return failed_tests ? -EINVAL : 0;
+static void case_to_desc_correct(const struct test_data *t, char *desc)
+{
+	strcpy(desc, t->uuid);
 }
-module_init(test_uuid_init);
 
-static void __exit test_uuid_exit(void)
+KUNIT_ARRAY_PARAM(correct, correct_data, case_to_desc_correct);
+
+static void case_to_desc_wrong(const char * const *s, char *desc)
 {
-	/* do nothing */
+	strcpy(desc, *s);
 }
-module_exit(test_uuid_exit);
+
+KUNIT_ARRAY_PARAM(wrong, wrong_data, case_to_desc_wrong);
+
+static struct kunit_case uuid_test_cases[] = {
+	KUNIT_CASE_PARAM(uuid_correct_be, correct_gen_params),
+	KUNIT_CASE_PARAM(uuid_correct_le, correct_gen_params),
+	KUNIT_CASE_PARAM(uuid_wrong_be, wrong_gen_params),
+	KUNIT_CASE_PARAM(uuid_wrong_le, wrong_gen_params),
+	{}
+};
+
+static struct kunit_suite uuid_test_suite = {
+	.name = "uuid",
+	.test_cases = uuid_test_cases,
+};
+kunit_test_suite(uuid_test_suite);
 
 MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.33.0

