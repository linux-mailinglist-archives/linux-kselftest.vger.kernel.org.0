Return-Path: <linux-kselftest+bounces-44606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F31C28539
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 775A94ED28C
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159523074A1;
	Sat,  1 Nov 2025 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBKwpse/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC481306B1A;
	Sat,  1 Nov 2025 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021243; cv=none; b=FDOXsr58CzrNzBmgBuqvBFB/zl6VMNA30/DWYnsZ8IG3VGC5L5aOO1A7osLpYmhRFuH9Du8pSsFNnHkCbJJ86iVEhe6mgbZmbjQveOq/sju25RyYChF2hQhSg2WyYsnDaFQ66qTxf2kmkY/dmtKwTD6i9UNACyUJz0KIMIZX9wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021243; c=relaxed/simple;
	bh=YKKetXWckUNAeNivss353X8s+7x7z2c2pZKrb6m5Vqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDGanlAre56GzLFzq8URz3w61DbZroDIsgdxjBzi2uC29ijjNSC27wdJVI4ibteRv/pplPu3w+shxBhOwKpr/xGbyz/zB86JMoZxBBCe/ozVHEfiII7shm05VAXR48qwTOk6kBDSEqtbpTmXUyQ8MhtbXcOS24MvoVb8p9VfH1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBKwpse/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED08C116D0;
	Sat,  1 Nov 2025 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021242;
	bh=YKKetXWckUNAeNivss353X8s+7x7z2c2pZKrb6m5Vqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBKwpse/W69Y85fbiyxFTe0Yhn0KF55DLJUWj7U/1BQmCjOjs9/sk7MwkKx2qt5yP
	 20MSUTKtBNCNfZ+lOjrSwRis54URs5b/7mg+Kfw/rH2hL826ghikSzuGKIirCe+yUp
	 5+rnCF4THr0Xs0PD50d5TjYTJOlFqPoAkE6A4VEvydg8RtPh+3iIdfpkhfn17Zc5I/
	 W8DJnV3+sPWBnDxWk59G2mnuEWQCVFbXX/OgS/4mf2k6xoWM0lsFwIjJaQxcxIx7oe
	 em/lD1X9cfs54/iwlOuEo+LAbbcR0j7L/VS1b51U2kaDhOYzX1zWkaJSkcuyXzUEjf
	 UGN5MC4ojfWgA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 7 . x" <stable@vger.kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 20/22] mm/damon/tests/sysfs-kunit: handle alloc failures on damon_sysfs_test_add_targets()
Date: Sat,  1 Nov 2025 11:20:14 -0700
Message-ID: <20251101182021.74868-21-sj@kernel.org>
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

damon_sysfs_test_add_targets() is assuming all dynamic memory allocation
in it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Fixes: b8ee5575f763 ("mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()")
Cc: <stable@vger.kernel.org> # 6.7.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/sysfs-kunit.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/damon/tests/sysfs-kunit.h b/mm/damon/tests/sysfs-kunit.h
index 7b5c7b307da9..ce7218469f20 100644
--- a/mm/damon/tests/sysfs-kunit.h
+++ b/mm/damon/tests/sysfs-kunit.h
@@ -45,16 +45,41 @@ static void damon_sysfs_test_add_targets(struct kunit *test)
 	struct damon_ctx *ctx;
 
 	sysfs_targets = damon_sysfs_targets_alloc();
+	if (!sysfs_targets)
+		kunit_skip(test, "sysfs_targets alloc fail");
 	sysfs_targets->nr = 1;
 	sysfs_targets->targets_arr = kmalloc_array(1,
 			sizeof(*sysfs_targets->targets_arr), GFP_KERNEL);
+	if (!sysfs_targets->targets_arr) {
+		kfree(sysfs_targets);
+		kunit_skip(test, "targets_arr alloc fail");
+	}
 
 	sysfs_target = damon_sysfs_target_alloc();
+	if (!sysfs_target) {
+		kfree(sysfs_targets->targets_arr);
+		kfree(sysfs_targets);
+		kunit_skip(test, "sysfs_target alloc fail");
+	}
 	sysfs_target->pid = __damon_sysfs_test_get_any_pid(12, 100);
 	sysfs_target->regions = damon_sysfs_regions_alloc();
+	if (!sysfs_target->regions) {
+		kfree(sysfs_targets->targets_arr);
+		kfree(sysfs_targets);
+		kfree(sysfs_target);
+		kunit_skip(test, "sysfs_regions alloc fail");
+	}
+
 	sysfs_targets->targets_arr[0] = sysfs_target;
 
 	ctx = damon_new_ctx();
+	if (!ctx) {
+		kfree(sysfs_targets->targets_arr);
+		kfree(sysfs_targets);
+		kfree(sysfs_target);
+		kfree(sysfs_target->regions);
+		kunit_skip(test, "ctx alloc fail");
+	}
 
 	damon_sysfs_add_targets(ctx, sysfs_targets);
 	KUNIT_EXPECT_EQ(test, 1u, nr_damon_targets(ctx));
-- 
2.47.3

