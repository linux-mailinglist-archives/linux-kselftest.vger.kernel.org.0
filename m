Return-Path: <linux-kselftest+bounces-44605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 292F4C28554
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713803AF2F5
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF889306B0D;
	Sat,  1 Nov 2025 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk8oZQyt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6C30648A;
	Sat,  1 Nov 2025 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021242; cv=none; b=rCWydrA3ZQlSJfXZjYeG/+ZS4kQrlKSCOUV6zZr37rjCt4TyL0tVuTAGxTECuGXwaMiZg6sIY0KYk0oApBpOEb5pVg+UrHGkPjZCLH8AQD+3yAf0NWg+AsGBJbOA7L63frDmvgt2BP7owXZTBL8kbvliz0pjy8TCZ8Jvn71oeJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021242; c=relaxed/simple;
	bh=PLzxcHsoSe+0yVejn7B0A/LGthJsGhvzYk8OEsuxAOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXasbcxF3IZKG7fPakosD5ql3VJVc6uzPn2sPEMWYytgDs0LNyh17MUS/WX0UM7GCwhXxnKimAFCWKGhnFxIMCPjwpir0166iRHve3XLZamBOfkdcGaDe6RgUfoa1kRSJYpHqV0gSVjS7YqW2JbxAPqwaeDGgsoSqgddUvJCizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk8oZQyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B93C4CEF1;
	Sat,  1 Nov 2025 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021242;
	bh=PLzxcHsoSe+0yVejn7B0A/LGthJsGhvzYk8OEsuxAOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hk8oZQytRHvD4yY1GTSmSR5xdnrFQaYLz0Neg46BHv9DIcvoXZdYDUeepzqOKkRGA
	 PQdMwmnMSndNRmiV6tEnV7K4EfSB9+2onrnhkjywAkSRC89hu097m8uH1DBSOaUEnt
	 QcxZhCZ0+e4MYhaAlAXRjP5D+1Lu/cM+QyXRWq6yL0OWM/3MzNwW2Q9OTGtFERMY+b
	 okP80u3h6S+YiBXPPzoxNpKy2T+CyEy3C/323OTjtzJ4rpIoRDknBu95SpbnHJ9eQv
	 ELqNdB/w1R6hmLmm7ZrdEC8pqQEkyG82IoWq2U+dAHxzHkZHRgObgmwwTMNOj4ZsLw
	 /6ovLKarDPWhA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 15 . x" <stable@vger.kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 19/22] mm/damon/tests/vaddr-kunit: handle alloc failures on damon_test_split_evenly_succ()
Date: Sat,  1 Nov 2025 11:20:13 -0700
Message-ID: <20251101182021.74868-20-sj@kernel.org>
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

damon_test_split_evenly_succ() is assuming all dynamic memory allocation
in it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/vaddr-kunit.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 1b0f21c2e376..30dc5459f1d2 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -284,10 +284,17 @@ static void damon_test_split_evenly_succ(struct kunit *test,
 	unsigned long start, unsigned long end, unsigned int nr_pieces)
 {
 	struct damon_target *t = damon_new_target();
-	struct damon_region *r = damon_new_region(start, end);
+	struct damon_region *r;
 	unsigned long expected_width = (end - start) / nr_pieces;
 	unsigned long i = 0;
 
+	if (!t)
+		kunit_skip(test, "target alloc fail");
+	r = damon_new_region(start, end);
+	if (!r) {
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	damon_add_region(r, t);
 	KUNIT_EXPECT_EQ(test,
 			damon_va_evenly_split_region(t, r, nr_pieces), 0);
-- 
2.47.3

