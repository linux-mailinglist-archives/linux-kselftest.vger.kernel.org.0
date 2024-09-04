Return-Path: <linux-kselftest+bounces-17158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEE296C573
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 19:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2877286670
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 17:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8B01D0169;
	Wed,  4 Sep 2024 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zf8qnOV4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FD10A12;
	Wed,  4 Sep 2024 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470982; cv=none; b=o52p+/q5RoFk5z7yRk1yqc53ySnXH3Myw7bKj1B2jEysDGp8ZXANFf7QDznLg/rbbz2P0xLRlf/YWJu6EMSEnWaqK9vvCPj7rPuohIaex+WFw8VjqTG86SJLufndXyfsOEVWaeXnxr8f4yWbOzAWTTgUYCwxn4TXztGX4WvVqd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470982; c=relaxed/simple;
	bh=g2SvYEsNRUISamOgyu6CD7Iy+rnUtlzFhcKFNMBbW+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W3cJ48+6RCXwMjy2WB/XstyM6VMELpXV/kkh1uV97sFtbv9GkwWQvVAcZr9vgOwFEK1Fu1KJag/CvXi26R19F/PGjac7Ts7PEJe2WiEmJ2m3XbLGY7QIL/2Eecr+Eq6JRuuhTjIWRskgDfqfsG7G+4nCV6IiCPNDnnWyyYn13S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zf8qnOV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D39C4CEC2;
	Wed,  4 Sep 2024 17:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725470981;
	bh=g2SvYEsNRUISamOgyu6CD7Iy+rnUtlzFhcKFNMBbW+o=;
	h=From:To:Cc:Subject:Date:From;
	b=Zf8qnOV4xVEXtXImMjjoQ/DlyyKTurmsFg3Sn05aCnHyFRrQOWLthCj5ZcGmKdLAh
	 wFcoCGDddKU40xe0pqdzgyVXOCwQMKv1DQuHhVi2mi406cM53G8vic1HXtCqKnm+Hs
	 gYcCqMhy+hvi+i0op9ujV83L+n+JktjTMubSLiezAKKoN0BxaN+KbkIJG/4Yn2uPc5
	 DBVVAwKKkqI0ZrVLN1T/v5xdQ5UtfELgG5BOkjkkUz+/zB7n4ECdc2I1LReLUcfi2r
	 4U1/sG3ax9xfvJZwYS9Kl4/0e8Y7fLJdkOa+LiGM1kBjwYm9XsDLlba4exX9XFuJ4e
	 usaZEqvlOLUpw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2] mm/damon/tests/vaddr-kunit: init maple tree without MT_FLAGS_LOCK_EXTERN
Date: Wed,  4 Sep 2024 10:29:31 -0700
Message-Id: <20240904172931.1284-1-sj@kernel.org>
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
problem becomes clear when spinlock debugging is turned on, since it
reports spinlock bad magic bug.

Fix the issue by excluding MT_FLAGS_LOCK_EXTERN from the maple tree
initialization flags.  Note that we don't use empty flags to make it
further similar to the usage of mm maple tree, and to be prepared for
possible future changes, as suggested by Liam.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/1453b2b2-6119-4082-ad9e-f3c5239bf87e@roeck-us.net
Fixes: d0cf3dd47f0d ("damon: convert __damon_va_three_regions to use the VMA iterator")
Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
(https://lore.kernel.org/20240904004534.1189-1-sj@kernel.org)
- Keep lock usage and update the initialization flags (Liam)
- Fix a typo: s/celar/clear/ (Guenter)

 mm/damon/tests/vaddr-kunit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 83626483f82b..a339d117150f 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -77,7 +77,7 @@ static void damon_test_three_regions_in_vmas(struct kunit *test)
 		(struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
 	};
 
-	mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
+	mt_init_flags(&mm.mm_mt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU);
 	if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
 		kunit_skip(test, "Failed to create VMA tree");
 
-- 
2.39.2


