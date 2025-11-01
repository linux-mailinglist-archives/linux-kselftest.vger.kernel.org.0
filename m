Return-Path: <linux-kselftest+bounces-44602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C02C28530
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850383A603B
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928A2303A15;
	Sat,  1 Nov 2025 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd5Ed5BV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61301302169;
	Sat,  1 Nov 2025 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021241; cv=none; b=CRGgu02PSHasijm/zCZH69QRxnp2Pjt7v0SngDd1n2F8MS4TtSXy07qEdZ4SLkieP5nV75QSyu3s7QuOcCYup6pqJH797bc0WXS/x8X2Dz5k6T/xtlIOYGczzxoatTc3X7kgvtUzxGxgXWjaKWblnif9m1F2VuPNExhqKpCUDUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021241; c=relaxed/simple;
	bh=dn7Te6QsD/vqr21yqQqDCBMBy4CNhY/OvT08906eNi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REheMsoAOcIq3qy14aRJojJLu6mkRVulWC1u62DnpjkB4OubuifJn80a/VAHEyprI2RSeB8JJk9gykff2uOXsLvYNYWggIBCpu83An1nmEXBomKrRU0sKCyXOnZXfXh4ym+QZOvDsP3crvJE/MWVnk0XMx6uv/fEUQaNjrDAyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd5Ed5BV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B07C113D0;
	Sat,  1 Nov 2025 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021241;
	bh=dn7Te6QsD/vqr21yqQqDCBMBy4CNhY/OvT08906eNi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dd5Ed5BVesnLrVSQvAtYBMZfXXw32oZl1EOX5c3pKiV3gC7DlIlyUGCM58LPxLqam
	 NWGqb58KNK4zc3zJPipj+r6qXsyPwLvRNLAYpvpXFlV7OCkQ/vysBBcMzhptz2dkem
	 UXZOYypCXYYyuCx4tJyJHI7EI98sSFYWnPMtJvH/URMGgwKtMXjMus8cEXk40LEy0H
	 A9AA2U7idxN3Duzxc0GhiI3JaTZNtqcx/b4FGJMDwnys85e/N6IYgDepoqf8xdC56A
	 Sgls6IeIucaNB6roBKnKHeaCc8uG6JfjEsQziDoiGiCqe1XmtrLHRdq/le0K6LorwT
	 sGAGvw+0CqNAg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 16/22] mm/damon/tests/core-kunit: handle alloc failures on damon_test_set_filters_default_reject()
Date: Sat,  1 Nov 2025 11:20:10 -0700
Message-ID: <20251101182021.74868-17-sj@kernel.org>
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

damon_test_set_filters_default_reject() is assuming all dynamic memory
allocation in it will succeed.  Those are indeed likely in the real use
cases since those allocations are too small to fail, but theoretically
those could fail.  In the case, inappropriate memory access can happen.
Fix it by appropriately cleanup pre-allocated memory and skip the
execution of the remaining tests in the failure cases.

Fixes: 094fb14913c7 ("mm/damon/tests/core-kunit: add a test for damos_set_filters_default_reject()")
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index a03ae9ddd88a..a91d798caa70 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -659,6 +659,8 @@ static void damon_test_set_filters_default_reject(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, scheme.ops_filters_default_reject, false);
 
 	target_filter = damos_new_filter(DAMOS_FILTER_TYPE_TARGET, true, true);
+	if (!target_filter)
+		kunit_skip(test, "filter alloc fail");
 	damos_add_filter(&scheme, target_filter);
 	damos_set_filters_default_reject(&scheme);
 	/*
@@ -684,6 +686,10 @@ static void damon_test_set_filters_default_reject(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, scheme.ops_filters_default_reject, false);
 
 	anon_filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true, true);
+	if (!anon_filter) {
+		damos_free_filter(target_filter);
+		kunit_skip(test, "anon_filter alloc fail");
+	}
 	damos_add_filter(&scheme, anon_filter);
 
 	damos_set_filters_default_reject(&scheme);
-- 
2.47.3

