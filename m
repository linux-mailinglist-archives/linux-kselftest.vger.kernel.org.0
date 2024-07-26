Return-Path: <linux-kselftest+bounces-14268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AB793D1AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 13:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7071F22980
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0233A1791EF;
	Fri, 26 Jul 2024 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JKdOSqdg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7BD17838A;
	Fri, 26 Jul 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992051; cv=none; b=qjkxBLIWcpBcS6TyBciAmyndAFlbWHOaHED4WF9hA5SfAIobfvXrhwdUP/3AFV/pPXgq2Y3VrqRaQ7zPpPqvyGeZs/xwyyb+1t3CjdpDUeComQx4D6yH9ml1JstDidY9G4DnUYZZBaWFO8SghheIYBcOsJyxA43NtQMtVAzqBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992051; c=relaxed/simple;
	bh=ZmbkccuC2IUGnezpbBgFySm9fatixIidqcy8Cv/zLE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kBKEAmin6tt+hmvnFoJydNepQnCWiLaKI3vq1Vwpgc+rIT7P1W48+hX5gDXFKGnRc8Gbcn+EzyVM/6qsnqIKY/sUtrZEuP7m1ZScBvketsHy7p1XHjTG1OJIcZIuDf05OWi3KFYlv+bRVqIXIFZFt95VHA6vCOIWAXYgsXiyI3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JKdOSqdg; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721992047;
	bh=ZmbkccuC2IUGnezpbBgFySm9fatixIidqcy8Cv/zLE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JKdOSqdge3QyY/XRXMTgK0tMZydEwCCPT6NPsm6XFb2yEdjKXDRBLEQtJuQxP/WZs
	 0PHTwwQpKcI9KmEdsL50rJwX4MA9V2BlOKcsPZk8yMTyuRYIDFBTrh57rNTHt7/9qC
	 OISw+9zpvXlLqeatTWW5QPov+8vSEYz6Pkxe/8I2YvRXjLjjY/2pxT8zvi9dgcYGaO
	 Ooo9ahbY/xwBt1lZlxeSbOB3lyfifVc5+JONOlJuwccI54kpcGnbwXj0isIocff3MC
	 JictKUOtyx1sOJxWHuqziJ2SB8Qy8qRTtQ2OF+b0THqKjsFOPqoT6Sc1bmmxg6BTz8
	 0gvChh3amvL9g==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EDB2037821C0;
	Fri, 26 Jul 2024 11:07:21 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kees@kernel.org,
	David Gow <davidgow@google.com>,
	John Hubbard <jhubbard@nvidia.com>
Cc: kernel@collabora.com
Subject: [PATCH 1/3] bitmap: convert test_bitmap to KUnit test
Date: Fri, 26 Jul 2024 16:06:56 +0500
Message-Id: <20240726110658.2281070-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240726110658.2281070-1-usama.anjum@collabora.com>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the test_bitmap to Kunit test in-place (without moving the file
so that changes can be reviewed esaily). The test has been converted
from kselftest module helper functions to kunit. Following major changes
were done to achieve this:
- Convert the init logic
- Remove all __init* as kunit tests can be called multiple times
- Use KUNIT_ASSERT_* macros for determining results.

Cc: kees@kernel.org
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 lib/test_bitmap.c | 624 +++++++++++++++++++++-------------------------
 1 file changed, 284 insertions(+), 340 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 65a75d58ed9e4..41c82b8339ffc 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -13,17 +13,14 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
-
-#include "../tools/testing/selftests/kselftest_module.h"
+#include <kunit/test.h>
 
 #define EXP1_IN_BITS	(sizeof(exp1) * 8)
 
-KSTM_MODULE_GLOBALS();
-
-static char pbl_buffer[PAGE_SIZE] __initdata;
-static char print_buf[PAGE_SIZE * 2] __initdata;
+static char pbl_buffer[PAGE_SIZE];
+static char print_buf[PAGE_SIZE * 2];
 
-static const unsigned long exp1[] __initconst = {
+static const unsigned long exp1[] = {
 	BITMAP_FROM_U64(1),
 	BITMAP_FROM_U64(2),
 	BITMAP_FROM_U64(0x0000ffff),
@@ -41,70 +38,59 @@ static const unsigned long exp1[] __initconst = {
 	BITMAP_FROM_U64(0x80000000),
 };
 
-static const unsigned long exp2[] __initconst = {
+static const unsigned long exp2[] = {
 	BITMAP_FROM_U64(0x3333333311111111ULL),
 	BITMAP_FROM_U64(0xffffffff77777777ULL),
 };
 
 /* Fibonacci sequence */
-static const unsigned long exp2_to_exp3_mask[] __initconst = {
+static const unsigned long exp2_to_exp3_mask[] = {
 	BITMAP_FROM_U64(0x008000020020212eULL),
 };
 /* exp3_0_1 = (exp2[0] & ~exp2_to_exp3_mask) | (exp2[1] & exp2_to_exp3_mask) */
-static const unsigned long exp3_0_1[] __initconst = {
+static const unsigned long exp3_0_1[] = {
 	BITMAP_FROM_U64(0x33b3333311313137ULL),
 };
 /* exp3_1_0 = (exp2[1] & ~exp2_to_exp3_mask) | (exp2[0] & exp2_to_exp3_mask) */
-static const unsigned long exp3_1_0[] __initconst = {
+static const unsigned long exp3_1_0[] = {
 	BITMAP_FROM_U64(0xff7fffff77575751ULL),
 };
 
-static bool __init
-__check_eq_ulong(const char *srcfile, unsigned int line,
+static void
+__check_eq_ulong(struct kunit *test, const char *srcfile, unsigned int line,
 		 const unsigned long exp_ulong, unsigned long x)
 {
-	if (exp_ulong != x) {
-		pr_err("[%s:%u] expected %lu, got %lu\n",
-			srcfile, line, exp_ulong, x);
-		return false;
-	}
-	return true;
+	KUNIT_ASSERT_EQ_MSG(test, exp_ulong, x,
+			    "[%s:%u] expected %lu, got %lu\n",
+			    srcfile, line, exp_ulong, x);
 }
 
-static bool __init
-__check_eq_bitmap(const char *srcfile, unsigned int line,
+static void
+__check_eq_bitmap(struct kunit *test, const char *srcfile, unsigned int line,
 		  const unsigned long *exp_bmap, const unsigned long *bmap,
 		  unsigned int nbits)
 {
-	if (!bitmap_equal(exp_bmap, bmap, nbits)) {
-		pr_warn("[%s:%u] bitmaps contents differ: expected \"%*pbl\", got \"%*pbl\"\n",
-			srcfile, line,
-			nbits, exp_bmap, nbits, bmap);
-		return false;
-	}
-	return true;
+	KUNIT_ASSERT_TRUE_MSG(test, bitmap_equal(exp_bmap, bmap, nbits),
+			      "[%s:%u] bitmaps contents differ: expected \"%*pbl\", got \"%*pbl\"\n",
+			      srcfile, line, nbits, exp_bmap, nbits, bmap);
 }
 
-static bool __init
-__check_eq_pbl(const char *srcfile, unsigned int line,
+static void
+__check_eq_pbl(struct kunit *test, const char *srcfile, unsigned int line,
 	       const char *expected_pbl,
 	       const unsigned long *bitmap, unsigned int nbits)
 {
 	snprintf(pbl_buffer, sizeof(pbl_buffer), "%*pbl", nbits, bitmap);
-	if (strcmp(expected_pbl, pbl_buffer)) {
-		pr_warn("[%s:%u] expected \"%s\", got \"%s\"\n",
-			srcfile, line,
-			expected_pbl, pbl_buffer);
-		return false;
-	}
-	return true;
+	KUNIT_ASSERT_STREQ_MSG(test, expected_pbl, pbl_buffer,
+			       "[%s:%u] expected \"%s\", got \"%s\"\n",
+			       srcfile, line, expected_pbl, pbl_buffer);
 }
 
-static bool __init
+static bool
 __check_eq_u32_array(const char *srcfile, unsigned int line,
 		     const u32 *exp_arr, unsigned int exp_len,
 		     const u32 *arr, unsigned int len) __used;
-static bool __init
+static bool
 __check_eq_u32_array(const char *srcfile, unsigned int line,
 		     const u32 *exp_arr, unsigned int exp_len,
 		     const u32 *arr, unsigned int len)
@@ -128,100 +114,82 @@ __check_eq_u32_array(const char *srcfile, unsigned int line,
 	return true;
 }
 
-static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
-				    const unsigned int offset,
-				    const unsigned int size,
-				    const unsigned char *const clump_exp,
-				    const unsigned long *const clump)
+static void __check_eq_clump8(struct kunit *test, const char *srcfile, unsigned int line,
+			      const unsigned int offset,
+			      const unsigned int size,
+			      const unsigned char *const clump_exp,
+			      const unsigned long *const clump)
 {
 	unsigned long exp;
 
-	if (offset >= size) {
-		pr_warn("[%s:%u] bit offset for clump out-of-bounds: expected less than %u, got %u\n",
-			srcfile, line, size, offset);
-		return false;
-	}
+	KUNIT_ASSERT_LE_MSG(test, offset, size,
+			    "[%s:%u] bit offset for clump out-of-bounds: expected less than %u, got %u\n",
+			    srcfile, line, size, offset);
 
 	exp = clump_exp[offset / 8];
-	if (!exp) {
-		pr_warn("[%s:%u] bit offset for zero clump: expected nonzero clump, got bit offset %u with clump value 0",
-			srcfile, line, offset);
-		return false;
-	}
-
-	if (*clump != exp) {
-		pr_warn("[%s:%u] expected clump value of 0x%lX, got clump value of 0x%lX",
-			srcfile, line, exp, *clump);
-		return false;
-	}
+	KUNIT_ASSERT_TRUE_MSG(test, exp,
+			      "[%s:%u] bit offset for zero clump: expected nonzero clump, got bit offset %u with clump value 0",
+			      srcfile, line, offset);
 
-	return true;
+	KUNIT_ASSERT_EQ_MSG(test, *clump, exp,
+			    "[%s:%u] expected clump value of 0x%lX, got clump value of 0x%lX",
+			    srcfile, line, exp, *clump);
 }
 
-static bool __init
-__check_eq_str(const char *srcfile, unsigned int line,
-		const char *exp_str, const char *str,
-		unsigned int len)
+static void
+__check_eq_str(struct kunit *test, const char *srcfile, unsigned int line,
+	       const char *exp_str, const char *str,
+	       unsigned int len)
 {
-	bool eq;
+	KUNIT_EXPECT_STREQ_MSG(test, exp_str, str,
+			       "[%s:%u] expected %s, got %s\n",
+			       srcfile, line, exp_str, str);
 
-	eq = strncmp(exp_str, str, len) == 0;
-	if (!eq)
-		pr_err("[%s:%u] expected %s, got %s\n", srcfile, line, exp_str, str);
-
-	return eq;
 }
 
-#define __expect_eq(suffix, ...)					\
+#define __expect_eq(test, suffix, ...)					\
 	({								\
-		int result = 0;						\
-		total_tests++;						\
-		if (!__check_eq_ ## suffix(__FILE__, __LINE__,		\
-					   ##__VA_ARGS__)) {		\
-			failed_tests++;					\
-			result = 1;					\
-		}							\
-		result;							\
+		__check_eq_ ## suffix(test, __FILE__, __LINE__,		\
+					   ##__VA_ARGS__);		\
 	})
 
-#define expect_eq_ulong(...)		__expect_eq(ulong, ##__VA_ARGS__)
-#define expect_eq_uint(x, y)		expect_eq_ulong((unsigned int)(x), (unsigned int)(y))
-#define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
-#define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
-#define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
-#define expect_eq_clump8(...)		__expect_eq(clump8, ##__VA_ARGS__)
-#define expect_eq_str(...)		__expect_eq(str, ##__VA_ARGS__)
+#define expect_eq_ulong(test, ...)	__expect_eq(test, ulong, ##__VA_ARGS__)
+#define expect_eq_uint(test, x, y)	expect_eq_ulong(test, (unsigned int)(x), (unsigned int)(y))
+#define expect_eq_bitmap(test, ...)	__expect_eq(test, bitmap, ##__VA_ARGS__)
+#define expect_eq_pbl(test, ...)	__expect_eq(test, pbl, ##__VA_ARGS__)
+#define expect_eq_clump8(test, ...)	__expect_eq(test, clump8, ##__VA_ARGS__)
+#define expect_eq_str(test, ...)	__expect_eq(test, str, ##__VA_ARGS__)
 
-static void __init test_zero_clear(void)
+static void test_zero_clear(struct kunit *test)
 {
 	DECLARE_BITMAP(bmap, 1024);
 
 	/* Known way to set all bits */
 	memset(bmap, 0xff, 128);
 
-	expect_eq_pbl("0-22", bmap, 23);
-	expect_eq_pbl("0-1023", bmap, 1024);
+	expect_eq_pbl(test, "0-22", bmap, 23);
+	expect_eq_pbl(test, "0-1023", bmap, 1024);
 
 	/* single-word bitmaps */
 	bitmap_clear(bmap, 0, 9);
-	expect_eq_pbl("9-1023", bmap, 1024);
+	expect_eq_pbl(test, "9-1023", bmap, 1024);
 
 	bitmap_zero(bmap, 35);
-	expect_eq_pbl("64-1023", bmap, 1024);
+	expect_eq_pbl(test, "64-1023", bmap, 1024);
 
 	/* cross boundaries operations */
 	bitmap_clear(bmap, 79, 19);
-	expect_eq_pbl("64-78,98-1023", bmap, 1024);
+	expect_eq_pbl(test, "64-78,98-1023", bmap, 1024);
 
 	bitmap_zero(bmap, 115);
-	expect_eq_pbl("128-1023", bmap, 1024);
+	expect_eq_pbl(test, "128-1023", bmap, 1024);
 
 	/* Zeroing entire area */
 	bitmap_zero(bmap, 1024);
-	expect_eq_pbl("", bmap, 1024);
+	expect_eq_pbl(test, "", bmap, 1024);
 }
 
-static void __init test_find_nth_bit(void)
+static void test_find_nth_bit(struct kunit *test)
 {
 	unsigned long b, bit, cnt = 0;
 	DECLARE_BITMAP(bmap, 64 * 3);
@@ -236,62 +204,62 @@ static void __init test_find_nth_bit(void)
 	__set_bit(80, bmap);
 	__set_bit(123, bmap);
 
-	expect_eq_uint(10,  find_nth_bit(bmap, 64 * 3, 0));
-	expect_eq_uint(20,  find_nth_bit(bmap, 64 * 3, 1));
-	expect_eq_uint(30,  find_nth_bit(bmap, 64 * 3, 2));
-	expect_eq_uint(40,  find_nth_bit(bmap, 64 * 3, 3));
-	expect_eq_uint(50,  find_nth_bit(bmap, 64 * 3, 4));
-	expect_eq_uint(60,  find_nth_bit(bmap, 64 * 3, 5));
-	expect_eq_uint(80,  find_nth_bit(bmap, 64 * 3, 6));
-	expect_eq_uint(123, find_nth_bit(bmap, 64 * 3, 7));
-	expect_eq_uint(0,   !!(find_nth_bit(bmap, 64 * 3, 8) < 64 * 3));
-
-	expect_eq_uint(10,  find_nth_bit(bmap, 64 * 3 - 1, 0));
-	expect_eq_uint(20,  find_nth_bit(bmap, 64 * 3 - 1, 1));
-	expect_eq_uint(30,  find_nth_bit(bmap, 64 * 3 - 1, 2));
-	expect_eq_uint(40,  find_nth_bit(bmap, 64 * 3 - 1, 3));
-	expect_eq_uint(50,  find_nth_bit(bmap, 64 * 3 - 1, 4));
-	expect_eq_uint(60,  find_nth_bit(bmap, 64 * 3 - 1, 5));
-	expect_eq_uint(80,  find_nth_bit(bmap, 64 * 3 - 1, 6));
-	expect_eq_uint(123, find_nth_bit(bmap, 64 * 3 - 1, 7));
-	expect_eq_uint(0,   !!(find_nth_bit(bmap, 64 * 3 - 1, 8) < 64 * 3 - 1));
+	expect_eq_uint(test, 10,  find_nth_bit(bmap, 64 * 3, 0));
+	expect_eq_uint(test, 20,  find_nth_bit(bmap, 64 * 3, 1));
+	expect_eq_uint(test, 30,  find_nth_bit(bmap, 64 * 3, 2));
+	expect_eq_uint(test, 40,  find_nth_bit(bmap, 64 * 3, 3));
+	expect_eq_uint(test, 50,  find_nth_bit(bmap, 64 * 3, 4));
+	expect_eq_uint(test, 60,  find_nth_bit(bmap, 64 * 3, 5));
+	expect_eq_uint(test, 80,  find_nth_bit(bmap, 64 * 3, 6));
+	expect_eq_uint(test, 123, find_nth_bit(bmap, 64 * 3, 7));
+	expect_eq_uint(test, 0,   !!(find_nth_bit(bmap, 64 * 3, 8) < 64 * 3));
+
+	expect_eq_uint(test, 10,  find_nth_bit(bmap, 64 * 3 - 1, 0));
+	expect_eq_uint(test, 20,  find_nth_bit(bmap, 64 * 3 - 1, 1));
+	expect_eq_uint(test, 30,  find_nth_bit(bmap, 64 * 3 - 1, 2));
+	expect_eq_uint(test, 40,  find_nth_bit(bmap, 64 * 3 - 1, 3));
+	expect_eq_uint(test, 50,  find_nth_bit(bmap, 64 * 3 - 1, 4));
+	expect_eq_uint(test, 60,  find_nth_bit(bmap, 64 * 3 - 1, 5));
+	expect_eq_uint(test, 80,  find_nth_bit(bmap, 64 * 3 - 1, 6));
+	expect_eq_uint(test, 123, find_nth_bit(bmap, 64 * 3 - 1, 7));
+	expect_eq_uint(test, 0,   !!(find_nth_bit(bmap, 64 * 3 - 1, 8) < 64 * 3 - 1));
 
 	for_each_set_bit(bit, exp1, EXP1_IN_BITS) {
 		b = find_nth_bit(exp1, EXP1_IN_BITS, cnt++);
-		expect_eq_uint(b, bit);
+		expect_eq_uint(test, b, bit);
 	}
 }
 
-static void __init test_fill_set(void)
+static void test_fill_set(struct kunit *test)
 {
 	DECLARE_BITMAP(bmap, 1024);
 
 	/* Known way to clear all bits */
 	memset(bmap, 0x00, 128);
 
-	expect_eq_pbl("", bmap, 23);
-	expect_eq_pbl("", bmap, 1024);
+	expect_eq_pbl(test, "", bmap, 23);
+	expect_eq_pbl(test, "", bmap, 1024);
 
 	/* single-word bitmaps */
 	bitmap_set(bmap, 0, 9);
-	expect_eq_pbl("0-8", bmap, 1024);
+	expect_eq_pbl(test, "0-8", bmap, 1024);
 
 	bitmap_fill(bmap, 35);
-	expect_eq_pbl("0-63", bmap, 1024);
+	expect_eq_pbl(test, "0-63", bmap, 1024);
 
 	/* cross boundaries operations */
 	bitmap_set(bmap, 79, 19);
-	expect_eq_pbl("0-63,79-97", bmap, 1024);
+	expect_eq_pbl(test, "0-63,79-97", bmap, 1024);
 
 	bitmap_fill(bmap, 115);
-	expect_eq_pbl("0-127", bmap, 1024);
+	expect_eq_pbl(test, "0-127", bmap, 1024);
 
 	/* Zeroing entire area */
 	bitmap_fill(bmap, 1024);
-	expect_eq_pbl("0-1023", bmap, 1024);
+	expect_eq_pbl(test, "0-1023", bmap, 1024);
 }
 
-static void __init test_copy(void)
+static void test_copy(struct kunit *test)
 {
 	DECLARE_BITMAP(bmap1, 1024);
 	DECLARE_BITMAP(bmap2, 1024);
@@ -302,20 +270,20 @@ static void __init test_copy(void)
 	/* single-word bitmaps */
 	bitmap_set(bmap1, 0, 19);
 	bitmap_copy(bmap2, bmap1, 23);
-	expect_eq_pbl("0-18", bmap2, 1024);
+	expect_eq_pbl(test, "0-18", bmap2, 1024);
 
 	bitmap_set(bmap2, 0, 23);
 	bitmap_copy(bmap2, bmap1, 23);
-	expect_eq_pbl("0-18", bmap2, 1024);
+	expect_eq_pbl(test, "0-18", bmap2, 1024);
 
 	/* multi-word bitmaps */
 	bitmap_set(bmap1, 0, 109);
 	bitmap_copy(bmap2, bmap1, 1024);
-	expect_eq_pbl("0-108", bmap2, 1024);
+	expect_eq_pbl(test, "0-108", bmap2, 1024);
 
 	bitmap_fill(bmap2, 1024);
 	bitmap_copy(bmap2, bmap1, 1024);
-	expect_eq_pbl("0-108", bmap2, 1024);
+	expect_eq_pbl(test, "0-108", bmap2, 1024);
 
 	/* the following tests assume a 32- or 64-bit arch (even 128b
 	 * if we care)
@@ -323,14 +291,14 @@ static void __init test_copy(void)
 
 	bitmap_fill(bmap2, 1024);
 	bitmap_copy(bmap2, bmap1, 109);  /* ... but 0-padded til word length */
-	expect_eq_pbl("0-108,128-1023", bmap2, 1024);
+	expect_eq_pbl(test, "0-108,128-1023", bmap2, 1024);
 
 	bitmap_fill(bmap2, 1024);
 	bitmap_copy(bmap2, bmap1, 97);  /* ... but aligned on word length */
-	expect_eq_pbl("0-108,128-1023", bmap2, 1024);
+	expect_eq_pbl(test, "0-108,128-1023", bmap2, 1024);
 }
 
-static void __init test_bitmap_region(void)
+static void test_bitmap_region(struct kunit *test)
 {
 	int pos, order;
 
@@ -341,21 +309,21 @@ static void __init test_bitmap_region(void)
 	for (order = 0; order < 10; order++) {
 		pos = bitmap_find_free_region(bmap, 1000, order);
 		if (order == 0)
-			expect_eq_uint(pos, 0);
+			expect_eq_uint(test, pos, 0);
 		else
-			expect_eq_uint(pos, order < 9 ? BIT(order) : -ENOMEM);
+			expect_eq_uint(test, pos, order < 9 ? BIT(order) : -ENOMEM);
 	}
 
 	bitmap_release_region(bmap, 0, 0);
 	for (order = 1; order < 9; order++)
 		bitmap_release_region(bmap, BIT(order), order);
 
-	expect_eq_uint(bitmap_weight(bmap, 1000), 0);
+	expect_eq_uint(test, bitmap_weight(bmap, 1000), 0);
 }
 
 #define EXP2_IN_BITS	(sizeof(exp2) * 8)
 
-static void __init test_replace(void)
+static void test_replace(struct kunit *test)
 {
 	unsigned int nbits = 64;
 	unsigned int nlongs = DIV_ROUND_UP(nbits, BITS_PER_LONG);
@@ -365,38 +333,38 @@ static void __init test_replace(void)
 
 	bitmap_zero(bmap, 1024);
 	bitmap_replace(bmap, &exp2[0 * nlongs], &exp2[1 * nlongs], exp2_to_exp3_mask, nbits);
-	expect_eq_bitmap(bmap, exp3_0_1, nbits);
+	expect_eq_bitmap(test, bmap, exp3_0_1, nbits);
 
 	bitmap_zero(bmap, 1024);
 	bitmap_replace(bmap, &exp2[1 * nlongs], &exp2[0 * nlongs], exp2_to_exp3_mask, nbits);
-	expect_eq_bitmap(bmap, exp3_1_0, nbits);
+	expect_eq_bitmap(test, bmap, exp3_1_0, nbits);
 
 	bitmap_fill(bmap, 1024);
 	bitmap_replace(bmap, &exp2[0 * nlongs], &exp2[1 * nlongs], exp2_to_exp3_mask, nbits);
-	expect_eq_bitmap(bmap, exp3_0_1, nbits);
+	expect_eq_bitmap(test, bmap, exp3_0_1, nbits);
 
 	bitmap_fill(bmap, 1024);
 	bitmap_replace(bmap, &exp2[1 * nlongs], &exp2[0 * nlongs], exp2_to_exp3_mask, nbits);
-	expect_eq_bitmap(bmap, exp3_1_0, nbits);
+	expect_eq_bitmap(test, bmap, exp3_1_0, nbits);
 }
 
-static const unsigned long sg_mask[] __initconst = {
+static const unsigned long sg_mask[] = {
 	BITMAP_FROM_U64(0x000000000000035aULL),
 };
 
-static const unsigned long sg_src[] __initconst = {
+static const unsigned long sg_src[] = {
 	BITMAP_FROM_U64(0x0000000000000667ULL),
 };
 
-static const unsigned long sg_gather_exp[] __initconst = {
+static const unsigned long sg_gather_exp[] = {
 	BITMAP_FROM_U64(0x0000000000000029ULL),
 };
 
-static const unsigned long sg_scatter_exp[] __initconst = {
+static const unsigned long sg_scatter_exp[] = {
 	BITMAP_FROM_U64(0x000000000000021aULL),
 };
 
-static void __init test_bitmap_sg(void)
+static void test_bitmap_sg(struct kunit *test)
 {
 	unsigned int nbits = 64;
 	DECLARE_BITMAP(bmap_gather, 100);
@@ -407,18 +375,18 @@ static void __init test_bitmap_sg(void)
 	/* Simple gather call */
 	bitmap_zero(bmap_gather, 100);
 	bitmap_gather(bmap_gather, sg_src, sg_mask, nbits);
-	expect_eq_bitmap(sg_gather_exp, bmap_gather, nbits);
+	expect_eq_bitmap(test, sg_gather_exp, bmap_gather, nbits);
 
 	/* Simple scatter call */
 	bitmap_zero(bmap_scatter, 100);
 	bitmap_scatter(bmap_scatter, sg_src, sg_mask, nbits);
-	expect_eq_bitmap(sg_scatter_exp, bmap_scatter, nbits);
+	expect_eq_bitmap(test, sg_scatter_exp, bmap_scatter, nbits);
 
 	/* Scatter/gather relationship */
 	bitmap_zero(bmap_tmp, 100);
 	bitmap_gather(bmap_tmp, bmap_scatter, sg_mask, nbits);
 	bitmap_scatter(bmap_res, bmap_tmp, sg_mask, nbits);
-	expect_eq_bitmap(bmap_scatter, bmap_res, nbits);
+	expect_eq_bitmap(test, bmap_scatter, bmap_res, nbits);
 }
 
 #define PARSE_TIME	0x1
@@ -432,7 +400,7 @@ struct test_bitmap_parselist{
 	const int flags;
 };
 
-static const struct test_bitmap_parselist parselist_tests[] __initconst = {
+static const struct test_bitmap_parselist parselist_tests[] = {
 #define step (sizeof(u64) / sizeof(unsigned long))
 
 	{0, "0",			&exp1[0], 8, 0},
@@ -517,7 +485,7 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 
 };
 
-static void __init test_bitmap_parselist(void)
+static void test_bitmap_parselist(struct kunit *test)
 {
 	int i;
 	int err;
@@ -531,21 +499,14 @@ static void __init test_bitmap_parselist(void)
 		err = bitmap_parselist(ptest.in, bmap, ptest.nbits);
 		time = ktime_get() - time;
 
-		if (err != ptest.errno) {
-			pr_err("parselist: %d: input is %s, errno is %d, expected %d\n",
-					i, ptest.in, err, ptest.errno);
-			failed_tests++;
-			continue;
-		}
+		KUNIT_ASSERT_EQ_MSG(test, err, ptest.errno,
+				    "parselist: %d: input is %s, errno is %d, expected %d\n",
+				    i, ptest.in, err, ptest.errno);
 
-		if (!err && ptest.expected
-			 && !__bitmap_equal(bmap, ptest.expected, ptest.nbits)) {
-			pr_err("parselist: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
-					i, ptest.in, bmap[0],
-					*ptest.expected);
-			failed_tests++;
-			continue;
-		}
+		KUNIT_ASSERT_FALSE_MSG(test, !err && ptest.expected &&
+				       !__bitmap_equal(bmap, ptest.expected, ptest.nbits),
+				       "parselist: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
+				       i, ptest.in, bmap[0], *ptest.expected);
 
 		if (ptest.flags & PARSE_TIME)
 			pr_info("parselist: %d: input is '%s' OK, Time: %llu\n",
@@ -555,7 +516,7 @@ static void __init test_bitmap_parselist(void)
 	}
 }
 
-static void __init test_bitmap_printlist(void)
+static void test_bitmap_printlist(struct kunit *test)
 {
 	unsigned long *bmap = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
@@ -575,17 +536,13 @@ static void __init test_bitmap_printlist(void)
 	ret = bitmap_print_to_pagebuf(true, buf, bmap, PAGE_SIZE * 8);
 	time = ktime_get() - time;
 
-	if (ret != slen + 1) {
-		pr_err("bitmap_print_to_pagebuf: result is %d, expected %d\n", ret, slen);
-		failed_tests++;
-		goto out;
-	}
+	KUNIT_ASSERT_EQ_MSG(test, ret, slen + 1,
+			    "bitmap_print_to_pagebuf: result is %d, expected %d\n",
+			    ret, slen);
 
-	if (strncmp(buf, expected, slen)) {
-		pr_err("bitmap_print_to_pagebuf: result is %s, expected %s\n", buf, expected);
-		failed_tests++;
-		goto out;
-	}
+	KUNIT_ASSERT_FALSE_MSG(test, strncmp(buf, expected, slen),
+			       "bitmap_print_to_pagebuf: result is %s, expected %s\n",
+			       buf, expected);
 
 	pr_info("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
 out:
@@ -593,20 +550,20 @@ static void __init test_bitmap_printlist(void)
 	kfree(bmap);
 }
 
-static const unsigned long parse_test[] __initconst = {
+static const unsigned long parse_test[] = {
 	BITMAP_FROM_U64(0),
 	BITMAP_FROM_U64(1),
 	BITMAP_FROM_U64(0xdeadbeef),
 	BITMAP_FROM_U64(0x100000000ULL),
 };
 
-static const unsigned long parse_test2[] __initconst = {
+static const unsigned long parse_test2[] = {
 	BITMAP_FROM_U64(0x100000000ULL), BITMAP_FROM_U64(0xdeadbeef),
 	BITMAP_FROM_U64(0x100000000ULL), BITMAP_FROM_U64(0xbaadf00ddeadbeef),
 	BITMAP_FROM_U64(0x100000000ULL), BITMAP_FROM_U64(0x0badf00ddeadbeef),
 };
 
-static const struct test_bitmap_parselist parse_tests[] __initconst = {
+static const struct test_bitmap_parselist parse_tests[] = {
 	{0, "",				&parse_test[0 * step], 32, 0},
 	{0, " ",			&parse_test[0 * step], 32, 0},
 	{0, "0",			&parse_test[0 * step], 32, 0},
@@ -633,7 +590,7 @@ static const struct test_bitmap_parselist parse_tests[] __initconst = {
 #undef step
 };
 
-static void __init test_bitmap_parse(void)
+static void test_bitmap_parse(struct kunit *_test)
 {
 	int i;
 	int err;
@@ -648,21 +605,14 @@ static void __init test_bitmap_parse(void)
 		err = bitmap_parse(test.in, len, bmap, test.nbits);
 		time = ktime_get() - time;
 
-		if (err != test.errno) {
-			pr_err("parse: %d: input is %s, errno is %d, expected %d\n",
-					i, test.in, err, test.errno);
-			failed_tests++;
-			continue;
-		}
+		KUNIT_ASSERT_EQ_MSG(_test, err, test.errno,
+				    "parse: %d: input is %s, errno is %d, expected %d\n",
+				     i, test.in, err, test.errno);
 
-		if (!err && test.expected
-			 && !__bitmap_equal(bmap, test.expected, test.nbits)) {
-			pr_err("parse: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
-					i, test.in, bmap[0],
-					*test.expected);
-			failed_tests++;
-			continue;
-		}
+		KUNIT_ASSERT_FALSE_MSG(_test, !err && test.expected &&
+				       !__bitmap_equal(bmap, test.expected, test.nbits),
+				       "parse: %d: input is %s, result is 0x%lx, expected 0x%lx\n",
+					i, test.in, bmap[0], *test.expected);
 
 		if (test.flags & PARSE_TIME)
 			pr_info("parse: %d: input is '%s' OK, Time: %llu\n",
@@ -670,7 +620,7 @@ static void __init test_bitmap_parse(void)
 	}
 }
 
-static void __init test_bitmap_arr32(void)
+static void test_bitmap_arr32(struct kunit *test)
 {
 	unsigned int nbits, next_bit;
 	u32 arr[EXP1_IN_BITS / 32];
@@ -681,24 +631,22 @@ static void __init test_bitmap_arr32(void)
 	for (nbits = 0; nbits < EXP1_IN_BITS; ++nbits) {
 		bitmap_to_arr32(arr, exp1, nbits);
 		bitmap_from_arr32(bmap2, arr, nbits);
-		expect_eq_bitmap(bmap2, exp1, nbits);
+		expect_eq_bitmap(test, bmap2, exp1, nbits);
 
 		next_bit = find_next_bit(bmap2,
 				round_up(nbits, BITS_PER_LONG), nbits);
-		if (next_bit < round_up(nbits, BITS_PER_LONG)) {
-			pr_err("bitmap_copy_arr32(nbits == %d:"
-				" tail is not safely cleared: %d\n",
-				nbits, next_bit);
-			failed_tests++;
-		}
+
+		KUNIT_ASSERT_GE_MSG(test, next_bit, round_up(nbits, BITS_PER_LONG),
+				    "bitmap_copy_arr32(nbits == %d: tail is not safely cleared: %d\n",
+				    nbits, next_bit);
 
 		if (nbits < EXP1_IN_BITS - 32)
-			expect_eq_uint(arr[DIV_ROUND_UP(nbits, 32)],
-								0xa5a5a5a5);
+			expect_eq_uint(test, arr[DIV_ROUND_UP(nbits, 32)],
+				       0xa5a5a5a5);
 	}
 }
 
-static void __init test_bitmap_arr64(void)
+static void test_bitmap_arr64(struct kunit *test)
 {
 	unsigned int nbits, next_bit;
 	u64 arr[EXP1_IN_BITS / 64];
@@ -710,29 +658,25 @@ static void __init test_bitmap_arr64(void)
 		memset(bmap2, 0xff, sizeof(arr));
 		bitmap_to_arr64(arr, exp1, nbits);
 		bitmap_from_arr64(bmap2, arr, nbits);
-		expect_eq_bitmap(bmap2, exp1, nbits);
+		expect_eq_bitmap(test, bmap2, exp1, nbits);
 
 		next_bit = find_next_bit(bmap2, round_up(nbits, BITS_PER_LONG), nbits);
-		if (next_bit < round_up(nbits, BITS_PER_LONG)) {
-			pr_err("bitmap_copy_arr64(nbits == %d:"
-				" tail is not safely cleared: %d\n", nbits, next_bit);
-			failed_tests++;
-		}
+		KUNIT_ASSERT_GE_MSG(test, next_bit, round_up(nbits, BITS_PER_LONG),
+				    "bitmap_copy_arr64(nbits == %d: tail is not safely cleared: %d\n",
+				    nbits, next_bit);
 
-		if ((nbits % 64) &&
-		    (arr[(nbits - 1) / 64] & ~GENMASK_ULL((nbits - 1) % 64, 0))) {
-			pr_err("bitmap_to_arr64(nbits == %d): tail is not safely cleared: 0x%016llx (must be 0x%016llx)\n",
-			       nbits, arr[(nbits - 1) / 64],
-			       GENMASK_ULL((nbits - 1) % 64, 0));
-			failed_tests++;
-		}
+		KUNIT_ASSERT_FALSE_MSG(test, (nbits % 64) &&
+				       (arr[(nbits - 1) / 64] & ~GENMASK_ULL((nbits - 1) % 64, 0)),
+				       "bitmap_to_arr64(nbits == %d): tail is not safely cleared: 0x%016llx (must be 0x%016llx)\n",
+				       nbits, arr[(nbits - 1) / 64],
+				       GENMASK_ULL((nbits - 1) % 64, 0));
 
 		if (nbits < EXP1_IN_BITS - 64)
-			expect_eq_uint(arr[DIV_ROUND_UP(nbits, 64)], 0xa5a5a5a5);
+			expect_eq_uint(test, arr[DIV_ROUND_UP(nbits, 64)], 0xa5a5a5a5);
 	}
 }
 
-static void noinline __init test_mem_optimisations(void)
+static noinline void test_mem_optimisations(struct kunit *test)
 {
 	DECLARE_BITMAP(bmap1, 1024);
 	DECLARE_BITMAP(bmap2, 1024);
@@ -745,31 +689,26 @@ static void noinline __init test_mem_optimisations(void)
 
 			bitmap_set(bmap1, start, nbits);
 			__bitmap_set(bmap2, start, nbits);
-			if (!bitmap_equal(bmap1, bmap2, 1024)) {
-				printk("set not equal %d %d\n", start, nbits);
-				failed_tests++;
-			}
-			if (!__bitmap_equal(bmap1, bmap2, 1024)) {
-				printk("set not __equal %d %d\n", start, nbits);
-				failed_tests++;
-			}
+
+			KUNIT_ASSERT_TRUE_MSG(test, bitmap_equal(bmap1, bmap2, 1024),
+					      "set not equal %d %d\n", start, nbits);
+
+			KUNIT_ASSERT_TRUE_MSG(test, __bitmap_equal(bmap1, bmap2, 1024),
+					      "set not __equal %d %d\n", start, nbits);
 
 			bitmap_clear(bmap1, start, nbits);
 			__bitmap_clear(bmap2, start, nbits);
-			if (!bitmap_equal(bmap1, bmap2, 1024)) {
-				printk("clear not equal %d %d\n", start, nbits);
-				failed_tests++;
-			}
-			if (!__bitmap_equal(bmap1, bmap2, 1024)) {
-				printk("clear not __equal %d %d\n", start,
-									nbits);
-				failed_tests++;
-			}
+
+			KUNIT_ASSERT_TRUE_MSG(test, bitmap_equal(bmap1, bmap2, 1024),
+					      "clear not equal %d %d\n", start, nbits);
+
+			KUNIT_ASSERT_TRUE_MSG(test, __bitmap_equal(bmap1, bmap2, 1024),
+					      "clear not __equal %d %d\n", start, nbits);
 		}
 	}
 }
 
-static const unsigned char clump_exp[] __initconst = {
+static const unsigned char clump_exp[] = {
 	0x01,	/* 1 bit set */
 	0x02,	/* non-edge 1 bit set */
 	0x00,	/* zero bits set */
@@ -780,7 +719,7 @@ static const unsigned char clump_exp[] __initconst = {
 	0x05,	/* non-adjacent 2 bits set */
 };
 
-static void __init test_for_each_set_clump8(void)
+static void test_for_each_set_clump8(struct kunit *test)
 {
 #define CLUMP_EXP_NUMBITS 64
 	DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS);
@@ -799,10 +738,10 @@ static void __init test_for_each_set_clump8(void)
 	bitmap_set(bits, 58, 1);	/* 0x05 - part 2 */
 
 	for_each_set_clump8(start, clump, bits, CLUMP_EXP_NUMBITS)
-		expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
+		expect_eq_clump8(test, start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
 }
 
-static void __init test_for_each_set_bit_wrap(void)
+static void test_for_each_set_bit_wrap(struct kunit *test)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -823,11 +762,11 @@ static void __init test_for_each_set_bit_wrap(void)
 		for_each_set_bit_wrap(bit, orig, 500, wr)
 			bitmap_set(copy, bit, 1);
 
-		expect_eq_bitmap(orig, copy, 500);
+		expect_eq_bitmap(test, orig, copy, 500);
 	}
 }
 
-static void __init test_for_each_set_bit(void)
+static void test_for_each_set_bit(struct kunit *test)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -846,10 +785,10 @@ static void __init test_for_each_set_bit(void)
 	for_each_set_bit(bit, orig, 500)
 		bitmap_set(copy, bit, 1);
 
-	expect_eq_bitmap(orig, copy, 500);
+	expect_eq_bitmap(test, orig, copy, 500);
 }
 
-static void __init test_for_each_set_bit_from(void)
+static void test_for_each_set_bit_from(struct kunit *test)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -875,11 +814,11 @@ static void __init test_for_each_set_bit_from(void)
 
 		bitmap_copy(tmp, orig, 500);
 		bitmap_clear(tmp, 0, wr);
-		expect_eq_bitmap(tmp, copy, 500);
+		expect_eq_bitmap(test, tmp, copy, 500);
 	}
 }
 
-static void __init test_for_each_clear_bit(void)
+static void test_for_each_clear_bit(struct kunit *test)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -898,10 +837,10 @@ static void __init test_for_each_clear_bit(void)
 	for_each_clear_bit(bit, orig, 500)
 		bitmap_clear(copy, bit, 1);
 
-	expect_eq_bitmap(orig, copy, 500);
+	expect_eq_bitmap(test, orig, copy, 500);
 }
 
-static void __init test_for_each_clear_bit_from(void)
+static void test_for_each_clear_bit_from(struct kunit *test)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -927,11 +866,11 @@ static void __init test_for_each_clear_bit_from(void)
 
 		bitmap_copy(tmp, orig, 500);
 		bitmap_set(tmp, 0, wr);
-		expect_eq_bitmap(tmp, copy, 500);
+		expect_eq_bitmap(test, tmp, copy, 500);
 	}
 }
 
-static void __init test_for_each_set_bitrange(void)
+static void test_for_each_set_bitrange(struct kunit *test)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -950,10 +889,10 @@ static void __init test_for_each_set_bitrange(void)
 	for_each_set_bitrange(s, e, orig, 500)
 		bitmap_set(copy, s, e-s);
 
-	expect_eq_bitmap(orig, copy, 500);
+	expect_eq_bitmap(test, orig, copy, 500);
 }
 
-static void __init test_for_each_clear_bitrange(void)
+static void test_for_each_clear_bitrange(struct kunit *test)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -972,10 +911,10 @@ static void __init test_for_each_clear_bitrange(void)
 	for_each_clear_bitrange(s, e, orig, 500)
 		bitmap_clear(copy, s, e-s);
 
-	expect_eq_bitmap(orig, copy, 500);
+	expect_eq_bitmap(test, orig, copy, 500);
 }
 
-static void __init test_for_each_set_bitrange_from(void)
+static void test_for_each_set_bitrange_from(struct kunit *test)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -1001,11 +940,11 @@ static void __init test_for_each_set_bitrange_from(void)
 
 		bitmap_copy(tmp, orig, 500);
 		bitmap_clear(tmp, 0, wr);
-		expect_eq_bitmap(tmp, copy, 500);
+		expect_eq_bitmap(test, tmp, copy, 500);
 	}
 }
 
-static void __init test_for_each_clear_bitrange_from(void)
+static void test_for_each_clear_bitrange_from(struct kunit *test)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -1031,7 +970,7 @@ static void __init test_for_each_clear_bitrange_from(void)
 
 		bitmap_copy(tmp, orig, 500);
 		bitmap_set(tmp, 0, wr);
-		expect_eq_bitmap(tmp, copy, 500);
+		expect_eq_bitmap(test, tmp, copy, 500);
 	}
 }
 
@@ -1076,7 +1015,7 @@ static struct test_bitmap_cut test_cut[] = {
 	},
 };
 
-static void __init test_bitmap_cut(void)
+static void test_bitmap_cut(struct kunit *test)
 {
 	unsigned long b[5], *in = &b[1], *out = &b[0];	/* Partial overlap */
 	int i;
@@ -1088,7 +1027,7 @@ static void __init test_bitmap_cut(void)
 
 		bitmap_cut(out, in, t->first, t->cut, t->nbits);
 
-		expect_eq_bitmap(t->expected, out, t->nbits);
+		expect_eq_bitmap(test, t->expected, out, t->nbits);
 	}
 }
 
@@ -1099,14 +1038,14 @@ struct test_bitmap_print {
 	const char *list;
 };
 
-static const unsigned long small_bitmap[] __initconst = {
+static const unsigned long small_bitmap[] = {
 	BITMAP_FROM_U64(0x3333333311111111ULL),
 };
 
-static const char small_mask[] __initconst = "33333333,11111111\n";
-static const char small_list[] __initconst = "0,4,8,12,16,20,24,28,32-33,36-37,40-41,44-45,48-49,52-53,56-57,60-61\n";
+static const char small_mask[] = "33333333,11111111\n";
+static const char small_list[] = "0,4,8,12,16,20,24,28,32-33,36-37,40-41,44-45,48-49,52-53,56-57,60-61\n";
 
-static const unsigned long large_bitmap[] __initconst = {
+static const unsigned long large_bitmap[] = {
 	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
 	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
 	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
@@ -1129,28 +1068,28 @@ static const unsigned long large_bitmap[] __initconst = {
 	BITMAP_FROM_U64(0x3333333311111111ULL), BITMAP_FROM_U64(0x3333333311111111ULL),
 };
 
-static const char large_mask[] __initconst = "33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111,"
-					"33333333,11111111,33333333,11111111\n";
-
-static const char large_list[] __initconst = /* more than 4KB */
+static const char large_mask[] = "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111,"
+				 "33333333,11111111,33333333,11111111\n";
+
+static const char large_list[] = /* more than 4KB */
 	"0,4,8,12,16,20,24,28,32-33,36-37,40-41,44-45,48-49,52-53,56-57,60-61,64,68,72,76,80,84,88,92,96-97,100-101,104-1"
 	"05,108-109,112-113,116-117,120-121,124-125,128,132,136,140,144,148,152,156,160-161,164-165,168-169,172-173,176-1"
 	"77,180-181,184-185,188-189,192,196,200,204,208,212,216,220,224-225,228-229,232-233,236-237,240-241,244-245,248-2"
@@ -1192,12 +1131,12 @@ static const char large_list[] __initconst = /* more than 4KB */
 	"2489,2492-2493,2496,2500,2504,2508,2512,2516,2520,2524,2528-2529,2532-2533,2536-2537,2540-2541,2544-2545,2548-25"
 	"49,2552-2553,2556-2557\n";
 
-static const struct test_bitmap_print test_print[] __initconst = {
+static const struct test_bitmap_print test_print[] = {
 	{ small_bitmap, sizeof(small_bitmap) * BITS_PER_BYTE, small_mask, small_list },
 	{ large_bitmap, sizeof(large_bitmap) * BITS_PER_BYTE, large_mask, large_list },
 };
 
-static void __init test_bitmap_print_buf(void)
+static void test_bitmap_print_buf(struct kunit *test)
 {
 	int i;
 
@@ -1207,20 +1146,20 @@ static void __init test_bitmap_print_buf(void)
 
 		n = bitmap_print_bitmask_to_buf(print_buf, t->bitmap, t->nbits,
 						0, 2 * PAGE_SIZE);
-		expect_eq_uint(strlen(t->mask) + 1, n);
-		expect_eq_str(t->mask, print_buf, n);
+		expect_eq_uint(test, strlen(t->mask) + 1, n);
+		expect_eq_str(test, t->mask, print_buf, n);
 
 		n = bitmap_print_list_to_buf(print_buf, t->bitmap, t->nbits,
 					     0, 2 * PAGE_SIZE);
-		expect_eq_uint(strlen(t->list) + 1, n);
-		expect_eq_str(t->list, print_buf, n);
+		expect_eq_uint(test, strlen(t->list) + 1, n);
+		expect_eq_str(test, t->list, print_buf, n);
 
 		/* test by non-zero offset */
 		if (strlen(t->list) > PAGE_SIZE) {
 			n = bitmap_print_list_to_buf(print_buf, t->bitmap, t->nbits,
 						     PAGE_SIZE, PAGE_SIZE);
-			expect_eq_uint(strlen(t->list) + 1 - PAGE_SIZE, n);
-			expect_eq_str(t->list + PAGE_SIZE, print_buf, n);
+			expect_eq_uint(test, strlen(t->list) + 1 - PAGE_SIZE, n);
+			expect_eq_str(test, t->list + PAGE_SIZE, print_buf, n);
 		}
 	}
 }
@@ -1229,7 +1168,7 @@ static void __init test_bitmap_print_buf(void)
  * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are enabled.
  * To workaround it, GCOV is force-disabled in Makefile for this configuration.
  */
-static void __init test_bitmap_const_eval(void)
+static void test_bitmap_const_eval(struct kunit *test)
 {
 	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
 	unsigned long initvar = BIT(2);
@@ -1297,7 +1236,7 @@ static void __init test_bitmap_const_eval(void)
 /*
  * Helper function to test bitmap_write() overwriting the chosen byte pattern.
  */
-static void __init test_bitmap_write_helper(const char *pattern)
+static void test_bitmap_write_helper(struct kunit *test, const char *pattern)
 {
 	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
 	DECLARE_BITMAP(exp_bitmap, TEST_BIT_LEN);
@@ -1321,7 +1260,7 @@ static void __init test_bitmap_write_helper(const char *pattern)
 		for (bit = 0; bit <= 1; bit++) {
 			bitmap_write(bitmap, bit, i, 1);
 			__assign_bit(i, exp_bitmap, bit);
-			expect_eq_bitmap(exp_bitmap, bitmap,
+			expect_eq_bitmap(test, exp_bitmap, bitmap,
 					 TEST_BIT_LEN);
 		}
 	}
@@ -1331,7 +1270,7 @@ static void __init test_bitmap_write_helper(const char *pattern)
 	bitmap_copy(exp_bitmap, pat_bitmap, TEST_BIT_LEN);
 	for (i = 0; i < TEST_BIT_LEN; i++) {
 		bitmap_write(bitmap, ~0UL, i, 0);
-		expect_eq_bitmap(exp_bitmap, bitmap, TEST_BIT_LEN);
+		expect_eq_bitmap(test, exp_bitmap, bitmap, TEST_BIT_LEN);
 	}
 
 	for (nbits = BITS_PER_LONG; nbits >= 1; nbits--) {
@@ -1344,14 +1283,14 @@ static void __init test_bitmap_write_helper(const char *pattern)
 			for (n = 0; n < nbits; n++)
 				__assign_bit(i + n, exp_bitmap, w & BIT(n));
 			bitmap_write(bitmap, w, i, nbits);
-			expect_eq_bitmap(exp_bitmap, bitmap, TEST_BIT_LEN);
+			expect_eq_bitmap(test, exp_bitmap, bitmap, TEST_BIT_LEN);
 			r = bitmap_read(bitmap, i, nbits);
-			expect_eq_ulong(r, w);
+			expect_eq_ulong(test, r, w);
 		}
 	}
 }
 
-static void __init test_bitmap_read_write(void)
+static void test_bitmap_read_write(struct kunit *test)
 {
 	unsigned char *pattern[3] = {"", "all:1/2", "all"};
 	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
@@ -1386,21 +1325,21 @@ static void __init test_bitmap_read_write(void)
 
 		bitmap_write(bitmap, 0b10101UL, i, 5);
 		val = bitmap_read(bitmap, i, 5);
-		expect_eq_ulong(0b10101UL, val);
+		expect_eq_ulong(test, 0b10101UL, val);
 
 		bitmap_write(bitmap, 0b101UL, i + 5, 3);
 		val = bitmap_read(bitmap, i + 5, 3);
-		expect_eq_ulong(0b101UL, val);
+		expect_eq_ulong(test, 0b101UL, val);
 
 		val = bitmap_read(bitmap, i, 8);
-		expect_eq_ulong(0b10110101UL, val);
+		expect_eq_ulong(test, 0b10110101UL, val);
 	}
 
 	for (pi = 0; pi < ARRAY_SIZE(pattern); pi++)
-		test_bitmap_write_helper(pattern[pi]);
+		test_bitmap_write_helper(test, pattern[pi]);
 }
 
-static void __init test_bitmap_read_perf(void)
+static void test_bitmap_read_perf(struct kunit *test)
 {
 	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
 	unsigned int cnt, nbits, i;
@@ -1426,7 +1365,7 @@ static void __init test_bitmap_read_perf(void)
 	pr_info("Time spent in %s:\t%llu\n", __func__, time);
 }
 
-static void __init test_bitmap_write_perf(void)
+static void test_bitmap_write_perf(struct kunit *test)
 {
 	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
 	unsigned int cnt, nbits, i;
@@ -1450,41 +1389,46 @@ static void __init test_bitmap_write_perf(void)
 
 #undef TEST_BIT_LEN
 
-static void __init selftest(void)
-{
-	test_zero_clear();
-	test_fill_set();
-	test_copy();
-	test_bitmap_region();
-	test_replace();
-	test_bitmap_sg();
-	test_bitmap_arr32();
-	test_bitmap_arr64();
-	test_bitmap_parse();
-	test_bitmap_parselist();
-	test_bitmap_printlist();
-	test_mem_optimisations();
-	test_bitmap_cut();
-	test_bitmap_print_buf();
-	test_bitmap_const_eval();
-	test_bitmap_read_write();
-	test_bitmap_read_perf();
-	test_bitmap_write_perf();
-
-	test_find_nth_bit();
-	test_for_each_set_bit();
-	test_for_each_set_bit_from();
-	test_for_each_clear_bit();
-	test_for_each_clear_bit_from();
-	test_for_each_set_bitrange();
-	test_for_each_clear_bitrange();
-	test_for_each_set_bitrange_from();
-	test_for_each_clear_bitrange_from();
-	test_for_each_set_clump8();
-	test_for_each_set_bit_wrap();
-}
+static struct kunit_case bitmap_test_cases[] = {
+	KUNIT_CASE(test_zero_clear),
+	KUNIT_CASE(test_fill_set),
+	KUNIT_CASE(test_copy),
+	KUNIT_CASE(test_bitmap_region),
+	KUNIT_CASE(test_replace),
+	KUNIT_CASE(test_bitmap_sg),
+	KUNIT_CASE(test_bitmap_arr32),
+	KUNIT_CASE(test_bitmap_arr64),
+	KUNIT_CASE(test_bitmap_parse),
+	KUNIT_CASE(test_bitmap_parselist),
+	KUNIT_CASE(test_bitmap_printlist),
+	KUNIT_CASE(test_mem_optimisations),
+	KUNIT_CASE(test_bitmap_cut),
+	KUNIT_CASE(test_bitmap_print_buf),
+	KUNIT_CASE(test_bitmap_const_eval),
+	KUNIT_CASE(test_bitmap_read_write),
+	KUNIT_CASE(test_bitmap_read_perf),
+	KUNIT_CASE(test_bitmap_write_perf),
+
+	KUNIT_CASE(test_find_nth_bit),
+	KUNIT_CASE(test_for_each_set_bit),
+	KUNIT_CASE(test_for_each_set_bit_from),
+	KUNIT_CASE(test_for_each_clear_bit),
+	KUNIT_CASE(test_for_each_clear_bit_from),
+	KUNIT_CASE(test_for_each_set_bitrange),
+	KUNIT_CASE(test_for_each_clear_bitrange),
+	KUNIT_CASE(test_for_each_set_bitrange_from),
+	KUNIT_CASE(test_for_each_clear_bitrange_from),
+	KUNIT_CASE(test_for_each_set_clump8),
+	KUNIT_CASE(test_for_each_set_bit_wrap),
+	{}
+};
+
+static struct kunit_suite bitmap_test_suite = {
+	.name = "bitmap",
+	.test_cases = bitmap_test_cases,
+};
 
-KSTM_MODULE_LOADERS(test_bitmap);
+kunit_test_suite(bitmap_test_suite);
 MODULE_AUTHOR("david decotigny <david.decotigny@googlers.com>");
 MODULE_DESCRIPTION("Test cases for bitmap API");
 MODULE_LICENSE("GPL");
-- 
2.39.2


