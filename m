Return-Path: <linux-kselftest+bounces-45427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A80CCC53404
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 17:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD293546E0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2304D34574A;
	Wed, 12 Nov 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKPHCnkr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3F8345741;
	Wed, 12 Nov 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962162; cv=none; b=WauEgE3R+zGcUA3k8RPCZZFxpvWgsmRSk4f4smmHskLui9E/jsW7xUaYUxetoCszOvqT5aZz4YwLVg/4fS7hPZOUx7UIKmfG06+e/zk+Sju7DwBonS6wc5BCaNyHO1YtfQJ8qm/eqzeq70fCDhRxQCgvdbg4BALkz64/yoCVc/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962162; c=relaxed/simple;
	bh=+nAXiRSD3au0hre7wXKW+GzTCyBQWmgweSl5Hvkt0UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADwPxF8+/8IhdQ7PzIii22Fw3vpm6YPgbj38Kd47jFvwXhipipp6DJOa6aY1PU+Me/CAehwN47j4CpTh1oPsmVXKqHWwAilVO+wXV75e0hKrRmKwQ9/B/6vQuB/fsCMfu2N1bTHYcYNdAJH+hZk8xImNoDF5mZxR//ofrv56u74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKPHCnkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A8AC113D0;
	Wed, 12 Nov 2025 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762962161;
	bh=+nAXiRSD3au0hre7wXKW+GzTCyBQWmgweSl5Hvkt0UE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKPHCnkr5xrhSxNOU3m625LuzkuCWOODKU1mxNA8UPfpVMV0HL4sjQoCKeTF7uCVz
	 72NUEswHEoG3hW6Z0dSp+AxdHBU7UPvYieZd57XItZIn0JaeTW5f4SmNLNX5+AomQe
	 2Pe7ETYWYPjTp+bCrBZPGCRuisiFDj+7B9XyHbwsiZu9XFlSVWzebW5aZHzhyVoE0s
	 UI+waiZR83g9weR6KegWdRkRc8dLl13dbAGkGHRNb+hnfOYEsqZJknnJc4wpoLUU3+
	 d+YU1ES+v9SaY8pH9XS8/JehwifOHZDttMieLdb81GXmKQtKmGysVI20TIj1Aq9iaG
	 hrHb2gI2ctpkA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/9] mm/damon/tests/core-kunit: remove DAMON_MIN_REGION redefinition
Date: Wed, 12 Nov 2025 07:41:09 -0800
Message-ID: <20251112154114.66053-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112154114.66053-1-sj@kernel.org>
References: <20251112154114.66053-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few DAMON core functions including damon_set_regions() were hard-coded
to use DAMON_MIN_REGION as their regions management granularity.  For
simple and human-readable unit tests' expectations, DAMON core layer
kunit test re-defines DAMON_MIN_REGION to '1'.

A previous patch series [1] has removed the hard-coded part but kept the
redefinition and updated related function calls to explicitly use
DAMON_MIN_REGION.  Remove the unnecessary redefinition and update
relevant function calls to pass literals (number '1') instead of the
DAMON_MIN_REGION.

[1] https://lore.kernel.org/20250828171242.59810-1-sj@kernel.org

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c             |  5 ----
 mm/damon/tests/core-kunit.h | 55 ++++++++++++++++++-------------------
 2 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index aedb315b075a..f9fc0375890a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -20,11 +20,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/damon.h>
 
-#ifdef CONFIG_DAMON_KUNIT_TEST
-#undef DAMON_MIN_REGION
-#define DAMON_MIN_REGION 1
-#endif
-
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;
 static bool running_exclusive_ctxs;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 4380d0312d24..a1eff023e928 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -279,7 +279,7 @@ static void damon_test_split_regions_of(struct kunit *test)
 		kunit_skip(test, "region alloc fail");
 	}
 	damon_add_region(r, t);
-	damon_split_regions_of(t, 2, DAMON_MIN_REGION);
+	damon_split_regions_of(t, 2, 1);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 2u);
 	damon_free_target(t);
 
@@ -292,7 +292,7 @@ static void damon_test_split_regions_of(struct kunit *test)
 		kunit_skip(test, "second region alloc fail");
 	}
 	damon_add_region(r, t);
-	damon_split_regions_of(t, 4, DAMON_MIN_REGION);
+	damon_split_regions_of(t, 4, 1);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
 	damon_free_target(t);
 }
@@ -373,7 +373,7 @@ static void damon_test_set_regions(struct kunit *test)
 
 	damon_add_region(r1, t);
 	damon_add_region(r2, t);
-	damon_set_regions(t, &range, 1, DAMON_MIN_REGION);
+	damon_set_regions(t, &range, 1, 1);
 
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 3);
 	damon_for_each_region(r, t) {
@@ -1037,15 +1037,14 @@ static void damos_test_filter_out(struct kunit *test)
 	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
 	if (!f)
 		kunit_skip(test, "filter alloc fail");
-	f->addr_range = (struct damon_addr_range){
-		.start = DAMON_MIN_REGION * 2, .end = DAMON_MIN_REGION * 6};
+	f->addr_range = (struct damon_addr_range){.start = 2, .end = 6};
 
 	t = damon_new_target();
 	if (!t) {
 		damos_destroy_filter(f);
 		kunit_skip(test, "target alloc fail");
 	}
-	r = damon_new_region(DAMON_MIN_REGION * 3, DAMON_MIN_REGION * 5);
+	r = damon_new_region(3, 5);
 	if (!r) {
 		damos_destroy_filter(f);
 		damon_free_target(t);
@@ -1054,50 +1053,48 @@ static void damos_test_filter_out(struct kunit *test)
 	damon_add_region(r, t);
 
 	/* region in the range */
-	KUNIT_EXPECT_TRUE(test,
-			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
+	KUNIT_EXPECT_TRUE(test, damos_filter_match(NULL, t, r, f, 1));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region before the range */
-	r->ar.start = DAMON_MIN_REGION * 1;
-	r->ar.end = DAMON_MIN_REGION * 2;
+	r->ar.start = 1;
+	r->ar.end = 2;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
+			damos_filter_match(NULL, t, r, f, 1));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region after the range */
-	r->ar.start = DAMON_MIN_REGION * 6;
-	r->ar.end = DAMON_MIN_REGION * 8;
+	r->ar.start = 6;
+	r->ar.end = 8;
 	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
+			damos_filter_match(NULL, t, r, f, 1));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region started before the range */
-	r->ar.start = DAMON_MIN_REGION * 1;
-	r->ar.end = DAMON_MIN_REGION * 4;
-	KUNIT_EXPECT_FALSE(test,
-			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
+	r->ar.start = 1;
+	r->ar.end = 4;
+	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f, 1));
 	/* filter should have split the region */
-	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 1);
-	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 2);
+	KUNIT_EXPECT_EQ(test, r->ar.start, 1);
+	KUNIT_EXPECT_EQ(test, r->ar.end, 2);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
 	r2 = damon_next_region(r);
-	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 2);
-	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 4);
+	KUNIT_EXPECT_EQ(test, r2->ar.start, 2);
+	KUNIT_EXPECT_EQ(test, r2->ar.end, 4);
 	damon_destroy_region(r2, t);
 
 	/* region started in the range */
-	r->ar.start = DAMON_MIN_REGION * 2;
-	r->ar.end = DAMON_MIN_REGION * 8;
+	r->ar.start = 2;
+	r->ar.end = 8;
 	KUNIT_EXPECT_TRUE(test,
-			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
+			damos_filter_match(NULL, t, r, f, 1));
 	/* filter should have split the region */
-	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 2);
-	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 6);
+	KUNIT_EXPECT_EQ(test, r->ar.start, 2);
+	KUNIT_EXPECT_EQ(test, r->ar.end, 6);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
 	r2 = damon_next_region(r);
-	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 6);
-	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 8);
+	KUNIT_EXPECT_EQ(test, r2->ar.start, 6);
+	KUNIT_EXPECT_EQ(test, r2->ar.end, 8);
 	damon_destroy_region(r2, t);
 
 	damon_free_target(t);
-- 
2.47.3

