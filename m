Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA5C2331E4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jul 2020 14:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgG3MSY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jul 2020 08:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgG3MSX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jul 2020 08:18:23 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0901C061794;
        Thu, 30 Jul 2020 05:18:22 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g19so1365194plq.0;
        Thu, 30 Jul 2020 05:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWcupHG1mhYkAKx/dy8TBzw4I8ChGdzaP3QPFWlXFhU=;
        b=SCERfaljin7+1GMBuo1tAr6qj36cEB4ODEub6UroXGTIC8HGiQaqdHAGczdnceUWgP
         zpT2BG72kyT0uGe1HwcEgJpy2DV59l0kIa/SalRtvjdFC1pUxolTk9nQbXe4OxEqOK22
         PuGjAE9ss0iPIWPabmMQdq++B5fSpbyzgXP+NsztTNZTxCg9f3peXVtFxzo96CntpxCW
         yqLk89Hp+MCHCTgVg+MXgduHljb1QIxXG2uROprw2whuSMeKpMTA/zrrWYlbvppQZq0m
         qa4azl8DlfHQA4LG3HneA14HvuxMWHZ5hg5jQeSEf2eN9TLWZE3bhfeuW1+maeRGBgpq
         ClTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWcupHG1mhYkAKx/dy8TBzw4I8ChGdzaP3QPFWlXFhU=;
        b=tO6GrsfRL35wvbmFFi4BQcTa9FailSNZUbEqPGtlJhVhZE5N+j3GjgoSf4SmUfxazi
         mw0pkRFVy9cwB1wyT3NuoSZo1FBUfy0H8aXBSEQHQ9kHWMWIGeNuteghbaaL8VjjSRbo
         IFfqD6H6Y6w0eGaGIffpAHiDwpDDaXuWemMjU8IbCWyKHQUq8swjpycqRW/I4Iv8gtUJ
         cINMxdPl6x3hFZXqj27b02AKSE+f3gIIhAqK/INdxWQTz8tdhU9Y8Cma7oB5N28gqVvv
         hVzL2xCocByjMdCRRe5sN1t9zCzg1dpALlqd9tsqiHlA5JXDfACdtcon0ELdJTkvLK2c
         TKeA==
X-Gm-Message-State: AOAM531hjc1N92L1slfbt+FiDXb4NzGCRHgXISoS01XUJ1NKs8QYZWmI
        vCv8/j9sDvpVGEoLEzrjVFrzT2vf0xp3Xg==
X-Google-Smtp-Source: ABdhPJyky7gP0f/vjyTeyGWzHxMzT+NSR/DK2UIvM7ADGohkTEu/p+599JS/86wzLivsb9w6/M/DNA==
X-Received: by 2002:a17:902:7585:: with SMTP id j5mr15898476pll.168.1596111502234;
        Thu, 30 Jul 2020 05:18:22 -0700 (PDT)
Received: from arpitha-Inspiron-7570.lan ([49.206.12.123])
        by smtp.gmail.com with ESMTPSA id a184sm5886600pfa.83.2020.07.30.05.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 05:18:21 -0700 (PDT)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] lib: Convert test_uuid.c to KUnit
Date:   Thu, 30 Jul 2020 17:46:56 +0530
Message-Id: <20200730121656.45302-1-98.arpi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Converts test lib/test_uuid.c to KUnit

Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
---
 lib/Kconfig.debug                 |  7 +--
 lib/Makefile                      |  2 +-
 lib/{test_uuid.c => uuid_kunit.c} | 84 +++++++++----------------------
 3 files changed, 28 insertions(+), 65 deletions(-)
 rename lib/{test_uuid.c => uuid_kunit.c} (48%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f174f8887ae7..330c0d1de50b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2070,9 +2070,6 @@ config TEST_BITFIELD
 
 	  If unsure, say N.
 
-config TEST_UUID
-	tristate "Test functions located in the uuid module at runtime"
-
 config TEST_XARRAY
 	tristate "Test the XArray code at runtime"
 
@@ -2273,6 +2270,10 @@ config BITS_TEST
 
 	  If unsure, say N.
 
+config UUID_KUNIT_TEST
+	tristate "KUnit test for functions located in the uuid module at runtime"
+	depends on KUNIT
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 032cc6c71a3a..62ef383c7563 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -81,7 +81,6 @@ obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
 obj-$(CONFIG_TEST_BITFIELD) += test_bitfield.o
-obj-$(CONFIG_TEST_UUID) += test_uuid.o
 obj-$(CONFIG_TEST_XARRAY) += test_xarray.o
 obj-$(CONFIG_TEST_PARMAN) += test_parman.o
 obj-$(CONFIG_TEST_KMOD) += test_kmod.o
@@ -342,5 +341,6 @@ obj-$(CONFIG_PLDMFW) += pldmfw/
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
+obj-$(CONFIG_UUID_KUNIT_TEST) += uuid_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
diff --git a/lib/test_uuid.c b/lib/uuid_kunit.c
similarity index 48%
rename from lib/test_uuid.c
rename to lib/uuid_kunit.c
index cd819c397dc7..f7f219ddecc2 100644
--- a/lib/test_uuid.c
+++ b/lib/uuid_kunit.c
@@ -3,6 +3,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/test.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -39,95 +40,56 @@ static const char * const test_uuid_wrong_data[] = {
 	"0cb4ddff-a545-4401-9d06-688af53e",	/* not enough data */
 };
 
-static unsigned total_tests __initdata;
-static unsigned failed_tests __initdata;
-
-static void __init test_uuid_failed(const char *prefix, bool wrong, bool be,
-				    const char *data, const char *actual)
-{
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
-}
-
-static void __init test_uuid_test(const struct test_uuid_data *data)
+static void test_uuid_test(struct kunit *test, const struct test_uuid_data *data)
 {
 	guid_t le;
 	uuid_t be;
 	char buf[48];
 
 	/* LE */
-	total_tests++;
-	if (guid_parse(data->uuid, &le))
-		test_uuid_failed("conversion", false, false, data->uuid, NULL);
-
-	total_tests++;
-	if (!guid_equal(&data->le, &le)) {
-		sprintf(buf, "%pUl", &le);
-		test_uuid_failed("cmp", false, false, data->uuid, buf);
-	}
+	KUNIT_EXPECT_EQ(test, 0, guid_parse(data->uuid, &le));
+	KUNIT_EXPECT_TRUE(test, guid_equal(&data->le, &le));
 
 	/* BE */
-	total_tests++;
-	if (uuid_parse(data->uuid, &be))
-		test_uuid_failed("conversion", false, true, data->uuid, NULL);
-
-	total_tests++;
-	if (!uuid_equal(&data->be, &be)) {
-		sprintf(buf, "%pUb", &be);
-		test_uuid_failed("cmp", false, true, data->uuid, buf);
-	}
+	KUNIT_EXPECT_EQ(test, 0, uuid_parse(data->uuid, &be));
+	KUNIT_EXPECT_TRUE(test, uuid_equal(&data->be, &be));
 }
 
-static void __init test_uuid_wrong(const char *data)
+static void test_uuid_wrong(struct kunit *test, const char *data)
 {
 	guid_t le;
 	uuid_t be;
 
 	/* LE */
-	total_tests++;
-	if (!guid_parse(data, &le))
-		test_uuid_failed("negative", true, false, data, NULL);
+	KUNIT_EXPECT_NE(test, 0, guid_parse(data, &le));
 
 	/* BE */
-	total_tests++;
-	if (!uuid_parse(data, &be))
-		test_uuid_failed("negative", true, true, data, NULL);
+	KUNIT_EXPECT_NE(test, 0, uuid_parse(data, &be));
 }
 
-static int __init test_uuid_init(void)
+static void test_uuid_init(struct kunit *test)
 {
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(test_uuid_test_data); i++)
-		test_uuid_test(&test_uuid_test_data[i]);
+		test_uuid_test(test, &test_uuid_test_data[i]);
 
 	for (i = 0; i < ARRAY_SIZE(test_uuid_wrong_data); i++)
-		test_uuid_wrong(test_uuid_wrong_data[i]);
+		test_uuid_wrong(test, test_uuid_wrong_data[i]);
+}
 
-	if (failed_tests == 0)
-		pr_info("all %u tests passed\n", total_tests);
-	else
-		pr_err("failed %u out of %u tests\n", failed_tests, total_tests);
+static struct kunit_case uuid_test_cases[] = {
+	KUNIT_CASE(test_uuid_init),
+	{}
+};
 
-	return failed_tests ? -EINVAL : 0;
-}
-module_init(test_uuid_init);
+static struct kunit_suite uuid_test_suite = {
+	.name = "uuid-kunit-test",
+	.test_cases = uuid_test_cases,
+};
+
+kunit_test_suite(uuid_test_suite);
 
-static void __exit test_uuid_exit(void)
-{
-	/* do nothing */
-}
-module_exit(test_uuid_exit);
 
 MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1

