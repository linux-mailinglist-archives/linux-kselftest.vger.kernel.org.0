Return-Path: <linux-kselftest+bounces-16360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669A195FF8E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 05:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CC0282CE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 03:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567B57B3E1;
	Tue, 27 Aug 2024 03:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHRDIBRY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE877113;
	Tue, 27 Aug 2024 03:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727830; cv=none; b=VKzF1lTe2JE6gZd4M7o1oCdXcsqw2b8tIrWRMFCjXDqUKL8hJ12aZ/LyVXa0P3jknumjYFUXBKdDW/hVLVjxQAw5h17OM9gBdX/QDXKicWUzvP0lqaQM0jMU6kc7JFvVPaSvBaq6vkwB1TcXrX0XmU5S0uPow+NJNcrf/4do9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727830; c=relaxed/simple;
	bh=UByfltsl+0NKbRlC3XW64geq3UiMNgzqDTzx3r/unzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GYVj0QAN/bNaifg7xonDq+ERfVvZAD/Q3kvMrWEBTiwoYTueDLrm03F77dP3B0RYytboeQjETEImjy+iYp6D/3SDM0kBf8sOZuMvYELwXi3KeAxwkGG/vPNBHWkMX9W/EPOAqRsIzC6RSDxJVGdp1Y/l/BgGBF1J1bMvLBa97dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHRDIBRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616F4C8B7B4;
	Tue, 27 Aug 2024 03:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724727830;
	bh=UByfltsl+0NKbRlC3XW64geq3UiMNgzqDTzx3r/unzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHRDIBRYwvoiaUxi62tRmC7xHEIuX4zUxcHBLqbd6VeALE2Q6nv+0pMEpPfRUpMsy
	 FLEDnT/JyJ80ydIVI9/sSxyWOakamo1Tb0Ser+wP/UXZ3NC/MAHvPoskEJCcMCABI8
	 fEd8jb1AKXiAF48Wr1s2RT5c+PfV28DYDE6nN932/Hw2Y9kfinsKS7F3DQNpnGxOkr
	 SErgum5KfTJIQNbmYxUMUOzs0+kWumrDwQ3F7OsWuK2i9WfSEhs9W5SmCF2PGk1fV4
	 h1X1/LJHzEJU0MaAplOD3KaxhoMOpnD/EoLZShohd8+cMyl0RoDOZclTTCiswo/Hsy
	 VH9khOcXvGLXg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] mm/damon/dbgfs-test: skip dbgfs_set_targets() test if PADDR is not registered
Date: Mon, 26 Aug 2024 20:03:33 -0700
Message-Id: <20240827030336.7930-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827030336.7930-1-sj@kernel.org>
References: <20240827030336.7930-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test depends on registration of DAMON_OPS_PADDR.  It would be
registered only when CONFIG_DAMON_PADDR is set.  DAMON core kunit tests
do fake ops registration for such case.  However, the functions for such
fake ops registration is not available to DAMON debugfs interface.  Just
skip the test in the case.

Fixes: 999b9467974f ("mm/damon/dbgfs-test: fix is_target_id() change")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs-test.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/dbgfs-test.h b/mm/damon/dbgfs-test.h
index 2d85217f5ba4..9bd5dca5d4ad 100644
--- a/mm/damon/dbgfs-test.h
+++ b/mm/damon/dbgfs-test.h
@@ -73,6 +73,11 @@ static void damon_dbgfs_test_set_targets(struct kunit *test)
 	struct damon_ctx *ctx = dbgfs_new_ctx();
 	char buf[64];
 
+	if (!damon_is_registered_ops(DAMON_OPS_PADDR)) {
+		dbgfs_destroy_ctx(ctx);
+		kunit_skip(test, "PADDR not registered");
+	}
+
 	/* Make DAMON consider target has no pid */
 	damon_select_ops(ctx, DAMON_OPS_PADDR);
 
-- 
2.39.2


