Return-Path: <linux-kselftest+bounces-44590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4DAC284B2
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 872904EABBA
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87682FC870;
	Sat,  1 Nov 2025 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIzuvFW0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F002FC005;
	Sat,  1 Nov 2025 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021237; cv=none; b=Zw/0DpXzDG4ELeD/VE8W2wrK2vOBzk8vz4UgdPjZ8dy7teX7TpFwliSwh/IriDRt1GyKXpVILlrgleG1P5VRUMjb99OY1sweL4V0EY2S7ItPFPB+kvQ7Rm8Uq51gqguT57884nwjQSddgHHNi4quXpWA5tAbSgJCoqKjU0uC2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021237; c=relaxed/simple;
	bh=MAHj0zqutyRZpbO2i6YXcMC7MCCsz7KkFpvZC2OrxTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiHGGPRNHs9mk6FwjBnKlLl6prd/y4CtSIZxCnhMs//mTpGApfok58sLYpje61lRNUs4O0C/2gL6ayOTZejjP+5qTpQzwZfIgks+ZrvpIuUbFiQJTzS53KivBofjwT/A4Qok9xjeSkhy7lKMct18++ruxMkysvibdgRCoGykYBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIzuvFW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDF6C113D0;
	Sat,  1 Nov 2025 18:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021237;
	bh=MAHj0zqutyRZpbO2i6YXcMC7MCCsz7KkFpvZC2OrxTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vIzuvFW0beDimEA3rhSSda12ZcO/KMSATCqAyuGISaMV5hCauIF/+XqjyCAc+J2/T
	 QaGsH0X+/Eoheu7F64I6YbtbMgHUhg+00l/5iLqqGfKKF6g/kH/zS8E2pCW7PQzJ88
	 F9Q8bGLFDNIQlsqbAReQHcU/UqZt+9oV1pFy6IbeX8kTD/96mcEBPwpVIoN00/awFB
	 aeYYrqdLju9ixABzTjJUPAXFcwhvwoqCsu2mdsUafcxvTVM+HptBM0FrSLxI0DWGKP
	 TZjUQwQU+sClOrLEBhUeR4FQlQd7uBvNR4XJZkx7EhenNkCuOSLwD10m7ZHzLFOu/S
	 d7xrjSuiegTXA==
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
Subject: [PATCH 04/22] mm/damon/tests/core-kunit: handle memory alloc failure from damon_test_aggregate()
Date: Sat,  1 Nov 2025 11:19:58 -0700
Message-ID: <20251101182021.74868-5-sj@kernel.org>
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

damon_test_aggregate() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.
In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 6e8a605277a3..fd1e1ecaa2c9 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -97,8 +97,15 @@ static void damon_test_aggregate(struct kunit *test)
 	struct damon_region *r;
 	int it, ir;
 
+	if (!ctx)
+		kunit_skip(test, "ctx alloc fail");
+
 	for (it = 0; it < 3; it++) {
 		t = damon_new_target();
+		if (!t) {
+			damon_destroy_ctx(ctx);
+			kunit_skip(test, "target alloc fail");
+		}
 		damon_add_target(ctx, t);
 	}
 
@@ -106,6 +113,10 @@ static void damon_test_aggregate(struct kunit *test)
 	damon_for_each_target(t, ctx) {
 		for (ir = 0; ir < 3; ir++) {
 			r = damon_new_region(saddr[it][ir], eaddr[it][ir]);
+			if (!r) {
+				damon_destroy_ctx(ctx);
+				kunit_skip(test, "region alloc fail");
+			}
 			r->nr_accesses = accesses[it][ir];
 			r->nr_accesses_bp = accesses[it][ir] * 10000;
 			damon_add_region(r, t);
-- 
2.47.3

