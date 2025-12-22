Return-Path: <linux-kselftest+bounces-47847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C6ECD6330
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 14:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC55A3022B4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1061631CA4A;
	Mon, 22 Dec 2025 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyPv5Iv7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9422231ED6B;
	Mon, 22 Dec 2025 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766410820; cv=none; b=I114a4PC5KITmdhhrY2IXDlBvIHHSQsidEurQ3W6jg/528eU/Dn+NHLV8hBtOh+CD3XXpTOzrA5cX7dzQruTxpOslW/UMQ8U+x0R90NrLlAaIoqRjnyxokJla2JI9sOMyiuIloPlN3f9cz8fXu4Zn109x9c5cmxzsz+fTeCvIDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766410820; c=relaxed/simple;
	bh=/lKszDe+FNEt/3bELURkNcBl9r0IktZH+V2oYiyjo74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ECNfFZh/QtaSAt2thYtQjd1uQ2TGpVHkWOtz3S9NxEEjlMwMlySIrhTFRBj094nyA/h+p35yD2plDbCQliKkwfoTmQbF4gfzcDac2zMQL+xnJKVR87YG6c9J95AEHvWkF45d2yFbib1iZDIvyVtoS0QATznlqTIXMVMpOzZvbmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyPv5Iv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3ECCC4CEF1;
	Mon, 22 Dec 2025 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766410819;
	bh=/lKszDe+FNEt/3bELURkNcBl9r0IktZH+V2oYiyjo74=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XyPv5Iv7yQsBm/2NUkodG8NYK7GAc6n2jUUeWhrSTlJxy+w9Gree6G26177vq79Mt
	 1KIB9dZmePyPhN+APxv7O5kMyj3Mqzx73UODTrQ2j4cAiBLu6pszrafeqR6pHb3mAX
	 ORMF9FD2xOkrviP0ApXG7Qk5MtMagSFr7j5bABSkwNHIFVraEoUY9XAD4RiLlEt0bO
	 XB9le4cD536wzuyI2vqQvOYesPBfwIHyxLKWxUVhHuYp50ewjKMeM+aQbxZFQOXLfQ
	 YXpdzjtZWpzgQ4mxtfrO3JRCI8nUb7J1FooC7w/LrVhSad479K9nvvFGaKEYKY9TgI
	 lZOHwGYsxoPuA==
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 22 Dec 2025 14:39:56 +0100
Subject: [PATCH v2 3/3] bitmap: break kunit into test cases
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-bitmap-kunit-convert-v2-3-6a61a5330eff@gmail.com>
References: <20251222-bitmap-kunit-convert-v2-0-6a61a5330eff@gmail.com>
In-Reply-To: <20251222-bitmap-kunit-convert-v2-0-6a61a5330eff@gmail.com>
To: David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Naveen N Rao <naveen@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>, 
 Kees Cook <kees@kernel.org>, Christophe Leroy <chleroy@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1766410800; l=22719;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=/Ho1DOURoBJ2Ef25CvsoMQhBFRGc5jf4bV6fycnBTc8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCGdP2AiGEG4t0EmeiWJwr02zrivU9+J4tEsIqFTNawuYOvbMyTQ0noyGWwX0o84Hq72bvxbN26
 EGNJdmVLm6Q8=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

From: Tamir Duberstein <tamird@gmail.com>

Move individual tests into `bitmap_test_cases`.

Retire the tc_err macro. It was using during migration to reduce churn,
but now obscures the opporunity for richer assertion.

Parameterize tests where possible to ensure KUnit assertions produce
descriptive messages.

Reduce duplication between `test_bitmap_parse{,list}`. Note that
`test_bitmap_parse_fn` is defined out-of-line to reduce churn.

Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/bitmap_kunit.c | 388 ++++++++++++++++++++++++++---------------------------
 1 file changed, 191 insertions(+), 197 deletions(-)

diff --git a/lib/bitmap_kunit.c b/lib/bitmap_kunit.c
index 3a71e2039c1f..88770a1804cb 100644
--- a/lib/bitmap_kunit.c
+++ b/lib/bitmap_kunit.c
@@ -10,6 +10,7 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/uaccess.h>
 
 #define EXP1_IN_BITS	(sizeof(exp1) * 8)
@@ -17,11 +18,6 @@
 static char pbl_buffer[PAGE_SIZE];
 static char print_buf[PAGE_SIZE * 2];
 
-static struct kunit *kunittest;
-
-#define tc_err(fmt, ...) \
-	KUNIT_FAIL(kunittest, fmt, ##__VA_ARGS__)
-
 static const unsigned long exp1[] = {
 	BITMAP_FROM_U64(1),
 	BITMAP_FROM_U64(2),
@@ -87,16 +83,9 @@ static const unsigned long exp3_1_0[] = {
 		}									\
 	} while (0)
 
-#define expect_eq_str(exp_str, str, len)				\
-	{								\
-		if (strncmp(exp_str, str, len) != 0) {			\
-			tc_err("expected %s, got %s", exp_str, str);	\
-		}							\
-	}
-
 #define expect_eq_uint(x, y)		expect_eq_ulong((unsigned int)(x), (unsigned int)(y))
 
-static void test_zero_clear(void)
+static void test_zero_clear(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(bmap, 1024);
 
@@ -125,7 +114,7 @@ static void test_zero_clear(void)
 	expect_eq_pbl("", bmap, 1024);
 }
 
-static void test_find_nth_bit(void)
+static void test_find_nth_bit(struct kunit *kunittest)
 {
 	unsigned long b, bit, cnt = 0;
 	DECLARE_BITMAP(bmap, 64 * 3);
@@ -166,7 +155,7 @@ static void test_find_nth_bit(void)
 	}
 }
 
-static void test_fill_set(void)
+static void test_fill_set(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(bmap, 1024);
 
@@ -195,7 +184,7 @@ static void test_fill_set(void)
 	expect_eq_pbl("0-1023", bmap, 1024);
 }
 
-static void test_copy(void)
+static void test_copy(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(bmap1, 1024);
 	DECLARE_BITMAP(bmap2, 1024);
@@ -234,7 +223,7 @@ static void test_copy(void)
 	expect_eq_pbl("0-108,128-1023", bmap2, 1024);
 }
 
-static void test_bitmap_region(void)
+static void test_bitmap_region(struct kunit *kunittest)
 {
 	int pos, order;
 
@@ -259,7 +248,7 @@ static void test_bitmap_region(void)
 
 #define EXP2_IN_BITS	(sizeof(exp2) * 8)
 
-static void test_replace(void)
+static void test_replace(struct kunit *kunittest)
 {
 	unsigned int nbits = 64;
 	unsigned int nlongs = DIV_ROUND_UP(nbits, BITS_PER_LONG);
@@ -300,7 +289,7 @@ static const unsigned long sg_scatter_exp[] = {
 	BITMAP_FROM_U64(0x000000000000021aULL),
 };
 
-static void test_bitmap_sg(void)
+static void test_bitmap_sg(struct kunit *kunittest)
 {
 	unsigned int nbits = 64;
 	DECLARE_BITMAP(bmap_gather, 100);
@@ -336,6 +325,19 @@ struct test_bitmap_parselist{
 	const int flags;
 };
 
+static void parselist_to_desc(const struct test_bitmap_parselist *param, char *desc)
+{
+	int n = 0;
+
+	n += snprintf(desc + n, KUNIT_PARAM_DESC_SIZE - n, "\"");
+	n += string_escape_str(param->in, desc + n, KUNIT_PARAM_DESC_SIZE - n, ESCAPE_SPACE, NULL);
+	n += snprintf(desc + n, KUNIT_PARAM_DESC_SIZE - n, "\"");
+}
+
+typedef int (*bitmap_parse_fn)(const struct test_bitmap_parselist *test, unsigned long *maskp);
+
+static void test_bitmap_parse_fn(struct kunit *kunittest, bitmap_parse_fn fn);
+
 static const struct test_bitmap_parselist parselist_tests[] = {
 #define step (sizeof(u64) / sizeof(unsigned long))
 
@@ -421,76 +423,60 @@ static const struct test_bitmap_parselist parselist_tests[] = {
 
 };
 
-static void test_bitmap_parselist(void)
+KUNIT_ARRAY_PARAM(test_parselist, parselist_tests, parselist_to_desc);
+
+static int do_bitmap_parselist(const struct test_bitmap_parselist *test, unsigned long *maskp)
 {
-	int i;
+	return bitmap_parselist(test->in, maskp, test->nbits);
+}
+
+static void test_bitmap_parselist(struct kunit *kunittest)
+{
+	test_bitmap_parse_fn(kunittest, do_bitmap_parselist);
+}
+
+static void test_bitmap_parse_fn(struct kunit *kunittest, bitmap_parse_fn fn)
+{
+	const struct test_bitmap_parselist *t = kunittest->param_value;
 	int err;
 	ktime_t time;
 	DECLARE_BITMAP(bmap, 2048);
 
-	for (i = 0; i < ARRAY_SIZE(parselist_tests); i++) {
-#define ptest parselist_tests[i]
-
-		time = ktime_get();
-		err = bitmap_parselist(ptest.in, bmap, ptest.nbits);
-		time = ktime_get() - time;
-
-		if (err != ptest.errno) {
-			tc_err("parselist: %d: input is %s, errno is %d, expected %d",
-					i, ptest.in, err, ptest.errno);
-			continue;
-		}
-
-		if (!err && ptest.expected
-			 && !__bitmap_equal(bmap, ptest.expected, ptest.nbits)) {
-			tc_err("parselist: %d: input is %s, result is 0x%lx, expected 0x%lx",
-					i, ptest.in, bmap[0],
-					*ptest.expected);
-			continue;
-		}
+	time = ktime_get();
+	err = fn(t, bmap);
+	time = ktime_get() - time;
 
-		if (ptest.flags & PARSE_TIME)
-			kunit_info(kunittest, "parselist: %d: input is '%s' OK, Time: %llu",
-					i, ptest.in, time);
+	KUNIT_ASSERT_EQ(kunittest, err, t->errno);
 
-#undef ptest
+	if (!err && t->expected && !__bitmap_equal(bmap, t->expected, t->nbits)) {
+		KUNIT_FAIL_AND_ABORT(kunittest,
+				     "result is 0x%lx, expected 0x%lx", bmap[0], *t->expected);
 	}
+
+	if (t->flags & PARSE_TIME)
+		kunit_info(kunittest, "Time: %llu", time);
 }
 
-static void test_bitmap_printlist(void)
+static void test_bitmap_printlist(struct kunit *kunittest)
 {
-	unsigned long *bmap = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	static long bmap[PAGE_SIZE];
+	static char buf[PAGE_SIZE];
 	char expected[256];
 	int ret, slen;
 	ktime_t time;
 
-	if (!buf || !bmap)
-		goto out;
-
 	memset(bmap, -1, PAGE_SIZE);
-	slen = snprintf(expected, 256, "0-%ld", PAGE_SIZE * 8 - 1);
-	if (slen < 0)
-		goto out;
+	slen = snprintf(expected, sizeof(expected), "0-%ld\n", PAGE_SIZE * 8 - 1);
+	KUNIT_ASSERT_GT(kunittest, slen, 0);
 
 	time = ktime_get();
 	ret = bitmap_print_to_pagebuf(true, buf, bmap, PAGE_SIZE * 8);
 	time = ktime_get() - time;
 
-	if (ret != slen + 1) {
-		tc_err("bitmap_print_to_pagebuf: result is %d, expected %d", ret, slen);
-		goto out;
-	}
-
-	if (strncmp(buf, expected, slen)) {
-		tc_err("bitmap_print_to_pagebuf: result is %s, expected %s", buf, expected);
-		goto out;
-	}
+	KUNIT_ASSERT_EQ(kunittest, ret, slen);
+	KUNIT_ASSERT_STREQ(kunittest, buf, expected);
 
-	kunit_info(kunittest, "bitmap_print_to_pagebuf: input is '%s', Time: %llu", buf, time);
-out:
-	kfree(buf);
-	kfree(bmap);
+	kunit_info(kunittest, "Time: %llu", time);
 }
 
 static const unsigned long parse_test[] = {
@@ -533,42 +519,21 @@ static const struct test_bitmap_parselist parse_tests[] = {
 #undef step
 };
 
-static void test_bitmap_parse(void)
-{
-	int i;
-	int err;
-	ktime_t time;
-	DECLARE_BITMAP(bmap, 2048);
-
-	for (i = 0; i < ARRAY_SIZE(parse_tests); i++) {
-		struct test_bitmap_parselist test = parse_tests[i];
-		size_t len = test.flags & NO_LEN ? UINT_MAX : strlen(test.in);
-
-		time = ktime_get();
-		err = bitmap_parse(test.in, len, bmap, test.nbits);
-		time = ktime_get() - time;
+KUNIT_ARRAY_PARAM(test_parse, parse_tests, parselist_to_desc);
 
-		if (err != test.errno) {
-			tc_err("parse: %d: input is %s, errno is %d, expected %d",
-					i, test.in, err, test.errno);
-			continue;
-		}
+static int do_bitmap_parse(const struct test_bitmap_parselist *test, unsigned long *maskp)
+{
+	const size_t len = test->flags & NO_LEN ? UINT_MAX : strlen(test->in);
 
-		if (!err && test.expected
-			 && !__bitmap_equal(bmap, test.expected, test.nbits)) {
-			tc_err("parse: %d: input is %s, result is 0x%lx, expected 0x%lx",
-					i, test.in, bmap[0],
-					*test.expected);
-			continue;
-		}
+	return bitmap_parse(test->in, len, maskp, test->nbits);
+}
 
-		if (test.flags & PARSE_TIME)
-			kunit_info(kunittest, "parse: %d: input is '%s' OK, Time: %llu",
-					i, test.in, time);
-	}
+static void test_bitmap_parse(struct kunit *kunittest)
+{
+	test_bitmap_parse_fn(kunittest, do_bitmap_parse);
 }
 
-static void test_bitmap_arr32(void)
+static void test_bitmap_arr32(struct kunit *kunittest)
 {
 	unsigned int nbits, next_bit;
 	u32 arr[EXP1_IN_BITS / 32];
@@ -584,8 +549,9 @@ static void test_bitmap_arr32(void)
 		next_bit = find_next_bit(bmap2,
 				round_up(nbits, BITS_PER_LONG), nbits);
 		if (next_bit < round_up(nbits, BITS_PER_LONG)) {
-			tc_err("bitmap_copy_arr32(nbits == %d: tail is not safely cleared: %d",
-				nbits, next_bit);
+			KUNIT_FAIL(kunittest,
+				   "bitmap_copy_arr32(nbits == %d: tail is not safely cleared: %d",
+				   nbits, next_bit);
 		}
 
 		if (nbits < EXP1_IN_BITS - 32)
@@ -594,7 +560,7 @@ static void test_bitmap_arr32(void)
 	}
 }
 
-static void test_bitmap_arr64(void)
+static void test_bitmap_arr64(struct kunit *kunittest)
 {
 	unsigned int nbits, next_bit;
 	u64 arr[EXP1_IN_BITS / 64];
@@ -610,15 +576,16 @@ static void test_bitmap_arr64(void)
 
 		next_bit = find_next_bit(bmap2, round_up(nbits, BITS_PER_LONG), nbits);
 		if (next_bit < round_up(nbits, BITS_PER_LONG)) {
-			tc_err("bitmap_copy_arr64(nbits == %d: tail is not safely cleared: %d",
-				nbits, next_bit);
+			KUNIT_FAIL(kunittest,
+				   "bitmap_copy_arr64(nbits == %d: tail is not safely cleared: %d",
+				   nbits, next_bit);
 		}
 
 		if ((nbits % 64) &&
 		    (arr[(nbits - 1) / 64] & ~GENMASK_ULL((nbits - 1) % 64, 0))) {
-			tc_err("bitmap_to_arr64(nbits == %d): tail is not safely cleared: 0x%016llx (must be 0x%016llx)",
-			       nbits, arr[(nbits - 1) / 64],
-			       GENMASK_ULL((nbits - 1) % 64, 0));
+			KUNIT_FAIL(kunittest,
+				   "bitmap_to_arr64(nbits == %d): tail is not safely cleared: 0x%016llx (must be 0x%016llx)",
+				   nbits, arr[(nbits - 1) / 64], GENMASK_ULL((nbits - 1) % 64, 0));
 		}
 
 		if (nbits < EXP1_IN_BITS - 64)
@@ -626,7 +593,7 @@ static void test_bitmap_arr64(void)
 	}
 }
 
-static noinline void test_mem_optimisations(void)
+static noinline void test_mem_optimisations(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(bmap1, 1024);
 	DECLARE_BITMAP(bmap2, 1024);
@@ -640,19 +607,19 @@ static noinline void test_mem_optimisations(void)
 			bitmap_set(bmap1, start, nbits);
 			__bitmap_set(bmap2, start, nbits);
 			if (!bitmap_equal(bmap1, bmap2, 1024)) {
-				tc_err("set not equal %d %d", start, nbits);
+				KUNIT_FAIL(kunittest, "set not equal %d %d", start, nbits);
 			}
 			if (!__bitmap_equal(bmap1, bmap2, 1024)) {
-				tc_err("set not __equal %d %d", start, nbits);
+				KUNIT_FAIL(kunittest, "set not __equal %d %d", start, nbits);
 			}
 
 			bitmap_clear(bmap1, start, nbits);
 			__bitmap_clear(bmap2, start, nbits);
 			if (!bitmap_equal(bmap1, bmap2, 1024)) {
-				tc_err("clear not equal %d %d", start, nbits);
+				KUNIT_FAIL(kunittest, "clear not equal %d %d", start, nbits);
 			}
 			if (!__bitmap_equal(bmap1, bmap2, 1024)) {
-				tc_err("clear not __equal %d %d", start, nbits);
+				KUNIT_FAIL(kunittest, "clear not __equal %d %d", start, nbits);
 			}
 		}
 	}
@@ -669,7 +636,7 @@ static const unsigned char clump_exp[] = {
 	0x05,	/* non-adjacent 2 bits set */
 };
 
-static void test_for_each_set_clump8(void)
+static void test_for_each_set_clump8(struct kunit *kunittest)
 {
 #define CLUMP_EXP_NUMBITS 64
 	DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS);
@@ -691,7 +658,7 @@ static void test_for_each_set_clump8(void)
 		expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
 }
 
-static void test_for_each_set_bit_wrap(void)
+static void test_for_each_set_bit_wrap(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -716,7 +683,7 @@ static void test_for_each_set_bit_wrap(void)
 	}
 }
 
-static void test_for_each_set_bit(void)
+static void test_for_each_set_bit(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -738,7 +705,7 @@ static void test_for_each_set_bit(void)
 	expect_eq_bitmap(orig, copy, 500);
 }
 
-static void test_for_each_set_bit_from(void)
+static void test_for_each_set_bit_from(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -768,7 +735,7 @@ static void test_for_each_set_bit_from(void)
 	}
 }
 
-static void test_for_each_clear_bit(void)
+static void test_for_each_clear_bit(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -790,7 +757,7 @@ static void test_for_each_clear_bit(void)
 	expect_eq_bitmap(orig, copy, 500);
 }
 
-static void test_for_each_clear_bit_from(void)
+static void test_for_each_clear_bit_from(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -820,7 +787,7 @@ static void test_for_each_clear_bit_from(void)
 	}
 }
 
-static void test_for_each_set_bitrange(void)
+static void test_for_each_set_bitrange(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -842,7 +809,7 @@ static void test_for_each_set_bitrange(void)
 	expect_eq_bitmap(orig, copy, 500);
 }
 
-static void test_for_each_clear_bitrange(void)
+static void test_for_each_clear_bitrange(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -864,7 +831,7 @@ static void test_for_each_clear_bitrange(void)
 	expect_eq_bitmap(orig, copy, 500);
 }
 
-static void test_for_each_set_bitrange_from(void)
+static void test_for_each_set_bitrange_from(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -894,7 +861,7 @@ static void test_for_each_set_bitrange_from(void)
 	}
 }
 
-static void test_for_each_clear_bitrange_from(void)
+static void test_for_each_clear_bitrange_from(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(orig, 500);
 	DECLARE_BITMAP(copy, 500);
@@ -965,20 +932,50 @@ static struct test_bitmap_cut test_cut[] = {
 	},
 };
 
-static void test_bitmap_cut(void)
+static void cut_to_desc(struct test_bitmap_cut *param, char * const desc)
 {
-	unsigned long b[5], *in = &b[1], *out = &b[0];	/* Partial overlap */
+	int n = 0;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(test_cut); i++) {
-		struct test_bitmap_cut *t = &test_cut[i];
+	#define append(...) (n += snprintf(desc + n, KUNIT_PARAM_DESC_SIZE - n, ##__VA_ARGS__))
+
+	append("first=%d,cut=%d,nbits=%d", param->first, param->cut, param->nbits);
+
+	#define append_array(name) do {					\
+		{							\
+			append("," #name "={");				\
+			for (i = 0; i < ARRAY_SIZE(param->name); i++) {	\
+				if (param->name[i] == 0) {		\
+					break;				\
+				}					\
+				if (i != 0) {				\
+					append(",");			\
+				}					\
+				append("0x%08lxUL", param->name[i]);	\
+			}						\
+			append("}");					\
+		}							\
+	} while (0)
 
-		memcpy(in, t->in, sizeof(t->in));
+	append_array(in);
+	append_array(expected);
 
-		bitmap_cut(out, in, t->first, t->cut, t->nbits);
+	#undef append_array
+	#undef append
+}
 
-		expect_eq_bitmap(t->expected, out, t->nbits);
-	}
+KUNIT_ARRAY_PARAM(test_cut, test_cut, cut_to_desc);
+
+static void test_bitmap_cut(struct kunit *kunittest)
+{
+	const struct test_bitmap_cut *t = kunittest->param_value;
+	unsigned long b[5], *in = &b[1], *out = &b[0];	/* Partial overlap */
+
+	memcpy(in, t->in, sizeof(t->in));
+
+	bitmap_cut(out, in, t->first, t->cut, t->nbits);
+
+	expect_eq_bitmap(t->expected, out, t->nbits);
 }
 
 struct test_bitmap_print {
@@ -986,6 +983,7 @@ struct test_bitmap_print {
 	unsigned long nbits;
 	const char *mask;
 	const char *list;
+	const char *name;
 };
 
 static const unsigned long small_bitmap[] = {
@@ -1082,35 +1080,33 @@ static const char large_list[] = /* more than 4KB */
 	"49,2552-2553,2556-2557\n";
 
 static const struct test_bitmap_print test_print[] = {
-	{ small_bitmap, sizeof(small_bitmap) * BITS_PER_BYTE, small_mask, small_list },
-	{ large_bitmap, sizeof(large_bitmap) * BITS_PER_BYTE, large_mask, large_list },
+	{ small_bitmap, sizeof(small_bitmap) * BITS_PER_BYTE, small_mask, small_list, "small" },
+	{ large_bitmap, sizeof(large_bitmap) * BITS_PER_BYTE, large_mask, large_list, "large" },
 };
 
-static void test_bitmap_print_buf(void)
+KUNIT_ARRAY_PARAM_DESC(test_print, test_print, name);
+
+static void test_bitmap_print_buf(struct kunit *kunittest)
 {
-	int i;
+	const struct test_bitmap_print *t = kunittest->param_value;
+	int n;
 
-	for (i = 0; i < ARRAY_SIZE(test_print); i++) {
-		const struct test_bitmap_print *t = &test_print[i];
-		int n;
+	n = bitmap_print_bitmask_to_buf(print_buf, t->bitmap, t->nbits,
+					0, 2 * PAGE_SIZE);
+	expect_eq_uint(strlen(t->mask) + 1, n);
+	KUNIT_EXPECT_STREQ(kunittest, t->mask, print_buf);
 
-		n = bitmap_print_bitmask_to_buf(print_buf, t->bitmap, t->nbits,
-						0, 2 * PAGE_SIZE);
-		expect_eq_uint(strlen(t->mask) + 1, n);
-		expect_eq_str(t->mask, print_buf, n);
+	n = bitmap_print_list_to_buf(print_buf, t->bitmap, t->nbits,
+					0, 2 * PAGE_SIZE);
+	expect_eq_uint(strlen(t->list) + 1, n);
+	KUNIT_EXPECT_STREQ(kunittest, t->list, print_buf);
 
+	/* test by non-zero offset */
+	if (strlen(t->list) > PAGE_SIZE) {
 		n = bitmap_print_list_to_buf(print_buf, t->bitmap, t->nbits,
-					     0, 2 * PAGE_SIZE);
-		expect_eq_uint(strlen(t->list) + 1, n);
-		expect_eq_str(t->list, print_buf, n);
-
-		/* test by non-zero offset */
-		if (strlen(t->list) > PAGE_SIZE) {
-			n = bitmap_print_list_to_buf(print_buf, t->bitmap, t->nbits,
-						     PAGE_SIZE, PAGE_SIZE);
-			expect_eq_uint(strlen(t->list) + 1 - PAGE_SIZE, n);
-			expect_eq_str(t->list + PAGE_SIZE, print_buf, n);
-		}
+						PAGE_SIZE, PAGE_SIZE);
+		expect_eq_uint(strlen(t->list) + 1 - PAGE_SIZE, n);
+		KUNIT_EXPECT_STREQ(kunittest, t->list + PAGE_SIZE, print_buf);
 	}
 }
 
@@ -1118,7 +1114,7 @@ static void test_bitmap_print_buf(void)
  * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are enabled.
  * To workaround it, GCOV is force-disabled in Makefile for this configuration.
  */
-static void test_bitmap_const_eval(void)
+static void test_bitmap_const_eval(struct kunit *kunittest)
 {
 	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
 	unsigned long initvar = BIT(2);
@@ -1183,11 +1179,19 @@ static void test_bitmap_const_eval(void)
  */
 #define TEST_BIT_LEN (1000)
 
-/*
- * Helper function to test bitmap_write() overwriting the chosen byte pattern.
- */
-static void test_bitmap_write_helper(const char *pattern)
+static const char * const pattern[] = {"", "all:1/2", "all"};
+
+static void pattern_to_desc(const char * const *param, char *desc)
 {
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "\"%s\"", *param);
+}
+
+KUNIT_ARRAY_PARAM(pattern, pattern, pattern_to_desc);
+
+static void test_bitmap_write_pattern(struct kunit *kunittest)
+{
+	const char * const *p = kunittest->param_value;
+	const char *pattern = *p;
 	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
 	DECLARE_BITMAP(exp_bitmap, TEST_BIT_LEN);
 	DECLARE_BITMAP(pat_bitmap, TEST_BIT_LEN);
@@ -1240,13 +1244,12 @@ static void test_bitmap_write_helper(const char *pattern)
 	}
 }
 
-static void test_bitmap_read_write(void)
+static void test_bitmap_read_write(struct kunit *kunittest)
 {
-	unsigned char *pattern[3] = {"", "all:1/2", "all"};
 	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
 	unsigned long zero_bits = 0, bits_per_long = BITS_PER_LONG;
 	unsigned long val;
-	int i, pi;
+	int i;
 
 	/*
 	 * Reading/writing zero bits should not crash the kernel.
@@ -1284,49 +1287,40 @@ static void test_bitmap_read_write(void)
 		val = bitmap_read(bitmap, i, 8);
 		expect_eq_ulong(0b10110101UL, val);
 	}
-
-	for (pi = 0; pi < ARRAY_SIZE(pattern); pi++)
-		test_bitmap_write_helper(pattern[pi]);
 }
 
 #undef TEST_BIT_LEN
 
-static void bitmap_test(struct kunit *test)
-{
-	kunittest = test;
-
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
-
 static struct kunit_case bitmap_test_cases[] = {
-	KUNIT_CASE(bitmap_test),
+	KUNIT_CASE(test_zero_clear),
+	KUNIT_CASE(test_fill_set),
+	KUNIT_CASE(test_copy),
+	KUNIT_CASE(test_bitmap_region),
+	KUNIT_CASE(test_replace),
+	KUNIT_CASE(test_bitmap_sg),
+	KUNIT_CASE(test_bitmap_arr32),
+	KUNIT_CASE(test_bitmap_arr64),
+	KUNIT_CASE_PARAM(test_bitmap_parse, test_parse_gen_params),
+	KUNIT_CASE_PARAM(test_bitmap_parselist, test_parselist_gen_params),
+	KUNIT_CASE(test_bitmap_printlist),
+	KUNIT_CASE(test_mem_optimisations),
+	KUNIT_CASE_PARAM(test_bitmap_cut, test_cut_gen_params),
+	KUNIT_CASE_PARAM(test_bitmap_print_buf, test_print_gen_params),
+	KUNIT_CASE(test_bitmap_const_eval),
+	KUNIT_CASE(test_bitmap_read_write),
+	KUNIT_CASE_PARAM(test_bitmap_write_pattern, pattern_gen_params),
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
 	{}
 };
 

-- 
2.52.0


