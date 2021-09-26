Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6F6418B7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Sep 2021 00:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhIZWfZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Sep 2021 18:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhIZWfW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Sep 2021 18:35:22 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB01C061570
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Sep 2021 15:33:46 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id p4so34958825qki.3
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Sep 2021 15:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=blJvberSBtGAgP9ahJKdLib3J1pQn66IrJrwYCfOl4c=;
        b=rjTZUeHw6RrX1AZLRp0U+0mBfHd6l2lMvV6Yfd89cs16P9t16XBegH1+a2wO9GNo70
         LmlV2ALvr5KZPhW2og/Q3/sWSamOCBns+r3B6VXcEekFniWDQ6inIoI9bAYEUIJacdGQ
         cjX2Ft50zwPCl8cQL0IyCyo1LLG5XaCU20vLdKDdk4MkmPsYgSva4zoORtQJrMjE+r58
         eJpB8CiSVnhcdBnjfdcH1zqWR1MC3YF/ImmZDj99Tiyr+YH8LOi5xoaICyOIZtqQiBxb
         fZREims52n2oDSy5XtH10lwPEkMoL6jsd1D+rrLrhS8pc7R3EwHW0QgVhmaQHtSpguQv
         aIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=blJvberSBtGAgP9ahJKdLib3J1pQn66IrJrwYCfOl4c=;
        b=zZewhdWVYH4yjYhJ90ON8frd9ikOTvMtt8D5OTErO8RBBOq2c4LDL9gP0EmJ7ILbiu
         sossuh9egpnN4sGUbKxHSH1GQY7VbAWZLKrsXrv27M6lZUT+R9b3mZj1Ue+3B9tkblIh
         dKH59Ct3QX1C19f7HPPVFLPibCNMNhj+IXQQTa1I63IDAR3B8GV8QSqd+ll8Cyg50/iu
         cx4gHxDkXn44khqAnGoE8CpmMSVp0AXBFNjmLv/rMT77+w33zYDFGb+GV2nh5v2WZAzS
         IGiWQIZVQpvNPWyCfIknmyv7uiUljdH5nXpA6ATktXqR0Kn33A5/VPqV8gc2A81cnUB+
         rL7w==
X-Gm-Message-State: AOAM530dx4L6bbCxkok10BA8uYj29tuE5VNQLIJoUWw8VoqNCPfLzcQc
        itWFExgJ4sXd3H2oY9KsvcHWzQ==
X-Google-Smtp-Source: ABdhPJwDCcZBgln9FPBztXIJpDdpAPiVATTg13vJGl/4tI5x/stUsQ9DSHm8+DLurUpf134IkBANXg==
X-Received: by 2002:ae9:de83:: with SMTP id s125mr21392851qkf.248.1632695625209;
        Sun, 26 Sep 2021 15:33:45 -0700 (PDT)
Received: from aehse.localdomain ([2804:d41:bd1c:9100:f2e1:f671:7a83:1eb8])
        by smtp.gmail.com with ESMTPSA id x6sm7244151qts.79.2021.09.26.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:33:44 -0700 (PDT)
From:   Isabella Basso <isabellabdoamaral@usp.br>
To:     geert@linux-m68k.org
Cc:     ferreiraenzoa@gmail.com, augusto.duraes33@gmail.com,
        brendanhiggins@google.com, dlatypov@google.com,
        davidgow@google.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        ~lkcamp/patches@lists.sr.ht, rodrigosiqueiramelo@gmail.com,
        Isabella Basso <isabellabdoamaral@usp.br>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 5/5] test_hash.c: refactor into kunit
Date:   Sun, 26 Sep 2021 19:33:22 -0300
Message-Id: <20210926223322.848641-6-isabellabdoamaral@usp.br>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210926223322.848641-1-isabellabdoamaral@usp.br>
References: <20210926223322.848641-1-isabellabdoamaral@usp.br>
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

Changes since v1:
- As suggested by David Gow:
  1. Keep module support.
  2. Reword commit message.
- As reported by the kernel test bot:
  1. Fix compilation for m68k and parisc architectures.

Reported-by: kernel test robot <lkp@intel.com>
Tested-by: David Gow <davidgow@google.com>
Co-developed-by: Augusto Durães Camargo <augusto.duraes33@gmail.com>
Signed-off-by: Augusto Durães Camargo <augusto.duraes33@gmail.com>
Co-developed-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
Signed-off-by: Enzo Ferreira <ferreiraenzoa@gmail.com>
Signed-off-by: Isabella Basso <isabellabdoamaral@usp.br>
---
 lib/Kconfig.debug |  28 ++++---
 lib/Makefile      |   2 +-
 lib/test_hash.c   | 187 ++++++++++++++--------------------------------
 3 files changed, 78 insertions(+), 139 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index eb6c4daf5fcb..04eec87c2964 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2204,15 +2204,6 @@ config TEST_RHASHTABLE
 
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
@@ -2361,6 +2352,25 @@ config BITFIELD_KUNIT
 
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
index db9dd18b4e8b..9cb8b1d2ab06 100644
--- a/lib/test_hash.c
+++ b/lib/test_hash.c
@@ -14,14 +14,12 @@
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
 static u32 __init __attribute_const__
@@ -66,40 +64,32 @@ struct test_hash_params {
 };
 
 #ifdef HAVE_ARCH__HASH_32
-static bool __init
-test_int__hash_32(struct test_hash_params *params)
+static void __init
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
+static void __init
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
 
@@ -112,8 +102,8 @@ test_int_hash_64(struct test_hash_params *params, u32 const *m, int *k)
  * inline, the code being tested is actually in the module, and you can
  * recompile and re-test the module without rebooting.
  */
-static bool __init
-test_int_hash(unsigned long long h64, u32 hash_or[2][33])
+static void __init
+test_int_hash(struct kunit *test, unsigned long long h64, u32 hash_or[2][33])
 {
 	int k;
 	struct test_hash_params params = { &h64, (u32)h64, 0, 0, hash_or };
@@ -121,8 +111,7 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
 	/* Test __hash32 */
 	hash_or[0][0] |= params.h1 = __hash_32(params.h0);
 #ifdef HAVE_ARCH__HASH_32
-	if (!test_int__hash_32(&params))
-		return false;
+	test_int__hash_32(test, &params);
 #endif
 
 	/* Test k = 1..32 bits */
@@ -131,29 +120,24 @@ test_int_hash(unsigned long long h64, u32 hash_or[2][33])
 
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
+static void __init test_string_or(struct kunit *test)
 {
 	char buf[SIZE+1];
 	u32 string_or = 0;
@@ -173,20 +157,15 @@ static int __init test_string_or(void)
 	} /* j */
 
 	/* The OR of all the hash values should cover all the bits */
-	if (~string_or) {
-		pr_err("OR of all string hash results = %#x != %#x",
-		       string_or, -1u);
-		return -EINVAL;
-	}
-
-	return 0;
+	KUNIT_EXPECT_FALSE_MSG(test, ~string_or,
+			       "OR of all string hash results = %#x != %#x",
+			       string_or, -1u);
 }
 
-static int __init test_hash_or(void)
+static void __init test_hash_or(struct kunit *test)
 {
 	char buf[SIZE+1];
 	u32 hash_or[2][33] = { { 0, } };
-	unsigned tests = 0;
 	unsigned long long h64 = 0;
 	int i, j;
 
@@ -201,39 +180,27 @@ static int __init test_hash_or(void)
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
+	KUNIT_EXPECT_FALSE_MSG(test, ~hash_or[0][0],
+			       "OR of all __hash_32 results = %#x != %#x",
+			       hash_or[0][0], -1u);
 #ifdef HAVE_ARCH__HASH_32
 #if HAVE_ARCH__HASH_32 != 1	/* Test is pointless if results match */
-	if (~hash_or[1][0]) {
-		pr_err("OR of all __hash_32_generic results = %#x != %#x",
-			hash_or[1][0], -1u);
-		return -EINVAL;
-	}
+	KUNIT_EXPECT_FALSE_MSG(test, ~hash_or[1][0],
+			       "OR of all __hash_32_generic results = %#x != %#x",
+			       hash_or[1][0], -1u);
 #endif
 #endif
 
@@ -241,65 +208,27 @@ static int __init test_hash_or(void)
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
-}
-
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
 }
 
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
2.33.0

