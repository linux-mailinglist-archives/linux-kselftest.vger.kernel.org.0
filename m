Return-Path: <linux-kselftest+bounces-16361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CC895FF91
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 05:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51F2AB22801
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 03:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D47613664E;
	Tue, 27 Aug 2024 03:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiviURUz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C6212E1C2;
	Tue, 27 Aug 2024 03:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727831; cv=none; b=PY5zva+kzd9QyQxgmkuZew13bHRp2VkQ7gyd0K2oO71FxzAPOX1oFOBDTiqKRjSw2JdrB1A4MDlCUV7WiQMWrnSmAz0g4VTDdH9vDjuf/2lCVUA0rmbpBSpDpPBBaAxEeMVz6Y+q77VRd+zls59afXY+/hnCqvuMUD+EUAc1gXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727831; c=relaxed/simple;
	bh=IxpMWIJWc8lNeei5qcMinGRh56gQoVV53dw/oH9g9XY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IvU50WanE9vSv9nN+pmmxLq2itBsQvvyzlFUOjMkVNakH9TeXvJvEz/TIPmeRvIhnshmR9YdQk2xx8LMg/c96eI+1E6E0XKmF5wo4U210Rk2GKgCEzvtcrScniWlEmKI1vtUcVPOFTmpvS/aTG8jNIKTUn5cuhRww5DkyIy0s2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiviURUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37166C8B7A5;
	Tue, 27 Aug 2024 03:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724727830;
	bh=IxpMWIJWc8lNeei5qcMinGRh56gQoVV53dw/oH9g9XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MiviURUzk+69xkmiUshCH+Qi8dVAA/xCMLUfogwfkfbJUxQY1HGwZxk8lRXi73tQs
	 XBngynWjeia092BrzXj2pGuzw0+ipJrLWg5NVe+JAP/VNxcug9W0sHHpzDv7A501Ka
	 o/KfyFoT5INKzm/sVa350CYg2pNKt1EkaQhm80BR/b/wtEhhEKvOMOejygId9dm7Xo
	 hnnVohkPkstiDwN7ZO/bkxPccj6CBdkjv9kEEDk8ZGVMNDnfmBByuep9+j6ZzveQIs
	 PHr56HS4WJhMnvfezEgLoOHQxq93dkM9qQdV+vzJkzcncy/AR9xeqglpuNRaVfo0Ka
	 XxgaKsNvtokdg==
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
Subject: [PATCH 7/9] mm/damon/dbgfs-test: skip dbgfs_set_init_regions() test if PADDR is not registered
Date: Mon, 26 Aug 2024 20:03:34 -0700
Message-Id: <20240827030336.7930-8-sj@kernel.org>
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
index 9bd5dca5d4ad..d2ecfcc8db86 100644
--- a/mm/damon/dbgfs-test.h
+++ b/mm/damon/dbgfs-test.h
@@ -116,6 +116,11 @@ static void damon_dbgfs_test_set_init_regions(struct kunit *test)
 	int i, rc;
 	char buf[256];
 
+	if (!damon_is_registered_ops(DAMON_OPS_PADDR)) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "PADDR not registered");
+	}
+
 	damon_select_ops(ctx, DAMON_OPS_PADDR);
 
 	dbgfs_set_targets(ctx, 3, NULL);
-- 
2.39.2


