Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360404650D0
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 16:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350358AbhLAPI3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 10:08:29 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:52734 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350326AbhLAPI1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 10:08:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 97ED0CE1F99;
        Wed,  1 Dec 2021 15:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481D1C53FD2;
        Wed,  1 Dec 2021 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638371103;
        bh=nMvEMx9k5IK3wjDZ51A43sizsqcw2go8DgM5XkopF88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2MAP9GBrsmaOi7c2RYIkFbH+11PGH2NYi1oLnww8zPh8lxqLXLBtnpw7AQD6Bct1
         f5kCYVluvB8MBzBLaEVXLsGcYU1xxi0Y16tnbH9BTSvGqrvbwtQmanJtfWOMDDaqY9
         +Q+EaV5NiGMNigvk3qEUszmS/iGf6WND0TU3AEFGWs6R4ZWWIMdwWND6awQBwEuNAH
         3QfQabM/AEoJ4UIpgqpPzBCbIWk07/VtxnQbQIykHlRKjht9KcDkAj2fgeTdGo9cW2
         hfvxcIVcYLvTc0j/Ok2T3Ev1JMc43qwMFdxjjfjOSFDc+BDncaLkfqKB9HzFfAtyZh
         QureMzo946rYw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 06/11] mm/damon/vaddr-test: Remove unnecessary variables
Date:   Wed,  1 Dec 2021 15:04:35 +0000
Message-Id: <20211201150440.1088-7-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201150440.1088-1-sj@kernel.org>
References: <20211201150440.1088-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A couple of test functions in DAMON virtual address space monitoring
primitives implementation has unnecessary damon_ctx variables.  This
commit removes those.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr-test.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 3097ef9c662a..6a1b9272ea12 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -135,7 +135,6 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 				struct damon_addr_range *three_regions,
 				unsigned long *expected, int nr_expected)
 {
-	struct damon_ctx *ctx = damon_new_ctx();
 	struct damon_target *t;
 	struct damon_region *r;
 	int i;
@@ -145,7 +144,6 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 		r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
 		damon_add_region(r, t);
 	}
-	damon_add_target(ctx, t);
 
 	damon_va_apply_three_regions(t, three_regions);
 
@@ -154,8 +152,6 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 		KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);
 		KUNIT_EXPECT_EQ(test, r->ar.end, expected[i * 2 + 1]);
 	}
-
-	damon_destroy_ctx(ctx);
 }
 
 /*
@@ -298,8 +294,6 @@ static void damon_test_split_evenly_succ(struct kunit *test,
 
 static void damon_test_split_evenly(struct kunit *test)
 {
-	struct damon_ctx *c = damon_new_ctx();
-
 	KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(NULL, NULL, 5),
 			-EINVAL);
 
@@ -307,8 +301,6 @@ static void damon_test_split_evenly(struct kunit *test)
 	damon_test_split_evenly_succ(test, 0, 100, 10);
 	damon_test_split_evenly_succ(test, 5, 59, 5);
 	damon_test_split_evenly_fail(test, 5, 6, 2);
-
-	damon_destroy_ctx(c);
 }
 
 static struct kunit_case damon_test_cases[] = {
-- 
2.17.1

