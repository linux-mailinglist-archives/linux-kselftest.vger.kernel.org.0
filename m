Return-Path: <linux-kselftest+bounces-37-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B427E9253
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 20:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6ED280A73
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Nov 2023 19:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1B7179A8;
	Sun, 12 Nov 2023 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZqjkc6F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC7617729;
	Sun, 12 Nov 2023 19:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47C7C433C9;
	Sun, 12 Nov 2023 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699818376;
	bh=aHVFSWkLgL3DSZk4BMjseldmOMFwERpUZXKvLSdezzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZqjkc6FTf18ZhcDORKrMuhByH+hD2Ss0jubtVf43EF5ai/X82RLUEbaKYzgzrYU9
	 z6lLO2EUuHLi77rriepOZl7QKtaMC8Lnri0kYl1PYU209QyxwYWYWi9JCcsCDjorSY
	 nX7TWmp0x/LbG5ORpd0gvkGY5iZ3V4vgnl0FRXB+P9gnFbOn20pXo3jAaOlyD6rwT3
	 EMOH773xXOzjDJZwTk0G2KvHE4Vh6Lo3Loq7gL6WzItm5OgzbL5eYpkwesgfSh4aAc
	 tfP0sImuju4Qi3qfRbyvnT60OF/mRJz+vhHo9fpIDgD5AGwY3tf9vxowqQUza3+BJo
	 jkDyFPFq0/qnA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/8] mm/damon/core-test: add a unit test for the feedback loop algorithm
Date: Sun, 12 Nov 2023 19:46:04 +0000
Message-Id: <20231112194607.61399-6-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112194607.61399-1-sj@kernel.org>
References: <20231112194607.61399-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a simple kunit test for testing the behavior of the core logic
of the goal-oriented feedback-driven DAMOS quota auto-tuning.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index f405d79dc623..c2b8cb25a195 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -447,6 +447,37 @@ static void damos_test_filter_out(struct kunit *test)
 	damos_free_filter(f);
 }
 
+static void damon_test_feed_loop_next_input(struct kunit *test)
+{
+	unsigned long last_input = 900000, current_score = 200;
+
+	/*
+	 * If current score is lower than the goal, which is always 10,000
+	 * (read the comment on damon_feed_loop_next_input()'s comment), next
+	 * input should be higher than the last input.
+	 */
+	KUNIT_EXPECT_GT(test,
+			damon_feed_loop_next_input(last_input, current_score),
+			last_input);
+
+	/*
+	 * If current score is higher than the goal, next input should be lower
+	 * than the last input.
+	 */
+	current_score = 250000000;
+	KUNIT_EXPECT_LT(test,
+			damon_feed_loop_next_input(last_input, current_score),
+			last_input);
+
+	/*
+	 * The next input depends on the distance between the current score and
+	 * the goal
+	 */
+	KUNIT_EXPECT_GT(test,
+			damon_feed_loop_next_input(last_input, 200),
+			damon_feed_loop_next_input(last_input, 2000));
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -463,6 +494,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_moving_sum),
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_filter_out),
+	KUNIT_CASE(damon_test_feed_loop_next_input),
 	{},
 };
 
-- 
2.34.1


