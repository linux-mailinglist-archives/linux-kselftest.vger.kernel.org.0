Return-Path: <linux-kselftest+bounces-16359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9887C95FF8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 05:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB45F1C21F64
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 03:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBE1629E4;
	Tue, 27 Aug 2024 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eClTrHDs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F850271;
	Tue, 27 Aug 2024 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727829; cv=none; b=E4H+pdY1CQkqWPcnSlLTOqdQxsCN9t5oslWfzI8l4Cj8qt7SwMi0AcUHe5Zj/yYdBVqi1kJqdWTH9SZ0rQWVgSZ8vb6sPhLikILX437p8xqeoLr14jH6qHg1N1mhvpjs9fjB1rpUq51+lenuhzQevEIp4vhvixCjMFMwAisfALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727829; c=relaxed/simple;
	bh=27cqGwuOVW8eGx/ZGwFvgMxuQ6m1KJSHIM8DINfBPro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n9aavlkQsFlwe2FkzspkrbS28fCutIGwOtGVIoh/f5l/HbUL+hZIltOxjH+1WB7WUAHFjBL7nacABFLOnPl/QGG3TsZjr2GhyblJzefEcShByDbke/ALeUhMCfL50xFSQowVbvEu8VPO4RO663JBZ0waTZ1v6/S+u2Pge2HS1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eClTrHDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBE4C8B7A6;
	Tue, 27 Aug 2024 03:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724727829;
	bh=27cqGwuOVW8eGx/ZGwFvgMxuQ6m1KJSHIM8DINfBPro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eClTrHDsw5bze3VQM1izuo3k6Ruz46VEbDkR9eLTbtSzGk0Sn4iYhBaqh0F+D+rH1
	 OSMbS4v+PEaxr/ZZXlbFAnJy3XwPC4vOOS6GdmmZkCxU/ro8hLwdh2AY30ULWmqEyR
	 xCd5s31I7vC16GUF4VGOFTMZQMNFzAc8mWZxxWuLOi73pRoQyb0lVQngW3BwDj9q0M
	 1qcrRQwpeUTK9JLwUvntkOFU5iL5pip0zw36zYm0YvvhMH72MzUYAp1sY/ZxDXVd7M
	 InrrNfiZKRlVab5GMdTZqQU4lbJQjGqDznTvD5WNgHPJbKBLsEUbX9dWedDMFatali
	 V1I0CsmY6EEtw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] mm/damon/core-test: fix damon_test_ops_registration() for DAMON_VADDR unset case
Date: Mon, 26 Aug 2024 20:03:32 -0700
Message-Id: <20240827030336.7930-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827030336.7930-1-sj@kernel.org>
References: <20240827030336.7930-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core kunit test can be executed without CONFIG_DAMON_VADDR.  In
the case, vaddr DAMON ops is not registered.  Meanwhile, ops
registration kunit test assumes the vaddr ops is registered.  Check and
handle the case by registrering fake vaddr ops inside the test code.

Fixes: 4f540f5ab4f2 ("mm/damon/core-test: add a kunit test case for ops registration")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index ef36d586d6ee..ae03df71737e 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -247,8 +247,16 @@ static void damon_test_ops_registration(struct kunit *test)
 {
 	struct damon_ctx *c = damon_new_ctx();
 	struct damon_operations ops = {.id = DAMON_OPS_VADDR}, bak;
+	bool need_cleanup = false;
 
-	/* DAMON_OPS_VADDR is registered on subsys_initcall */
+	/* DAMON_OPS_VADDR is registered only if CONFIG_DAMON_VADDR is set */
+	if (!damon_is_registered_ops(DAMON_OPS_VADDR)) {
+		bak.id = DAMON_OPS_VADDR;
+		KUNIT_EXPECT_EQ(test, damon_register_ops(&bak), 0);
+		need_cleanup = true;
+	}
+
+	/* DAMON_OPS_VADDR is ensured to be registered */
 	KUNIT_EXPECT_EQ(test, damon_select_ops(c, DAMON_OPS_VADDR), 0);
 
 	/* Double-registration is prohibited */
@@ -274,6 +282,13 @@ static void damon_test_ops_registration(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, damon_register_ops(&ops), -EINVAL);
 
 	damon_destroy_ctx(c);
+
+	if (need_cleanup) {
+		mutex_lock(&damon_ops_lock);
+		damon_registered_ops[DAMON_OPS_VADDR] =
+			(struct damon_operations){};
+		mutex_unlock(&damon_ops_lock);
+	}
 }
 
 static void damon_test_set_regions(struct kunit *test)
-- 
2.39.2


