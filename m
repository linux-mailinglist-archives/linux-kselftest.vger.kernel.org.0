Return-Path: <linux-kselftest+bounces-45352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D230C4F7AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595533AC4BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E982C0F6F;
	Tue, 11 Nov 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rj81mmns"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE352C08BB;
	Tue, 11 Nov 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886669; cv=none; b=r07733ygPh0IKT2cE2j32WS2Sigs3nnFo8BGZn7F5AvlxodSfT4uZIci6iZjBZrTeq1xUNchBVn7n/FQdufKMdoioRClp/FC5xacoDQsktwDAM4k1XgA5t83q+wfwPjkfW9fnoFVfefApCRJWhbQMx4DXEebpuUeh/0v3Uoxqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886669; c=relaxed/simple;
	bh=5hPS/JRy01yuhaxPekjxyV4N7WLnupymMnfSho8r7YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Glp76kjM/tJPe4hYc6jHsMw4VoFdvRJ5Mgu6Zcm+U3tk5gYM0bSEUpdZZWtIH0jkselq0mEalwGaBKb6EiSZQyS7I7Jc1+ZMltuWmY7GhNT7vpoMbp66zqERJeqFKvbLRqCtm+YuDQqLl6Fo0yJVM9rHJFiM6UD2GSrcIPgaixE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rj81mmns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B436AC2BCB1;
	Tue, 11 Nov 2025 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762886668;
	bh=5hPS/JRy01yuhaxPekjxyV4N7WLnupymMnfSho8r7YU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rj81mmnsTq9QoQJciglj+bJbWGeRJMX1Z8c3nXxw5O866+6jzgG4D0x1bG/s/cn6t
	 Wm0mjoiaPhVNsS3s2lED/trYsAAYtzb3wqopG5VmmZ4K1TPEwrWC+sXxv7sfN7wQpm
	 3jPPoH0C2v8/27DKJTnnFYbiQoq25aOahjNWIRfHE0y4s0dHjAYQdH+651u1ARpvR2
	 V2QRm7lKBebdCZvRnz+600iCpaBS94DRjlRxAm86QubX5E9PQh95Yni4JVMDB+uYhq
	 76qP//eUUWQVLd1sBWkr9wxUDZqVr81muia0rWg/4VRdvg7XwFY4wGDoAeL/00hp6n
	 9CaqyCsyW7C9g==
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
Subject: [PATCH 07/11] mm/damon/tests/core-kunit: add damos_commit_quota() test
Date: Tue, 11 Nov 2025 10:44:06 -0800
Message-ID: <20251111184415.141757-8-sj@kernel.org>
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

Add a new unit test for damos_commit_quota().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 3abf31fb1074..546e1a09d801 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -660,6 +660,38 @@ static void damos_test_commit_quota_goals(struct kunit *test)
 			(struct damos_quota_goal[]){}, 0);
 }
 
+static void damos_test_commit_quota(struct kunit *test)
+{
+	struct damos_quota dst = {
+		.reset_interval = 1,
+		.ms = 2,
+		.sz = 3,
+		.weight_sz = 4,
+		.weight_nr_accesses = 5,
+		.weight_age = 6,
+	};
+	struct damos_quota src = {
+		.reset_interval = 7,
+		.ms = 8,
+		.sz = 9,
+		.weight_sz = 10,
+		.weight_nr_accesses = 11,
+		.weight_age = 12,
+	};
+
+	INIT_LIST_HEAD(&dst.goals);
+	INIT_LIST_HEAD(&src.goals);
+
+	damos_commit_quota(&dst, &src);
+
+	KUNIT_EXPECT_EQ(test, dst.reset_interval, src.reset_interval);
+	KUNIT_EXPECT_EQ(test, dst.ms, src.ms);
+	KUNIT_EXPECT_EQ(test, dst.sz, src.sz);
+	KUNIT_EXPECT_EQ(test, dst.weight_sz, src.weight_sz);
+	KUNIT_EXPECT_EQ(test, dst.weight_nr_accesses, src.weight_nr_accesses);
+	KUNIT_EXPECT_EQ(test, dst.weight_age, src.weight_age);
+}
+
 static void damos_test_commit_filter_for(struct kunit *test,
 		struct damos_filter *dst, struct damos_filter *src)
 {
@@ -947,6 +979,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damos_test_new_filter),
 	KUNIT_CASE(damos_test_commit_quota_goal),
 	KUNIT_CASE(damos_test_commit_quota_goals),
+	KUNIT_CASE(damos_test_commit_quota),
 	KUNIT_CASE(damos_test_commit_filter),
 	KUNIT_CASE(damos_test_filter_out),
 	KUNIT_CASE(damon_test_feed_loop_next_input),
-- 
2.47.3

