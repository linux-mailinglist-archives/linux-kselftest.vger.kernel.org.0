Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696F02323DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 19:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgG2R66 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jul 2020 13:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgG2R64 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jul 2020 13:58:56 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F2EC0619DC
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 10:58:55 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so23082112qkc.6
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IR8kl6q02JQVV7/sYzqm1Sm6y7ctVZjq+Lwk1QFsbIY=;
        b=CXPoDUsEGcDQYbZMW+Rn6nD+0PCCPwiwRLZExgj5iUx1tW06qD45DsVfCnJnkTXJeq
         pnTo4s7uRNKDygqcufUAMIrMxLqiKqrqI0a6JW/IKEsTTCLVWji4LA3kwZMTDxoo87WO
         c56vVUR2OKwY9BtXTqUAqdPYnfzp0vBso1Yp5f87ObH63BWUUDhoXA3VjCZlGm+G0Tez
         ZxxRTyWNuUBYDqyUFHkIOv+vUH6Ko0pZH6ANv+x84zO85KRARuwNvLkSzMxU8GAInQz3
         e34Wb2/H97fjDaWiJ9hDjt9zLuisSiK0hmvFMa8F9SpWbG75282gnMNA452o+iG+EC8U
         TrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IR8kl6q02JQVV7/sYzqm1Sm6y7ctVZjq+Lwk1QFsbIY=;
        b=T9WswjXJ/mayN8XGEOXXf2o3cZ2Y2l8T8zzMuC2D9OWuqpl4uM8O8EAZ0X/Czrsy5Q
         yEuR19My5OV497gRUuW6yCkMC2QYLXDz2NKRJh3SpIhZ56xj0nponCBZbBoksMe29ZLR
         ErDX/s+6wdVBHjeNOxpGMAxKPTMrHwk+I5PrW46Xw2tW7dvb9zelgT83iNRuMmiz1R4+
         i+MP+iCNN1+HgG1OPe0+MBYG1zZh4tID4ljNSfzBeupOco8NuKs1XhWioSWA2prCw3rU
         pLlL2EhSgrEa6ktOQDzRN8KByZIqBtD4L7o8txwTpbHvJuvz1R/xxf1zdD62vRTw2ePH
         lkMA==
X-Gm-Message-State: AOAM532PuTB8bEuSzVlVJQ9RSIWG3m5n8da61U7pV6uKBUEvGkdH/KRG
        OO5D3lfyzHakAJYLp8DpXXPt4g==
X-Google-Smtp-Source: ABdhPJzLCTFy8pCLR85PV/ZE79tLd8wUmFZrt7pruhZOb0N5M7MYNCV+YDocdMWsEc9EgXrgW9Dmmg==
X-Received: by 2002:a37:4185:: with SMTP id o127mr34187889qka.478.1596045534623;
        Wed, 29 Jul 2020 10:58:54 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id s128sm2026340qkd.108.2020.07.29.10.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 10:58:54 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        andy.shevchenko@gmail.com, johannes@sipsolutions.net,
        kvalo@codeaurora.org
Subject: [PATCH] lib: kunit: add bitfield test conversion to KUnit
Date:   Wed, 29 Jul 2020 14:58:49 -0300
Message-Id: <20200729175849.148332-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds the conversion of the runtime tests of test_bitfield,
from `lib/test_bitfield.c` to KUnit tests.

Please apply this commit first (linux-kselftest/kunit-fixes):
3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space

Code Style Documentation: [0]

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
Link: [0] https://lore.kernel.org/linux-kselftest/20200620054944.167330-1-davidgow@google.com/T/#u
---
 lib/Kconfig.debug                         | 23 ++++--
 lib/Makefile                              |  2 +-
 lib/{test_bitfield.c => bitfield_kunit.c} | 92 ++++++++++-------------
 3 files changed, 57 insertions(+), 60 deletions(-)
 rename lib/{test_bitfield.c => bitfield_kunit.c} (66%)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210d70a1..16c5574bf103 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1986,13 +1986,6 @@ config TEST_BITMAP
 
 	  If unsure, say N.
 
-config TEST_BITFIELD
-	tristate "Test bitfield functions at runtime"
-	help
-	  Enable this option to test the bitfield functions at boot.
-
-	  If unsure, say N.
-
 config TEST_UUID
 	tristate "Test functions located in the uuid module at runtime"
 
@@ -2142,6 +2135,22 @@ config TEST_SYSCTL
 
 	  If unsure, say N.
 
+config BITFIELD_KUNIT
+	tristate "KUnit test bitfield functions at runtime"
+	depends on KUNIT
+	help
+	  Enable this option to test the bitfield functions at boot.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (http://testanything.org/). Only useful for kernel devs
+	  running the KUnit test harness, and not intended for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config SYSCTL_KUNIT_TEST
 	tristate "KUnit test for sysctl" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index b1c42c10073b..56019c34f5ed 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -84,7 +84,6 @@ obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
-obj-$(CONFIG_TEST_BITFIELD) += test_bitfield.o
 obj-$(CONFIG_TEST_UUID) += test_uuid.o
 obj-$(CONFIG_TEST_XARRAY) += test_xarray.o
 obj-$(CONFIG_TEST_PARMAN) += test_parman.o
@@ -316,5 +315,6 @@ obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
 obj-$(CONFIG_OBJAGG) += objagg.o
 
 # KUnit tests
+obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
diff --git a/lib/test_bitfield.c b/lib/bitfield_kunit.c
similarity index 66%
rename from lib/test_bitfield.c
rename to lib/bitfield_kunit.c
index 5b8f4108662d..d63a2be5aff8 100644
--- a/lib/test_bitfield.c
+++ b/lib/bitfield_kunit.c
@@ -5,8 +5,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/kernel.h>
-#include <linux/module.h>
+#include <kunit/test.h>
 #include <linux/bitfield.h>
 
 #define CHECK_ENC_GET_U(tp, v, field, res) do {				\
@@ -14,13 +13,11 @@
 			u##tp _res;					\
 									\
 			_res = u##tp##_encode_bits(v, field);		\
-			if (_res != res) {				\
-				pr_warn("u" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != " #res "\n",\
-					(u64)_res);			\
-				return -EINVAL;				\
-			}						\
-			if (u##tp##_get_bits(_res, field) != v)		\
-				return -EINVAL;				\
+			KUNIT_ASSERT_FALSE_MSG(context, _res != res,	\
+				       "u" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != " #res "\n",	\
+				       (u64)_res);			\
+			KUNIT_ASSERT_FALSE(context,			\
+				   u##tp##_get_bits(_res, field) != v);	\
 		}							\
 	} while (0)
 
@@ -29,14 +26,13 @@
 			__le##tp _res;					\
 									\
 			_res = le##tp##_encode_bits(v, field);		\
-			if (_res != cpu_to_le##tp(res)) {		\
-				pr_warn("le" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != 0x%llx\n",\
-					(u64)le##tp##_to_cpu(_res),	\
-					(u64)(res));			\
-				return -EINVAL;				\
-			}						\
-			if (le##tp##_get_bits(_res, field) != v)	\
-				return -EINVAL;				\
+			KUNIT_ASSERT_FALSE_MSG(context,			\
+				       _res != cpu_to_le##tp(res),	\
+				       "le" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != 0x%llx",\
+				       (u64)le##tp##_to_cpu(_res),	\
+				       (u64)(res));			\
+			KUNIT_ASSERT_FALSE(context,			\
+				   le##tp##_get_bits(_res, field) != v);\
 		}							\
 	} while (0)
 
@@ -45,14 +41,13 @@
 			__be##tp _res;					\
 									\
 			_res = be##tp##_encode_bits(v, field);		\
-			if (_res != cpu_to_be##tp(res)) {		\
-				pr_warn("be" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != 0x%llx\n",\
-					(u64)be##tp##_to_cpu(_res),	\
-					(u64)(res));			\
-				return -EINVAL;				\
-			}						\
-			if (be##tp##_get_bits(_res, field) != v)	\
-				return -EINVAL;				\
+			KUNIT_ASSERT_FALSE_MSG(context,			\
+				       _res != cpu_to_be##tp(res),	\
+				       "be" #tp "_encode_bits(" #v ", " #field ") is 0x%llx != 0x%llx",	\
+				       (u64)be##tp##_to_cpu(_res),	\
+				       (u64)(res));			\
+			KUNIT_ASSERT_FALSE(context,			\
+				   be##tp##_get_bits(_res, field) != v);\
 		}							\
 	} while (0)
 
@@ -62,7 +57,7 @@
 		CHECK_ENC_GET_BE(tp, v, field, res);			\
 	} while (0)
 
-static int test_constants(void)
+static void __init test_bitfields_constants(struct kunit *context)
 {
 	/*
 	 * NOTE
@@ -95,19 +90,17 @@ static int test_constants(void)
 	CHECK_ENC_GET(64,  7, 0x00f0000000000000ull, 0x0070000000000000ull);
 	CHECK_ENC_GET(64, 14, 0x0f00000000000000ull, 0x0e00000000000000ull);
 	CHECK_ENC_GET(64, 15, 0xf000000000000000ull, 0xf000000000000000ull);
-
-	return 0;
 }
 
 #define CHECK(tp, mask) do {						\
 		u64 v;							\
 									\
 		for (v = 0; v < 1 << hweight32(mask); v++)		\
-			if (tp##_encode_bits(v, mask) != v << __ffs64(mask)) \
-				return -EINVAL;				\
+			KUNIT_ASSERT_FALSE(context,			\
+				tp##_encode_bits(v, mask) != v << __ffs64(mask));\
 	} while (0)
 
-static int test_variables(void)
+static void __init test_bitfields_variables(struct kunit *context)
 {
 	CHECK(u8, 0x0f);
 	CHECK(u8, 0xf0);
@@ -130,39 +123,34 @@ static int test_variables(void)
 	CHECK(u64, 0x000000007f000000ull);
 	CHECK(u64, 0x0000000018000000ull);
 	CHECK(u64, 0x0000001f8000000ull);
-
-	return 0;
 }
 
-static int __init test_bitfields(void)
-{
-	int ret = test_constants();
-
-	if (ret) {
-		pr_warn("constant tests failed!\n");
-		return ret;
-	}
-
-	ret = test_variables();
-	if (ret) {
-		pr_warn("variable tests failed!\n");
-		return ret;
-	}
 
-#ifdef TEST_BITFIELD_COMPILE
+static void __init test_bitfields_compile(struct kunit *context)
+{
 	/* these should fail compilation */
 	CHECK_ENC_GET(16, 16, 0x0f00, 0x1000);
 	u32_encode_bits(7, 0x06000000);
 
 	/* this should at least give a warning */
 	u16_encode_bits(0, 0x60000);
+}
+
+static struct kunit_case __refdata bitfields_test_cases[] = {
+	KUNIT_CASE(test_bitfields_constants),
+	KUNIT_CASE(test_bitfields_variables),
+#ifdef TEST_BITFIELD_COMPILE
+	KUNIT_CASE(test_bitfields_compile),
 #endif
+	{}
+};
 
-	pr_info("tests passed\n");
+static struct kunit_suite bitfields_test_suite = {
+	.name = "bitfields",
+	.test_cases = bitfields_test_cases,
+};
 
-	return 0;
-}
-module_init(test_bitfields)
+kunit_test_suites(&bitfields_test_suite);
 
 MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
 MODULE_LICENSE("GPL");

base-commit: d43c7fb05765152d4d4a39a8ef957c4ea14d8847
-- 
2.26.2

