Return-Path: <linux-kselftest+bounces-44607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E9BC28557
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8829E3BB313
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290933081A3;
	Sat,  1 Nov 2025 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9Qs0SVq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090F2FF655;
	Sat,  1 Nov 2025 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021243; cv=none; b=rKiS5QzL8uywTBZoHNhpe3ECrGfAxKCoEdMy15aYTBaVuF6IPhWsIlqD4gcT2SNKTGQEaze1hDAq3QtQ/yTQfPBwZrBs/JP83lKRUj1JWzKB/gK1pWHOIXbDpdf+en/NjnEv+LztI4yw2B+fiZ3I1+yrNyfDbOQ1BDcw4hoGSEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021243; c=relaxed/simple;
	bh=7DGmc3I+5nR3iT/IUWCpGRBq8NOcMAe9aK8+QNZZPkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVu5LNtjeLUFhmhCZroczLEX+uQk4nekT6xsCrKlZvBUNydJjetaJtyRs6/aEcS53/U2N4weljkDD/FOXbTw2tMeGplSoFKO3oTGIp/IOfEZZfAsJChO8BDadg6hBKGS+PHChdsdp1bYafr1ty1KFl9YAGkG4JnZNBY+VcD1rk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9Qs0SVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD677C116C6;
	Sat,  1 Nov 2025 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021242;
	bh=7DGmc3I+5nR3iT/IUWCpGRBq8NOcMAe9aK8+QNZZPkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i9Qs0SVqVhQ+cgTpUUlxG5QlAQukPmjmxt6eZXHcyaU3l9KUJtW09FWDRDcfT0Rr6
	 9+CFFebpcb2rwBWvOGieJzSUGdHSJOwYvDvyFcqoZOzLTX2qNFaBgTXoR+jkAD15MN
	 r1SNi9xKeePBufxbAMqfuFxfzKTWCtScyMfK6ee6Jo++FdHxttENFVYZa/3JXtdYSf
	 iZzlr3E+xOnNca6wscC0ot5/Mk2SinVlANgjDOIGUwnUlBcNwebF17q9mVUXnBv02b
	 S0j9Gwh+W48r/aC9lIi1VLYMz9MYluQoYZYCfs2q81gx7Vu+rIBFGrruYT8/Tn6mS/
	 09N3b7/ZLMuyg==
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
Subject: [PATCH 21/22] mm/damon/tests/core-kunit: remove unnecessary damon_ctx variable on damon_test_split_at()
Date: Sat,  1 Nov 2025 11:20:15 -0700
Message-ID: <20251101182021.74868-22-sj@kernel.org>
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

damon_test_split_at() dynamically allocates a 'struct damon_ctx' object,
but it is not really being used in the code other than handling the
allocation failure and deallocating it at the end of the function.
Remove the unnecessary allocation and deallocation of the object.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index a91d798caa70..726f593930e7 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -144,20 +144,14 @@ static void damon_test_aggregate(struct kunit *test)
 
 static void damon_test_split_at(struct kunit *test)
 {
-	struct damon_ctx *c = damon_new_ctx();
 	struct damon_target *t;
 	struct damon_region *r, *r_new;
 
-	if (!c)
-		kunit_skip(test, "ctx alloc fail");
 	t = damon_new_target();
-	if (!t) {
-		damon_destroy_ctx(c);
+	if (!t)
 		kunit_skip(test, "target alloc fail");
-	}
 	r = damon_new_region(0, 100);
 	if (!r) {
-		damon_destroy_ctx(c);
 		damon_free_target(t);
 		kunit_skip(test, "region alloc fail");
 	}
@@ -178,7 +172,6 @@ static void damon_test_split_at(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->last_nr_accesses, r_new->last_nr_accesses);
 
 	damon_free_target(t);
-	damon_destroy_ctx(c);
 }
 
 static void damon_test_merge_two(struct kunit *test)
-- 
2.47.3

