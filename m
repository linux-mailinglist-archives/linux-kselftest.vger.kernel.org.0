Return-Path: <linux-kselftest+bounces-44595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B16C5C284D9
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2E0189DCF9
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917A02FE593;
	Sat,  1 Nov 2025 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzx1oqvX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EC12FE563;
	Sat,  1 Nov 2025 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021239; cv=none; b=LEWhZ5iHmmW8aSDWeu12HPjn90Sc4i/OZh1el+8JIcX9aBSLJZzBBPGRDO3frjQHQIZ3O2kAUNXb5DEgkjlw+zRga96q7+60x8Hqhnb4KkZNxZuCug/2C/88VEOfvs7BtnDzZ5vVS1FurgbCA/eX1jujLIslEH91F3fDi9v2cp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021239; c=relaxed/simple;
	bh=7jFvaJGAP1Q4wk1944apRFLq0yQCQ9xbNJKdqchcXTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cInH78zx3Rq3d1O+ePaXOLeFAachopGoI54/KJxXoBZ6k3wOrG6dpfeh8VRUzazwCPBq5ivYjxA67k2rEhWhW3g3cNIzkY4m5DbuRgtWj4s5hfQy7IFq+V/By3AkgHFxpVn2Ln7c9AOWkwFaOdSBHX6WTkN/qUMVriYEkC45R/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzx1oqvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFD7C113D0;
	Sat,  1 Nov 2025 18:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021239;
	bh=7jFvaJGAP1Q4wk1944apRFLq0yQCQ9xbNJKdqchcXTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fzx1oqvXMfUViV2BMqJZfpb2KQUo0kC6CUqYBP0FLxcaGA0B1YdoM+vM/lR9jXdkQ
	 qucFe3ffLdcRsidGlwfI2JPBgfhilaS7lDoaq+Ypdutd6XFBKLk8+qh46IQRv0RtKZ
	 DUkCvOoDwFpjzVk/PELeY0IqCbcWoeppyIBMHVXAgxbuxoQzAIgjM+owg5Lp0mGzc9
	 7qOzWsP/orm51MAae9p1o3z7PhJbKG9OlXIa0VolWBEymS/OTdUCDuDfr/3tI1NvWm
	 qXjGK8v1MFiB+uahqGHPzfoWkCUnFpwdZx/KwgpEBGqOc/fFkpZp0IUPleZcXSJWh2
	 Kg2xrmTnJwrZA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 1 . x" <stable@vger.kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/22] mm/damon/tests/core-kunit: handle alloc failures in damon_test_set_regions()
Date: Sat,  1 Nov 2025 11:20:04 -0700
Message-ID: <20251101182021.74868-11-sj@kernel.org>
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

damon_test_set_regions() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.
In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Fixes: 62f409560eb2 ("mm/damon/core-test: test damon_set_regions")
Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 96c8f1269f44..e38c95f86a68 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -368,13 +368,26 @@ static void damon_test_ops_registration(struct kunit *test)
 static void damon_test_set_regions(struct kunit *test)
 {
 	struct damon_target *t = damon_new_target();
-	struct damon_region *r1 = damon_new_region(4, 16);
-	struct damon_region *r2 = damon_new_region(24, 32);
+	struct damon_region *r1, *r2;
 	struct damon_addr_range range = {.start = 8, .end = 28};
 	unsigned long expects[] = {8, 16, 16, 24, 24, 28};
 	int expect_idx = 0;
 	struct damon_region *r;
 
+	if (!t)
+		kunit_skip(test, "target alloc fail");
+	r1 = damon_new_region(4, 16);
+	if (!r1) {
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
+	r2 = damon_new_region(24, 32);
+	if (!r2) {
+		damon_free_target(t);
+		damon_free_region(r1);
+		kunit_skip(test, "second region alloc fail");
+	}
+
 	damon_add_region(r1, t);
 	damon_add_region(r2, t);
 	damon_set_regions(t, &range, 1, DAMON_MIN_REGION);
-- 
2.47.3

