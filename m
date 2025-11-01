Return-Path: <linux-kselftest+bounces-44594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21523C284D3
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9F53BB5A3
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04102FDC31;
	Sat,  1 Nov 2025 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnytKmMm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209E2FD7A0;
	Sat,  1 Nov 2025 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021238; cv=none; b=YibwUKYOXSkikfUux2YIvbtJp02ChbxikD5CdXr312D1xAiSdEmhpeDF1MvdolPUbz1xuQMUUkP2+HfERSuPk1XghYiGRwkivPqCa8CCXRO/LbQzKhYzyvIkvUUpcp9fKiWZrZwWrBCMht7vn3aGcxsiqzripstTsEvsICLWeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021238; c=relaxed/simple;
	bh=N0sjlEOjAoI+Rw+maQxTDR5r9ce2wPbMV20M9TtSgUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxqOuwCXLXgYoevMyvF4F7MqOGfihiBUWgD740OHDMryIWJMp5Sc+GJoFY76Q+3pLpIGhumT1pWW+0r2XtU+XhAv7Ms70Yt3dbCQbSitGm5Gleipev5qXf66x50zqamIHxP1B2An8mnLkn+6MHhFmx4eXk9krD7YTgA6i3DA2Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnytKmMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2FCC4CEF1;
	Sat,  1 Nov 2025 18:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021238;
	bh=N0sjlEOjAoI+Rw+maQxTDR5r9ce2wPbMV20M9TtSgUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lnytKmMmhwH7ctE3pW95SaD8GKebhnNqUSr+FWjzJEvCgLZooM6anHIe2iE2OmJ0b
	 ZYGxHaWCOZHC8K/p0IOyOAyJV/Gazga2XGl3QWnCSTKFxUXCOdKi2GjVwbckAaCxDb
	 /G2XmsKfz4DVQdHmEmq2skYgeRKlTZ7iSBZDKXQCEI6g2Azi8JUvFGLLqVh6EgQ1jc
	 W/Tbmtj1811G8oaN7zrZaVyCO8WXnEI7w24HmS7ZuLDY1kE5OF/ceXBZD/X+/3d4wt
	 bou/2a25glhCCPZ6snb5bm++oAmwyVnN6S60rW6wUzIMfsRKo37V4JeLvocWNaOZRS
	 bsfRTKt1mo57A==
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
Subject: [PATCH 07/22] mm/damon/tests/core-kunit: handle alloc failures on dasmon_test_merge_regions_of()
Date: Sat,  1 Nov 2025 11:20:01 -0700
Message-ID: <20251101182021.74868-8-sj@kernel.org>
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

damon_test_merge_regions_of() is assuming all dynamic memory allocation
in it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index e8219fd23318..98f2a3de7cea 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -248,8 +248,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	int i;
 
 	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "target alloc fail");
 	for (i = 0; i < ARRAY_SIZE(sa); i++) {
 		r = damon_new_region(sa[i], ea[i]);
+		if (!r) {
+			damon_free_target(t);
+			kunit_skip(test, "region alloc fail");
+		}
 		r->nr_accesses = nrs[i];
 		r->nr_accesses_bp = nrs[i] * 10000;
 		damon_add_region(r, t);
-- 
2.47.3

