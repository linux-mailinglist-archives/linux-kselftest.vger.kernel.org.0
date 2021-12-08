Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B75546DB42
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 19:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbhLHSl1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 13:41:27 -0500
Received: from mx1.riseup.net ([198.252.153.129]:54722 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239082AbhLHSlW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 13:41:22 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4J8Qrs4vVYzF4fq;
        Wed,  8 Dec 2021 10:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1638988669; bh=ZX8Vo9OhbrdhzWqnRrnm2308GXPTxjp4l/X1oTpKFDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=amptQi0lOSuG5PBb0Bt9XkNMRYFdGkX/6bA4vfxcC0FPBPflMcBYFm6mNzNFgHlfe
         vcVu4Nn2Y8mEPs+1npoTkV8OkrcmFQ4o+58tLcH43MktbOPUROgD2tzCidTPxOSqGQ
         mKHHNVyI+L0Yf4092NraJ9WP4/xP8gjWXgtseCRI=
X-Riseup-User-ID: 7560746CF860497DEF262AD34A9CAA3D66E044DB26784A8888E9D338F1A9ADF6
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4J8Qrp0GNxz5vcG;
        Wed,  8 Dec 2021 10:37:45 -0800 (PST)
From:   Isabella Basso <isabbasso@riseup.net>
To:     geert@linux-m68k.org, brendanhiggins@google.com,
        dlatypov@google.com, davidgow@google.com,
        akpm@linux-foundation.org, skhan@linuxfoundation.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, ~lkcamp/patches@lists.sr.ht,
        rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabbasso@riseup.net>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH RESEND v3 5/5] test_hash.c: refactor into kunit
Date:   Wed,  8 Dec 2021 15:37:11 -0300
Message-Id: <20211208183711.390454-6-isabbasso@riseup.net>
In-Reply-To: <20211208183711.390454-1-isabbasso@riseup.net>
References: <20211208183711.390454-1-isabbasso@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use KUnit framework to make tests more easily integrable with CIs. Even
though these tests are not yet properly written as unit tests this
change should help in debugging.

Also remove kernel messages (i.e. through pr_info) as KUnit handles all
debugging output and let it handle module init and exit details.

Reviewed-by: David Gow <davidgow@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Tested-by: David Gow <davidgow@google.com>
Co-developed-by: Augusto Durães Camargo <augusto.duraes33@gmail.com>
Signed-off-by: Augusto Durães Camargo <augusto.duraes33@gmail.com>
Co-developed-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
Signed-off-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
Signed-off-by: Isabella Basso <isabbasso@riseup.net>
---
Changes since v2:
- As suggested by David Gow:
  1. Remove unnecessary __init from functions.
  2. Change KUnit's "EXPECT_FALSE"s for "EXPECT_EQ"s.
Changes since v1:
- As suggested by David Gow:
  1. Keep module support.
  2. Reword commit message.
- As reported by the kernel test bot:
  1. Fix compilation for m68k and parisc architectures.

 lib/Kconfig.debug |  28 ++++---
 lib/Makefile      |   2 +-
 lib/test_hash.c   | 194 +++++++++++++++-------------------------------
 3 files changed, 81 insertions(+), 143 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e5f43d423bc9..3f56f5ab007a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2206,15 +2206,6 @@ config TEST_RHASHTABLE
 
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
@@ -2363,6 +2354,25 @@ config BITFIELD_KUNIT
 
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
index f3a2a251471d..511c27827701 100644
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
index 032849a48da7..bb25fda34794 100644
--- a/lib/test_hash.c
+++ b/lib/test_hash.c
@@ -14,17 +14,15 @@
  * and hash_64().
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt "\n"
-
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/hash.h>
 #include <linux/stringhash.h>
-#include <linux/printk.h>
+#include <kunit/test.h>
 
 /* 32-bit XORSHIFT generator.  Seed must not be zero. */
-static u32 __init __attribute_const__
+static u32 __attribute_const__
 xorshift(u32 seed)
 {
 	seed ^= seed << 13;
@@ -34,7 +32,7 @@ xorshift(u32 seed)
 }
 
 /* Given a non-zero x, returns a non-zero byte. */
-static u8 __init __attribute_const__
+static u8 __attribute_const__
 mod255(u32 x)
 {
 	x = (x & 0xffff) + (x >> 16);	/* 1 <= x <= 0x1fffe */
@@ -45,8 +43,7 @@ mod255(u32 x)
 }
 
 /* Fill the buffer with non-zero bytes. */
-static void __init
-fill_buf(char *buf, size_t len, u32 seed)
+static void fill_buf(char *buf, size_t len, u32 seed)
 {
 	size_t i;
 
@@ -71,40 +68,32 @@ struct test_hash_params {
 };
 
 #ifdef HAVE_ARCH__HASH_32
-static bool __init
-test_int__hash_32(struct test_hash_params *params)
+static void
+test_int__hash_32(struct kunit *test, struct test_hash_params *params)
 {
 	params->hash_or[1][0] |= params->h2 = __hash_32_generic(params->h0);
 #if HAVE_ARCH__HASH_32 == 1
-	if (params->h1 != params->h2) {
-		pr_err("__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
-		       params->h0, params->h1, params->h2);
-		return false;
-	}
+	KUNIT_EXPECT_EQ_MSG(test, params->h1, params->h2,
+			    "__hash_32(%#x) = %#x != __hash_32_generic() = %#x",
+			    params->h0, params->h1, params->h2);
 #endif
-	return true;
 }
 #endif
 
 #ifdef HAVE_ARCH_HASH_64
-static bool __init
-test_int_hash_64(struct test_hash_params *params, u32 const *m, int *k)
+static void
+test_int_hash_64(struct kunit *test, struct test_hash_params *params, u32 const *m, int *k)
 {
 	params->h2 = hash_64_generic(*params->h64, *k);
 #if HAVE_ARCH_HASH_64 == 1
-	if (params->h1 != params->h2) {
-		pr_err("hash_64(%#llx, %d) = %#x != hash_64_generic() = %#x",
-		       *params->h64, *k, params->h1, params->h2);
-		return false;
-	}
+	KUNIT_EXPECT_EQ_MSG(test, params->h1, params->h2,
+			    "hash_64(%#llx, %d) = %#x != hash_64_generic() = %#x",
+			    *params->h64, *k, params->h1, params->h2);
 #else
-	if (params->h2 > *m) {
-		pr_err("hash_64_generic(%#llx, %d) = %#x > %#x",
-		       *params->h64, *k, params->h1, *m);
-		return false;
-	}
+	KUNIT_EXPECT_LE_MSG(test, params->h1, params->h2,
+			    "hash_64_generic(%#llx, %d) = %#x > %#x",
+			    *params->h64, *k, params->h1, *m);
 #endif
-	return true;
 }
 #endif
 
@@ -117,8 +106,8 @@ test_int_hash_64(struct test_hash_params *params, u32 const *m, int *k)
  * inline, the code being tested is actually in the module, and you can
  * recompile and re-test the module without rebooting.
  */
-static bool __init
-test_int_hash(unsigned long long h64, u32 hash_or[2][33])
+static void
+test_int_hash(struct kunit *test, unsigned long long h64, u32 hash_or[2][33])
 {
 	int k;
 	struct test_hash_params params = { &h64, (u32)h64, 0, 0, hash_or };
@@ -126,8 +115,7 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
 	/* Test __hash32 */
 	hash_or[0][0] |= params.h1 = __hash_32(params.h0);
 #ifdef HAVE_ARCH__HASH_32
-	if (!test_int__hash_32(&params))
-		return false;
+	test_int__hash_32(test, &params);
 #endif
 
 	/* Test k = 1..32 bits */
@@ -136,29 +124,24 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
 
 		/* Test hash_32 */
 		hash_or[0][k] |= params.h1 = hash_32(params.h0, k);
-		if (params.h1 > m) {
-			pr_err("hash_32(%#x, %d) = %#x > %#x", params.h0, k, params.h1, m);
-			return false;
-		}
+		KUNIT_EXPECT_LE_MSG(test, params.h1, m,
+				    "hash_32(%#x, %d) = %#x > %#x",
+				    params.h0, k, params.h1, m);
 
 		/* Test hash_64 */
 		hash_or[1][k] |= params.h1 = hash_64(h64, k);
-		if (params.h1 > m) {
-			pr_err("hash_64(%#llx, %d) = %#x > %#x", h64, k, params.h1, m);
-			return false;
-		}
+		KUNIT_EXPECT_LE_MSG(test, params.h1, m,
+				    "hash_64(%#llx, %d) = %#x > %#x",
+				    h64, k, params.h1, m);
 #ifdef HAVE_ARCH_HASH_64
-		if (!test_int_hash_64(&params, &m, &k))
-			return false;
+		test_int_hash_64(test, &params, &m, &k);
 #endif
 	}
-
-	return true;
 }
 
 #define SIZE 256	/* Run time is cubic in SIZE */
 
-static int __init test_string_or(void)
+static void test_string_or(struct kunit *test)
 {
 	char buf[SIZE+1];
 	u32 string_or = 0;
@@ -178,20 +161,15 @@ static int __init test_string_or(void)
 	} /* j */
 
 	/* The OR of all the hash values should cover all the bits */
-	if (~string_or) {
-		pr_err("OR of all string hash results = %#x != %#x",
-		       string_or, -1u);
-		return -EINVAL;
-	}
-
-	return 0;
+	KUNIT_EXPECT_EQ_MSG(test, string_or, -1u,
+			    "OR of all string hash results = %#x != %#x",
+			    string_or, -1u);
 }
 
-static int __init test_hash_or(void)
+static void test_hash_or(struct kunit *test)
 {
 	char buf[SIZE+1];
 	u32 hash_or[2][33] = { { 0, } };
-	unsigned tests = 0;
 	unsigned long long h64 = 0;
 	int i, j;
 
@@ -206,39 +184,27 @@ static int __init test_hash_or(void)
 			u32 h0 = full_name_hash(buf+i, buf+i, j-i);
 
 			/* Check that hashlen_string gets the length right */
-			if (hashlen_len(hashlen) != j-i) {
-				pr_err("hashlen_string(%d..%d) returned length"
-					" %u, expected %d",
-					i, j, hashlen_len(hashlen), j-i);
-				return -EINVAL;
-			}
+			KUNIT_EXPECT_EQ_MSG(test, hashlen_len(hashlen), j-i,
+					    "hashlen_string(%d..%d) returned length %u, expected %d",
+					    i, j, hashlen_len(hashlen), j-i);
 			/* Check that the hashes match */
-			if (hashlen_hash(hashlen) != h0) {
-				pr_err("hashlen_string(%d..%d) = %08x != "
-					"full_name_hash() = %08x",
-					i, j, hashlen_hash(hashlen), h0);
-				return -EINVAL;
-			}
+			KUNIT_EXPECT_EQ_MSG(test, hashlen_hash(hashlen), h0,
+					    "hashlen_string(%d..%d) = %08x != full_name_hash() = %08x",
+					    i, j, hashlen_hash(hashlen), h0);
 
 			h64 = h64 << 32 | h0;	/* For use with hash_64 */
-			if (!test_int_hash(h64, hash_or))
-				return -EINVAL;
-			tests++;
+			test_int_hash(test, h64, hash_or);
 		} /* i */
 	} /* j */
 
-	if (~hash_or[0][0]) {
-		pr_err("OR of all __hash_32 results = %#x != %#x",
-			hash_or[0][0], -1u);
-		return -EINVAL;
-	}
+	KUNIT_EXPECT_EQ_MSG(test, hash_or[0][0], -1u,
+			    "OR of all __hash_32 results = %#x != %#x",
+			    hash_or[0][0], -1u);
 #ifdef HAVE_ARCH__HASH_32
 #if HAVE_ARCH__HASH_32 != 1	/* Test is pointless if results match */
-	if (~hash_or[1][0]) {
-		pr_err("OR of all __hash_32_generic results = %#x != %#x",
-			hash_or[1][0], -1u);
-		return -EINVAL;
-	}
+	KUNIT_EXPECT_EQ_MSG(test, hash_or[1][0], -1u,
+			    "OR of all __hash_32_generic results = %#x != %#x",
+			    hash_or[1][0], -1u);
 #endif
 #endif
 
@@ -246,65 +212,27 @@ static int __init test_hash_or(void)
 	for (i = 1; i <= 32; i++) {
 		u32 const m = ((u32)2 << (i-1)) - 1;	/* Low i bits set */
 
-		if (hash_or[0][i] != m) {
-			pr_err("OR of all hash_32(%d) results = %#x "
-				"(%#x expected)", i, hash_or[0][i], m);
-			return -EINVAL;
-		}
-		if (hash_or[1][i] != m) {
-			pr_err("OR of all hash_64(%d) results = %#x "
-				"(%#x expected)", i, hash_or[1][i], m);
-			return -EINVAL;
-		}
+		KUNIT_EXPECT_EQ_MSG(test, hash_or[0][i], m,
+				    "OR of all hash_32(%d) results = %#x (%#x expected)",
+				    i, hash_or[0][i], m);
+		KUNIT_EXPECT_EQ_MSG(test, hash_or[1][i], m,
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
+static struct kunit_case hash_test_cases[] __refdata = {
+	KUNIT_CASE(test_string_or),
+	KUNIT_CASE(test_hash_or),
+	{}
+};
 
-	return ret;
-}
+static struct kunit_suite hash_test_suite = {
+	.name = "hash",
+	.test_cases = hash_test_cases,
+};
 
-static void __exit test_hash_exit(void)
-{
-}
 
-module_init(test_hash_init);	/* Does everything */
-module_exit(test_hash_exit);	/* Does nothing */
+kunit_test_suite(hash_test_suite);
 
 MODULE_LICENSE("GPL");
-- 
2.34.1

