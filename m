Return-Path: <linux-kselftest+bounces-44593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC797C284D0
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4AB3BC5E5
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24BD2FDC23;
	Sat,  1 Nov 2025 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN3fiNJJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17162FD692;
	Sat,  1 Nov 2025 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021238; cv=none; b=ZyedktS7doQ5OeovLWKcSeVDtioUG20TzvSNFrdM91+k1LKSVtjY+Peo3ka0m2C7pIvA3BdJDNMtpNB4TXAZNvMUCSwVk7YwgfFt1v0XJBklDZdi944V600EgftXovuMQv60/Rx/lGdTppgI9ohn7KZicFX1ri/Ef7V8uM5TYK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021238; c=relaxed/simple;
	bh=xEepEI/9EWPjrFmW0+GI6DwgedFIowTo82PSpqc2yR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=modqingTg9dsJxwnUT6rJ30SLMfgF7c3ho6mUszaZgsmA4mNXjhcNmE+M1O3AyTXvvY+GV1MTa4tGrdhNuQY7XBPTO/zZmsvAZHrIn5ySNBLrMcGmZhCjKb9Ojr5JrW39fpXf0TU2i0arETo/myUAvot8gZdpgMZ7/XpN7IvIhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN3fiNJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69578C113D0;
	Sat,  1 Nov 2025 18:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021238;
	bh=xEepEI/9EWPjrFmW0+GI6DwgedFIowTo82PSpqc2yR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hN3fiNJJRo0pvY442J+Yl1LisLZv1Nv6XgkcnFaM5wTHfwFoEBaMR6N0dHOloSFOk
	 6Ta978Kg2+ckOqj6eAzdq1b1VybHv8iRogTFKwZTelDx9TllrklStkaekQVt+XZqgs
	 jIwNBZIBB7sVuU8N4t/7L8/sP7nBp9CsA9MYkWOsD0zLpBhpbDvSEgSRryFUM9L99r
	 qUuvOCF4MTT4YUaJmr1syRo4PevEFj/iwXBvdoTWS/dEEcC8IX1RJUwOmZHL6MMx4V
	 GcbOX59ebc5c5HQaBVGu3E3vnLO4bwJqp3mWmbUrQsg43s5EiYwmLm4KdFbz+mAK2s
	 cPLHV1NWBCE0A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 15 . x" <stable@vger.kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/22] mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_regions_of()
Date: Sat,  1 Nov 2025 11:20:02 -0700
Message-ID: <20251101182021.74868-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251101182021.74868-1-sj@kernel.org>
References: <20251101182021.74868-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_split_regions_of() is assuming all dynamic memory allocation
in it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 98f2a3de7cea..10618cdd188e 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -278,15 +278,35 @@ static void damon_test_split_regions_of(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r;
 
+	if (!c)
+		kunit_skip("ctx alloc fail");
 	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
 	r = damon_new_region(0, 22);
+	if (!r) {
+		damon_destroy_ctx(c);
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	damon_add_region(r, t);
 	damon_split_regions_of(t, 2, DAMON_MIN_REGION);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 2u);
 	damon_free_target(t);
 
 	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "second target alloc fail");
+	}
 	r = damon_new_region(0, 220);
+	if (!r) {
+		damon_destroy_ctx(c);
+		damon_free_target(t);
+		kunit_skip(test, "second region alloc fail");
+	}
 	damon_add_region(r, t);
 	damon_split_regions_of(t, 4, DAMON_MIN_REGION);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
-- 
2.47.3

