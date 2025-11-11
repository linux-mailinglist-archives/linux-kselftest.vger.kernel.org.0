Return-Path: <linux-kselftest+bounces-45350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7951EC4F7A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D917C3AA50D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D2C2C026D;
	Tue, 11 Nov 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQWlzsuR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74AF2BF007;
	Tue, 11 Nov 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886668; cv=none; b=ZNWApOCiPM0j4PbFVoqYfHMDfBecEgo4WzqyyEUYwZj8mvIKufWZNDevgrfCiAOqZlIBTPtJZ6NQGzRvOwJl6mXC8TwJCO0JnpggTuQYZnx69QqFyLtlX0Md2uSD2pZOyiI1oWSX22xQJmWWzDBiMhQl9Xa/N9fe4p2POoQQNs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886668; c=relaxed/simple;
	bh=MQs6Y/Ot6w9U45Nl0r78HMyQFGLOFhpfSPQUVvOaEtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CV3eAbIIqlw9yXJ84P3ZsHlz6r9tuI4zd/Kv5aucIGTT8blUBrHXbnYGgYHb78EpObVOSsYkzq2kHDiY4mHkTSHWWmPwNCKfuXdDHCalKlrlxKadDKSFFaD3tu/rNnFj/HDotdqXbva6Hi1JnsACK67yqc5vwfPuiO8kXTpCBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQWlzsuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A02AC4CEFB;
	Tue, 11 Nov 2025 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762886668;
	bh=MQs6Y/Ot6w9U45Nl0r78HMyQFGLOFhpfSPQUVvOaEtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQWlzsuRWYrl1E2RWLvBQDFRbGxb+uIKfxtaP82qW/+/iTPUYBJSSHXvj3tEWsret
	 0iE27Jz4WI7y6LkrJT5NRSWj3F2LTF/dtjFV+rQ4OwP5nwEhtEzuSOF3jZgVSMYrIZ
	 mr0E2hsfrcWA4yleupkxDejpHH+yQfTmW4MI3QimBIYWqTG85KUgTR6AMBj5nGr0nY
	 yyowd4ZkMMutoeiJ573OIVjopUxKJ+FKpLMAaqJPJ3nIZf8/vjwVYn8L5GuskpliGN
	 Bjik5X7nCG4PIhbsQYUJKx9DWxaZxQpyqQYCAjdpGB/iZr9kCPP9p6w1ljvpN3GBln
	 EORRV8vuf+tVQ==
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
Subject: [PATCH 06/11] mm/damon/tests/core-kunit: add damos_commit_quota_goals() test
Date: Tue, 11 Nov 2025 10:44:05 -0800
Message-ID: <20251111184415.141757-7-sj@kernel.org>
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

Add a new unit test for damos_commit_quota_goals().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 81 +++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 0fdf9c7eedc3..3abf31fb1074 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -580,6 +580,86 @@ static void damos_test_commit_quota_goal(struct kunit *test)
 			});
 }
 
+static void damos_test_commit_quota_goals_for(struct kunit *test,
+		struct damos_quota_goal *dst_goals, int nr_dst_goals,
+		struct damos_quota_goal *src_goals, int nr_src_goals)
+{
+	struct damos_quota dst, src;
+	struct damos_quota_goal *goal, *next;
+	bool skip = true;
+	int i;
+
+	INIT_LIST_HEAD(&dst.goals);
+	INIT_LIST_HEAD(&src.goals);
+
+	for (i = 0; i < nr_dst_goals; i++) {
+		/*
+		 * When nr_src_goals is smaller than dst_goals,
+		 * damos_commit_quota_goals() will kfree() the dst goals.
+		 * Make it kfree()-able.
+		 */
+		goal = damos_new_quota_goal(dst_goals[i].metric,
+				dst_goals[i].target_value);
+		if (!goal)
+			goto out;
+		damos_add_quota_goal(&dst, goal);
+	}
+	skip = false;
+	for (i = 0; i < nr_src_goals; i++)
+		damos_add_quota_goal(&src, &src_goals[i]);
+
+	damos_commit_quota_goals(&dst, &src);
+
+	i = 0;
+	damos_for_each_quota_goal(goal, (&dst)) {
+		KUNIT_EXPECT_EQ(test, goal->metric, src_goals[i].metric);
+		KUNIT_EXPECT_EQ(test, goal->target_value,
+				src_goals[i++].target_value);
+	}
+	KUNIT_EXPECT_EQ(test, i, nr_src_goals);
+
+out:
+	damos_for_each_quota_goal_safe(goal, next, (&dst))
+		damos_destroy_quota_goal(goal);
+	if (skip)
+		kunit_skip(test, "goal alloc fail");
+}
+
+static void damos_test_commit_quota_goals(struct kunit *test)
+{
+	damos_test_commit_quota_goals_for(test,
+			(struct damos_quota_goal[]){}, 0,
+			(struct damos_quota_goal[]){
+				{
+				.metric = DAMOS_QUOTA_USER_INPUT,
+				.target_value = 123,
+				},
+			}, 1);
+	damos_test_commit_quota_goals_for(test,
+			(struct damos_quota_goal[]){
+				{
+				.metric = DAMOS_QUOTA_USER_INPUT,
+				.target_value = 234,
+				},
+
+			}, 1,
+			(struct damos_quota_goal[]){
+				{
+				.metric = DAMOS_QUOTA_USER_INPUT,
+				.target_value = 345,
+				},
+			}, 1);
+	damos_test_commit_quota_goals_for(test,
+			(struct damos_quota_goal[]){
+				{
+				.metric = DAMOS_QUOTA_USER_INPUT,
+				.target_value = 456,
+				},
+
+			}, 1,
+			(struct damos_quota_goal[]){}, 0);
+}
+
 static void damos_test_commit_filter_for(struct kunit *test,
 		struct damos_filter *dst, struct damos_filter *src)
 {
@@ -866,6 +946,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_moving_sum),
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_commit_quota_goal),
+	KUNIT_CASE(damos_test_commit_quota_goals),
 	KUNIT_CASE(damos_test_commit_filter),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
-- 
2.47.3

