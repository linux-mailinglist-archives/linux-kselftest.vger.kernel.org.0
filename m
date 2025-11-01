Return-Path: <linux-kselftest+bounces-44601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B4DC284DD
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFDEA3496D7
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7120A302767;
	Sat,  1 Nov 2025 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Imjr3I8O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426423016EF;
	Sat,  1 Nov 2025 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021241; cv=none; b=mYn1F5HPmA2g7BtivwPx9Dq/78ibR2LH24Okv0I7cbqtFnk1SCYcgaptI5irr5VBiI4Il7lvsRtd5JWBd7n/0PLx1GDaXbGwxUd2zPBjHUoZF53CUXI6jJ22B8DCkjnTvbscaghRZohtx0SpD8mj64LLCEGLUgbuNuIwFwIzD2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021241; c=relaxed/simple;
	bh=XQHOX0L3vnaITOpKzT4V1ps8fyI4g/lGuTAfNYAXwxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=helZKSsAzQ93utEu5b16ThRHDYU6KBAJdkkyzi45PFSdnDCx9ZlJA4eH660GmCdnlm7bkKHHUhkbU1Vf3nl6x1YtbNHmYCoqtHAK46mnU6pa9c6fZbEs1kfKE2S2udS3Rg2mcVADTH8XFEZmdgEJ1OzJw16rp+/6weQcLu+z2Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Imjr3I8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BC1C16AAE;
	Sat,  1 Nov 2025 18:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021240;
	bh=XQHOX0L3vnaITOpKzT4V1ps8fyI4g/lGuTAfNYAXwxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Imjr3I8OuNTg5Jna92aip8rzDvyfRpHauqHGpTvTfxPPVWB7HZ559aZLEngl7yTsL
	 WsQiSy3lb7MATQaG5cMCagUHftewHz9Y7Rc3BznXFp44lPsX7g88xMa1DAT47Sb7Dg
	 7T2ssgB81oACG+Qqi0V4dA3RDcK3h/YHX1ZPjYXjtNBcH6rTgCOOdbbTF8ef6UsCOV
	 8GCbXS9gvGeHCvToxcmwmaQnSFzIM0SyybVQH6TtD5ImHuIC7V/QiWVG3dbdIVybH0
	 7f3ipUat6vqcfFBbr2X9bfPdHnqDTygrcF3vn60OK17js1A1vg99ZmijOZB0xHfTe2
	 w1Jd+dwaikcGw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 6 . x" <stable@vger.kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 15/22] mm/damon/tests/core-kunit: handle alloc failures on damos_test_filter_out()
Date: Sat,  1 Nov 2025 11:20:09 -0700
Message-ID: <20251101182021.74868-16-sj@kernel.org>
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

damon_test_filter_out() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.
In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Fixes: 26713c890875 ("mm/damon/core-test: add a unit test for __damos_filter_out()")
Cc: <stable@vger.kernel.org> # 6.6.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 5af8275ffd7d..a03ae9ddd88a 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -542,11 +542,22 @@ static void damos_test_filter_out(struct kunit *test)
 	struct damos_filter *f;
 
 	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
+	if (!f)
+		kunit_skip(test, "filter alloc fail");
 	f->addr_range = (struct damon_addr_range){
 		.start = DAMON_MIN_REGION * 2, .end = DAMON_MIN_REGION * 6};
 
 	t = damon_new_target();
+	if (!t) {
+		damos_destroy_filter(f);
+		kunit_skip(test, "target alloc fail");
+	}
 	r = damon_new_region(DAMON_MIN_REGION * 3, DAMON_MIN_REGION * 5);
+	if (!r) {
+		damos_destroy_filter(f);
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	damon_add_region(r, t);
 
 	/* region in the range */
-- 
2.47.3

