Return-Path: <linux-kselftest+bounces-17083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD2196AD72
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 02:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8855E285EDB
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 00:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786857E6;
	Wed,  4 Sep 2024 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B13qpL9p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB8539B;
	Wed,  4 Sep 2024 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725410739; cv=none; b=pkU4zkVZ0RFAU7MP5gkOWWJM/RV7qqF2aBkmt4TKB5PFv5TZzQ4YT1kqRGTUB4aKTsdQMmFNpR52IwOZZ8VzF+DBJdasGbxK+ZQCmwGkGdQxeBV24LBMuJ7GXwvUt4MP/dndQxpYxeQofhQUdZkh+3JdzMjd5Xolg1qpM1NCaXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725410739; c=relaxed/simple;
	bh=xSWI9r6Swvs+yoAPpNGT8PdDYc4MPyldkqyhEGpxlnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EdW8EuuyGCwHuVUs6NXouJ5MgIVz6Su31THR2FGSOLCPBIZyyA2Hv40iU0BqimMw4JpwyM1c6yHFay4d8VBRencpzDtdCLVB5dj02yQawJiEQiB9earSCF3ll8DiQZmq4hxmvSGOKidKAFzbWo4OVoqagRtUVekLmf9m+05I4K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B13qpL9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A397EC4CEC4;
	Wed,  4 Sep 2024 00:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725410738;
	bh=xSWI9r6Swvs+yoAPpNGT8PdDYc4MPyldkqyhEGpxlnE=;
	h=From:To:Cc:Subject:Date:From;
	b=B13qpL9pcFVJFQl6efVY9KY05M5WB6tlAsaEw92tuRZ26yu6yreUSoa2Qy9q+Ke2T
	 PtfIa5Wa4S9hX4agaN2AtsIP1AbwrFeuNclurekYVfsGNEeTvyLGcPFL6yHkri9ScP
	 WGvzQHHUDVhrOYdLrIdn2KY7RZc2j1MxL4YmCI9HNMDQez5NrTgHoFuOhFZ4S5tPlv
	 DU3nQL4NpT1RW5tsEqQwj5DV1C7M3OTcYI/UD8J1cTkxAu9F0iF/5YEu9IgE81PlAE
	 xBxeK0vPaEzBMr0iVblHt2LHCRPe30Rl/ianGluHaRdX1sQUw2x7rKiPOe9mKTnHQG
	 F2mGPXDsCaFaA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] mm/damon/tests/vaddr-kunit: don't use mas_lock for MM_MT_FLAGS-initialized maple tree
Date: Tue,  3 Sep 2024 17:45:34 -0700
Message-Id: <20240904004534.1189-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_three_regions_in_vmas() initializes a maple tree with
MM_MT_FLAGS.  The flags contains MT_FLAGS_LOCK_EXTERN, which means
mt_lock of the maple tree will not be used.  And therefore the maple
tree initialization code skips initialization of the mt_lock.  However,
__link_vmas(), which adds vmas for test to the maple tree, uses the
mt_lock.  In other words, the uninitialized spinlock is used.  The
problem becomes celar when spinlock debugging is turned on, since it
reports spinlock bad magic bug.  Fix the issue by not using the mt_lock
as promised.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/1453b2b2-6119-4082-ad9e-f3c5239bf87e@roeck-us.net
Fixes: d0cf3dd47f0d ("damon: convert __damon_va_three_regions to use the VMA iterator")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/vaddr-kunit.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 83626483f82b..c6c7e0e0ab07 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -17,23 +17,19 @@
 static int __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas,
 			ssize_t nr_vmas)
 {
-	int i, ret = -ENOMEM;
+	int i;
 	MA_STATE(mas, mt, 0, 0);
 
 	if (!nr_vmas)
 		return 0;
 
-	mas_lock(&mas);
 	for (i = 0; i < nr_vmas; i++) {
 		mas_set_range(&mas, vmas[i].vm_start, vmas[i].vm_end - 1);
 		if (mas_store_gfp(&mas, &vmas[i], GFP_KERNEL))
-			goto failed;
+			return -ENOMEM;
 	}
 
-	ret = 0;
-failed:
-	mas_unlock(&mas);
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.39.2


