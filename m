Return-Path: <linux-kselftest+bounces-277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE8A7F080B
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Nov 2023 18:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D6AB20933
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Nov 2023 17:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07021804D;
	Sun, 19 Nov 2023 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjylG+h6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC49101C1;
	Sun, 19 Nov 2023 17:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEBFC433C9;
	Sun, 19 Nov 2023 17:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700414134;
	bh=YDy2xpgd3SqWOCCdmUAUqNT0vwzIyx0UHeHWEu/iyRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjylG+h6XhlGYO3Ub30LrxVW6R/8F/y1CvnVEtKokrXHOcCFNtYWT2iWfNIgY/B4K
	 3cS78u1fskzF0FeyFDELRMq5TGWSesXNl4/W3mWmuwYfRQzZCmNw2+gsO/6c275yI9
	 lnjz95ZZZsA805p85xdm8l6+tEmOblMYoWkYqyFUbkXTk+r7NIa6hTPjWBd3AZosuH
	 LLNMn21EXI7PiMbDrpx86j1jLp87JOZAMKgeIQcRxzMvYWHk33LKX6OR/pCBN4wNAQ
	 C0S+WwA3iwQFHhmX4KpoAXFc6YTFVbPHaWIr7m+e21K+AGomVHVN1WYJN3Qvl7KYEG
	 MiEfdSmcOp5uw==
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
Subject: [PATCH 2/2] mm/damon/core-test: test damon_split_region_at()'s access rate copying
Date: Sun, 19 Nov 2023 17:15:29 +0000
Message-Id: <20231119171529.66863-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231119171529.66863-1-sj@kernel.org>
References: <20231119171529.66863-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_split_region_at() should set access rate related fields of the
resulting regions same.  It may forgotten, and actually there was the
mistake before.  Test it with the unit test case for the function.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 649adf91ebc5..e6a01ea2ec54 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -122,18 +122,25 @@ static void damon_test_split_at(struct kunit *test)
 {
 	struct damon_ctx *c = damon_new_ctx();
 	struct damon_target *t;
-	struct damon_region *r;
+	struct damon_region *r, *r_new;
 
 	t = damon_new_target();
 	r = damon_new_region(0, 100);
+	r->nr_accesses_bp = 420000;
+	r->nr_accesses = 42;
+	r->last_nr_accesses = 15;
 	damon_add_region(r, t);
 	damon_split_region_at(t, r, 25);
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
 
-	r = damon_next_region(r);
-	KUNIT_EXPECT_EQ(test, r->ar.start, 25ul);
-	KUNIT_EXPECT_EQ(test, r->ar.end, 100ul);
+	r_new = damon_next_region(r);
+	KUNIT_EXPECT_EQ(test, r_new->ar.start, 25ul);
+	KUNIT_EXPECT_EQ(test, r_new->ar.end, 100ul);
+
+	KUNIT_EXPECT_EQ(test, r->nr_accesses_bp, r_new->nr_accesses_bp);
+	KUNIT_EXPECT_EQ(test, r->nr_accesses, r_new->nr_accesses);
+	KUNIT_EXPECT_EQ(test, r->last_nr_accesses, r_new->last_nr_accesses);
 
 	damon_free_target(t);
 	damon_destroy_ctx(c);
-- 
2.34.1


