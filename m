Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697553F7FE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Aug 2021 03:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbhHZB1o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 21:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbhHZB1n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 21:27:43 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AE8C0613C1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:26:57 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a66so1677638qkc.1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Aug 2021 18:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PbE2qfFBe6GYsESxfnvqNdhyVyD92IjDvn8DjhZslDM=;
        b=D79nZV86emSiTJ4o+M2dkx+eEA0XD/Q4el8sDyGUdTPC/AYBSKRZWQSVOrQuhVm9Kk
         +pu8ApPjWVFYJhGwi+iSaLQTyXcaAMgMlG3ODp7hkLQ7hmha5ZNhiYnnAaV4a670oz4v
         8JSVQq/9UjrOM3prRLCbOuQeuULrypHL3z4ViKjxVdTtZtuiqSWZklUQ3tFtvgtDGc/U
         OLNqUqqj5kRFekXMBUIZmcdLdzbQPsHT+VOQyDUWEu62ChSX2QypMO2AdXvJgiG3GmRi
         TWrCOVeDLWT/IvEBj2ZjXPyRIzLOjpL9HisPqMyBsmIW07Q2G58M6ZeVJ8bzGcjsbCgO
         HTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PbE2qfFBe6GYsESxfnvqNdhyVyD92IjDvn8DjhZslDM=;
        b=Rfl+zVf+bEQ7KvhI1M8tGHMdbUpVAKNjyvOPpjZLtUKM7aIOplykFi5y6SSiH3uTvK
         m4RxwJ0pxzCZwCwE0m46BJmxSrihp+0kVEC93ymg8tETCSFsunstO80zTIThcL9g7u9k
         MTXMw2DpsipB/fyWw1h6MUYF1mCU5I6oCyLEtiuEJQqw/kswVF4Ws/KMyPlZ7dDkorjd
         7LD9THuqhabaKPwvEDj41B3Ahq2K62gQWxqX22EspKVUpWccjWtJ/0AxuQTebxfNoUvq
         zWdUx6LIUIWED+WjPdvJTAB0fdMDrW8SwUw4CfoNzjGfhQJTQ0txSTVMJAB+8DJxc52m
         v/LA==
X-Gm-Message-State: AOAM53326GO0SHb/+Jeiclarbs4PqAP5xfKdae/tDH73GobIPQNLMm/5
        TDOtWmR6wQqMpYBpWAJjgULu8Q==
X-Google-Smtp-Source: ABdhPJz9oQRN3zhWVZyBfF+URj1GACWGeD105/MZy1aeE23hmNqVSavp+ikwVZXUzpRQowcUiF8PbQ==
X-Received: by 2002:a05:620a:2549:: with SMTP id s9mr1455470qko.256.1629941216216;
        Wed, 25 Aug 2021 18:26:56 -0700 (PDT)
Received: from aehse.localdomain (177-209-76-11.user3p.veloxzone.com.br. [177.209.76.11])
        by smtp.gmail.com with ESMTPSA id p123sm1375053qke.94.2021.08.25.18.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 18:26:55 -0700 (PDT)
From:   Isabella Basso <isabellabdoamaral@usp.br>
To:     linux@sciencehorizons.net, geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabellabdoamaral@usp.br>
Subject: [PATCH 6/6] test_hash.c: refactor into kunit
Date:   Wed, 25 Aug 2021 22:26:26 -0300
Message-Id: <20210826012626.1163705-7-isabellabdoamaral@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
References: <20210826012626.1163705-1-isabellabdoamaral@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use KUnit framework to make tests more easily integrable with CIs. Even
though these tests are not yet properly written as unit tests this
change should help in debugging.

Also drop module support and remove kernel messages (i.e. through
pr_info) as KUnit handles all debugging output.

Co-developed-by: Augusto Durães Camargo <augusto.duraes33@gmail.com>
Signed-off-by: Augusto Durães Camargo <augusto.duraes33@gmail.com>
Co-developed-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
Signed-off-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
---
 lib/Kconfig.debug |  28 ++++---
 lib/Makefile      |   2 +-
 lib/test_hash.c   | 197 ++++++++++++++--------------------------------
 3 files changed, 79 insertions(+), 148 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5e5894d98c50..adefb03a7e16 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2221,15 +2221,6 @@ config TEST_RHASHTABLE
 
 	  If unsure, say N.
 
-config TEST_HASH
-	tristate "Perform selftest on hash functions"
-	help
-	  Enable this option to test the kernel's integer (<linux/hash.h>), and
-	  string (<linux/stringhash.h>) hash functions on boot (or module load).
-
-	  This is intended to help people writing architecture-specific
-	  optimized versions.  If unsure, say N.
-
 config TEST_SIPHASH
 	tristate "Perform selftest on siphash functions"
 	help
@@ -2378,6 +2369,25 @@ config BITFIELD_KUNIT
 
 	  If unsure, say N.
 
+config HASH_KUNIT_TEST
+	tristate "KUnit Test for integer hash functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test the kernel's string (<linux/stringhash.h>), and
+	  integer (<linux/hash.h>) hash functions on boot.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (https://testanything.org/). Only useful for kernel devs
+	  running the KUnit test harness, and not intended for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  This is intended to help people writing architecture-specific
+	  optimized versions. If unsure, say N.
+
 config RESOURCE_KUNIT_TEST
 	tristate "KUnit test for resource API"
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index c2e81d0eb31c..0bc336d9d036 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -62,7 +62,7 @@ obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
 CFLAGS_test_bitops.o += -Werror
 obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
 obj-$(CONFIG_TEST_SIPHASH) += test_siphash.o
-obj-$(CONFIG_TEST_HASH) += test_hash.o
+obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
 obj-$(CONFIG_TEST_IDA) += test_ida.o
 obj-$(CONFIG_KASAN_KUNIT_TEST) += test_kasan.o
 CFLAGS_test_kasan.o += -fno-builtin
diff --git a/lib/test_hash.c b/lib/test_hash.c
index c168823b0963..84590bbf47dc 100644
--- a/lib/test_hash.c
+++ b/lib/test_hash.c
@@ -14,14 +14,10 @@
  * and hash_64().
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt "\n"
-
-#include <linux/compiler.h>
 #include <linux/types.h>
-#include <linux/module.h>
 #include <linux/hash.h>
 #include <linux/stringhash.h>
-#include <linux/printk.h>
+#include <kunit/test.h>
 
 #define SIZE 256 /* Run time is cubic in SIZE */
 
@@ -29,7 +25,7 @@ static u32 string_or; /* stores or-ed string output */
 static u32 hash_or[2][33] = { { 0, } }; /* stores or-ed hash output */
 
 /* 32-bit XORSHIFT generator.  Seed must not be zero. */
-static u32 __init __attribute_const__
+static u32 __attribute_const__
 xorshift(u32 seed)
 {
 	seed ^= seed << 13;
@@ -39,7 +35,7 @@ xorshift(u32 seed)
 }
 
 /* Given a non-zero x, returns a non-zero byte. */
-static u8 __init __attribute_const__
+static u8 __attribute_const__
 mod255(u32 x)
 {
 	x = (x & 0xffff) + (x >> 16);	/* 1 <= x <= 0x1fffe */
@@ -50,8 +46,7 @@ mod255(u32 x)
 }
 
 /* Fill the buffer with non-zero bytes. */
-static void __init
-fill_buf(char *buf, size_t len, u32 seed)
+static void fill_buf(char *buf, size_t len, u32 seed)
 {
 	size_t i;
 
@@ -62,41 +57,31 @@ fill_buf(char *buf, size_t len, u32 seed)
 }
 
 #ifdef HAVE_ARCH__HASH_32
-static bool __init
-test_int_hash32(u32 *h0, u32 *h1, u32 *h2)
+static bool test_int_hash32(struct kunit *test, u32 *h0, u32 *h1, u32 *h2)
 {
 	hash_or[1][0] |= *h2 = __hash_32_generic(h0);
 #if HAVE_ARCH__HASH_32 == 1
-	if (*h1 != *h2) {
-		pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
-		       *h0, *h1, *h2);
-		return false;
-	}
+	KUNIT_ASSERT_EQ_MSG(test, *h1, *h2,
+			    "__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
+			    *h0, *h1, *h2);
 #endif
-	return true;
 }
 #endif
 
 #ifdef HAVE_ARCH_HASH_64
-static bool __init
-test_int_hash64(unsigned long long h64, u32 *h0, u32 *h1, u32 *h2, u32 const *m, int k)
+static bool test_int_hash64(struct kunit *test, unsigned long long h64, u32 *h0, u32 *h1,
+		u32 *h2, u32 const *m, int k)
 {
 	*h2 = hash_64_generic(*h64, *k);
 #if HAVE_ARCH_HASH_64 == 1
-	if (*h1 != *h2) {
-		pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() = %#x",
-		       *h64, *k, *h1, *h2);
-		return false;
-	}
+	KUNIT_ASSERT_EQ_MSG(test, *h1, *h2,
+			    "hash_64(%#llx, %d) = %#x != hash_64_generic() = %#x",
+			    *h64, *k, *h1, *h2);
 #else
-	if (*h2 > *m) {
-		pr_err("hash_64_generic(%#llx, %d) = %#x > %#x",
-		       *h64, *k, *h1, *m);
-		return false;
-	}
+	KUNIT_ASSERT_LE_MSG(test, *h1, *h2,
+			    "hash_64_generic(%#llx, %d) = %#x > %#x",
+			    *h64, *k, *h1, *m);
 #endif
-	return true;
-
 }
 #endif
 
@@ -109,8 +94,7 @@ test_int_hash64(unsigned long long h64, u32 *h0, u32 *h1, u32 *h2, u32 const *m,
  * inline, the code being tested is actually in the module, and you can
  * recompile and re-test the module without rebooting.
  */
-static bool __init
-test_int_hash(unsigned long long h64)
+static void test_int_hash(struct kunit *test, unsigned long long h64)
 {
 	int k;
 	u32 h0 = (u32)h64, h1;
@@ -122,7 +106,7 @@ test_int_hash(unsigned long long h64)
 	/* Test __hash32 */
 	hash_or[0][0] |= h1 = __hash_32(h0);
 #ifdef HAVE_ARCH__HASH_32
-	if (!test_int_hash32(&h0, &h1, &h2))
+	if (!test_int_hash32(test, &h0, &h1, &h2))
 		return false;
 #endif
 
@@ -132,27 +116,22 @@ test_int_hash(unsigned long long h64)
 
 		/* Test hash_32 */
 		hash_or[0][k] |= h1 = hash_32(h0, k);
-		if (h1 > m) {
-			pr_err("hash_32(%#x, %d) = %#x > %#x", h0, k, h1, m);
-			return false;
-		}
+		KUNIT_ASSERT_LE_MSG(test, h1, m,
+				    "hash_32(%#x, %d) = %#x > %#x",
+				    h0, k, h1, m);
 
 		/* Test hash_64 */
 		hash_or[1][k] |= h1 = hash_64(h64, k);
-		if (h1 > m) {
-			pr_err("hash_64(%#llx, %d) = %#x > %#x", h64, k, h1, m);
-			return false;
-		}
+		KUNIT_ASSERT_LE_MSG(test, h1, m,
+				    "hash_64(%#llx, %d) = %#x > %#x",
+				    h64, k, h1, m);
 #ifdef HAVE_ARCH_HASH_64
-		if (!test_int_hash64(&h64, &h0, &h1, &h2, &m, &k))
-			return false;
+		test_int_hash64(test, &h64, &h0, &h1, &h2, &m, &k);
 #endif
 	}
-
-	return true;
 }
 
-static int __init test_string_or(void)
+static void test_string_or(struct kunit *test)
 {
 	char buf[SIZE+1];
 	int i, j;
@@ -173,19 +152,14 @@ static int __init test_string_or(void)
 	} /* j */
 
 	/* The OR of all the hash values should cover all the bits */
-	if (~string_or) {
-		pr_err("OR of all string hash results = %#x != %#x",
-		       string_or, -1u);
-		return -EINVAL;
-	}
-
-	return 0;
+	KUNIT_ASSERT_FALSE_MSG(test, ~string_or,
+			      "OR of all string hash results = %#x != %#x",
+			      string_or, -1u);
 }
 
-static int __init test_hash_or(void)
+static void test_hash_or(struct kunit *test)
 {
 	char buf[SIZE+1];
-	unsigned tests = 0;
 	unsigned long long h64 = 0;
 	int i, j;
 
@@ -201,39 +175,27 @@ static int __init test_hash_or(void)
 			u32 h0 = full_name_hash(buf+i, buf+i, j-i);
 
 			/* Check that hashlen_string gets the length right */
-			if (hashlen_len(hashlen) != j-i) {
-				pr_err("hashlen_string(%d..%d) returned length"
-				       " %u, expected %d",
-				       i, j, hashlen_len(hashlen), j-i);
-				return -EINVAL;
-			}
+			KUNIT_ASSERT_EQ_MSG(test, hashlen_len(hashlen), j-i,
+					    "hashlen_string(%d..%d) returned length %u, expected %d",
+					    i, j, hashlen_len(hashlen), j-i);
 			/* Check that the hashes match */
-			if (hashlen_hash(hashlen) != h0) {
-				pr_err("hashlen_string(%d..%d) = %08x != "
-				       "full_name_hash() = %08x",
-				       i, j, hashlen_hash(hashlen), h0);
-				return -EINVAL;
-			}
+			KUNIT_ASSERT_EQ_MSG(test, hashlen_hash(hashlen), h0,
+					    "hashlen_string(%d..%d) = %08x != full_name_hash() = %08x",
+					    i, j, hashlen_hash(hashlen), h0);
 
 			h64 = h64 << 32 | h0;	/* For use with hash_64 */
-			if (!test_int_hash(h64))
-				return -EINVAL;
-			tests++;
+			test_int_hash(test, h64);
 		} /* i */
 	} /* j */
 
-	if (~hash_or[0][0]) {
-		pr_err("OR of all __hash_32 results = %#x != %#x",
-		       hash_or[0][0], -1u);
-		return -EINVAL;
-	}
+	KUNIT_ASSERT_FALSE_MSG(test, ~hash_or[0][0],
+			       "OR of all __hash_32 results = %#x != %#x",
+			       hash_or[0][0], -1u);
 #ifdef HAVE_ARCH__HASH_32
 #if HAVE_ARCH__HASH_32 != 1	/* Test is pointless if results match */
-	if (~hash_or[1][0]) {
-		pr_err("OR of all __hash_32_generic results = %#x != %#x",
-		       hash_or[1][0], -1u);
-		return -EINVAL;
-	}
+	KUNIT_ASSERT_FALSE_MSG(test, ~hash_or[1][0],
+			       "OR of all __hash_32_generic results = %#x != %#x",
+			       hash_or[1][0], -1u);
 #endif
 #endif
 
@@ -241,65 +203,24 @@ static int __init test_hash_or(void)
 	for (i = 1; i <= 32; i++) {
 		u32 const m = ((u32)2 << (i-1)) - 1;	/* Low i bits set */
 
-		if (hash_or[0][i] != m) {
-			pr_err("OR of all hash_32(%d) results = %#x "
-			       "(%#x expected)", i, hash_or[0][i], m);
-			return -EINVAL;
-		}
-		if (hash_or[1][i] != m) {
-			pr_err("OR of all hash_64(%d) results = %#x "
-			       "(%#x expected)", i, hash_or[1][i], m);
-			return -EINVAL;
-		}
+		KUNIT_ASSERT_EQ_MSG(test, hash_or[0][i], m,
+				    "OR of all hash_32(%d) results = %#x (%#x expected)",
+				    i, hash_or[0][i], m);
+		KUNIT_ASSERT_EQ_MSG(test, hash_or[1][i], m,
+				    "OR of all hash_64(%d) results = %#x (%#x expected)",
+				    i, hash_or[1][i], m);
 	}
-
-	pr_notice("%u tests passed.", tests);
-
-	return 0;
 }
 
-static void __init notice_skipped_tests(void)
-{
-	/* Issue notices about skipped tests. */
-#ifdef HAVE_ARCH__HASH_32
-#if HAVE_ARCH__HASH_32 != 1
-	pr_info("__hash_32() is arch-specific; not compared to generic.");
-#endif
-#else
-	pr_info("__hash_32() has no arch implementation to test.");
-#endif
-#ifdef HAVE_ARCH_HASH_64
-#if HAVE_ARCH_HASH_64 != 1
-	pr_info("hash_64() is arch-specific; not compared to generic.");
-#endif
-#else
-	pr_info("hash_64() has no arch implementation to test.");
-#endif
-}
-
-static int __init
-test_hash_init(void)
-{
-	int ret;
-
-	ret = test_string_or();
-	if (ret < 0)
-		return ret;
-
-	ret = test_hash_or();
-	if (ret < 0)
-		return ret;
-
-	notice_skipped_tests();
-
-	return ret;
-}
-
-static void __exit test_hash_exit(void)
-{
-}
+static struct kunit_case hash_test_cases[] = {
+	KUNIT_CASE(test_string_or),
+	KUNIT_CASE(test_hash_or),
+	{}
+};
 
-module_init(test_hash_init);	/* Does everything */
-module_exit(test_hash_exit);	/* Does nothing */
+static struct kunit_suite hash_test_suite = {
+	.name = "hash_tests",
+	.test_cases = hash_test_cases,
+};
 
-MODULE_LICENSE("GPL");
+kunit_test_suite(hash_test_suite);
-- 
2.33.0

