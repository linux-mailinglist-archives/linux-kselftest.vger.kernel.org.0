Return-Path: <linux-kselftest+bounces-45351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EABC4F7AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 794264F01C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24582C0272;
	Tue, 11 Nov 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFCM8je4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CF62BF016;
	Tue, 11 Nov 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886668; cv=none; b=Aq6L0TI+Fb9J4BhuwZn3orPfnwI5tF3X9a3vi+Xn/vhgCf00BQe7pvxCGWkyU5M1CCmdJvlh7deXekacTMcGUK6DRmTTk62NZ1FOzNMvi0B6i7cyTk/L8EH87FCBZTGIJfJpN5ov1vx5dwkQqTAve1yGMi0gHLItFtj/lhdpklE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886668; c=relaxed/simple;
	bh=6GIRF1VPc6ujIgCM/hIhi5fTx9G4B73HDb3fviuhNMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKJm3QKTL2k3hxxE6oLL7e0fNW3Af2zj2p9/DbVrvp6QXqkHE92daeYz5trnbPXzSGp4Ber+p29T5vJDKgnCsXovR8GkoSbJf7ZRWRj71+rP1l1jFvCI0A6vq9avKSFDYtlM64y1uwbFaBql8wb0oyg/2xlQkTrnGig9jyHBAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFCM8je4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D14C2BC87;
	Tue, 11 Nov 2025 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762886668;
	bh=6GIRF1VPc6ujIgCM/hIhi5fTx9G4B73HDb3fviuhNMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IFCM8je4C6B8TLyL7WzV8/bGwLWLzPgT822w2nvlMY50AJZYGbB6t8uoSVpVnbIxC
	 d10Q8aC0D4hxUdiFtHVE7xWbgZhyDSnYAQjnHbjwPx37VYOmTSla5T0oWc5s48MOSz
	 o5LNlQi9tG2Lk6ytnC0BlIoyj81nnvdK55vxxjLqFyUIZOKYDJqGk8z3/ON2y26JYK
	 5DiDCgwzcI7aMsjI8mWklr/ilhQlz5aXFXF3F2HoaOidO5mn9ICyNvOijSLcMHX7Oc
	 oR0xVxjnTsou1ulG5fkQpUSzgbcE8ijCK6ne7moUh2GvRa7/3Dytm/q6E1IGZVwTjE
	 1E6BX/ZtLAA2Q==
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
Subject: [PATCH 05/11] mm/damon/tests/core-kunit: add damos_commit_quota_goal() test
Date: Tue, 11 Nov 2025 10:44:04 -0800
Message-ID: <20251111184415.141757-6-sj@kernel.org>
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

Add a new unit test for damos_commit_quota_goal().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 84 +++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 2770972b0a39..0fdf9c7eedc3 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -497,6 +497,89 @@ static void damos_test_new_filter(struct kunit *test)
 	damos_destroy_filter(filter);
 }
 
+static void damos_test_commit_quota_goal_for(struct kunit *test,
+		struct damos_quota_goal *dst,
+		struct damos_quota_goal *src)
+{
+	u64 dst_last_psi_total = 0;
+
+	if (dst->metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
+		dst_last_psi_total = dst->last_psi_total;
+	damos_commit_quota_goal(dst, src);
+
+	KUNIT_EXPECT_EQ(test, dst->metric, src->metric);
+	KUNIT_EXPECT_EQ(test, dst->target_value, src->target_value);
+	if (src->metric == DAMOS_QUOTA_USER_INPUT)
+		KUNIT_EXPECT_EQ(test, dst->current_value, src->current_value);
+	if (dst_last_psi_total && src->metric == DAMOS_QUOTA_SOME_MEM_PSI_US)
+		KUNIT_EXPECT_EQ(test, dst->last_psi_total, dst_last_psi_total);
+	switch (dst->metric) {
+	case DAMOS_QUOTA_NODE_MEM_USED_BP:
+	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
+		KUNIT_EXPECT_EQ(test, dst->nid, src->nid);
+		break;
+	case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
+	case DAMOS_QUOTA_NODE_MEMCG_FREE_BP:
+		KUNIT_EXPECT_EQ(test, dst->nid, src->nid);
+		KUNIT_EXPECT_EQ(test, dst->memcg_id, src->memcg_id);
+		break;
+	default:
+		break;
+	}
+}
+
+static void damos_test_commit_quota_goal(struct kunit *test)
+{
+	struct damos_quota_goal dst = {
+		.metric = DAMOS_QUOTA_SOME_MEM_PSI_US,
+		.target_value = 1000,
+		.current_value = 123,
+		.last_psi_total = 456,
+	};
+
+	damos_test_commit_quota_goal_for(test, &dst,
+			&(struct damos_quota_goal){
+			.metric = DAMOS_QUOTA_USER_INPUT,
+			.target_value = 789,
+			.current_value = 12});
+	damos_test_commit_quota_goal_for(test, &dst,
+			&(struct damos_quota_goal){
+			.metric = DAMOS_QUOTA_NODE_MEM_FREE_BP,
+			.target_value = 345,
+			.current_value = 678,
+			.nid = 9,
+			});
+	damos_test_commit_quota_goal_for(test, &dst,
+			&(struct damos_quota_goal){
+			.metric = DAMOS_QUOTA_NODE_MEM_USED_BP,
+			.target_value = 12,
+			.current_value = 345,
+			.nid = 6,
+			});
+	damos_test_commit_quota_goal_for(test, &dst,
+			&(struct damos_quota_goal){
+			.metric = DAMOS_QUOTA_NODE_MEMCG_USED_BP,
+			.target_value = 456,
+			.current_value = 567,
+			.nid = 6,
+			.memcg_id = 7,
+			});
+	damos_test_commit_quota_goal_for(test, &dst,
+			&(struct damos_quota_goal){
+			.metric = DAMOS_QUOTA_NODE_MEMCG_FREE_BP,
+			.target_value = 890,
+			.current_value = 901,
+			.nid = 10,
+			.memcg_id = 1,
+			});
+	damos_test_commit_quota_goal_for(test, &dst,
+			&(struct damos_quota_goal) {
+			.metric = DAMOS_QUOTA_USER_INPUT,
+			.target_value = 789,
+			.current_value = 12,
+			});
+}
+
 static void damos_test_commit_filter_for(struct kunit *test,
 		struct damos_filter *dst, struct damos_filter *src)
 {
@@ -782,6 +865,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_moving_sum),
 	KUNIT_CASE(damos_test_new_filter),
+	KUNIT_CASE(damos_test_commit_quota_goal),
 	KUNIT_CASE(damos_test_commit_filter),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
-- 
2.47.3

