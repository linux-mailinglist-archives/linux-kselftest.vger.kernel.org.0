Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3655A6F01
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 23:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiH3VQg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 17:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiH3VQd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 17:16:33 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F422B870B8;
        Tue, 30 Aug 2022 14:16:29 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4MHKqc6Rf6zDqQ5;
        Tue, 30 Aug 2022 21:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1661894189; bh=huzSaaKW3YAEQG2RNk+YG4sjhZaYJFfr4n86yxVHJ+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDQ+8171Xyhe7rNPKVXxH3ivmJbFAJmyQhmZnu1QyTmwUfxCWVgYbbbIS/2b8aFAw
         81Xa+ixP63BEK4UUeXtXlV45b0WkfvJAl+aYuTuScW/+CXoL0/6Nqws/ogRzxDOwgE
         g3GhYSbgtogAa0mQ59njeYsL8UXYrxHjms87ZinY=
X-Riseup-User-ID: 4A42A36D69134391CD8C0C4C8951E2CFA5DA1F4C2391D0FD2B44FA2538D91FB2
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4MHKqW39TQz1yQt;
        Tue, 30 Aug 2022 21:16:23 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Gow <davidgow@google.com>, brendanhiggins@google.com,
        Arthur Grillo <arthur.grillo@usp.br>,
        michal.winiarski@intel.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH 2/2] drm/tests: Change "igt_" prefix to "drm_"
Date:   Tue, 30 Aug 2022 18:16:03 -0300
Message-Id: <20220830211603.191734-2-mairacanal@riseup.net>
In-Reply-To: <20220830211603.191734-1-mairacanal@riseup.net>
References: <20220830211603.191734-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With the introduction of KUnit, IGT is no longer the only option to run
the DRM unit tests, as the tests can be run through kunit-tool or on
real hardware with CONFIG_KUNIT.

Therefore, remove the "igt_" prefix from the tests and replace it with
the "drm_" prefix, making the tests' names independent from the tool
used.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/tests/drm_buddy_test.c        |  84 +++++-----
 .../gpu/drm/tests/drm_damage_helper_test.c    |  84 +++++-----
 .../gpu/drm/tests/drm_dp_mst_helper_test.c    |   8 +-
 .../gpu/drm/tests/drm_format_helper_test.c    |   8 +-
 drivers/gpu/drm/tests/drm_format_test.c       |  20 +--
 drivers/gpu/drm/tests/drm_mm_test.c           | 155 +++++++++---------
 drivers/gpu/drm/tests/drm_plane_helper_test.c |   4 +-
 drivers/gpu/drm/tests/drm_rect_test.c         |  16 +-
 8 files changed, 190 insertions(+), 189 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
index d76f83833e75..a9393d788390 100644
--- a/drivers/gpu/drm/tests/drm_buddy_test.c
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -13,7 +13,7 @@
 
 #include "../lib/drm_random.h"
 
-#define IGT_TIMEOUT(name__)                                                    \
+#define TIMEOUT(name__)								\
 	unsigned long name__ = jiffies + MAX_SCHEDULE_TIMEOUT
 
 static unsigned int random_seed;
@@ -24,7 +24,7 @@ static inline u64 get_size(int order, u64 chunk_size)
 }
 
 __printf(2, 3)
-static bool __igt_timeout(unsigned long timeout, const char *fmt, ...)
+static bool __timeout(unsigned long timeout, const char *fmt, ...)
 {
 	va_list va;
 
@@ -43,8 +43,8 @@ static bool __igt_timeout(unsigned long timeout, const char *fmt, ...)
 	return true;
 }
 
-static void __igt_dump_block(struct kunit *test, struct drm_buddy *mm,
-			     struct drm_buddy_block *block, bool buddy)
+static void __dump_block(struct kunit *test, struct drm_buddy *mm,
+			 struct drm_buddy_block *block, bool buddy)
 {
 	kunit_err(test, "block info: header=%llx, state=%u, order=%d, offset=%llx size=%llx root=%d buddy=%d\n",
 		  block->header, drm_buddy_block_state(block),
@@ -52,20 +52,20 @@ static void __igt_dump_block(struct kunit *test, struct drm_buddy *mm,
 			  drm_buddy_block_size(mm, block), !block->parent, buddy);
 }
 
-static void igt_dump_block(struct kunit *test, struct drm_buddy *mm,
-			   struct drm_buddy_block *block)
+static void dump_block(struct kunit *test, struct drm_buddy *mm,
+		       struct drm_buddy_block *block)
 {
 	struct drm_buddy_block *buddy;
 
-	__igt_dump_block(test, mm, block, false);
+	__dump_block(test, mm, block, false);
 
 	buddy = drm_get_buddy(block);
 	if (buddy)
-		__igt_dump_block(test, mm, buddy, true);
+		__dump_block(test, mm, buddy, true);
 }
 
-static int igt_check_block(struct kunit *test, struct drm_buddy *mm,
-			   struct drm_buddy_block *block)
+static int check_block(struct kunit *test, struct drm_buddy *mm,
+		       struct drm_buddy_block *block)
 {
 	struct drm_buddy_block *buddy;
 	unsigned int block_state;
@@ -137,8 +137,8 @@ static int igt_check_block(struct kunit *test, struct drm_buddy *mm,
 	return err;
 }
 
-static int igt_check_blocks(struct kunit *test, struct drm_buddy *mm,
-			    struct list_head *blocks, u64 expected_size, bool is_contiguous)
+static int check_blocks(struct kunit *test, struct drm_buddy *mm,
+			struct list_head *blocks, u64 expected_size, bool is_contiguous)
 {
 	struct drm_buddy_block *block;
 	struct drm_buddy_block *prev;
@@ -150,7 +150,7 @@ static int igt_check_blocks(struct kunit *test, struct drm_buddy *mm,
 	total = 0;
 
 	list_for_each_entry(block, blocks, link) {
-		err = igt_check_block(test, mm, block);
+		err = check_block(test, mm, block);
 
 		if (!drm_buddy_block_is_allocated(block)) {
 			kunit_err(test, "block not allocated\n");
@@ -190,16 +190,16 @@ static int igt_check_blocks(struct kunit *test, struct drm_buddy *mm,
 
 	if (prev) {
 		kunit_err(test, "prev block, dump:\n");
-		igt_dump_block(test, mm, prev);
+		dump_block(test, mm, prev);
 	}
 
 	kunit_err(test, "bad block, dump:\n");
-	igt_dump_block(test, mm, block);
+	dump_block(test, mm, block);
 
 	return err;
 }
 
-static int igt_check_mm(struct kunit *test, struct drm_buddy *mm)
+static int check_mm(struct kunit *test, struct drm_buddy *mm)
 {
 	struct drm_buddy_block *root;
 	struct drm_buddy_block *prev;
@@ -233,7 +233,7 @@ static int igt_check_mm(struct kunit *test, struct drm_buddy *mm)
 			break;
 		}
 
-		err = igt_check_block(test, mm, root);
+		err = check_block(test, mm, root);
 
 		if (!drm_buddy_block_is_free(root)) {
 			kunit_err(test, "root not free\n");
@@ -289,18 +289,18 @@ static int igt_check_mm(struct kunit *test, struct drm_buddy *mm)
 
 	if (prev) {
 		kunit_err(test, "prev root(%u), dump:\n", i - 1);
-		igt_dump_block(test, mm, prev);
+		dump_block(test, mm, prev);
 	}
 
 	if (root) {
 		kunit_err(test, "bad root(%u), dump:\n", i);
-		igt_dump_block(test, mm, root);
+		dump_block(test, mm, root);
 	}
 
 	return err;
 }
 
-static void igt_mm_config(u64 *size, u64 *chunk_size)
+static void mm_config(u64 *size, u64 *chunk_size)
 {
 	DRM_RND_STATE(prng, random_seed);
 	u32 s, ms;
@@ -321,7 +321,7 @@ static void igt_mm_config(u64 *size, u64 *chunk_size)
 	*size = (u64)s << 12;
 }
 
-static void igt_buddy_alloc_pathological(struct kunit *test)
+static void drm_buddy_alloc_pathological(struct kunit *test)
 {
 	u64 mm_size, size, start = 0;
 	struct drm_buddy_block *block;
@@ -402,7 +402,7 @@ static void igt_buddy_alloc_pathological(struct kunit *test)
 	drm_buddy_fini(&mm);
 }
 
-static void igt_buddy_alloc_smoke(struct kunit *test)
+static void drm_buddy_alloc_smoke(struct kunit *test)
 {
 	u64 mm_size, chunk_size, start = 0;
 	unsigned long flags = 0;
@@ -411,9 +411,9 @@ static void igt_buddy_alloc_smoke(struct kunit *test)
 	int i;
 
 	DRM_RND_STATE(prng, random_seed);
-	IGT_TIMEOUT(end_time);
+	TIMEOUT(end_time);
 
-	igt_mm_config(&mm_size, &chunk_size);
+	mm_config(&mm_size, &chunk_size);
 
 	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_init(&mm, mm_size, chunk_size),
 			       "buddy_init failed\n");
@@ -430,7 +430,7 @@ static void igt_buddy_alloc_smoke(struct kunit *test)
 		LIST_HEAD(tmp);
 		int order, err;
 
-		KUNIT_ASSERT_FALSE_MSG(test, igt_check_mm(test, &mm),
+		KUNIT_ASSERT_FALSE_MSG(test, check_mm(test, &mm),
 				       "pre-mm check failed, abort\n");
 
 		order = max_order;
@@ -466,19 +466,19 @@ static void igt_buddy_alloc_smoke(struct kunit *test)
 
 			total += drm_buddy_block_size(&mm, block);
 
-			if (__igt_timeout(end_time, NULL)) {
+			if (__timeout(end_time, NULL)) {
 				timeout = true;
 				break;
 			}
 		} while (total < mm.size);
 
 		if (!err)
-			err = igt_check_blocks(test, &mm, &blocks, total, false);
+			err = check_blocks(test, &mm, &blocks, total, false);
 
 		drm_buddy_free_list(&mm, &blocks);
 
 		if (!err) {
-			KUNIT_EXPECT_FALSE_MSG(test, igt_check_mm(test, &mm),
+			KUNIT_EXPECT_FALSE_MSG(test, check_mm(test, &mm),
 					       "post-mm check failed\n");
 		}
 
@@ -492,7 +492,7 @@ static void igt_buddy_alloc_smoke(struct kunit *test)
 	drm_buddy_fini(&mm);
 }
 
-static void igt_buddy_alloc_pessimistic(struct kunit *test)
+static void drm_buddy_alloc_pessimistic(struct kunit *test)
 {
 	u64 mm_size, size, start = 0;
 	struct drm_buddy_block *block, *bn;
@@ -587,7 +587,7 @@ static void igt_buddy_alloc_pessimistic(struct kunit *test)
 	drm_buddy_fini(&mm);
 }
 
-static void igt_buddy_alloc_optimistic(struct kunit *test)
+static void drm_buddy_alloc_optimistic(struct kunit *test)
 {
 	u64 mm_size, size, start = 0;
 	struct drm_buddy_block *block;
@@ -633,7 +633,7 @@ static void igt_buddy_alloc_optimistic(struct kunit *test)
 	drm_buddy_fini(&mm);
 }
 
-static void igt_buddy_alloc_range(struct kunit *test)
+static void drm_buddy_alloc_range(struct kunit *test)
 {
 	unsigned long flags = DRM_BUDDY_RANGE_ALLOCATION;
 	u64 offset, size, rem, chunk_size, end;
@@ -641,12 +641,12 @@ static void igt_buddy_alloc_range(struct kunit *test)
 	struct drm_buddy mm;
 	LIST_HEAD(blocks);
 
-	igt_mm_config(&size, &chunk_size);
+	mm_config(&size, &chunk_size);
 
 	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_init(&mm, size, chunk_size),
 			       "buddy_init failed");
 
-	KUNIT_ASSERT_FALSE_MSG(test, igt_check_mm(test, &mm),
+	KUNIT_ASSERT_FALSE_MSG(test, check_mm(test, &mm),
 			       "pre-mm check failed, abort!");
 
 	rem = mm.size;
@@ -671,7 +671,7 @@ static void igt_buddy_alloc_range(struct kunit *test)
 				    "alloc_range start offset mismatch, found=%llx, expected=%llx\n",
 							drm_buddy_block_offset(block), offset);
 
-		KUNIT_ASSERT_FALSE(test, igt_check_blocks(test, &mm, &tmp, size, true));
+		KUNIT_ASSERT_FALSE(test, check_blocks(test, &mm, &tmp, size, true));
 
 		list_splice_tail(&tmp, &blocks);
 
@@ -686,12 +686,12 @@ static void igt_buddy_alloc_range(struct kunit *test)
 
 	drm_buddy_free_list(&mm, &blocks);
 
-	KUNIT_EXPECT_FALSE_MSG(test, igt_check_mm(test, &mm), "post-mm check failed\n");
+	KUNIT_EXPECT_FALSE_MSG(test, check_mm(test, &mm), "post-mm check failed\n");
 
 	drm_buddy_fini(&mm);
 }
 
-static void igt_buddy_alloc_limit(struct kunit *test)
+static void drm_buddy_alloc_limit(struct kunit *test)
 {
 	u64 size = U64_MAX, start = 0;
 	struct drm_buddy_block *block;
@@ -735,12 +735,12 @@ static int drm_buddy_init_test(struct kunit *test)
 }
 
 static struct kunit_case drm_buddy_tests[] = {
-	KUNIT_CASE(igt_buddy_alloc_limit),
-	KUNIT_CASE(igt_buddy_alloc_range),
-	KUNIT_CASE(igt_buddy_alloc_optimistic),
-	KUNIT_CASE(igt_buddy_alloc_pessimistic),
-	KUNIT_CASE(igt_buddy_alloc_smoke),
-	KUNIT_CASE(igt_buddy_alloc_pathological),
+	KUNIT_CASE(drm_buddy_alloc_limit),
+	KUNIT_CASE(drm_buddy_alloc_range),
+	KUNIT_CASE(drm_buddy_alloc_optimistic),
+	KUNIT_CASE(drm_buddy_alloc_pessimistic),
+	KUNIT_CASE(drm_buddy_alloc_smoke),
+	KUNIT_CASE(drm_buddy_alloc_pathological),
 	{}
 };
 
diff --git a/drivers/gpu/drm/tests/drm_damage_helper_test.c b/drivers/gpu/drm/tests/drm_damage_helper_test.c
index bf250bd08d7e..91005b051c5c 100644
--- a/drivers/gpu/drm/tests/drm_damage_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_damage_helper_test.c
@@ -111,7 +111,7 @@ static void check_damage_clip(struct kunit *test, struct drm_rect *r,
 			   r->x1, r->y1, r->x2, r->y2, x1, y1, x2, y2);
 }
 
-static void igt_damage_iter_no_damage(struct kunit *test)
+static void drm_damage_iter_no_damage(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -129,7 +129,7 @@ static void igt_damage_iter_no_damage(struct kunit *test)
 	check_damage_clip(test, &clip, 0, 0, 2048, 2048);
 }
 
-static void igt_damage_iter_no_damage_fractional_src(struct kunit *test)
+static void drm_damage_iter_no_damage_fractional_src(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -150,7 +150,7 @@ static void igt_damage_iter_no_damage_fractional_src(struct kunit *test)
 	check_damage_clip(test, &clip, 3, 3, 1028, 772);
 }
 
-static void igt_damage_iter_no_damage_src_moved(struct kunit *test)
+static void drm_damage_iter_no_damage_src_moved(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -169,7 +169,7 @@ static void igt_damage_iter_no_damage_src_moved(struct kunit *test)
 	check_damage_clip(test, &clip, 10, 10, 1034, 778);
 }
 
-static void igt_damage_iter_no_damage_fractional_src_moved(struct kunit *test)
+static void drm_damage_iter_no_damage_fractional_src_moved(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -189,7 +189,7 @@ static void igt_damage_iter_no_damage_fractional_src_moved(struct kunit *test)
 	check_damage_clip(test, &clip, 4, 4, 1029, 773);
 }
 
-static void igt_damage_iter_no_damage_not_visible(struct kunit *test)
+static void drm_damage_iter_no_damage_not_visible(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -207,7 +207,7 @@ static void igt_damage_iter_no_damage_not_visible(struct kunit *test)
 	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should have no damage.");
 }
 
-static void igt_damage_iter_no_damage_no_crtc(struct kunit *test)
+static void drm_damage_iter_no_damage_no_crtc(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -225,7 +225,7 @@ static void igt_damage_iter_no_damage_no_crtc(struct kunit *test)
 	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should have no damage.");
 }
 
-static void igt_damage_iter_no_damage_no_fb(struct kunit *test)
+static void drm_damage_iter_no_damage_no_fb(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -243,7 +243,7 @@ static void igt_damage_iter_no_damage_no_fb(struct kunit *test)
 	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should have no damage.");
 }
 
-static void igt_damage_iter_simple_damage(struct kunit *test)
+static void drm_damage_iter_simple_damage(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -266,7 +266,7 @@ static void igt_damage_iter_simple_damage(struct kunit *test)
 	check_damage_clip(test, &clip, 0, 0, 1024, 768);
 }
 
-static void igt_damage_iter_single_damage(struct kunit *test)
+static void drm_damage_iter_single_damage(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -288,7 +288,7 @@ static void igt_damage_iter_single_damage(struct kunit *test)
 	check_damage_clip(test, &clip, 256, 192, 768, 576);
 }
 
-static void igt_damage_iter_single_damage_intersect_src(struct kunit *test)
+static void drm_damage_iter_single_damage_intersect_src(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -311,7 +311,7 @@ static void igt_damage_iter_single_damage_intersect_src(struct kunit *test)
 	check_damage_clip(test, &clip, 256, 192, 1024, 768);
 }
 
-static void igt_damage_iter_single_damage_outside_src(struct kunit *test)
+static void drm_damage_iter_single_damage_outside_src(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -333,7 +333,7 @@ static void igt_damage_iter_single_damage_outside_src(struct kunit *test)
 	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should have no damage.");
 }
 
-static void igt_damage_iter_single_damage_fractional_src(struct kunit *test)
+static void drm_damage_iter_single_damage_fractional_src(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -358,7 +358,7 @@ static void igt_damage_iter_single_damage_fractional_src(struct kunit *test)
 	check_damage_clip(test, &clip, 10, 10, 256, 330);
 }
 
-static void igt_damage_iter_single_damage_intersect_fractional_src(struct kunit *test)
+static void drm_damage_iter_single_damage_intersect_fractional_src(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -385,7 +385,7 @@ static void igt_damage_iter_single_damage_intersect_fractional_src(struct kunit
 	check_damage_clip(test, &clip, 10, 4, 1029, 330);
 }
 
-static void igt_damage_iter_single_damage_outside_fractional_src(struct kunit *test)
+static void drm_damage_iter_single_damage_outside_fractional_src(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -410,7 +410,7 @@ static void igt_damage_iter_single_damage_outside_fractional_src(struct kunit *t
 	KUNIT_EXPECT_EQ_MSG(test, num_hits, 0, "Should have no damage.");
 }
 
-static void igt_damage_iter_single_damage_src_moved(struct kunit *test)
+static void drm_damage_iter_single_damage_src_moved(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -435,7 +435,7 @@ static void igt_damage_iter_single_damage_src_moved(struct kunit *test)
 	check_damage_clip(test, &clip, 10, 10, 1034, 778);
 }
 
-static void igt_damage_iter_single_damage_fractional_src_moved(struct kunit *test)
+static void drm_damage_iter_single_damage_fractional_src_moved(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -462,7 +462,7 @@ static void igt_damage_iter_single_damage_fractional_src_moved(struct kunit *tes
 	check_damage_clip(test, &clip, 4, 4, 1029, 773);
 }
 
-static void igt_damage_iter_damage(struct kunit *test)
+static void drm_damage_iter_damage(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -490,7 +490,7 @@ static void igt_damage_iter_damage(struct kunit *test)
 	KUNIT_EXPECT_EQ_MSG(test, num_hits, 2, "Should return damage when set.");
 }
 
-static void igt_damage_iter_damage_one_intersect(struct kunit *test)
+static void drm_damage_iter_damage_one_intersect(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -520,7 +520,7 @@ static void igt_damage_iter_damage_one_intersect(struct kunit *test)
 	KUNIT_EXPECT_EQ_MSG(test, num_hits, 2, "Should return damage when set.");
 }
 
-static void igt_damage_iter_damage_one_outside(struct kunit *test)
+static void drm_damage_iter_damage_one_outside(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -544,7 +544,7 @@ static void igt_damage_iter_damage_one_outside(struct kunit *test)
 	check_damage_clip(test, &clip, 240, 200, 280, 250);
 }
 
-static void igt_damage_iter_damage_src_moved(struct kunit *test)
+static void drm_damage_iter_damage_src_moved(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -571,7 +571,7 @@ static void igt_damage_iter_damage_src_moved(struct kunit *test)
 	check_damage_clip(test, &clip, 3, 3, 1028, 772);
 }
 
-static void igt_damage_iter_damage_not_visible(struct kunit *test)
+static void drm_damage_iter_damage_not_visible(struct kunit *test)
 {
 	struct drm_damage_mock *mock = test->priv;
 	struct drm_atomic_helper_damage_iter iter;
@@ -599,27 +599,27 @@ static void igt_damage_iter_damage_not_visible(struct kunit *test)
 }
 
 static struct kunit_case drm_damage_helper_tests[] = {
-	KUNIT_CASE(igt_damage_iter_no_damage),
-	KUNIT_CASE(igt_damage_iter_no_damage_fractional_src),
-	KUNIT_CASE(igt_damage_iter_no_damage_src_moved),
-	KUNIT_CASE(igt_damage_iter_no_damage_fractional_src_moved),
-	KUNIT_CASE(igt_damage_iter_no_damage_not_visible),
-	KUNIT_CASE(igt_damage_iter_no_damage_no_crtc),
-	KUNIT_CASE(igt_damage_iter_no_damage_no_fb),
-	KUNIT_CASE(igt_damage_iter_simple_damage),
-	KUNIT_CASE(igt_damage_iter_single_damage),
-	KUNIT_CASE(igt_damage_iter_single_damage_intersect_src),
-	KUNIT_CASE(igt_damage_iter_single_damage_outside_src),
-	KUNIT_CASE(igt_damage_iter_single_damage_fractional_src),
-	KUNIT_CASE(igt_damage_iter_single_damage_intersect_fractional_src),
-	KUNIT_CASE(igt_damage_iter_single_damage_outside_fractional_src),
-	KUNIT_CASE(igt_damage_iter_single_damage_src_moved),
-	KUNIT_CASE(igt_damage_iter_single_damage_fractional_src_moved),
-	KUNIT_CASE(igt_damage_iter_damage),
-	KUNIT_CASE(igt_damage_iter_damage_one_intersect),
-	KUNIT_CASE(igt_damage_iter_damage_one_outside),
-	KUNIT_CASE(igt_damage_iter_damage_src_moved),
-	KUNIT_CASE(igt_damage_iter_damage_not_visible),
+	KUNIT_CASE(drm_damage_iter_no_damage),
+	KUNIT_CASE(drm_damage_iter_no_damage_fractional_src),
+	KUNIT_CASE(drm_damage_iter_no_damage_src_moved),
+	KUNIT_CASE(drm_damage_iter_no_damage_fractional_src_moved),
+	KUNIT_CASE(drm_damage_iter_no_damage_not_visible),
+	KUNIT_CASE(drm_damage_iter_no_damage_no_crtc),
+	KUNIT_CASE(drm_damage_iter_no_damage_no_fb),
+	KUNIT_CASE(drm_damage_iter_simple_damage),
+	KUNIT_CASE(drm_damage_iter_single_damage),
+	KUNIT_CASE(drm_damage_iter_single_damage_intersect_src),
+	KUNIT_CASE(drm_damage_iter_single_damage_outside_src),
+	KUNIT_CASE(drm_damage_iter_single_damage_fractional_src),
+	KUNIT_CASE(drm_damage_iter_single_damage_intersect_fractional_src),
+	KUNIT_CASE(drm_damage_iter_single_damage_outside_fractional_src),
+	KUNIT_CASE(drm_damage_iter_single_damage_src_moved),
+	KUNIT_CASE(drm_damage_iter_single_damage_fractional_src_moved),
+	KUNIT_CASE(drm_damage_iter_damage),
+	KUNIT_CASE(drm_damage_iter_damage_one_intersect),
+	KUNIT_CASE(drm_damage_iter_damage_one_outside),
+	KUNIT_CASE(drm_damage_iter_damage_src_moved),
+	KUNIT_CASE(drm_damage_iter_damage_not_visible),
 	{ }
 };
 
diff --git a/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c b/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c
index 1d2fade56227..88fc661b5559 100644
--- a/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c
@@ -16,7 +16,7 @@
 
 #include "../display/drm_dp_mst_topology_internal.h"
 
-static void igt_dp_mst_calc_pbn_mode(struct kunit *test)
+static void drm_dp_mst_calc_pbn_mode(struct kunit *test)
 {
 	int pbn, i;
 	const struct {
@@ -177,7 +177,7 @@ sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
 	return result;
 }
 
-static void igt_dp_mst_sideband_msg_req_decode(struct kunit *test)
+static void drm_dp_mst_sideband_msg_req_decode(struct kunit *test)
 {
 	struct drm_dp_sideband_msg_req_body in = { 0 };
 	u8 data[] = { 0xff, 0x0, 0xdd };
@@ -271,8 +271,8 @@ static void igt_dp_mst_sideband_msg_req_decode(struct kunit *test)
 }
 
 static struct kunit_case drm_dp_mst_helper_tests[] = {
-	KUNIT_CASE(igt_dp_mst_calc_pbn_mode),
-	KUNIT_CASE(igt_dp_mst_sideband_msg_req_decode),
+	KUNIT_CASE(drm_dp_mst_calc_pbn_mode),
+	KUNIT_CASE(drm_dp_mst_sideband_msg_req_decode),
 	{ }
 };
 
diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 828487071796..322240d7fceb 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -192,7 +192,7 @@ static void convert_xrgb8888_case_desc(struct convert_xrgb8888_case *t,
 KUNIT_ARRAY_PARAM(convert_xrgb8888, convert_xrgb8888_cases,
 		  convert_xrgb8888_case_desc);
 
-static void xrgb8888_to_rgb332_test(struct kunit *test)
+static void drm_fb_xrgb8888_to_rgb332_test(struct kunit *test)
 {
 	const struct convert_xrgb8888_case *params = test->param_value;
 	const struct convert_to_rgb332_result *result = &params->rgb332_result;
@@ -222,7 +222,7 @@ static void xrgb8888_to_rgb332_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
 }
 
-static void xrgb8888_to_rgb565_test(struct kunit *test)
+static void drm_fb_xrgb8888_to_rgb565_test(struct kunit *test)
 {
 	const struct convert_xrgb8888_case *params = test->param_value;
 	const struct convert_to_rgb565_result *result = &params->rgb565_result;
@@ -256,8 +256,8 @@ static void xrgb8888_to_rgb565_test(struct kunit *test)
 }
 
 static struct kunit_case drm_format_helper_test_cases[] = {
-	KUNIT_CASE_PARAM(xrgb8888_to_rgb332_test, convert_xrgb8888_gen_params),
-	KUNIT_CASE_PARAM(xrgb8888_to_rgb565_test, convert_xrgb8888_gen_params),
+	KUNIT_CASE_PARAM(drm_fb_xrgb8888_to_rgb332_test, convert_xrgb8888_gen_params),
+	KUNIT_CASE_PARAM(drm_fb_xrgb8888_to_rgb565_test, convert_xrgb8888_gen_params),
 	{}
 };
 
diff --git a/drivers/gpu/drm/tests/drm_format_test.c b/drivers/gpu/drm/tests/drm_format_test.c
index afb4bca72187..ed8b4a2dd849 100644
--- a/drivers/gpu/drm/tests/drm_format_test.c
+++ b/drivers/gpu/drm/tests/drm_format_test.c
@@ -9,7 +9,7 @@
 
 #include <drm/drm_fourcc.h>
 
-static void igt_check_drm_format_block_width(struct kunit *test)
+static void drm_format_block_width_test(struct kunit *test)
 {
 	const struct drm_format_info *info = NULL;
 
@@ -50,7 +50,7 @@ static void igt_check_drm_format_block_width(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, drm_format_info_block_width(info, -1));
 }
 
-static void igt_check_drm_format_block_height(struct kunit *test)
+static void drm_format_block_height_test(struct kunit *test)
 {
 	const struct drm_format_info *info = NULL;
 
@@ -91,7 +91,7 @@ static void igt_check_drm_format_block_height(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, drm_format_info_block_height(info, -1));
 }
 
-static void igt_check_drm_format_min_pitch_for_single_plane(struct kunit *test)
+static void drm_format_min_pitch_for_single_plane_test(struct kunit *test)
 {
 	const struct drm_format_info *info = NULL;
 
@@ -177,7 +177,7 @@ static void igt_check_drm_format_min_pitch_for_single_plane(struct kunit *test)
 			(uint64_t)(UINT_MAX - 1) * 4);
 }
 
-static void igt_check_drm_format_min_pitch_for_multi_planar(struct kunit *test)
+static void drm_format_min_pitch_for_multi_planar_test(struct kunit *test)
 {
 	const struct drm_format_info *info = NULL;
 
@@ -256,7 +256,7 @@ static void igt_check_drm_format_min_pitch_for_multi_planar(struct kunit *test)
 			(uint64_t)(UINT_MAX - 1) / 2);
 }
 
-static void igt_check_drm_format_min_pitch_for_tiled_format(struct kunit *test)
+static void drm_format_min_pitch_for_tiled_format_test(struct kunit *test)
 {
 	const struct drm_format_info *info = NULL;
 
@@ -281,11 +281,11 @@ static void igt_check_drm_format_min_pitch_for_tiled_format(struct kunit *test)
 }
 
 static struct kunit_case drm_format_tests[] = {
-	KUNIT_CASE(igt_check_drm_format_block_width),
-	KUNIT_CASE(igt_check_drm_format_block_height),
-	KUNIT_CASE(igt_check_drm_format_min_pitch_for_single_plane),
-	KUNIT_CASE(igt_check_drm_format_min_pitch_for_multi_planar),
-	KUNIT_CASE(igt_check_drm_format_min_pitch_for_tiled_format),
+	KUNIT_CASE(drm_format_block_width_test),
+	KUNIT_CASE(drm_format_block_height_test),
+	KUNIT_CASE(drm_format_min_pitch_for_single_plane_test),
+	KUNIT_CASE(drm_format_min_pitch_for_multi_planar_test),
+	KUNIT_CASE(drm_format_min_pitch_for_tiled_format_test),
 	{ }
 };
 
diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
index 1e2c1aa524bd..a50fd1ef2af5 100644
--- a/drivers/gpu/drm/tests/drm_mm_test.c
+++ b/drivers/gpu/drm/tests/drm_mm_test.c
@@ -191,7 +191,7 @@ static bool assert_node(struct kunit *test, struct drm_mm_node *node, struct drm
 	return ok;
 }
 
-static void igt_mm_init(struct kunit *test)
+static void drm_mm_check_init(struct kunit *test)
 {
 	const unsigned int size = 4096;
 	struct drm_mm mm;
@@ -245,7 +245,7 @@ static void igt_mm_init(struct kunit *test)
 	drm_mm_takedown(&mm);
 }
 
-static void igt_mm_debug(struct kunit *test)
+static void drm_mm_debug(struct kunit *test)
 {
 	struct drm_mm mm;
 	struct drm_mm_node nodes[2];
@@ -341,7 +341,7 @@ static bool check_reserve_boundaries(struct kunit *test, struct drm_mm *mm,
 	return true;
 }
 
-static int __igt_reserve(struct kunit *test, unsigned int count, u64 size)
+static int __drm_mm_reserve(struct kunit *test, unsigned int count, u64 size)
 {
 	DRM_RND_STATE(prng, random_seed);
 	struct drm_mm mm;
@@ -349,7 +349,7 @@ static int __igt_reserve(struct kunit *test, unsigned int count, u64 size)
 	unsigned int *order, n, m, o = 0;
 	int ret, err;
 
-	/* For exercising drm_mm_reserve_node(struct kunit *test, ), we want to check that
+	/* For exercising drm_mm_reserve_node(), we want to check that
 	 * reservations outside of the drm_mm range are rejected, and to
 	 * overlapping and otherwise already occupied ranges. Afterwards,
 	 * the tree and nodes should be intact.
@@ -463,7 +463,7 @@ static int __igt_reserve(struct kunit *test, unsigned int count, u64 size)
 	return ret;
 }
 
-static void igt_mm_reserve(struct kunit *test)
+static void drm_mm_reserve(struct kunit *test)
 {
 	const unsigned int count = min_t(unsigned int, BIT(10), max_iterations);
 	int n;
@@ -471,9 +471,9 @@ static void igt_mm_reserve(struct kunit *test)
 	for_each_prime_number_from(n, 1, 54) {
 		u64 size = BIT_ULL(n);
 
-		KUNIT_ASSERT_FALSE(test, __igt_reserve(test, count, size - 1));
-		KUNIT_ASSERT_FALSE(test, __igt_reserve(test, count, size));
-		KUNIT_ASSERT_FALSE(test, __igt_reserve(test, count, size + 1));
+		KUNIT_ASSERT_FALSE(test, __drm_mm_reserve(test, count, size - 1));
+		KUNIT_ASSERT_FALSE(test, __drm_mm_reserve(test, count, size));
+		KUNIT_ASSERT_FALSE(test, __drm_mm_reserve(test, count, size + 1));
 
 		cond_resched();
 	}
@@ -524,7 +524,7 @@ static bool expect_insert_fail(struct kunit *test, struct drm_mm *mm, u64 size)
 	return false;
 }
 
-static int __igt_insert(struct kunit *test, unsigned int count, u64 size, bool replace)
+static int __drm_mm_insert(struct kunit *test, unsigned int count, u64 size, bool replace)
 {
 	DRM_RND_STATE(prng, random_seed);
 	const struct insert_mode *mode;
@@ -660,7 +660,7 @@ static int __igt_insert(struct kunit *test, unsigned int count, u64 size, bool r
 	return ret;
 }
 
-static void igt_mm_insert(struct kunit *test)
+static void drm_mm_insert(struct kunit *test)
 {
 	const unsigned int count = min_t(unsigned int, BIT(10), max_iterations);
 	unsigned int n;
@@ -668,20 +668,20 @@ static void igt_mm_insert(struct kunit *test)
 	for_each_prime_number_from(n, 1, 54) {
 		u64 size = BIT_ULL(n);
 
-		KUNIT_ASSERT_FALSE(test, __igt_insert(test, count, size - 1, false));
-		KUNIT_ASSERT_FALSE(test, __igt_insert(test, count, size, false));
-		KUNIT_ASSERT_FALSE(test, __igt_insert(test, count, size + 1, false));
+		KUNIT_ASSERT_FALSE(test, __drm_mm_insert(test, count, size - 1, false));
+		KUNIT_ASSERT_FALSE(test, __drm_mm_insert(test, count, size, false));
+		KUNIT_ASSERT_FALSE(test, __drm_mm_insert(test, count, size + 1, false));
 
 		cond_resched();
 	}
 }
 
-static void igt_mm_replace(struct kunit *test)
+static void drm_mm_replace(struct kunit *test)
 {
 	const unsigned int count = min_t(unsigned int, BIT(10), max_iterations);
 	unsigned int n;
 
-	/* Reuse igt_insert to exercise replacement by inserting a dummy node,
+	/* Reuse __drm_mm_insert to exercise replacement by inserting a dummy node,
 	 * then replacing it with the intended node. We want to check that
 	 * the tree is intact and all the information we need is carried
 	 * across to the target node.
@@ -690,9 +690,9 @@ static void igt_mm_replace(struct kunit *test)
 	for_each_prime_number_from(n, 1, 54) {
 		u64 size = BIT_ULL(n);
 
-		KUNIT_ASSERT_FALSE(test, __igt_insert(test, count, size - 1, true));
-		KUNIT_ASSERT_FALSE(test, __igt_insert(test, count, size, true));
-		KUNIT_ASSERT_FALSE(test, __igt_insert(test, count, size + 1, true));
+		KUNIT_ASSERT_FALSE(test, __drm_mm_insert(test, count, size - 1, true));
+		KUNIT_ASSERT_FALSE(test, __drm_mm_insert(test, count, size, true));
+		KUNIT_ASSERT_FALSE(test, __drm_mm_insert(test, count, size + 1, true));
 
 		cond_resched();
 	}
@@ -808,7 +808,8 @@ static bool assert_contiguous_in_range(struct kunit *test, struct drm_mm *mm,
 	return true;
 }
 
-static int __igt_insert_range(struct kunit *test, unsigned int count, u64 size, u64 start, u64 end)
+static int __drm_mm_insert_range(struct kunit *test, unsigned int count, u64 size,
+				 u64 start, u64 end)
 {
 	const struct insert_mode *mode;
 	struct drm_mm mm;
@@ -820,7 +821,7 @@ static int __igt_insert_range(struct kunit *test, unsigned int count, u64 size,
 	DRM_MM_BUG_ON(!size);
 	DRM_MM_BUG_ON(end <= start);
 
-	/* Very similar to __igt_insert(struct kunit *test, ), but now instead of populating the
+	/* Very similar to __drm_mm_insert(), but now instead of populating the
 	 * full range of the drm_mm, we try to fill a small portion of it.
 	 */
 
@@ -921,7 +922,7 @@ static int insert_outside_range(struct kunit *test)
 	return 0;
 }
 
-static void igt_mm_insert_range(struct kunit *test)
+static void drm_mm_insert_range(struct kunit *test)
 {
 	const unsigned int count = min_t(unsigned int, BIT(13), max_iterations);
 	unsigned int n;
@@ -933,21 +934,21 @@ static void igt_mm_insert_range(struct kunit *test)
 		const u64 size = BIT_ULL(n);
 		const u64 max = count * size;
 
-		KUNIT_ASSERT_FALSE(test, __igt_insert_range(test, count, size, 0, max));
-		KUNIT_ASSERT_FALSE(test, __igt_insert_range(test, count, size, 1, max));
-		KUNIT_ASSERT_FALSE(test, __igt_insert_range(test, count, size, 0, max - 1));
-		KUNIT_ASSERT_FALSE(test, __igt_insert_range(test, count, size, 0, max / 2));
-		KUNIT_ASSERT_FALSE(test, __igt_insert_range(test, count, size, max / 2, max / 2));
-		KUNIT_ASSERT_FALSE(test, __igt_insert_range(test, count, size,
-							    max / 4 + 1, 3 * max / 4 - 1));
+		KUNIT_ASSERT_FALSE(test, __drm_mm_insert_range(test, count, size, 0, max));
+		KUNIT_ASSERT_FALSE(test, __drm_mm_insert_range(test, count, size, 1, max));
+		KUNIT_ASSERT_FALSE(test, __drm_mm_insert_range(test, count, size, 0, max - 1));
+		KUNIT_ASSERT_FALSE(test, __drm_mm_insert_range(test, count, size, 0, max / 2));
+		KUNIT_ASSERT_FALSE(test, __drm_mm_insert_range(test, count, size,
+							       max / 2, max / 2));
+		KUNIT_ASSERT_FALSE(test, __drm_mm_insert_range(test, count, size,
+							       max / 4 + 1, 3 * max / 4 - 1));
 
 		cond_resched();
 	}
 }
 
-static int prepare_igt_frag(struct kunit *test, struct drm_mm *mm,
-			    struct drm_mm_node *nodes, unsigned int num_insert,
-			    const struct insert_mode *mode)
+static int prepare_frag(struct kunit *test, struct drm_mm *mm, struct drm_mm_node *nodes,
+			unsigned int num_insert, const struct insert_mode *mode)
 {
 	unsigned int size = 4096;
 	unsigned int i;
@@ -987,7 +988,7 @@ static u64 get_insert_time(struct kunit *test, struct drm_mm *mm,
 	return ktime_to_ns(ktime_sub(ktime_get(), start));
 }
 
-static void igt_mm_frag(struct kunit *test)
+static void drm_mm_frag(struct kunit *test)
 {
 	struct drm_mm mm;
 	const struct insert_mode *mode;
@@ -997,15 +998,15 @@ static void igt_mm_frag(struct kunit *test)
 
 	/* We need 4 * insert_size nodes to hold intermediate allocated
 	 * drm_mm nodes.
-	 * 1 times for prepare_igt_frag(struct kunit *test, )
-	 * 1 times for get_insert_time(struct kunit *test, )
-	 * 2 times for get_insert_time(struct kunit *test, )
+	 * 1 times for prepare_frag()
+	 * 1 times for get_insert_time()
+	 * 2 times for get_insert_time()
 	 */
 	nodes = vzalloc(array_size(insert_size * 4, sizeof(*nodes)));
 	KUNIT_ASSERT_TRUE(test, nodes);
 
 	/* For BOTTOMUP and TOPDOWN, we first fragment the
-	 * address space using prepare_igt_frag(struct kunit *test, ) and then try to verify
+	 * address space using prepare_frag() and then try to verify
 	 * that insertions scale quadratically from 10k to 20k insertions
 	 */
 	drm_mm_init(&mm, 1, U64_MAX - 2);
@@ -1016,7 +1017,7 @@ static void igt_mm_frag(struct kunit *test)
 		    mode->mode != DRM_MM_INSERT_HIGH)
 			continue;
 
-		if (prepare_igt_frag(test, &mm, nodes, insert_size, mode))
+		if (prepare_frag(test, &mm, nodes, insert_size, mode))
 			goto err;
 
 		insert_time1 = get_insert_time(test, &mm, insert_size,
@@ -1049,7 +1050,7 @@ static void igt_mm_frag(struct kunit *test)
 	vfree(nodes);
 }
 
-static void igt_mm_align(struct kunit *test)
+static void drm_mm_align(struct kunit *test)
 {
 	const struct insert_mode *mode;
 	const unsigned int max_count = min(8192u, max_prime);
@@ -1096,7 +1097,7 @@ static void igt_mm_align(struct kunit *test)
 	vfree(nodes);
 }
 
-static void igt_align_pot(struct kunit *test, int max)
+static void drm_mm_align_pot(struct kunit *test, int max)
 {
 	struct drm_mm mm;
 	struct drm_mm_node *node, *next;
@@ -1133,14 +1134,14 @@ static void igt_align_pot(struct kunit *test, int max)
 	drm_mm_takedown(&mm);
 }
 
-static void igt_mm_align32(struct kunit *test)
+static void drm_mm_align32(struct kunit *test)
 {
-	igt_align_pot(test, 32);
+	drm_mm_align_pot(test, 32);
 }
 
-static void igt_mm_align64(struct kunit *test)
+static void drm_mm_align64(struct kunit *test)
 {
-	igt_align_pot(test, 64);
+	drm_mm_align_pot(test, 64);
 }
 
 static void show_scan(struct kunit *test, const struct drm_mm_scan *scan)
@@ -1386,7 +1387,7 @@ static int evict_something(struct kunit *test, struct drm_mm *mm,
 	return 0;
 }
 
-static void igt_mm_evict(struct kunit *test)
+static void drm_mm_evict(struct kunit *test)
 {
 	DRM_RND_STATE(prng, random_seed);
 	const unsigned int size = 8192;
@@ -1477,7 +1478,7 @@ static void igt_mm_evict(struct kunit *test)
 	vfree(nodes);
 }
 
-static void igt_mm_evict_range(struct kunit *test)
+static void drm_mm_evict_range(struct kunit *test)
 {
 	DRM_RND_STATE(prng, random_seed);
 	const unsigned int size = 8192;
@@ -1490,7 +1491,7 @@ static void igt_mm_evict_range(struct kunit *test)
 	struct drm_mm_node *node, *next;
 	unsigned int *order, n;
 
-	/* Like igt_evict() but now we are limiting the search to a
+	/* Like drm_mm_evict() but now we are limiting the search to a
 	 * small portion of the full drm_mm.
 	 */
 
@@ -1564,7 +1565,7 @@ static unsigned int node_index(const struct drm_mm_node *node)
 	return div64_u64(node->start, node->size);
 }
 
-static void igt_mm_topdown(struct kunit *test)
+static void drm_mm_topdown(struct kunit *test)
 {
 	const struct insert_mode *topdown = &insert_modes[TOPDOWN];
 
@@ -1671,7 +1672,7 @@ static void igt_mm_topdown(struct kunit *test)
 	vfree(nodes);
 }
 
-static void igt_mm_bottomup(struct kunit *test)
+static void drm_mm_bottomup(struct kunit *test)
 {
 	const struct insert_mode *bottomup = &insert_modes[BOTTOMUP];
 
@@ -1683,7 +1684,7 @@ static void igt_mm_bottomup(struct kunit *test)
 	struct drm_mm_node *nodes, *node, *next;
 	unsigned int *order, n, m, o = 0;
 
-	/* Like igt_topdown, but instead of searching for the last hole,
+	/* Like drm_mm_topdown, but instead of searching for the last hole,
 	 * we search for the first.
 	 */
 
@@ -1763,7 +1764,7 @@ static void igt_mm_bottomup(struct kunit *test)
 	vfree(nodes);
 }
 
-static void __igt_once(struct kunit *test, unsigned int mode)
+static void __drm_mm_once(struct kunit *test, unsigned int mode)
 {
 	struct drm_mm mm;
 	struct drm_mm_node rsvd_lo, rsvd_hi, node;
@@ -1806,14 +1807,14 @@ static void __igt_once(struct kunit *test, unsigned int mode)
 	drm_mm_takedown(&mm);
 }
 
-static void igt_mm_lowest(struct kunit *test)
+static void drm_mm_lowest(struct kunit *test)
 {
-	__igt_once(test, DRM_MM_INSERT_LOW);
+	__drm_mm_once(test, DRM_MM_INSERT_LOW);
 }
 
-static void igt_mm_highest(struct kunit *test)
+static void drm_mm_highest(struct kunit *test)
 {
-	__igt_once(test, DRM_MM_INSERT_HIGH);
+	__drm_mm_once(test, DRM_MM_INSERT_HIGH);
 }
 
 static void separate_adjacent_colors(const struct drm_mm_node *node,
@@ -1842,7 +1843,7 @@ static bool colors_abutt(struct kunit *test, const struct drm_mm_node *node)
 	return false;
 }
 
-static void igt_mm_color(struct kunit *test)
+static void drm_mm_color(struct kunit *test)
 {
 	const unsigned int count = min(4096u, max_iterations);
 	const struct insert_mode *mode;
@@ -2041,7 +2042,7 @@ static int evict_color(struct kunit *test, struct drm_mm *mm, u64 range_start,
 	return 0;
 }
 
-static void igt_mm_color_evict(struct kunit *test)
+static void drm_mm_color_evict(struct kunit *test)
 {
 	DRM_RND_STATE(prng, random_seed);
 	const unsigned int total_size = min(8192u, max_iterations);
@@ -2122,7 +2123,7 @@ static void igt_mm_color_evict(struct kunit *test)
 	vfree(nodes);
 }
 
-static void igt_mm_color_evict_range(struct kunit *test)
+static void drm_mm_color_evict_range(struct kunit *test)
 {
 	DRM_RND_STATE(prng, random_seed);
 	const unsigned int total_size = 8192;
@@ -2136,7 +2137,7 @@ static void igt_mm_color_evict_range(struct kunit *test)
 	struct drm_mm_node *node, *next;
 	unsigned int *order, n;
 
-	/* Like igt_color_evict(), but limited to small portion of the full
+	/* Like drm_mm_color_evict(), but limited to small portion of the full
 	 * drm_mm range.
 	 */
 
@@ -2221,25 +2222,25 @@ module_param(max_iterations, uint, 0400);
 module_param(max_prime, uint, 0400);
 
 static struct kunit_case drm_mm_tests[] = {
-	KUNIT_CASE(igt_mm_init),
-	KUNIT_CASE(igt_mm_debug),
-	KUNIT_CASE(igt_mm_reserve),
-	KUNIT_CASE(igt_mm_insert),
-	KUNIT_CASE(igt_mm_replace),
-	KUNIT_CASE(igt_mm_insert_range),
-	KUNIT_CASE(igt_mm_frag),
-	KUNIT_CASE(igt_mm_align),
-	KUNIT_CASE(igt_mm_align32),
-	KUNIT_CASE(igt_mm_align64),
-	KUNIT_CASE(igt_mm_evict),
-	KUNIT_CASE(igt_mm_evict_range),
-	KUNIT_CASE(igt_mm_topdown),
-	KUNIT_CASE(igt_mm_bottomup),
-	KUNIT_CASE(igt_mm_lowest),
-	KUNIT_CASE(igt_mm_highest),
-	KUNIT_CASE(igt_mm_color),
-	KUNIT_CASE(igt_mm_color_evict),
-	KUNIT_CASE(igt_mm_color_evict_range),
+	KUNIT_CASE(drm_mm_check_init),
+	KUNIT_CASE(drm_mm_debug),
+	KUNIT_CASE(drm_mm_reserve),
+	KUNIT_CASE(drm_mm_insert),
+	KUNIT_CASE(drm_mm_replace),
+	KUNIT_CASE(drm_mm_insert_range),
+	KUNIT_CASE(drm_mm_frag),
+	KUNIT_CASE(drm_mm_align),
+	KUNIT_CASE(drm_mm_align32),
+	KUNIT_CASE(drm_mm_align64),
+	KUNIT_CASE(drm_mm_evict),
+	KUNIT_CASE(drm_mm_evict_range),
+	KUNIT_CASE(drm_mm_topdown),
+	KUNIT_CASE(drm_mm_bottomup),
+	KUNIT_CASE(drm_mm_lowest),
+	KUNIT_CASE(drm_mm_highest),
+	KUNIT_CASE(drm_mm_color),
+	KUNIT_CASE(drm_mm_color_evict),
+	KUNIT_CASE(drm_mm_color_evict_range),
 	{}
 };
 
diff --git a/drivers/gpu/drm/tests/drm_plane_helper_test.c b/drivers/gpu/drm/tests/drm_plane_helper_test.c
index be6cff0020ed..90843395fd28 100644
--- a/drivers/gpu/drm/tests/drm_plane_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_plane_helper_test.c
@@ -73,7 +73,7 @@ static bool check_crtc_eq(struct drm_plane_state *plane_state,
 	return true;
 }
 
-static void igt_check_plane_state(struct kunit *test)
+static void drm_check_plane_state_desc(struct kunit *test)
 {
 	int ret;
 
@@ -223,7 +223,7 @@ static void igt_check_plane_state(struct kunit *test)
 }
 
 static struct kunit_case drm_plane_helper_test[] = {
-	KUNIT_CASE(igt_check_plane_state),
+	KUNIT_CASE(drm_check_plane_state_desc),
 	{}
 };
 
diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/tests/drm_rect_test.c
index c1dbefd49a4c..a1a94781862f 100644
--- a/drivers/gpu/drm/tests/drm_rect_test.c
+++ b/drivers/gpu/drm/tests/drm_rect_test.c
@@ -9,7 +9,7 @@
 
 #include <drm/drm_rect.h>
 
-static void igt_drm_rect_clip_scaled_div_by_zero(struct kunit *test)
+static void drm_rect_clip_scaled_div_by_zero(struct kunit *test)
 {
 	struct drm_rect src, dst, clip;
 	bool visible;
@@ -35,7 +35,7 @@ static void igt_drm_rect_clip_scaled_div_by_zero(struct kunit *test)
 	KUNIT_EXPECT_FALSE_MSG(test, drm_rect_visible(&src), "Source should not be visible\n");
 }
 
-static void igt_drm_rect_clip_scaled_not_clipped(struct kunit *test)
+static void drm_rect_clip_scaled_not_clipped(struct kunit *test)
 {
 	struct drm_rect src, dst, clip;
 	bool visible;
@@ -83,7 +83,7 @@ static void igt_drm_rect_clip_scaled_not_clipped(struct kunit *test)
 	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
 }
 
-static void igt_drm_rect_clip_scaled_clipped(struct kunit *test)
+static void drm_rect_clip_scaled_clipped(struct kunit *test)
 {
 	struct drm_rect src, dst, clip;
 	bool visible;
@@ -173,7 +173,7 @@ static void igt_drm_rect_clip_scaled_clipped(struct kunit *test)
 	KUNIT_EXPECT_TRUE_MSG(test, drm_rect_visible(&src), "Source should be visible\n");
 }
 
-static void igt_drm_rect_clip_scaled_signed_vs_unsigned(struct kunit *test)
+static void drm_rect_clip_scaled_signed_vs_unsigned(struct kunit *test)
 {
 	struct drm_rect src, dst, clip;
 	bool visible;
@@ -197,10 +197,10 @@ static void igt_drm_rect_clip_scaled_signed_vs_unsigned(struct kunit *test)
 }
 
 static struct kunit_case drm_rect_tests[] = {
-	KUNIT_CASE(igt_drm_rect_clip_scaled_div_by_zero),
-	KUNIT_CASE(igt_drm_rect_clip_scaled_not_clipped),
-	KUNIT_CASE(igt_drm_rect_clip_scaled_clipped),
-	KUNIT_CASE(igt_drm_rect_clip_scaled_signed_vs_unsigned),
+	KUNIT_CASE(drm_rect_clip_scaled_div_by_zero),
+	KUNIT_CASE(drm_rect_clip_scaled_not_clipped),
+	KUNIT_CASE(drm_rect_clip_scaled_clipped),
+	KUNIT_CASE(drm_rect_clip_scaled_signed_vs_unsigned),
 	{ }
 };
 
-- 
2.37.2

