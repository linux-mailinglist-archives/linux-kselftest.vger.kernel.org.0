Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7DB2239D94
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Aug 2020 05:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHCDAf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Aug 2020 23:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgHCDAe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Aug 2020 23:00:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85716C06174A;
        Sun,  2 Aug 2020 20:00:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kr4so8248896pjb.2;
        Sun, 02 Aug 2020 20:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SslfOAYowcSIRE7OJfXaZEhy+2zzQJIxjTX2JOfNhb0=;
        b=ClJLtk7ld1m3Hbn7U3wLFVfTa9n9Sax2PhdyVglv8jYvKM1jE1XyUVKtIP5hZAiAJz
         K/WRlfx6ylvKa9drNpdWB6gfkpcLcro9XFpZAVrBeC7JxLRVfEFk90mvXFQEpuBAn6vr
         qyrFFAK3OPDJEs08ooJmUD8S7KnBgJtgf+slm10wKQBh0jXGtEv4c+Fv35Efh94ldzkC
         XqC60Gu4mO4M8kx8XMKsdf3fuacFkrAL2CG0nnwQZUrJqmlJqa/FMFeGyj8Nk6uP9PC5
         kVFov0WtpT6PGCn5Vy0s3oJ7W50SK4EDuToJrC41Hqa/qar9YLKecqt7zqZjLgyW5f7e
         Svzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SslfOAYowcSIRE7OJfXaZEhy+2zzQJIxjTX2JOfNhb0=;
        b=jjv9wuoPb0keysi8Aaw35YM3G4PoOnc4uSMR8paCqyXHTkgp7ZK7DuMAgjRpvBLfr0
         JePEWsORyWJN6mXIlLKOFQFX262DsvL2edfOBhkz8InJDwRhcOwjhByl9SMFCF3tLaWg
         hMRxuPi+FT+Qf0aFKwdxnYs2wOOomfnrt7svLVibpYOlF9ZqV99mZjNZmMnr2uGyIi85
         +kIO2Lu1/uMuBbI1gPoR0hIHdP3SqNluIzCHW0cHPhIu8QuPlwugLh0rwODEZ8UsD8Zk
         zSfmEHnS4E3s8X6zCxv0fV3+Bl9+l0z4N60hQl0s8e6O50HlSgwkapfIbBcia7NkUOox
         0DGg==
X-Gm-Message-State: AOAM530VdXDolVRTq2Ey1uTzb7C2iQlORFWp3i1E3b0+QBmnpVqMlX5K
        AXviqYRndbldImtdMezVM54=
X-Google-Smtp-Source: ABdhPJxDrt2rUig4JsB3VONcCUv3daYW3E9vL8dO56SldvOAR9QRN2kiyiXC5AXgs1t7O5oC7rUAXQ==
X-Received: by 2002:a17:902:aa82:: with SMTP id d2mr12475796plr.336.1596423633945;
        Sun, 02 Aug 2020 20:00:33 -0700 (PDT)
Received: from arpitha-Inspiron-7570.lan ([49.206.12.123])
        by smtp.gmail.com with ESMTPSA id g23sm18069768pfo.95.2020.08.02.20.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:00:33 -0700 (PDT)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] lib: Convert test_uuid.c to KUnit
Date:   Mon,  3 Aug 2020 08:29:39 +0530
Message-Id: <20200803025939.21106-1-98.arpi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Converts test lib/test_uuid.c to KUnit.
More information about KUnit can be found at
https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
This change is beneficial as KUnit provides a common framework for
unit tests in the kernel. KUnit is fast as well.

Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
---
Changes v1->v2:
- Add a more detailed commit message

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

