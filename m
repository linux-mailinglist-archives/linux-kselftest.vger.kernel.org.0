Return-Path: <linux-kselftest+bounces-859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 744C27FE6ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 03:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55C71C20A20
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 02:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AE81170B;
	Thu, 30 Nov 2023 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6+6tCLI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49C8134C6;
	Thu, 30 Nov 2023 02:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC1AC433CC;
	Thu, 30 Nov 2023 02:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701311822;
	bh=EtcCE3aKL92GHTdnkP2hxrtGMR/ShXKbIT2mRyd4U4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6+6tCLIAdAhswg3GRnBOLmuTKm3/4K740cV/qZXqJeePCyk2PGDIM6hlz0JUF59h
	 CwnfWJGwv/ma6uevYQizY7w2KoKUhBrqhYWeTl81RNPi8QNGZA710/IYqgNHFbpUFW
	 jJ+B1MncEdyn4JY3Jr0tTxCUn4DI6onqGmUXvzSH9tCs5RBeYcbVXy2FIVA1Bx5Wx5
	 perHVTael5dUoP8C/cTLFdstUUTFfXURD7Yc5WTb/uyFBVMRv/1jHhviCMBe00BkaS
	 hfRoAuBG2WvyMptpLHFtLh1Hly+Atkns970LzE3OI3+Bb6MT12dFC25mvAtidZSgUH
	 qwYEgT3+dO6Xg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] mm/damon/core-test: add a unit test for the feedback loop algorithm
Date: Thu, 30 Nov 2023 02:36:48 +0000
Message-Id: <20231130023652.50284-6-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130023652.50284-1-sj@kernel.org>
References: <20231130023652.50284-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a simple kunit test for testing the behavior of the feedback
loop algorithm for the aim-oriented feedback-friven DAMOS aggressiveness
auto tuning.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index e6a01ea2ec54..6e5e9502d648 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -446,6 +446,37 @@ static void damos_test_filter_out(struct kunit *test)
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
@@ -461,6 +492,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_moving_sum),
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_filter_out),
+	KUNIT_CASE(damon_test_feed_loop_next_input),
 	{},
 };
 
-- 
2.34.1


