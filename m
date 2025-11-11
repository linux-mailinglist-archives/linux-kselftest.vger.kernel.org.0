Return-Path: <linux-kselftest+bounces-45349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F74DC4F79B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159823AADF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587B92BE7A1;
	Tue, 11 Nov 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOcGp6yY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5D92BD5BD;
	Tue, 11 Nov 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886668; cv=none; b=pPmwWZOOo+/EjL9JT5gT1HO6IWLLZ3YnuR2rUnZIWPidAJ8za4/3rcTb/i/qAUg9d+J0+LbFq8V+dufPT2XpUpWKX0u2NrXlkHTuc+lKvpToHx4OJgtvovpeVLO3secsWs1RtEhJupqx90mpk5sthZXtYUWGWCU6B4bC9BmHAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886668; c=relaxed/simple;
	bh=bWfWODgDizfceoDSDsQvR25at7fdp8OVsfqGkOutAqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDVdQL60RBBH7vYdXKGeXa0DAKuYQ3V0Pmc5vCA7gBh/QLlOwzi/hnkQRwHEiKZzT+0l6NiQFXQLQpWs/429n//23TH+xU8Tb5kcyuholtN81x/ipInHtG9rRFIPImy3+lfYwOF7raHEr9FuEPiNFFbJ1r0J2pgQJhjJ4QOkFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOcGp6yY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D320FC4CEF5;
	Tue, 11 Nov 2025 18:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762886668;
	bh=bWfWODgDizfceoDSDsQvR25at7fdp8OVsfqGkOutAqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOcGp6yY2aQatoc9Pf+0VGj8G7nF6mD5WtOgX1LI7HrKoGF+J5uDarPUUvNpntots
	 HO/A1rcMkU4gGomxfPV5O+QRdCwTBJhTOP2WAXYYCR1gBO0ujStAlusyiV3pHsEwHU
	 3huE/rA5fZ1sEbwMv+FkhBth8xsfxDg541I+XVotUHN4AGXeFMGVi1o51QFXwnMxc0
	 tIpelBNbkZwejQdLyv34q+zBFICZzjjmNOfrOPiCYb/2KUl++VDsvlkJbIKud3MgTe
	 hO1e3gy5yqcQNJ3AXl8DxUHNfD9LQCPDRZkp+eRLtb4H0k13FyEUTz82KCc41PaA4o
	 mKIRxMI6muc9w==
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
Subject: [PATCH 04/11] mm/damon/tests/core-kunit: add test cases to damos_test_commit_filter()
Date: Tue, 11 Nov 2025 10:44:03 -0800
Message-ID: <20251111184415.141757-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111184415.141757-1-sj@kernel.org>
References: <20251111184415.141757-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_test_commit_filter() is covering only a single test case.  Extend
it to cover multiple combinations of inputs.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 53 ++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 5052d8db9657..2770972b0a39 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -528,17 +528,58 @@ static void damos_test_commit_filter_for(struct kunit *test,
 
 static void damos_test_commit_filter(struct kunit *test)
 {
-	struct damos_filter src_filter = {
-		.type = DAMOS_FILTER_TYPE_ANON,
-		.matching = true,
-		.allow = true};
-	struct damos_filter dst_filter = {
+	struct damos_filter dst = {
 		.type = DAMOS_FILTER_TYPE_ACTIVE,
 		.matching = false,
 		.allow = false,
 	};
 
-	damos_test_commit_filter_for(test, &dst_filter, &src_filter);
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_ANON,
+			.matching = true,
+			.allow = true,
+			});
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_MEMCG,
+			.matching = false,
+			.allow = false,
+			.memcg_id = 123,
+			});
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_YOUNG,
+			.matching = true,
+			.allow = true,
+			});
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
+			.matching = false,
+			.allow = false,
+			.sz_range = {.min = 234, .max = 345},
+			});
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_UNMAPPED,
+			.matching = true,
+			.allow = true,
+			});
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_ADDR,
+			.matching = false,
+			.allow = false,
+			.addr_range = {.start = 456, .end = 567},
+			});
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_TARGET,
+			.matching = true,
+			.allow = true,
+			.target_idx = 6,
+			});
 }
 
 static void damos_test_filter_out(struct kunit *test)
-- 
2.47.3

