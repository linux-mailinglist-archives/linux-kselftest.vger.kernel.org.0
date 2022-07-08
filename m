Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0E056C1EB
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Jul 2022 01:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbiGHUdd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jul 2022 16:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240152AbiGHUc6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jul 2022 16:32:58 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620B7A23B8
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jul 2022 13:32:39 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w83so86345oiw.1
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jul 2022 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aYe8NPdG0wewkzIt6EnqBYrp6cug+uOho4B7z8nZIkQ=;
        b=ojqnb/xcx/VNtGHqthnX2CDAbIqDScuCk42DAqIdp1KED3m7VYPcheTEvdfkssU4v4
         WXsXgNlnn34gjUwQuJGJRZ8G+Vd+nSTmRJJuHOR36hBpbhtjhrU3+i3BSxDpainoTq9V
         Qjwk1uD1W9HwQ6Psenfvhp/kQx2h08d3r3K/sIJ13NtEidujgERPw/xxecaYS8G8xDAz
         wZitQj3fGl9NXDzRMMfq+P70agciprUCAoWXiGqD7xjoMyNIoDtXlRTjQjS4Dub3sPbg
         ClkG0TOemvneNmUzWLv7TakJkK53c2isJCFZ0BzeVw72t3J/R84aDR7HlJJ1g0ZR2dNb
         r2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aYe8NPdG0wewkzIt6EnqBYrp6cug+uOho4B7z8nZIkQ=;
        b=1ZGgCrHW5cElezQ3ZJq3VXr27twQuoRon5sle5znflvXXWxou5fX8As4m0n0vSR7uu
         ZXjdk2pHpJIX5ackvVmOPPrkGviGjriGfHvQetHits7MSeMSjNUxAezkKko/SVmzmLvd
         kXAq9JiSiFsLFwu7xnLPxs8VF7fnrUd8/j9IKM3kudWSlWEy3rBilm7SCUc5wrCtiLgW
         RYHOMXS1gd0TCfLGk0YOIJUksO+7Yv6/GjOfT7wXl4iQp/nWhffBJmkcWOJgBleTwMm0
         GW6PR1SuKYeUuLZcbZvPUaBTfzJ+6xr1Rd5ezcYrQTVJ0MKOqX65X2QOdbHVK2rw+7Ct
         ezRw==
X-Gm-Message-State: AJIora94U3gAIDuE5mnUSkvF0XG4UemkPCi/3EyPkv3N2Ll20g/THtvt
        BvxZOX9YrAuIXLk3JPxHQ6VMNw==
X-Google-Smtp-Source: AGRyM1vAuGW6KhxmAm23eDJRZM2t1L9mItqWBrW3OZbCaqcu70lzMMBgmWdt9sK0pHIP/rqSjkVd3A==
X-Received: by 2002:a05:6808:2395:b0:335:93c2:5804 with SMTP id bp21-20020a056808239500b0033593c25804mr1012259oib.2.1657312358236;
        Fri, 08 Jul 2022 13:32:38 -0700 (PDT)
Received: from fedora.. ([143.107.182.242])
        by smtp.gmail.com with ESMTPSA id ci10-20020a05683063ca00b0061c309b1dc2sm742225otb.39.2022.07.08.13.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:32:37 -0700 (PDT)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
To:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        michal.winiarski@intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>
Subject: [PATCH v5 8/9] drm: selftest: convert drm_buddy selftest to KUnit
Date:   Fri,  8 Jul 2022 17:30:51 -0300
Message-Id: <20220708203052.236290-9-maira.canal@usp.br>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220708203052.236290-1-maira.canal@usp.br>
References: <20220708203052.236290-1-maira.canal@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Considering the current adoption of the KUnit framework, convert the
DRM buddy selftest to the KUnit API.

Tested-by: David Gow <davidgow@google.com>
Acked-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/gpu/drm/selftests/Makefile            |   2 +-
 .../gpu/drm/selftests/drm_buddy_selftests.h   |  15 -
 drivers/gpu/drm/selftests/test-drm_buddy.c    | 994 ------------------
 drivers/gpu/drm/tests/Makefile                |   2 +-
 drivers/gpu/drm/tests/drm_buddy_test.c        | 756 +++++++++++++
 5 files changed, 758 insertions(+), 1011 deletions(-)
 delete mode 100644 drivers/gpu/drm/selftests/drm_buddy_selftests.h
 delete mode 100644 drivers/gpu/drm/selftests/test-drm_buddy.c
 create mode 100644 drivers/gpu/drm/tests/drm_buddy_test.c

diff --git a/drivers/gpu/drm/selftests/Makefile b/drivers/gpu/drm/selftests/Makefile
index f7db628b60cb..a4ebecb8146b 100644
--- a/drivers/gpu/drm/selftests/Makefile
+++ b/drivers/gpu/drm/selftests/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o test-drm_buddy.o
+obj-$(CONFIG_DRM_DEBUG_SELFTEST) += test-drm_mm.o
diff --git a/drivers/gpu/drm/selftests/drm_buddy_selftests.h b/drivers/gpu/drm/selftests/drm_buddy_selftests.h
deleted file mode 100644
index 455b756c4ae5..000000000000
--- a/drivers/gpu/drm/selftests/drm_buddy_selftests.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* List each unit test as selftest(name, function)
- *
- * The name is used as both an enum and expanded as igt__name to create
- * a module parameter. It must be unique and legal for a C identifier.
- *
- * Tests are executed in order by igt/drm_buddy
- */
-selftest(sanitycheck, igt_sanitycheck) /* keep first (selfcheck for igt) */
-selftest(buddy_alloc_limit, igt_buddy_alloc_limit)
-selftest(buddy_alloc_range, igt_buddy_alloc_range)
-selftest(buddy_alloc_optimistic, igt_buddy_alloc_optimistic)
-selftest(buddy_alloc_pessimistic, igt_buddy_alloc_pessimistic)
-selftest(buddy_alloc_smoke, igt_buddy_alloc_smoke)
-selftest(buddy_alloc_pathological, igt_buddy_alloc_pathological)
diff --git a/drivers/gpu/drm/selftests/test-drm_buddy.c b/drivers/gpu/drm/selftests/test-drm_buddy.c
deleted file mode 100644
index aca0c491040f..000000000000
--- a/drivers/gpu/drm/selftests/test-drm_buddy.c
+++ /dev/null
@@ -1,994 +0,0 @@
-// SPDX-License-Identifier: MIT
-/*
- * Copyright © 2019 Intel Corporation
- */
-
-#define pr_fmt(fmt) "drm_buddy: " fmt
-
-#include <linux/module.h>
-#include <linux/prime_numbers.h>
-#include <linux/sched/signal.h>
-
-#include <drm/drm_buddy.h>
-
-#include "../lib/drm_random.h"
-
-#define TESTS "drm_buddy_selftests.h"
-#include "drm_selftest.h"
-
-#define IGT_TIMEOUT(name__) \
-	unsigned long name__ = jiffies + MAX_SCHEDULE_TIMEOUT
-
-static unsigned int random_seed;
-
-static inline u64 get_size(int order, u64 chunk_size)
-{
-	return (1 << order) * chunk_size;
-}
-
-__printf(2, 3)
-static bool __igt_timeout(unsigned long timeout, const char *fmt, ...)
-{
-	va_list va;
-
-	if (!signal_pending(current)) {
-		cond_resched();
-		if (time_before(jiffies, timeout))
-			return false;
-	}
-
-	if (fmt) {
-		va_start(va, fmt);
-		vprintk(fmt, va);
-		va_end(va);
-	}
-
-	return true;
-}
-
-static inline const char *yesno(bool v)
-{
-	return v ? "yes" : "no";
-}
-
-static void __igt_dump_block(struct drm_buddy *mm,
-			     struct drm_buddy_block *block,
-			     bool buddy)
-{
-	pr_err("block info: header=%llx, state=%u, order=%d, offset=%llx size=%llx root=%s buddy=%s\n",
-	       block->header,
-	       drm_buddy_block_state(block),
-	       drm_buddy_block_order(block),
-	       drm_buddy_block_offset(block),
-	       drm_buddy_block_size(mm, block),
-	       yesno(!block->parent),
-	       yesno(buddy));
-}
-
-static void igt_dump_block(struct drm_buddy *mm,
-			   struct drm_buddy_block *block)
-{
-	struct drm_buddy_block *buddy;
-
-	__igt_dump_block(mm, block, false);
-
-	buddy = drm_get_buddy(block);
-	if (buddy)
-		__igt_dump_block(mm, buddy, true);
-}
-
-static int igt_check_block(struct drm_buddy *mm,
-			   struct drm_buddy_block *block)
-{
-	struct drm_buddy_block *buddy;
-	unsigned int block_state;
-	u64 block_size;
-	u64 offset;
-	int err = 0;
-
-	block_state = drm_buddy_block_state(block);
-
-	if (block_state != DRM_BUDDY_ALLOCATED &&
-	    block_state != DRM_BUDDY_FREE &&
-	    block_state != DRM_BUDDY_SPLIT) {
-		pr_err("block state mismatch\n");
-		err = -EINVAL;
-	}
-
-	block_size = drm_buddy_block_size(mm, block);
-	offset = drm_buddy_block_offset(block);
-
-	if (block_size < mm->chunk_size) {
-		pr_err("block size smaller than min size\n");
-		err = -EINVAL;
-	}
-
-	if (!is_power_of_2(block_size)) {
-		pr_err("block size not power of two\n");
-		err = -EINVAL;
-	}
-
-	if (!IS_ALIGNED(block_size, mm->chunk_size)) {
-		pr_err("block size not aligned to min size\n");
-		err = -EINVAL;
-	}
-
-	if (!IS_ALIGNED(offset, mm->chunk_size)) {
-		pr_err("block offset not aligned to min size\n");
-		err = -EINVAL;
-	}
-
-	if (!IS_ALIGNED(offset, block_size)) {
-		pr_err("block offset not aligned to block size\n");
-		err = -EINVAL;
-	}
-
-	buddy = drm_get_buddy(block);
-
-	if (!buddy && block->parent) {
-		pr_err("buddy has gone fishing\n");
-		err = -EINVAL;
-	}
-
-	if (buddy) {
-		if (drm_buddy_block_offset(buddy) != (offset ^ block_size)) {
-			pr_err("buddy has wrong offset\n");
-			err = -EINVAL;
-		}
-
-		if (drm_buddy_block_size(mm, buddy) != block_size) {
-			pr_err("buddy size mismatch\n");
-			err = -EINVAL;
-		}
-
-		if (drm_buddy_block_state(buddy) == block_state &&
-		    block_state == DRM_BUDDY_FREE) {
-			pr_err("block and its buddy are free\n");
-			err = -EINVAL;
-		}
-	}
-
-	return err;
-}
-
-static int igt_check_blocks(struct drm_buddy *mm,
-			    struct list_head *blocks,
-			    u64 expected_size,
-			    bool is_contiguous)
-{
-	struct drm_buddy_block *block;
-	struct drm_buddy_block *prev;
-	u64 total;
-	int err = 0;
-
-	block = NULL;
-	prev = NULL;
-	total = 0;
-
-	list_for_each_entry(block, blocks, link) {
-		err = igt_check_block(mm, block);
-
-		if (!drm_buddy_block_is_allocated(block)) {
-			pr_err("block not allocated\n"),
-			       err = -EINVAL;
-		}
-
-		if (is_contiguous && prev) {
-			u64 prev_block_size;
-			u64 prev_offset;
-			u64 offset;
-
-			prev_offset = drm_buddy_block_offset(prev);
-			prev_block_size = drm_buddy_block_size(mm, prev);
-			offset = drm_buddy_block_offset(block);
-
-			if (offset != (prev_offset + prev_block_size)) {
-				pr_err("block offset mismatch\n");
-				err = -EINVAL;
-			}
-		}
-
-		if (err)
-			break;
-
-		total += drm_buddy_block_size(mm, block);
-		prev = block;
-	}
-
-	if (!err) {
-		if (total != expected_size) {
-			pr_err("size mismatch, expected=%llx, found=%llx\n",
-			       expected_size, total);
-			err = -EINVAL;
-		}
-		return err;
-	}
-
-	if (prev) {
-		pr_err("prev block, dump:\n");
-		igt_dump_block(mm, prev);
-	}
-
-	pr_err("bad block, dump:\n");
-	igt_dump_block(mm, block);
-
-	return err;
-}
-
-static int igt_check_mm(struct drm_buddy *mm)
-{
-	struct drm_buddy_block *root;
-	struct drm_buddy_block *prev;
-	unsigned int i;
-	u64 total;
-	int err = 0;
-
-	if (!mm->n_roots) {
-		pr_err("n_roots is zero\n");
-		return -EINVAL;
-	}
-
-	if (mm->n_roots != hweight64(mm->size)) {
-		pr_err("n_roots mismatch, n_roots=%u, expected=%lu\n",
-		       mm->n_roots, hweight64(mm->size));
-		return -EINVAL;
-	}
-
-	root = NULL;
-	prev = NULL;
-	total = 0;
-
-	for (i = 0; i < mm->n_roots; ++i) {
-		struct drm_buddy_block *block;
-		unsigned int order;
-
-		root = mm->roots[i];
-		if (!root) {
-			pr_err("root(%u) is NULL\n", i);
-			err = -EINVAL;
-			break;
-		}
-
-		err = igt_check_block(mm, root);
-
-		if (!drm_buddy_block_is_free(root)) {
-			pr_err("root not free\n");
-			err = -EINVAL;
-		}
-
-		order = drm_buddy_block_order(root);
-
-		if (!i) {
-			if (order != mm->max_order) {
-				pr_err("max order root missing\n");
-				err = -EINVAL;
-			}
-		}
-
-		if (prev) {
-			u64 prev_block_size;
-			u64 prev_offset;
-			u64 offset;
-
-			prev_offset = drm_buddy_block_offset(prev);
-			prev_block_size = drm_buddy_block_size(mm, prev);
-			offset = drm_buddy_block_offset(root);
-
-			if (offset != (prev_offset + prev_block_size)) {
-				pr_err("root offset mismatch\n");
-				err = -EINVAL;
-			}
-		}
-
-		block = list_first_entry_or_null(&mm->free_list[order],
-						 struct drm_buddy_block,
-						 link);
-		if (block != root) {
-			pr_err("root mismatch at order=%u\n", order);
-			err = -EINVAL;
-		}
-
-		if (err)
-			break;
-
-		prev = root;
-		total += drm_buddy_block_size(mm, root);
-	}
-
-	if (!err) {
-		if (total != mm->size) {
-			pr_err("expected mm size=%llx, found=%llx\n", mm->size,
-			       total);
-			err = -EINVAL;
-		}
-		return err;
-	}
-
-	if (prev) {
-		pr_err("prev root(%u), dump:\n", i - 1);
-		igt_dump_block(mm, prev);
-	}
-
-	if (root) {
-		pr_err("bad root(%u), dump:\n", i);
-		igt_dump_block(mm, root);
-	}
-
-	return err;
-}
-
-static void igt_mm_config(u64 *size, u64 *chunk_size)
-{
-	DRM_RND_STATE(prng, random_seed);
-	u32 s, ms;
-
-	/* Nothing fancy, just try to get an interesting bit pattern */
-
-	prandom_seed_state(&prng, random_seed);
-
-	/* Let size be a random number of pages up to 8 GB (2M pages) */
-	s = 1 + drm_prandom_u32_max_state((BIT(33 - 12)) - 1, &prng);
-	/* Let the chunk size be a random power of 2 less than size */
-	ms = BIT(drm_prandom_u32_max_state(ilog2(s), &prng));
-	/* Round size down to the chunk size */
-	s &= -ms;
-
-	/* Convert from pages to bytes */
-	*chunk_size = (u64)ms << 12;
-	*size = (u64)s << 12;
-}
-
-static int igt_buddy_alloc_pathological(void *arg)
-{
-	u64 mm_size, size, min_page_size, start = 0;
-	struct drm_buddy_block *block;
-	const int max_order = 3;
-	unsigned long flags = 0;
-	int order, top, err;
-	struct drm_buddy mm;
-	LIST_HEAD(blocks);
-	LIST_HEAD(holes);
-	LIST_HEAD(tmp);
-
-	/*
-	 * Create a pot-sized mm, then allocate one of each possible
-	 * order within. This should leave the mm with exactly one
-	 * page left. Free the largest block, then whittle down again.
-	 * Eventually we will have a fully 50% fragmented mm.
-	 */
-
-	mm_size = PAGE_SIZE << max_order;
-	err = drm_buddy_init(&mm, mm_size, PAGE_SIZE);
-	if (err) {
-		pr_err("buddy_init failed(%d)\n", err);
-		return err;
-	}
-	BUG_ON(mm.max_order != max_order);
-
-	for (top = max_order; top; top--) {
-		/* Make room by freeing the largest allocated block */
-		block = list_first_entry_or_null(&blocks, typeof(*block), link);
-		if (block) {
-			list_del(&block->link);
-			drm_buddy_free_block(&mm, block);
-		}
-
-		for (order = top; order--; ) {
-			size = min_page_size = get_size(order, PAGE_SIZE);
-			err = drm_buddy_alloc_blocks(&mm, start, mm_size, size,
-						     min_page_size, &tmp, flags);
-			if (err) {
-				pr_info("buddy_alloc hit -ENOMEM with order=%d, top=%d\n",
-					order, top);
-				goto err;
-			}
-
-			block = list_first_entry_or_null(&tmp,
-							 struct drm_buddy_block,
-							 link);
-			if (!block) {
-				pr_err("alloc_blocks has no blocks\n");
-				err = -EINVAL;
-				goto err;
-			}
-
-			list_move_tail(&block->link, &blocks);
-		}
-
-		/* There should be one final page for this sub-allocation */
-		size = min_page_size = get_size(0, PAGE_SIZE);
-		err = drm_buddy_alloc_blocks(&mm, start, mm_size, size, min_page_size, &tmp, flags);
-		if (err) {
-			pr_info("buddy_alloc hit -ENOMEM for hole\n");
-			goto err;
-		}
-
-		block = list_first_entry_or_null(&tmp,
-						 struct drm_buddy_block,
-						 link);
-		if (!block) {
-			pr_err("alloc_blocks has no blocks\n");
-			err = -EINVAL;
-			goto err;
-		}
-
-		list_move_tail(&block->link, &holes);
-
-		size = min_page_size = get_size(top, PAGE_SIZE);
-		err = drm_buddy_alloc_blocks(&mm, start, mm_size, size, min_page_size, &tmp, flags);
-		if (!err) {
-			pr_info("buddy_alloc unexpectedly succeeded at top-order %d/%d, it should be full!",
-				top, max_order);
-			block = list_first_entry_or_null(&tmp,
-							 struct drm_buddy_block,
-							 link);
-			if (!block) {
-				pr_err("alloc_blocks has no blocks\n");
-				err = -EINVAL;
-				goto err;
-			}
-
-			list_move_tail(&block->link, &blocks);
-			err = -EINVAL;
-			goto err;
-		}
-	}
-
-	drm_buddy_free_list(&mm, &holes);
-
-	/* Nothing larger than blocks of chunk_size now available */
-	for (order = 1; order <= max_order; order++) {
-		size = min_page_size = get_size(order, PAGE_SIZE);
-		err = drm_buddy_alloc_blocks(&mm, start, mm_size, size, min_page_size, &tmp, flags);
-		if (!err) {
-			pr_info("buddy_alloc unexpectedly succeeded at order %d, it should be full!",
-				order);
-			block = list_first_entry_or_null(&tmp,
-							 struct drm_buddy_block,
-							 link);
-			if (!block) {
-				pr_err("alloc_blocks has no blocks\n");
-				err = -EINVAL;
-				goto err;
-			}
-
-			list_move_tail(&block->link, &blocks);
-			err = -EINVAL;
-			goto err;
-		}
-	}
-
-	if (err)
-		err = 0;
-
-err:
-	list_splice_tail(&holes, &blocks);
-	drm_buddy_free_list(&mm, &blocks);
-	drm_buddy_fini(&mm);
-	return err;
-}
-
-static int igt_buddy_alloc_smoke(void *arg)
-{
-	u64 mm_size, min_page_size, chunk_size, start = 0;
-	unsigned long flags = 0;
-	struct drm_buddy mm;
-	int *order;
-	int err, i;
-
-	DRM_RND_STATE(prng, random_seed);
-	IGT_TIMEOUT(end_time);
-
-	igt_mm_config(&mm_size, &chunk_size);
-
-	err = drm_buddy_init(&mm, mm_size, chunk_size);
-	if (err) {
-		pr_err("buddy_init failed(%d)\n", err);
-		return err;
-	}
-
-	order = drm_random_order(mm.max_order + 1, &prng);
-	if (!order) {
-		err = -ENOMEM;
-		goto out_fini;
-	}
-
-	for (i = 0; i <= mm.max_order; ++i) {
-		struct drm_buddy_block *block;
-		int max_order = order[i];
-		bool timeout = false;
-		LIST_HEAD(blocks);
-		u64 total, size;
-		LIST_HEAD(tmp);
-		int order;
-
-		err = igt_check_mm(&mm);
-		if (err) {
-			pr_err("pre-mm check failed, abort\n");
-			break;
-		}
-
-		order = max_order;
-		total = 0;
-
-		do {
-retry:
-			size = min_page_size = get_size(order, chunk_size);
-			err = drm_buddy_alloc_blocks(&mm, start, mm_size, size,
-						     min_page_size, &tmp, flags);
-			if (err) {
-				if (err == -ENOMEM) {
-					pr_info("buddy_alloc hit -ENOMEM with order=%d\n",
-						order);
-				} else {
-					if (order--) {
-						err = 0;
-						goto retry;
-					}
-
-					pr_err("buddy_alloc with order=%d failed(%d)\n",
-					       order, err);
-				}
-
-				break;
-			}
-
-			block = list_first_entry_or_null(&tmp,
-							 struct drm_buddy_block,
-							 link);
-			if (!block) {
-				pr_err("alloc_blocks has no blocks\n");
-				err = -EINVAL;
-				break;
-			}
-
-			list_move_tail(&block->link, &blocks);
-
-			if (drm_buddy_block_order(block) != order) {
-				pr_err("buddy_alloc order mismatch\n");
-				err = -EINVAL;
-				break;
-			}
-
-			total += drm_buddy_block_size(&mm, block);
-
-			if (__igt_timeout(end_time, NULL)) {
-				timeout = true;
-				break;
-			}
-		} while (total < mm.size);
-
-		if (!err)
-			err = igt_check_blocks(&mm, &blocks, total, false);
-
-		drm_buddy_free_list(&mm, &blocks);
-
-		if (!err) {
-			err = igt_check_mm(&mm);
-			if (err)
-				pr_err("post-mm check failed\n");
-		}
-
-		if (err || timeout)
-			break;
-
-		cond_resched();
-	}
-
-	if (err == -ENOMEM)
-		err = 0;
-
-	kfree(order);
-out_fini:
-	drm_buddy_fini(&mm);
-
-	return err;
-}
-
-static int igt_buddy_alloc_pessimistic(void *arg)
-{
-	u64 mm_size, size, min_page_size, start = 0;
-	struct drm_buddy_block *block, *bn;
-	const unsigned int max_order = 16;
-	unsigned long flags = 0;
-	struct drm_buddy mm;
-	unsigned int order;
-	LIST_HEAD(blocks);
-	LIST_HEAD(tmp);
-	int err;
-
-	/*
-	 * Create a pot-sized mm, then allocate one of each possible
-	 * order within. This should leave the mm with exactly one
-	 * page left.
-	 */
-
-	mm_size = PAGE_SIZE << max_order;
-	err = drm_buddy_init(&mm, mm_size, PAGE_SIZE);
-	if (err) {
-		pr_err("buddy_init failed(%d)\n", err);
-		return err;
-	}
-	BUG_ON(mm.max_order != max_order);
-
-	for (order = 0; order < max_order; order++) {
-		size = min_page_size = get_size(order, PAGE_SIZE);
-		err = drm_buddy_alloc_blocks(&mm, start, mm_size, size, min_page_size, &tmp, flags);
-		if (err) {
-			pr_info("buddy_alloc hit -ENOMEM with order=%d\n",
-				order);
-			goto err;
-		}
-
-		block = list_first_entry_or_null(&tmp,
-						 struct drm_buddy_block,
-						 link);
-		if (!block) {
-			pr_err("alloc_blocks has no blocks\n");
-			err = -EINVAL;
-			goto err;
-		}
-
-		list_move_tail(&block->link, &blocks);
-	}
-
-	/* And now the last remaining block available */
-	size = min_page_size = get_size(0, PAGE_SIZE);
-	err = drm_buddy_alloc_blocks(&mm, start, mm_size, size, min_page_size, &tmp, flags);
-	if (err) {
-		pr_info("buddy_alloc hit -ENOMEM on final alloc\n");
-		goto err;
-	}
-
-	block = list_first_entry_or_null(&tmp,
-					 struct drm_buddy_block,
-					 link);
-	if (!block) {
-		pr_err("alloc_blocks has no blocks\n");
-		err = -EINVAL;
-		goto err;
-	}
-
-	list_move_tail(&block->link, &blocks);
-
-	/* Should be completely full! */
-	for (order = max_order; order--; ) {
-		size = min_page_size = get_size(order, PAGE_SIZE);
-		err = drm_buddy_alloc_blocks(&mm, start, mm_size, size, min_page_size, &tmp, flags);
-		if (!err) {
-			pr_info("buddy_alloc unexpectedly succeeded at order %d, it should be full!",
-				order);
-			block = list_first_entry_or_null(&tmp,
-							 struct drm_buddy_block,
-							 link);
-			if (!block) {
-				pr_err("alloc_blocks has no blocks\n");
-				err = -EINVAL;
-				goto err;
-			}
-
-			list_move_tail(&block->link, &blocks);
-			err = -EINVAL;
-			goto err;
-		}
-	}
-
-	block = list_last_entry(&blocks, typeof(*block), link);
-	list_del(&block->link);
-	drm_buddy_free_block(&mm, block);
-
-	/* As we free in increasing size, we make available larger blocks */
-	order = 1;
-	list_for_each_entry_safe(block, bn, &blocks, link) {
-		list_del(&block->link);
-		drm_buddy_free_block(&mm, block);
-
-		size = min_page_size = get_size(order, PAGE_SIZE);
-		err = drm_buddy_alloc_blocks(&mm, start, mm_size, size, min_page_size, &tmp, flags);
-		if (err) {
-			pr_info("buddy_alloc (realloc) hit -ENOMEM with order=%d\n",
-				order);
-			goto err;
-		}
-
-		block = list_first_entry_or_null(&tmp,
-						 struct drm_buddy_block,
-						 link);
-		if (!block) {
-			pr_err("alloc_blocks has no blocks\n");
-			err = -EINVAL;
-			goto err;
-		}
-
-		list_del(&block->link);
-		drm_buddy_free_block(&mm, block);
-		order++;
-	}
-
-	/* To confirm, now the whole mm should be available */
-	size = min_page_size = get_size(max_order, PAGE_SIZE);
-	err = drm_buddy_alloc_blocks(&mm, start, mm_size, size, min_page_size, &tmp, flags);
-	if (err) {
-		pr_info("buddy_alloc (realloc) hit -ENOMEM with order=%d\n",
-			max_order);
-		goto err;
-	}
-
-	block = list_first_entry_or_null(&tmp,
-					 struct drm_buddy_block,
-					 link);
-	if (!block) {
-		pr_err("alloc_blocks has no blocks\n");
-		err = -EINVAL;
-		goto err;
-	}
-
-	list_del(&block->link);
-	drm_buddy_free_block(&mm, block);
-
-err:
-	drm_buddy_free_list(&mm, &blocks);
-	drm_buddy_fini(&mm);
-	return err;
-}
-
-static int igt_buddy_alloc_optimistic(void *arg)
-{
-	u64 mm_size, size, min_page_size, start = 0;
-	struct drm_buddy_block *block;
-	unsigned long flags = 0;
-	const int max_order = 16;
-	struct drm_buddy mm;
-	LIST_HEAD(blocks);
-	LIST_HEAD(tmp);
-	int order, err;
-
-	/*
-	 * Create a mm with one block of each order available, and
-	 * try to allocate them all.
-	 */
-
-	mm_size = PAGE_SIZE * ((1 << (max_order + 1)) - 1);
-	err = drm_buddy_init(&mm,
-			     mm_size,
-			     PAGE_SIZE);
-	if (err) {
-		pr_err("buddy_init failed(%d)\n", err);
-		return err;
-	}
-
-	BUG_ON(mm.max_order != max_order);
-
-	for (order = 0; order <= max_order; order++) {
-		size = min_page_size = get_size(order, PAGE_SIZE);
-		err = drm_buddy_alloc_blocks(&mm, start, mm_size, size, min_page_size, &tmp, flags);
-		if (err) {
-			pr_info("buddy_alloc hit -ENOMEM with order=%d\n",
-				order);
-			goto err;
-		}
-
-		block = list_first_entry_or_null(&tmp,
-						 struct drm_buddy_block,
-						 link);
-		if (!block) {
-			pr_err("alloc_blocks has no blocks\n");
-			err = -EINVAL;
-			goto err;
-		}
-
-		list_move_tail(&block->link, &blocks);
-	}
-
-	/* Should be completely full! */
-	size = min_page_size = get_size(0, PAGE_SIZE);
-	err = drm_buddy_alloc_blocks(&mm, start, mm_size, size, min_page_size, &tmp, flags);
-	if (!err) {
-		pr_info("buddy_alloc unexpectedly succeeded, it should be full!");
-		block = list_first_entry_or_null(&tmp,
-						 struct drm_buddy_block,
-						 link);
-		if (!block) {
-			pr_err("alloc_blocks has no blocks\n");
-			err = -EINVAL;
-			goto err;
-		}
-
-		list_move_tail(&block->link, &blocks);
-		err = -EINVAL;
-		goto err;
-	} else {
-		err = 0;
-	}
-
-err:
-	drm_buddy_free_list(&mm, &blocks);
-	drm_buddy_fini(&mm);
-	return err;
-}
-
-static int igt_buddy_alloc_range(void *arg)
-{
-	unsigned long flags = DRM_BUDDY_RANGE_ALLOCATION;
-	u64 offset, size, rem, chunk_size, end;
-	unsigned long page_num;
-	struct drm_buddy mm;
-	LIST_HEAD(blocks);
-	int err;
-
-	igt_mm_config(&size, &chunk_size);
-
-	err = drm_buddy_init(&mm, size, chunk_size);
-	if (err) {
-		pr_err("buddy_init failed(%d)\n", err);
-		return err;
-	}
-
-	err = igt_check_mm(&mm);
-	if (err) {
-		pr_err("pre-mm check failed, abort, abort, abort!\n");
-		goto err_fini;
-	}
-
-	rem = mm.size;
-	offset = 0;
-
-	for_each_prime_number_from(page_num, 1, ULONG_MAX - 1) {
-		struct drm_buddy_block *block;
-		LIST_HEAD(tmp);
-
-		size = min(page_num * mm.chunk_size, rem);
-		end = offset + size;
-
-		err = drm_buddy_alloc_blocks(&mm, offset, end, size, mm.chunk_size, &tmp, flags);
-		if (err) {
-			if (err == -ENOMEM) {
-				pr_info("alloc_range hit -ENOMEM with size=%llx\n",
-					size);
-			} else {
-				pr_err("alloc_range with offset=%llx, size=%llx failed(%d)\n",
-				       offset, size, err);
-			}
-
-			break;
-		}
-
-		block = list_first_entry_or_null(&tmp,
-						 struct drm_buddy_block,
-						 link);
-		if (!block) {
-			pr_err("alloc_range has no blocks\n");
-			err = -EINVAL;
-			break;
-		}
-
-		if (drm_buddy_block_offset(block) != offset) {
-			pr_err("alloc_range start offset mismatch, found=%llx, expected=%llx\n",
-			       drm_buddy_block_offset(block), offset);
-			err = -EINVAL;
-		}
-
-		if (!err)
-			err = igt_check_blocks(&mm, &tmp, size, true);
-
-		list_splice_tail(&tmp, &blocks);
-
-		if (err)
-			break;
-
-		offset += size;
-
-		rem -= size;
-		if (!rem)
-			break;
-
-		cond_resched();
-	}
-
-	if (err == -ENOMEM)
-		err = 0;
-
-	drm_buddy_free_list(&mm, &blocks);
-
-	if (!err) {
-		err = igt_check_mm(&mm);
-		if (err)
-			pr_err("post-mm check failed\n");
-	}
-
-err_fini:
-	drm_buddy_fini(&mm);
-
-	return err;
-}
-
-static int igt_buddy_alloc_limit(void *arg)
-{
-	u64 size = U64_MAX, start = 0;
-	struct drm_buddy_block *block;
-	unsigned long flags = 0;
-	LIST_HEAD(allocated);
-	struct drm_buddy mm;
-	int err;
-
-	err = drm_buddy_init(&mm, size, PAGE_SIZE);
-	if (err)
-		return err;
-
-	if (mm.max_order != DRM_BUDDY_MAX_ORDER) {
-		pr_err("mm.max_order(%d) != %d\n",
-		       mm.max_order, DRM_BUDDY_MAX_ORDER);
-		err = -EINVAL;
-		goto out_fini;
-	}
-
-	size = mm.chunk_size << mm.max_order;
-	err = drm_buddy_alloc_blocks(&mm, start, size, size,
-				     PAGE_SIZE, &allocated, flags);
-
-	if (unlikely(err))
-		goto out_free;
-
-	block = list_first_entry_or_null(&allocated,
-					 struct drm_buddy_block,
-					 link);
-
-	if (!block) {
-		err = -EINVAL;
-		goto out_fini;
-	}
-
-	if (drm_buddy_block_order(block) != mm.max_order) {
-		pr_err("block order(%d) != %d\n",
-		       drm_buddy_block_order(block), mm.max_order);
-		err = -EINVAL;
-		goto out_free;
-	}
-
-	if (drm_buddy_block_size(&mm, block) !=
-	    BIT_ULL(mm.max_order) * PAGE_SIZE) {
-		pr_err("block size(%llu) != %llu\n",
-		       drm_buddy_block_size(&mm, block),
-		       BIT_ULL(mm.max_order) * PAGE_SIZE);
-		err = -EINVAL;
-		goto out_free;
-	}
-
-out_free:
-	drm_buddy_free_list(&mm, &allocated);
-out_fini:
-	drm_buddy_fini(&mm);
-	return err;
-}
-
-static int igt_sanitycheck(void *ignored)
-{
-	pr_info("%s - ok!\n", __func__);
-	return 0;
-}
-
-#include "drm_selftest.c"
-
-static int __init test_drm_buddy_init(void)
-{
-	int err;
-
-	while (!random_seed)
-		random_seed = get_random_int();
-
-	pr_info("Testing DRM buddy manager (struct drm_buddy), with random_seed=0x%x\n",
-		random_seed);
-	err = run_selftests(selftests, ARRAY_SIZE(selftests), NULL);
-
-	return err > 0 ? 0 : err;
-}
-
-static void __exit test_drm_buddy_exit(void)
-{
-}
-
-module_init(test_drm_buddy_init);
-module_exit(test_drm_buddy_exit);
-
-MODULE_AUTHOR("Intel Corporation");
-MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index 4cbfd9098d56..cff59189598f 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -2,4 +2,4 @@
 
 obj-$(CONFIG_DRM_KUNIT_TEST) += drm_format_helper_test.o drm_damage_helper_test.o \
 	drm_cmdline_parser_test.o drm_rect_test.o drm_format_test.o drm_plane_helper_test.o \
-	drm_dp_mst_helper_test.o drm_framebuffer_test.o
+	drm_dp_mst_helper_test.o drm_framebuffer_test.o drm_buddy_test.o
diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
new file mode 100644
index 000000000000..d76f83833e75
--- /dev/null
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -0,0 +1,756 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2019 Intel Corporation
+ * Copyright © 2022 Maíra Canal <mairacanal@riseup.net>
+ */
+
+#include <kunit/test.h>
+
+#include <linux/prime_numbers.h>
+#include <linux/sched/signal.h>
+
+#include <drm/drm_buddy.h>
+
+#include "../lib/drm_random.h"
+
+#define IGT_TIMEOUT(name__)                                                    \
+	unsigned long name__ = jiffies + MAX_SCHEDULE_TIMEOUT
+
+static unsigned int random_seed;
+
+static inline u64 get_size(int order, u64 chunk_size)
+{
+	return (1 << order) * chunk_size;
+}
+
+__printf(2, 3)
+static bool __igt_timeout(unsigned long timeout, const char *fmt, ...)
+{
+	va_list va;
+
+	if (!signal_pending(current)) {
+		cond_resched();
+		if (time_before(jiffies, timeout))
+			return false;
+	}
+
+	if (fmt) {
+		va_start(va, fmt);
+		vprintk(fmt, va);
+		va_end(va);
+	}
+
+	return true;
+}
+
+static void __igt_dump_block(struct kunit *test, struct drm_buddy *mm,
+			     struct drm_buddy_block *block, bool buddy)
+{
+	kunit_err(test, "block info: header=%llx, state=%u, order=%d, offset=%llx size=%llx root=%d buddy=%d\n",
+		  block->header, drm_buddy_block_state(block),
+			  drm_buddy_block_order(block), drm_buddy_block_offset(block),
+			  drm_buddy_block_size(mm, block), !block->parent, buddy);
+}
+
+static void igt_dump_block(struct kunit *test, struct drm_buddy *mm,
+			   struct drm_buddy_block *block)
+{
+	struct drm_buddy_block *buddy;
+
+	__igt_dump_block(test, mm, block, false);
+
+	buddy = drm_get_buddy(block);
+	if (buddy)
+		__igt_dump_block(test, mm, buddy, true);
+}
+
+static int igt_check_block(struct kunit *test, struct drm_buddy *mm,
+			   struct drm_buddy_block *block)
+{
+	struct drm_buddy_block *buddy;
+	unsigned int block_state;
+	u64 block_size;
+	u64 offset;
+	int err = 0;
+
+	block_state = drm_buddy_block_state(block);
+
+	if (block_state != DRM_BUDDY_ALLOCATED &&
+	    block_state != DRM_BUDDY_FREE && block_state != DRM_BUDDY_SPLIT) {
+		kunit_err(test, "block state mismatch\n");
+		err = -EINVAL;
+	}
+
+	block_size = drm_buddy_block_size(mm, block);
+	offset = drm_buddy_block_offset(block);
+
+	if (block_size < mm->chunk_size) {
+		kunit_err(test, "block size smaller than min size\n");
+		err = -EINVAL;
+	}
+
+	if (!is_power_of_2(block_size)) {
+		kunit_err(test, "block size not power of two\n");
+		err = -EINVAL;
+	}
+
+	if (!IS_ALIGNED(block_size, mm->chunk_size)) {
+		kunit_err(test, "block size not aligned to min size\n");
+		err = -EINVAL;
+	}
+
+	if (!IS_ALIGNED(offset, mm->chunk_size)) {
+		kunit_err(test, "block offset not aligned to min size\n");
+		err = -EINVAL;
+	}
+
+	if (!IS_ALIGNED(offset, block_size)) {
+		kunit_err(test, "block offset not aligned to block size\n");
+		err = -EINVAL;
+	}
+
+	buddy = drm_get_buddy(block);
+
+	if (!buddy && block->parent) {
+		kunit_err(test, "buddy has gone fishing\n");
+		err = -EINVAL;
+	}
+
+	if (buddy) {
+		if (drm_buddy_block_offset(buddy) != (offset ^ block_size)) {
+			kunit_err(test, "buddy has wrong offset\n");
+			err = -EINVAL;
+		}
+
+		if (drm_buddy_block_size(mm, buddy) != block_size) {
+			kunit_err(test, "buddy size mismatch\n");
+			err = -EINVAL;
+		}
+
+		if (drm_buddy_block_state(buddy) == block_state &&
+		    block_state == DRM_BUDDY_FREE) {
+			kunit_err(test, "block and its buddy are free\n");
+			err = -EINVAL;
+		}
+	}
+
+	return err;
+}
+
+static int igt_check_blocks(struct kunit *test, struct drm_buddy *mm,
+			    struct list_head *blocks, u64 expected_size, bool is_contiguous)
+{
+	struct drm_buddy_block *block;
+	struct drm_buddy_block *prev;
+	u64 total;
+	int err = 0;
+
+	block = NULL;
+	prev = NULL;
+	total = 0;
+
+	list_for_each_entry(block, blocks, link) {
+		err = igt_check_block(test, mm, block);
+
+		if (!drm_buddy_block_is_allocated(block)) {
+			kunit_err(test, "block not allocated\n");
+			err = -EINVAL;
+		}
+
+		if (is_contiguous && prev) {
+			u64 prev_block_size;
+			u64 prev_offset;
+			u64 offset;
+
+			prev_offset = drm_buddy_block_offset(prev);
+			prev_block_size = drm_buddy_block_size(mm, prev);
+			offset = drm_buddy_block_offset(block);
+
+			if (offset != (prev_offset + prev_block_size)) {
+				kunit_err(test, "block offset mismatch\n");
+				err = -EINVAL;
+			}
+		}
+
+		if (err)
+			break;
+
+		total += drm_buddy_block_size(mm, block);
+		prev = block;
+	}
+
+	if (!err) {
+		if (total != expected_size) {
+			kunit_err(test, "size mismatch, expected=%llx, found=%llx\n",
+				  expected_size, total);
+			err = -EINVAL;
+		}
+		return err;
+	}
+
+	if (prev) {
+		kunit_err(test, "prev block, dump:\n");
+		igt_dump_block(test, mm, prev);
+	}
+
+	kunit_err(test, "bad block, dump:\n");
+	igt_dump_block(test, mm, block);
+
+	return err;
+}
+
+static int igt_check_mm(struct kunit *test, struct drm_buddy *mm)
+{
+	struct drm_buddy_block *root;
+	struct drm_buddy_block *prev;
+	unsigned int i;
+	u64 total;
+	int err = 0;
+
+	if (!mm->n_roots) {
+		kunit_err(test, "n_roots is zero\n");
+		return -EINVAL;
+	}
+
+	if (mm->n_roots != hweight64(mm->size)) {
+		kunit_err(test, "n_roots mismatch, n_roots=%u, expected=%lu\n",
+			  mm->n_roots, hweight64(mm->size));
+		return -EINVAL;
+	}
+
+	root = NULL;
+	prev = NULL;
+	total = 0;
+
+	for (i = 0; i < mm->n_roots; ++i) {
+		struct drm_buddy_block *block;
+		unsigned int order;
+
+		root = mm->roots[i];
+		if (!root) {
+			kunit_err(test, "root(%u) is NULL\n", i);
+			err = -EINVAL;
+			break;
+		}
+
+		err = igt_check_block(test, mm, root);
+
+		if (!drm_buddy_block_is_free(root)) {
+			kunit_err(test, "root not free\n");
+			err = -EINVAL;
+		}
+
+		order = drm_buddy_block_order(root);
+
+		if (!i) {
+			if (order != mm->max_order) {
+				kunit_err(test, "max order root missing\n");
+				err = -EINVAL;
+			}
+		}
+
+		if (prev) {
+			u64 prev_block_size;
+			u64 prev_offset;
+			u64 offset;
+
+			prev_offset = drm_buddy_block_offset(prev);
+			prev_block_size = drm_buddy_block_size(mm, prev);
+			offset = drm_buddy_block_offset(root);
+
+			if (offset != (prev_offset + prev_block_size)) {
+				kunit_err(test, "root offset mismatch\n");
+				err = -EINVAL;
+			}
+		}
+
+		block = list_first_entry_or_null(&mm->free_list[order],
+						 struct drm_buddy_block, link);
+		if (block != root) {
+			kunit_err(test, "root mismatch at order=%u\n", order);
+			err = -EINVAL;
+		}
+
+		if (err)
+			break;
+
+		prev = root;
+		total += drm_buddy_block_size(mm, root);
+	}
+
+	if (!err) {
+		if (total != mm->size) {
+			kunit_err(test, "expected mm size=%llx, found=%llx\n",
+				  mm->size, total);
+			err = -EINVAL;
+		}
+		return err;
+	}
+
+	if (prev) {
+		kunit_err(test, "prev root(%u), dump:\n", i - 1);
+		igt_dump_block(test, mm, prev);
+	}
+
+	if (root) {
+		kunit_err(test, "bad root(%u), dump:\n", i);
+		igt_dump_block(test, mm, root);
+	}
+
+	return err;
+}
+
+static void igt_mm_config(u64 *size, u64 *chunk_size)
+{
+	DRM_RND_STATE(prng, random_seed);
+	u32 s, ms;
+
+	/* Nothing fancy, just try to get an interesting bit pattern */
+
+	prandom_seed_state(&prng, random_seed);
+
+	/* Let size be a random number of pages up to 8 GB (2M pages) */
+	s = 1 + drm_prandom_u32_max_state((BIT(33 - 12)) - 1, &prng);
+	/* Let the chunk size be a random power of 2 less than size */
+	ms = BIT(drm_prandom_u32_max_state(ilog2(s), &prng));
+	/* Round size down to the chunk size */
+	s &= -ms;
+
+	/* Convert from pages to bytes */
+	*chunk_size = (u64)ms << 12;
+	*size = (u64)s << 12;
+}
+
+static void igt_buddy_alloc_pathological(struct kunit *test)
+{
+	u64 mm_size, size, start = 0;
+	struct drm_buddy_block *block;
+	const int max_order = 3;
+	unsigned long flags = 0;
+	int order, top;
+	struct drm_buddy mm;
+	LIST_HEAD(blocks);
+	LIST_HEAD(holes);
+	LIST_HEAD(tmp);
+
+	/*
+	 * Create a pot-sized mm, then allocate one of each possible
+	 * order within. This should leave the mm with exactly one
+	 * page left. Free the largest block, then whittle down again.
+	 * Eventually we will have a fully 50% fragmented mm.
+	 */
+
+	mm_size = PAGE_SIZE << max_order;
+	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_init(&mm, mm_size, PAGE_SIZE),
+			       "buddy_init failed\n");
+
+	KUNIT_EXPECT_EQ(test, mm.max_order, max_order);
+
+	for (top = max_order; top; top--) {
+		/* Make room by freeing the largest allocated block */
+		block = list_first_entry_or_null(&blocks, typeof(*block), link);
+		if (block) {
+			list_del(&block->link);
+			drm_buddy_free_block(&mm, block);
+		}
+
+		for (order = top; order--;) {
+			size = get_size(order, PAGE_SIZE);
+			KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, start,
+									    mm_size, size, size,
+										&tmp, flags),
+					"buddy_alloc hit -ENOMEM with order=%d, top=%d\n",
+					order, top);
+
+			block = list_first_entry_or_null(&tmp, struct drm_buddy_block, link);
+			KUNIT_ASSERT_TRUE_MSG(test, block, "alloc_blocks has no blocks\n");
+
+			list_move_tail(&block->link, &blocks);
+		}
+
+		/* There should be one final page for this sub-allocation */
+		size = get_size(0, PAGE_SIZE);
+		KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, start, mm_size,
+								    size, size, &tmp, flags),
+							   "buddy_alloc hit -ENOMEM for hole\n");
+
+		block = list_first_entry_or_null(&tmp, struct drm_buddy_block, link);
+		KUNIT_ASSERT_TRUE_MSG(test, block, "alloc_blocks has no blocks\n");
+
+		list_move_tail(&block->link, &holes);
+
+		size = get_size(top, PAGE_SIZE);
+		KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, start, mm_size,
+								   size, size, &tmp, flags),
+							  "buddy_alloc unexpectedly succeeded at top-order %d/%d, it should be full!",
+							  top, max_order);
+	}
+
+	drm_buddy_free_list(&mm, &holes);
+
+	/* Nothing larger than blocks of chunk_size now available */
+	for (order = 1; order <= max_order; order++) {
+		size = get_size(order, PAGE_SIZE);
+		KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, start, mm_size,
+								   size, size, &tmp, flags),
+							  "buddy_alloc unexpectedly succeeded at order %d, it should be full!",
+							  order);
+	}
+
+	list_splice_tail(&holes, &blocks);
+	drm_buddy_free_list(&mm, &blocks);
+	drm_buddy_fini(&mm);
+}
+
+static void igt_buddy_alloc_smoke(struct kunit *test)
+{
+	u64 mm_size, chunk_size, start = 0;
+	unsigned long flags = 0;
+	struct drm_buddy mm;
+	int *order;
+	int i;
+
+	DRM_RND_STATE(prng, random_seed);
+	IGT_TIMEOUT(end_time);
+
+	igt_mm_config(&mm_size, &chunk_size);
+
+	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_init(&mm, mm_size, chunk_size),
+			       "buddy_init failed\n");
+
+	order = drm_random_order(mm.max_order + 1, &prng);
+	KUNIT_ASSERT_TRUE(test, order);
+
+	for (i = 0; i <= mm.max_order; ++i) {
+		struct drm_buddy_block *block;
+		int max_order = order[i];
+		bool timeout = false;
+		LIST_HEAD(blocks);
+		u64 total, size;
+		LIST_HEAD(tmp);
+		int order, err;
+
+		KUNIT_ASSERT_FALSE_MSG(test, igt_check_mm(test, &mm),
+				       "pre-mm check failed, abort\n");
+
+		order = max_order;
+		total = 0;
+
+		do {
+retry:
+			size = get_size(order, chunk_size);
+			err = drm_buddy_alloc_blocks(&mm, start, mm_size, size, size, &tmp, flags);
+			if (err) {
+				if (err == -ENOMEM) {
+					KUNIT_FAIL(test, "buddy_alloc hit -ENOMEM with order=%d\n",
+						   order);
+				} else {
+					if (order--) {
+						err = 0;
+						goto retry;
+					}
+
+					KUNIT_FAIL(test, "buddy_alloc with order=%d failed\n",
+						   order);
+				}
+
+				break;
+			}
+
+			block = list_first_entry_or_null(&tmp, struct drm_buddy_block, link);
+			KUNIT_ASSERT_TRUE_MSG(test, block, "alloc_blocks has no blocks\n");
+
+			list_move_tail(&block->link, &blocks);
+			KUNIT_EXPECT_EQ_MSG(test, drm_buddy_block_order(block), order,
+					    "buddy_alloc order mismatch\n");
+
+			total += drm_buddy_block_size(&mm, block);
+
+			if (__igt_timeout(end_time, NULL)) {
+				timeout = true;
+				break;
+			}
+		} while (total < mm.size);
+
+		if (!err)
+			err = igt_check_blocks(test, &mm, &blocks, total, false);
+
+		drm_buddy_free_list(&mm, &blocks);
+
+		if (!err) {
+			KUNIT_EXPECT_FALSE_MSG(test, igt_check_mm(test, &mm),
+					       "post-mm check failed\n");
+		}
+
+		if (err || timeout)
+			break;
+
+		cond_resched();
+	}
+
+	kfree(order);
+	drm_buddy_fini(&mm);
+}
+
+static void igt_buddy_alloc_pessimistic(struct kunit *test)
+{
+	u64 mm_size, size, start = 0;
+	struct drm_buddy_block *block, *bn;
+	const unsigned int max_order = 16;
+	unsigned long flags = 0;
+	struct drm_buddy mm;
+	unsigned int order;
+	LIST_HEAD(blocks);
+	LIST_HEAD(tmp);
+
+	/*
+	 * Create a pot-sized mm, then allocate one of each possible
+	 * order within. This should leave the mm with exactly one
+	 * page left.
+	 */
+
+	mm_size = PAGE_SIZE << max_order;
+	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_init(&mm, mm_size, PAGE_SIZE),
+			       "buddy_init failed\n");
+
+	KUNIT_EXPECT_EQ(test, mm.max_order, max_order);
+
+	for (order = 0; order < max_order; order++) {
+		size = get_size(order, PAGE_SIZE);
+		KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, start, mm_size,
+								    size, size, &tmp, flags),
+							   "buddy_alloc hit -ENOMEM with order=%d\n",
+							   order);
+
+		block = list_first_entry_or_null(&tmp, struct drm_buddy_block, link);
+		KUNIT_ASSERT_TRUE_MSG(test, block, "alloc_blocks has no blocks\n");
+
+		list_move_tail(&block->link, &blocks);
+	}
+
+	/* And now the last remaining block available */
+	size = get_size(0, PAGE_SIZE);
+	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, start, mm_size,
+							    size, size, &tmp, flags),
+						   "buddy_alloc hit -ENOMEM on final alloc\n");
+
+	block = list_first_entry_or_null(&tmp, struct drm_buddy_block, link);
+	KUNIT_ASSERT_TRUE_MSG(test, block, "alloc_blocks has no blocks\n");
+
+	list_move_tail(&block->link, &blocks);
+
+	/* Should be completely full! */
+	for (order = max_order; order--;) {
+		size = get_size(order, PAGE_SIZE);
+		KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, start, mm_size,
+								   size, size, &tmp, flags),
+							  "buddy_alloc unexpectedly succeeded, it should be full!");
+	}
+
+	block = list_last_entry(&blocks, typeof(*block), link);
+	list_del(&block->link);
+	drm_buddy_free_block(&mm, block);
+
+	/* As we free in increasing size, we make available larger blocks */
+	order = 1;
+	list_for_each_entry_safe(block, bn, &blocks, link) {
+		list_del(&block->link);
+		drm_buddy_free_block(&mm, block);
+
+		size = get_size(order, PAGE_SIZE);
+		KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, start, mm_size,
+								    size, size, &tmp, flags),
+							   "buddy_alloc hit -ENOMEM with order=%d\n",
+							   order);
+
+		block = list_first_entry_or_null(&tmp, struct drm_buddy_block, link);
+		KUNIT_ASSERT_TRUE_MSG(test, block, "alloc_blocks has no blocks\n");
+
+		list_del(&block->link);
+		drm_buddy_free_block(&mm, block);
+		order++;
+	}
+
+	/* To confirm, now the whole mm should be available */
+	size = get_size(max_order, PAGE_SIZE);
+	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, start, mm_size,
+							    size, size, &tmp, flags),
+						   "buddy_alloc (realloc) hit -ENOMEM with order=%d\n",
+						   max_order);
+
+	block = list_first_entry_or_null(&tmp, struct drm_buddy_block, link);
+	KUNIT_ASSERT_TRUE_MSG(test, block, "alloc_blocks has no blocks\n");
+
+	list_del(&block->link);
+	drm_buddy_free_block(&mm, block);
+	drm_buddy_free_list(&mm, &blocks);
+	drm_buddy_fini(&mm);
+}
+
+static void igt_buddy_alloc_optimistic(struct kunit *test)
+{
+	u64 mm_size, size, start = 0;
+	struct drm_buddy_block *block;
+	unsigned long flags = 0;
+	const int max_order = 16;
+	struct drm_buddy mm;
+	LIST_HEAD(blocks);
+	LIST_HEAD(tmp);
+	int order;
+
+	/*
+	 * Create a mm with one block of each order available, and
+	 * try to allocate them all.
+	 */
+
+	mm_size = PAGE_SIZE * ((1 << (max_order + 1)) - 1);
+
+	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_init(&mm, mm_size, PAGE_SIZE),
+			       "buddy_init failed\n");
+
+	KUNIT_EXPECT_EQ(test, mm.max_order, max_order);
+
+	for (order = 0; order <= max_order; order++) {
+		size = get_size(order, PAGE_SIZE);
+		KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, start, mm_size,
+								    size, size, &tmp, flags),
+							   "buddy_alloc hit -ENOMEM with order=%d\n",
+							   order);
+
+		block = list_first_entry_or_null(&tmp, struct drm_buddy_block, link);
+		KUNIT_ASSERT_TRUE_MSG(test, block, "alloc_blocks has no blocks\n");
+
+		list_move_tail(&block->link, &blocks);
+	}
+
+	/* Should be completely full! */
+	size = get_size(0, PAGE_SIZE);
+	KUNIT_ASSERT_TRUE_MSG(test, drm_buddy_alloc_blocks(&mm, start, mm_size,
+							   size, size, &tmp, flags),
+						  "buddy_alloc unexpectedly succeeded, it should be full!");
+
+	drm_buddy_free_list(&mm, &blocks);
+	drm_buddy_fini(&mm);
+}
+
+static void igt_buddy_alloc_range(struct kunit *test)
+{
+	unsigned long flags = DRM_BUDDY_RANGE_ALLOCATION;
+	u64 offset, size, rem, chunk_size, end;
+	unsigned long page_num;
+	struct drm_buddy mm;
+	LIST_HEAD(blocks);
+
+	igt_mm_config(&size, &chunk_size);
+
+	KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_init(&mm, size, chunk_size),
+			       "buddy_init failed");
+
+	KUNIT_ASSERT_FALSE_MSG(test, igt_check_mm(test, &mm),
+			       "pre-mm check failed, abort!");
+
+	rem = mm.size;
+	offset = 0;
+
+	for_each_prime_number_from(page_num, 1, ULONG_MAX - 1) {
+		struct drm_buddy_block *block;
+		LIST_HEAD(tmp);
+
+		size = min(page_num * mm.chunk_size, rem);
+		end = offset + size;
+
+		KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_alloc_blocks(&mm, offset, end,
+								    size, mm.chunk_size,
+									&tmp, flags),
+				"alloc_range with offset=%llx, size=%llx failed\n", offset, size);
+
+		block = list_first_entry_or_null(&tmp, struct drm_buddy_block, link);
+		KUNIT_ASSERT_TRUE_MSG(test, block, "alloc_range has no blocks\n");
+
+		KUNIT_ASSERT_EQ_MSG(test, drm_buddy_block_offset(block), offset,
+				    "alloc_range start offset mismatch, found=%llx, expected=%llx\n",
+							drm_buddy_block_offset(block), offset);
+
+		KUNIT_ASSERT_FALSE(test, igt_check_blocks(test, &mm, &tmp, size, true));
+
+		list_splice_tail(&tmp, &blocks);
+
+		offset += size;
+
+		rem -= size;
+		if (!rem)
+			break;
+
+		cond_resched();
+	}
+
+	drm_buddy_free_list(&mm, &blocks);
+
+	KUNIT_EXPECT_FALSE_MSG(test, igt_check_mm(test, &mm), "post-mm check failed\n");
+
+	drm_buddy_fini(&mm);
+}
+
+static void igt_buddy_alloc_limit(struct kunit *test)
+{
+	u64 size = U64_MAX, start = 0;
+	struct drm_buddy_block *block;
+	unsigned long flags = 0;
+	LIST_HEAD(allocated);
+	struct drm_buddy mm;
+
+	KUNIT_EXPECT_FALSE(test, drm_buddy_init(&mm, size, PAGE_SIZE));
+
+	KUNIT_EXPECT_EQ_MSG(test, mm.max_order, DRM_BUDDY_MAX_ORDER,
+			    "mm.max_order(%d) != %d\n", mm.max_order,
+						DRM_BUDDY_MAX_ORDER);
+
+	size = mm.chunk_size << mm.max_order;
+	KUNIT_EXPECT_FALSE(test, drm_buddy_alloc_blocks(&mm, start, size, size,
+							PAGE_SIZE, &allocated, flags));
+
+	block = list_first_entry_or_null(&allocated, struct drm_buddy_block, link);
+	KUNIT_EXPECT_TRUE(test, block);
+
+	KUNIT_EXPECT_EQ_MSG(test, drm_buddy_block_order(block), mm.max_order,
+			    "block order(%d) != %d\n",
+						drm_buddy_block_order(block), mm.max_order);
+
+	KUNIT_EXPECT_EQ_MSG(test, drm_buddy_block_size(&mm, block),
+			    BIT_ULL(mm.max_order) * PAGE_SIZE,
+						"block size(%llu) != %llu\n",
+						drm_buddy_block_size(&mm, block),
+						BIT_ULL(mm.max_order) * PAGE_SIZE);
+
+	drm_buddy_free_list(&mm, &allocated);
+	drm_buddy_fini(&mm);
+}
+
+static int drm_buddy_init_test(struct kunit *test)
+{
+	while (!random_seed)
+		random_seed = get_random_int();
+
+	return 0;
+}
+
+static struct kunit_case drm_buddy_tests[] = {
+	KUNIT_CASE(igt_buddy_alloc_limit),
+	KUNIT_CASE(igt_buddy_alloc_range),
+	KUNIT_CASE(igt_buddy_alloc_optimistic),
+	KUNIT_CASE(igt_buddy_alloc_pessimistic),
+	KUNIT_CASE(igt_buddy_alloc_smoke),
+	KUNIT_CASE(igt_buddy_alloc_pathological),
+	{}
+};
+
+static struct kunit_suite drm_buddy_test_suite = {
+	.name = "drm_buddy",
+	.init = drm_buddy_init_test,
+	.test_cases = drm_buddy_tests,
+};
+
+kunit_test_suite(drm_buddy_test_suite);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL");
-- 
2.35.3

