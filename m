Return-Path: <linux-kselftest+bounces-44592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0023C284C7
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4399D3BA8D7
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68C42FD68C;
	Sat,  1 Nov 2025 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjPZlaB2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780652FD670;
	Sat,  1 Nov 2025 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021238; cv=none; b=oZaA+pGD7s4T2vwar/l/v4kBeYdtmV8VhE242LFAia0S2GXrAiyUZC/9Uu5w8WZjGOChczqOO5WlLd5PkUHcihdSOCaNGrCERAkwJWpvAkLUHrx4vbYambzc+AVkdtPTsv/sHgTtLpTB/KoEM8atQahWE1ZgaNtmFYSF3x4bZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021238; c=relaxed/simple;
	bh=mFKvW58Z/A1OQcFHyE0QlO67VUd7WnWfCLTNsVL0kBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lidZu+IqmS326d1l2jRM/SwYR2/y0AinJmfuUs6Nx9/rugbjvG9XMmVBJp1m3/SoqvvhG59Yb9VSECiQflwnBdaiN9yHiUWXDYNZdxHL2nR00Rclew5HUXraN74iJBghao8H5rcVrdEXzGJLCsSRcSz8Kl0fzCf11TPJkEoRYCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjPZlaB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52F1C116B1;
	Sat,  1 Nov 2025 18:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021238;
	bh=mFKvW58Z/A1OQcFHyE0QlO67VUd7WnWfCLTNsVL0kBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FjPZlaB2TObb4T2dW5PMEVnsKEXDA50bpKODTpc5GgHl21/G21jLbAlvsxq1boR+W
	 CulmNGBY0zT4Qdo93ckIV9xSsmlHG83/iM830OiMVCpjKGhBzKnvOkDGgUe+WA2Saz
	 tVK18LGeQljsGtziSPkVv3pdUfs+XN9b4cCzYKEEsMLMUu6/rBnkY6Z8esXKw7TUEw
	 oSNQgKIZ118ViGn/X/6d9PNyfXjcc6WSfgC5K4ww2ldfPdu9lwzLTQxl2M+XeZQEYY
	 3m4lkLAbyu5oEe8PmIxKJOHVqVjHAzYc1Dab5HJDXXDZGybbkCIoLvSw4MuIGEctzC
	 6QVQNiET8g+Vw==
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
Subject: [PATCH 06/22] mm/damon/tests/core-kunit: handle alloc failures on damon_test_merge_two()
Date: Sat,  1 Nov 2025 11:20:00 -0700
Message-ID: <20251101182021.74868-7-sj@kernel.org>
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

damon_test_merge_two() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.
In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index f5f3152cb8df..e8219fd23318 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -188,11 +188,21 @@ static void damon_test_merge_two(struct kunit *test)
 	int i;
 
 	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "target alloc fail");
 	r = damon_new_region(0, 100);
+	if (!r) {
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	r->nr_accesses = 10;
 	r->nr_accesses_bp = 100000;
 	damon_add_region(r, t);
 	r2 = damon_new_region(100, 300);
+	if (!r2) {
+		damon_free_target(t);
+		kunit_skip(test, "second region alloc fail");
+	}
 	r2->nr_accesses = 20;
 	r2->nr_accesses_bp = 200000;
 	damon_add_region(r2, t);
-- 
2.47.3

