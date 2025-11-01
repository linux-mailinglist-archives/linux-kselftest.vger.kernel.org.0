Return-Path: <linux-kselftest+bounces-44600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A4EC28512
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 200AF4ED1DE
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DBE3019D8;
	Sat,  1 Nov 2025 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTnX92eA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B6130171A;
	Sat,  1 Nov 2025 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021241; cv=none; b=sjYC+Mefz8zTMzCu0o7Z05eO9Pbmz+sKfp+0o9RJc7TiuFijdqcLCC0dzqgoL+DK0xw15SsQcoJM5TW8tih7I8+aoUUBLSZaKcS6ngiN/lv3a7p2k4Q/nREonQlylE7aMIwkpr/N92nU060dALCCY9eReaxeTBcUlgbd9Kgc7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021241; c=relaxed/simple;
	bh=nowG8T+x+dG/UTataXUmNzsTvJgJYwTbgZ7j9/viwz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkTJWoGIOhKPutA6RYcp1pa8/AFaeNtAI/2BgQGSOJj9UUAxD7j9wJjG5vl93J5iDd/g6EhUt481tXt/Nk6iRbAmdQQJTL/8vCH0Q0GSfJne00AHwKPr0UblA8IbAGD8bBGcgKHZPpEhjmIpv5zlY8m4nQXWJb8L2HY7mrgpxQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTnX92eA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B98C19422;
	Sat,  1 Nov 2025 18:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021240;
	bh=nowG8T+x+dG/UTataXUmNzsTvJgJYwTbgZ7j9/viwz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTnX92eAX8Tf+fp/lAUwcaxrEGjrHeadsPJpIZsbEqqDPrwZrqVp38LCtAZhEyl0l
	 fI/K64ycIzy/WXv1deyCvaZzD/ej/px2Ws/JvoMxo/BQz6DH4SCLO7OQt5PZ/emXh+
	 RErI/36eXxKdf1UAr4x9unOEWvp/1XboK1x+d4TaUpNX8JNnFk/v8KhbltiMHEA00c
	 HftovZWEBLEsB6ThgrTXJEWApG9I7yabjYikWW0a/nAnVqPtDN1QGKx8WlaXCcF7PU
	 bc9YLEoIj7Nr/hkeEaZIf74U2CtQEhFMohiQGqcoQG0X9pNkABBDigatEpVU1s/SmL
	 rVQwbBT//EPtA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 18 . x" <stable@vger.kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 14/22] mm/damon/tests/core-kunit: handle alloc failure on damos_test_commit_filter()
Date: Sat,  1 Nov 2025 11:20:08 -0700
Message-ID: <20251101182021.74868-15-sj@kernel.org>
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

damon_test_commit_filter() is assuming all dynamic memory allocation in
it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Fixes: f6a4a150f1ec ("mm/damon/tests/core-kunit: add damos_commit_filter test")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 03c7ac31db5c..5af8275ffd7d 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -516,11 +516,16 @@ static void damos_test_new_filter(struct kunit *test)
 
 static void damos_test_commit_filter(struct kunit *test)
 {
-	struct damos_filter *src_filter = damos_new_filter(
-		DAMOS_FILTER_TYPE_ANON, true, true);
-	struct damos_filter *dst_filter = damos_new_filter(
-		DAMOS_FILTER_TYPE_ACTIVE, false, false);
-
+	struct damos_filter *src_filter, *dst_filter;
+
+	src_filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true, true);
+	if (!src_filter)
+		kunit_skip(test, "src filter alloc fail");
+	dst_filter = damos_new_filter(DAMOS_FILTER_TYPE_ACTIVE, false, false);
+	if (!dst_filter) {
+		damos_destroy_filter(src_filter);
+		kunit_skip(test, "dst filter alloc fail");
+	}
 	damos_commit_filter(dst_filter, src_filter);
 	KUNIT_EXPECT_EQ(test, dst_filter->type, src_filter->type);
 	KUNIT_EXPECT_EQ(test, dst_filter->matching, src_filter->matching);
-- 
2.47.3

