Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B554650CF
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 16:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350333AbhLAPI2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 10:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350315AbhLAPI0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 10:08:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294CDC061748;
        Wed,  1 Dec 2021 07:05:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 76AB3CE1F9C;
        Wed,  1 Dec 2021 15:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F61C53FCC;
        Wed,  1 Dec 2021 15:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638371103;
        bh=OBCz9UA299ZoQQWT5MORsqWesgyjbdJekOP8AmbpsCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+GGhLC5Zay1gDZ2+gowpThvm766UXmaVlJ/6pBF5VFD7vamoiW9u4zylwjMI4L/S
         xENgawHtYFqohqfObAzWevaW6O2NQcm6w7j7lNXBaL1mBw3Ab8j2anlfNVTfAfqZNQ
         dD4L9C9qKvz+QbgJFsB3Sn45xyHxNGN6EkGOOp85bL1oXcu4ftJ5DAzb0JaZMpP6cj
         ZKWozefYgMqpaNn3X3G9Oi2v4gEbKEsp2AOuCFmjUB35+v4QfbcS0G3n8k6r3TdWNw
         7lMZkRwG9qwQdJeHl3mbUaHEOizPCaHg/HtM5mxK2ycK2iDoJ7Ii58rRaSnQaIX3U3
         JcW0WctOQ1vLA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 05/11] mm/damon/vaddr-test: Split a test function having >1024 bytes frame size
Date:   Wed,  1 Dec 2021 15:04:34 +0000
Message-Id: <20211201150440.1088-6-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201150440.1088-1-sj@kernel.org>
References: <20211201150440.1088-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On some configuration[1], 'damon_test_split_evenly()' kunit test
function has >1024 bytes frame size, so below build warning is
triggered:

      CC      mm/damon/vaddr.o
    In file included from mm/damon/vaddr.c:672:
    mm/damon/vaddr-test.h: In function 'damon_test_split_evenly':
    mm/damon/vaddr-test.h:309:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
      309 | }
          | ^

This commit fixes the warning by separating the common logics in the
function.

[1] https://lore.kernel.org/linux-mm/202111182146.OV3C4uGr-lkp@intel.com/

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr-test.h | 77 ++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index ecfd0b2ed222..3097ef9c662a 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -252,59 +252,62 @@ static void damon_test_apply_three_regions4(struct kunit *test)
 			new_three_regions, expected, ARRAY_SIZE(expected));
 }
 
-static void damon_test_split_evenly(struct kunit *test)
+static void damon_test_split_evenly_fail(struct kunit *test,
+		unsigned long start, unsigned long end, unsigned int nr_pieces)
 {
-	struct damon_ctx *c = damon_new_ctx();
-	struct damon_target *t;
-	struct damon_region *r;
-	unsigned long i;
-
-	KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(NULL, NULL, 5),
-			-EINVAL);
-
-	t = damon_new_target(42);
-	r = damon_new_region(0, 100);
-	KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(t, r, 0), -EINVAL);
+	struct damon_target *t = damon_new_target(42);
+	struct damon_region *r = damon_new_region(start, end);
 
 	damon_add_region(r, t);
-	KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(t, r, 10), 0);
-	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 10u);
+	KUNIT_EXPECT_EQ(test,
+			damon_va_evenly_split_region(t, r, nr_pieces), -EINVAL);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1u);
 
-	i = 0;
 	damon_for_each_region(r, t) {
-		KUNIT_EXPECT_EQ(test, r->ar.start, i++ * 10);
-		KUNIT_EXPECT_EQ(test, r->ar.end, i * 10);
+		KUNIT_EXPECT_EQ(test, r->ar.start, start);
+		KUNIT_EXPECT_EQ(test, r->ar.end, end);
 	}
+
 	damon_free_target(t);
+}
+
+static void damon_test_split_evenly_succ(struct kunit *test,
+	unsigned long start, unsigned long end, unsigned int nr_pieces)
+{
+	struct damon_target *t = damon_new_target(42);
+	struct damon_region *r = damon_new_region(start, end);
+	unsigned long expected_width = (end - start) / nr_pieces;
+	unsigned long i = 0;
 
-	t = damon_new_target(42);
-	r = damon_new_region(5, 59);
 	damon_add_region(r, t);
-	KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(t, r, 5), 0);
-	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
+	KUNIT_EXPECT_EQ(test,
+			damon_va_evenly_split_region(t, r, nr_pieces), 0);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), nr_pieces);
 
-	i = 0;
 	damon_for_each_region(r, t) {
-		if (i == 4)
+		if (i == nr_pieces - 1)
 			break;
-		KUNIT_EXPECT_EQ(test, r->ar.start, 5 + 10 * i++);
-		KUNIT_EXPECT_EQ(test, r->ar.end, 5 + 10 * i);
+		KUNIT_EXPECT_EQ(test,
+				r->ar.start, start + i++ * expected_width);
+		KUNIT_EXPECT_EQ(test, r->ar.end, start + i * expected_width);
 	}
-	KUNIT_EXPECT_EQ(test, r->ar.start, 5 + 10 * i);
-	KUNIT_EXPECT_EQ(test, r->ar.end, 59ul);
+	KUNIT_EXPECT_EQ(test, r->ar.start, start + i * expected_width);
+	KUNIT_EXPECT_EQ(test, r->ar.end, end);
 	damon_free_target(t);
+}
 
-	t = damon_new_target(42);
-	r = damon_new_region(5, 6);
-	damon_add_region(r, t);
-	KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(t, r, 2), -EINVAL);
-	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1u);
+static void damon_test_split_evenly(struct kunit *test)
+{
+	struct damon_ctx *c = damon_new_ctx();
+
+	KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(NULL, NULL, 5),
+			-EINVAL);
+
+	damon_test_split_evenly_fail(test, 0, 100, 0);
+	damon_test_split_evenly_succ(test, 0, 100, 10);
+	damon_test_split_evenly_succ(test, 5, 59, 5);
+	damon_test_split_evenly_fail(test, 5, 6, 2);
 
-	damon_for_each_region(r, t) {
-		KUNIT_EXPECT_EQ(test, r->ar.start, 5ul);
-		KUNIT_EXPECT_EQ(test, r->ar.end, 6ul);
-	}
-	damon_free_target(t);
 	damon_destroy_ctx(c);
 }
 
-- 
2.17.1

