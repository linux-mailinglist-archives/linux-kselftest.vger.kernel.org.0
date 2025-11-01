Return-Path: <linux-kselftest+bounces-44588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1ECC284A3
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3ACC189CF05
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2BD2FBDF0;
	Sat,  1 Nov 2025 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTwPfR0t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D92FB99B;
	Sat,  1 Nov 2025 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021237; cv=none; b=BxCoGBiaDGvKApQMQOrqvcCvWbA8HEHjXlZ7HzNJs1AahkIqSXkI03QJhitlaSxsLi31BOAjFJ611xrwzk8m9869NtTYe6NlrfDMcSp2fL3r2d5NtBgmMrw70+YGPUjnsZxzFHxTdLKSd4ut0hTwnF4iBmlkVha6nSP8qr7NkYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021237; c=relaxed/simple;
	bh=ouIjUDY9hLvXA2FpIhXVT6nydcM4s8x+MSQlq+lUn6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tm6KWzgZSK9SUTgU8qSXRIhxmqA8nmC2mil18tFF2WhvMrtjgmiDmS+E+w/LniZ7ENunxyfjBnCBz1qfvjc0w//pnoA3nYBN6xjv7dpaT3xJdazN0Bb2hAJ9V5GfZU/9QiJwXd9hc//XXtlJ1x4ecqFuVlBiSSq+vx+h9/DyH4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTwPfR0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE15C116D0;
	Sat,  1 Nov 2025 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021236;
	bh=ouIjUDY9hLvXA2FpIhXVT6nydcM4s8x+MSQlq+lUn6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTwPfR0tWlZ0xcg0bSAtUMV8xDBT9nY8XilWVFWUNCZHNu9tHdOoGMRwA9qgohWZI
	 dSYyiLubnG1H6HR9e+bU10DycteR2XiegfvrDfa7hIH/BjSKAcrbFHWPolG6utILBT
	 IIfYB2Lo7fpJnwwWqWfYU+o7KsFAdo79J3YdFlGAv6dhb30fH1yKH4NAWgM9DBSyAo
	 g70JxduxlhMwOVe5dJcBi+f1dMV2lTtmY3PkAckdQzMrJIVNXr5R1/nzpUVANVa7EO
	 Kz7RUnKtcTj+P+oo/wlfj2uqT1OM6yFZayxOldtxc0SdiygribF4CHq0u/pJUUVTwA
	 JBGgM5PwTmfXg==
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
Subject: [PATCH 02/22] mm/damon/tests/core-kunit: handle allocation failures in damon_test_regions()
Date: Sat,  1 Nov 2025 11:19:56 -0700
Message-ID: <20251101182021.74868-3-sj@kernel.org>
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

damon_test_regions() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.
In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 69ca44f9270b..a2c9ee7a5de1 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -20,11 +20,17 @@ static void damon_test_regions(struct kunit *test)
 	struct damon_target *t;
 
 	r = damon_new_region(1, 2);
+	if (!r)
+		kunit_skip(test, "region alloc fail");
 	KUNIT_EXPECT_EQ(test, 1ul, r->ar.start);
 	KUNIT_EXPECT_EQ(test, 2ul, r->ar.end);
 	KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
 
 	t = damon_new_target();
+	if (!t) {
+		damon_free_region(r);
+		kunit_skip(test, "target alloc fail");
+	}
 	KUNIT_EXPECT_EQ(test, 0u, damon_nr_regions(t));
 
 	damon_add_region(r, t);
-- 
2.47.3

