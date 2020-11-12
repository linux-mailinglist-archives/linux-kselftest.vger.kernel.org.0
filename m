Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE302B0C4C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 19:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKLSHn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 13:07:43 -0500
Received: from mga09.intel.com ([134.134.136.24]:40522 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgKLSHn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 13:07:43 -0500
IronPort-SDR: XBc7Wl6YjEuwzyWv4BdgCF/lBTJb9B05YCzAMxrD1xXHL5kogCyBtwtcvYcJDP80eQ56E9yNB4
 9jUZQT6bBD3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="170524801"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="170524801"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 10:07:41 -0800
IronPort-SDR: u+JcQyIcXV8QsAPOu6wkjD/w8gJIWsqCEOngdZIRbB9B9zeFFxdScBkLM1yl8kW/bDw4DKmG48
 g9qXIUixVdYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="355275608"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 12 Nov 2020 10:07:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BBC1D2AB; Thu, 12 Nov 2020 20:07:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 6/6] lib/cmdline_kunit: Add a new test suite for cmdline API
Date:   Thu, 12 Nov 2020 20:07:32 +0200
Message-Id: <20201112180732.75589-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
References: <20201112180732.75589-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test get_option() for a starter which is provided by cmdline.c.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: new patch
 lib/Kconfig.debug   | 11 +++++
 lib/Makefile        |  1 +
 lib/cmdline_kunit.c | 98 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 lib/cmdline_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6140413174be..b939740f93b7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2283,6 +2283,17 @@ config LINEAR_RANGES_TEST
 
 	  If unsure, say N.
 
+config CMDLINE_KUNIT_TEST
+	tristate "KUnit test for cmdline API"
+	depends on KUNIT
+	help
+	  This builds the cmdline API unit test.
+	  Tests the logic of API provided by cmdline.c.
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config BITS_TEST
 	tristate "KUnit test for bits.h"
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index dc76e7d8a453..985c6a8909e0 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -350,5 +350,6 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 # KUnit tests
 obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_BITS_TEST) += bits_kunit.o
+obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += linear_ranges_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list_kunit.o
diff --git a/lib/cmdline_kunit.c b/lib/cmdline_kunit.c
new file mode 100644
index 000000000000..acad1386d54c
--- /dev/null
+++ b/lib/cmdline_kunit.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test cases for API provided by cmdline.c
+ */
+
+#include <kunit/test.h>
+#include <linux/kernel.h>
+#include <linux/random.h>
+#include <linux/string.h>
+
+static const char *cmdline_test_strings[] = {
+	"\"\"", ""  , "=" , "\"-", ","    , "-,"   , ",-"   , "-" ,
+	"+,"  , "--", ",,", "''" , "\"\",", "\",\"", "-\"\"", "\"",
+};
+
+static const char *cmdline_test_values[] = {
+	1, 1, 1, 1, 2, 3, 2, 3,
+	1, 3, 2, 1, 1, 1, 3, 1,
+};
+
+static void cmdline_do_one_test(struct kunit *test, char *in, int rc, int offset)
+{
+	const char *fmt = "Pattern: %s";
+	char *out = in;
+	int dummy;
+	int ret;
+
+	ret = get_option(&out, &dummy);
+
+	KUNIT_EXPECT_EQ_MSG(test, ret, rc, fmt, in);
+	KUNIT_EXPECT_PTR_EQ_MSG(test, out, in + offset, fmt, in);
+}
+
+static void cmdline_test_noint(struct kunit *test)
+{
+	unsigned int i = 0;
+
+	do {
+		const char *str = cmdline_test_strings[i];
+		int rc = 0;
+		int offset;
+
+		/* Only first and leading '-' will advance the pointer */
+		offset = !!(*str == '-');
+		cmdline_do_one_test(test, str, rc, offset);
+	} while (++i < ARRAY_SIZE(cmdline_test_strings));
+}
+
+static void cmdline_test_lead_int(struct kunit *test)
+{
+	unsigned int i = 0;
+	char in[32];
+
+	do {
+		const char *str = cmdline_test_strings[i];
+		int rc = cmdline_test_values[i];
+		int offset;
+
+		sprintf(in, "%u%s", get_random_int() % 256, str);
+		/* Only first '-' after the number will advance the pointer */
+		offset = strlen(in) - strlen(str) + !!(rc == 2);
+		cmdline_do_one_test(test, in, rc, offset);
+	} while (++i < ARRAY_SIZE(cmdline_test_strings));
+}
+
+static void cmdline_test_tail_int(struct kunit *test)
+{
+	unsigned int i = 0;
+	char in[32];
+
+	do {
+		const char *str = cmdline_test_strings[i];
+		/* When "" or "-" the result will be valid integer */
+		int rc = strcmp(str, "") ? (strcmp(str, "-") ? 0 : 1) : 1;
+		int offset;
+
+		sprintf(in, "%s%u", str, get_random_int() % 256);
+		/*
+		 * Only first and leading '-' not followed by integer
+		 * will advance the pointer.
+		 */
+		offset = rc ? strlen(in) : !!(*str == '-');
+		cmdline_do_one_test(test, in, rc, offset);
+	} while (++i < ARRAY_SIZE(cmdline_test_strings));
+}
+
+static struct kunit_case cmdline_test_cases[] = {
+	KUNIT_CASE(cmdline_test_noint),
+	KUNIT_CASE(cmdline_test_lead_int),
+	KUNIT_CASE(cmdline_test_tail_int),
+	{}
+};
+
+static struct kunit_suite cmdline_test_suite = {
+	.name = "cmdline",
+	.test_cases = cmdline_test_cases,
+};
+kunit_test_suite(cmdline_test_suite);
-- 
2.28.0

