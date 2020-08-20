Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D3924C78C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Aug 2020 00:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHTWGH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Aug 2020 18:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgHTWGC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Aug 2020 18:06:02 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C82C061386;
        Thu, 20 Aug 2020 15:06:02 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c6so2949941ilo.13;
        Thu, 20 Aug 2020 15:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DzG5wNvIiElD5ig1Fzkuaob5nmroEr2fSQQ8nLhwOlg=;
        b=ob+ZIoDQv0++jw2FtN0RkOhURwOOrJKdKw+JyUWM/kDqk5Si3/fQgOHtIi1r6UwYPe
         WNe/OyatWM39FiRo59Kz3RnKJDGNSdS9r2hIEIvWlgcsOizt298LPSf8ayBCC7fbT3Pj
         Z7unfzBgcQeo79quSBUIZzQKlmI8f2PsetFpysAXacODjqZc39YF036q7gWpPSpzvXnW
         OvqDUJ+abxwvI7bJrDM6HJyGmlWyUQ6vYW60GRVlAT9tiR2sh5Q+Dy5QPABGgqHfoBai
         Ea02qQzFcaawVrH9jdnS6zvLI1sV+/BocgioGW1vgu50YsSok/h/szX3os4vZtA5Hdfv
         g7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzG5wNvIiElD5ig1Fzkuaob5nmroEr2fSQQ8nLhwOlg=;
        b=VpIibwgu8K1etUElTrArHRt+tvjiPasU10UJaH2eqdC5SbzxIMi2FXbgjqxrNrxQ/I
         b1a3lV0C9Hh5OCRZrDgETcYlxFR2v8CV1ONwQ21XCjVt35G8UXqVREiNT+aDViY8nY3t
         B7plHqD3Mh/HO9uDx+AjYpbWbdQjluSRaD13m1Ea5v6rYQWihevlrm1zuxDzH3zAnUgI
         /q4YWJSPXtoDGasCm5iCJngARUCozrVYkSBuAZ56CxWIET4wwft7swstTJmoCYgzz7XM
         s8hUAqoSEd+KRY7zJsEHRckWS4ZwTk0yUiSe9iDITlW6XBIAiHKD1v8EfDD9cT2TtEw9
         emCQ==
X-Gm-Message-State: AOAM530eXrh3EnGXFUrSpfL8Pf/bNbRwWJEfA1PhKdcskYydExun0oRf
        QTvyli+djxVqrdDgl0SXrIPmhE4Ft56chw==
X-Google-Smtp-Source: ABdhPJz0cLp2ifcpQ06WZItz/8AV4PeS5zxBtPimniRBTpwS5c0w/X/wDS6T+Lb4KYlwLtrbbFVZMQ==
X-Received: by 2002:a05:6e02:ef3:: with SMTP id j19mr135251ilk.88.1597961161668;
        Thu, 20 Aug 2020 15:06:01 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id u124sm2162827iod.20.2020.08.20.15.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:06:01 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com
Cc:     urielguajardo@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kunit: port UBSAN tests to KUnit
Date:   Thu, 20 Aug 2020 22:05:52 +0000
Message-Id: <20200820220552.3427995-2-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200820220552.3427995-1-urielguajardojr@gmail.com>
References: <20200820220552.3427995-1-urielguajardojr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Uriel Guajardo <urielguajardo@google.com>

UBSAN tests are ported to the KUnit testing framework using the tool failure
expectation feature added to KUnit.

I've commented out test_ubsan_divrem_overflow and
test_ubsan_out_of_bounds since they both consistently crash the kernel.
The former gives me a divide error and the latter gives a corrupted kernel
stack error. If this is only on my end, let me know.

Kconfig file is reformatted according the KUnit naming guidelines:
https://lore.kernel.org/linux-kselftest/20200702071416.1780522-1-davidgow@google.com/

Requires "kunit: UBSAN integration":
https://lore.kernel.org/linux-kselftest/20200813205722.1384108-2-urielguajardojr@gmail.com/

Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
---
 lib/Kconfig.ubsan | 12 ++++--
 lib/Makefile      |  2 +-
 lib/test_ubsan.c  | 96 ++++++++++++++++++++++++-----------------------
 lib/ubsan.c       |  2 +-
 4 files changed, 59 insertions(+), 53 deletions(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 774315de555a..aab5fbecd19a 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -80,11 +80,15 @@ config UBSAN_ALIGNMENT
 	  Enabling this option on architectures that support unaligned
 	  accesses may produce a lot of false positives.
 
-config TEST_UBSAN
-	tristate "Module for testing for undefined behavior detection"
-	depends on m
+config UBSAN_KUNIT_TEST
+	tristate "Tests for undefined behavior detection" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
-	  This is a test module for UBSAN.
+	  This is a test suite for UBSAN using the KUnit testing framework.
 	  It triggers various undefined behavior, and detect it.
 
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit
+
 endif	# if UBSAN
diff --git a/lib/Makefile b/lib/Makefile
index b1c42c10073b..8b1a134f5bf1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -67,7 +67,7 @@ obj-$(CONFIG_TEST_IDA) += test_ida.o
 obj-$(CONFIG_TEST_KASAN) += test_kasan.o
 CFLAGS_test_kasan.o += -fno-builtin
 CFLAGS_test_kasan.o += $(call cc-disable-warning, vla)
-obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
+obj-$(CONFIG_UBSAN_KUNIT_TEST) += test_ubsan.o
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
 UBSAN_SANITIZE_test_ubsan.o := y
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
index 9ea10adf7a66..ec724cddf005 100644
--- a/lib/test_ubsan.c
+++ b/lib/test_ubsan.c
@@ -2,63 +2,65 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <kunit/test.h>
 
-typedef void(*test_ubsan_fp)(void);
+#define KUNIT_EXPECT_UBSAN_FAIL(test, condition) \
+	KUNIT_EXPECT_TOOL_FAIL(test, condition, UBSAN)
 
-static void test_ubsan_add_overflow(void)
+static void test_ubsan_add_overflow(struct kunit *test)
 {
 	volatile int val = INT_MAX;
 
-	val += 2;
+	KUNIT_EXPECT_UBSAN_FAIL(test, val += 2);
 }
 
-static void test_ubsan_sub_overflow(void)
+static void test_ubsan_sub_overflow(struct kunit *test)
 {
 	volatile int val = INT_MIN;
 	volatile int val2 = 2;
 
-	val -= val2;
+	KUNIT_EXPECT_UBSAN_FAIL(test, val -= val2);
 }
 
-static void test_ubsan_mul_overflow(void)
+static void test_ubsan_mul_overflow(struct kunit *test)
 {
 	volatile int val = INT_MAX / 2;
 
-	val *= 3;
+	KUNIT_EXPECT_UBSAN_FAIL(test, val *= 3);
 }
 
-static void test_ubsan_negate_overflow(void)
+static void test_ubsan_negate_overflow(struct kunit *test)
 {
 	volatile int val = INT_MIN;
 
-	val = -val;
+	KUNIT_EXPECT_UBSAN_FAIL(test, val = -val);
 }
 
-static void test_ubsan_divrem_overflow(void)
+static void test_ubsan_divrem_overflow(struct kunit *test)
 {
 	volatile int val = 16;
 	volatile int val2 = 0;
 
-	val /= val2;
+	KUNIT_EXPECT_UBSAN_FAIL(test, val /= val2);
 }
 
-static void test_ubsan_shift_out_of_bounds(void)
+static void test_ubsan_shift_out_of_bounds(struct kunit *test)
 {
 	volatile int val = -1;
 	int val2 = 10;
 
-	val2 <<= val;
+	KUNIT_EXPECT_UBSAN_FAIL(test, val2 <<= val);
 }
 
-static void test_ubsan_out_of_bounds(void)
+static void test_ubsan_out_of_bounds(struct kunit *test)
 {
 	volatile int i = 4, j = 5;
 	volatile int arr[4];
 
-	arr[j] = i;
+	KUNIT_EXPECT_UBSAN_FAIL(test, arr[j] = i);
 }
 
-static void test_ubsan_load_invalid_value(void)
+static void test_ubsan_load_invalid_value(struct kunit *test)
 {
 	volatile char *dst, *src;
 	bool val, val2, *ptr;
@@ -69,10 +71,10 @@ static void test_ubsan_load_invalid_value(void)
 	*dst = *src;
 
 	ptr = &val2;
-	val2 = val;
+	KUNIT_EXPECT_UBSAN_FAIL(test, val2 = val);
 }
 
-static void test_ubsan_null_ptr_deref(void)
+static void test_ubsan_null_ptr_deref(struct kunit *test)
 {
 	volatile int *ptr = NULL;
 	int val;
@@ -80,56 +82,56 @@ static void test_ubsan_null_ptr_deref(void)
 	val = *ptr;
 }
 
-static void test_ubsan_misaligned_access(void)
+static void test_ubsan_misaligned_access(struct kunit *test)
 {
 	volatile char arr[5] __aligned(4) = {1, 2, 3, 4, 5};
 	volatile int *ptr, val = 6;
 
 	ptr = (int *)(arr + 1);
-	*ptr = val;
+	KUNIT_EXPECT_UBSAN_FAIL(test, *ptr = val);
 }
 
-static void test_ubsan_object_size_mismatch(void)
+static void test_ubsan_object_size_mismatch(struct kunit *test)
 {
 	/* "((aligned(8)))" helps this not into be misaligned for ptr-access. */
 	volatile int val __aligned(8) = 4;
 	volatile long long *ptr, val2;
 
 	ptr = (long long *)&val;
-	val2 = *ptr;
+	KUNIT_EXPECT_UBSAN_FAIL(test, val2 = *ptr);
 }
 
-static const test_ubsan_fp test_ubsan_array[] = {
-	test_ubsan_add_overflow,
-	test_ubsan_sub_overflow,
-	test_ubsan_mul_overflow,
-	test_ubsan_negate_overflow,
-	test_ubsan_divrem_overflow,
-	test_ubsan_shift_out_of_bounds,
-	test_ubsan_out_of_bounds,
-	test_ubsan_load_invalid_value,
-	//test_ubsan_null_ptr_deref, /* exclude it because there is a crash */
-	test_ubsan_misaligned_access,
-	test_ubsan_object_size_mismatch,
+static struct kunit_case ubsan_test_cases[] = {
+	KUNIT_CASE(test_ubsan_add_overflow),
+	KUNIT_CASE(test_ubsan_sub_overflow),
+	KUNIT_CASE(test_ubsan_mul_overflow),
+	KUNIT_CASE(test_ubsan_negate_overflow),
+	//KUNIT_CASE(test_ubsan_divrem_overflow), /* exclude because it crashes*/
+	KUNIT_CASE(test_ubsan_shift_out_of_bounds),
+	//KUNIT_CASE(test_ubsan_out_of_bounds), /* exclude because it crashes */
+	KUNIT_CASE(test_ubsan_load_invalid_value),
+	//KUNIT_CASE(test_ubsan_null_ptr_deref), /* exclude because it crashes */
+	KUNIT_CASE(test_ubsan_misaligned_access),
+	KUNIT_CASE(test_ubsan_object_size_mismatch),
+	{}
 };
 
-static int __init test_ubsan_init(void)
+static int test_ubsan_init(struct kunit *test)
 {
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(test_ubsan_array); i++)
-		test_ubsan_array[i]();
-
-	(void)test_ubsan_null_ptr_deref; /* to avoid unsed-function warning */
+	/* Avoid unused-function warnings */
+	(void)test_ubsan_divrem_overflow;
+	(void)test_ubsan_out_of_bounds;
+	(void)test_ubsan_null_ptr_deref;
 	return 0;
 }
-module_init(test_ubsan_init);
 
-static void __exit test_ubsan_exit(void)
-{
-	/* do nothing */
-}
-module_exit(test_ubsan_exit);
+static struct kunit_suite ubsan_test_suite = {
+	.name = "ubsan",
+	.init = test_ubsan_init,
+	.test_cases = ubsan_test_cases,
+};
+
+kunit_test_suites(&ubsan_test_suite);
 
 MODULE_AUTHOR("Jinbum Park <jinb.park7@gmail.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/lib/ubsan.c b/lib/ubsan.c
index 1460e2c828c8..9fe357eb1e81 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -138,7 +138,7 @@ static void ubsan_prologue(struct source_location *loc, const char *reason)
 {
 	current->in_ubsan++;
 
-	kunit_fail_current_test();
+	kunit_fail_from_tool(UBSAN);
 	pr_err("========================================"
 		"========================================\n");
 	pr_err("UBSAN: %s in %s:%d:%d\n", reason, loc->file_name,
-- 
2.28.0.297.g1956fa8f8d-goog

