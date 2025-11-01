Return-Path: <linux-kselftest+bounces-44604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08884C28521
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E3DA4EEFBB
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC1A30504D;
	Sat,  1 Nov 2025 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmC7pbG3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7230498D;
	Sat,  1 Nov 2025 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021242; cv=none; b=FynJomiYusUwV2f0JN5ZLT5LDauNEo2MHfUTxT8veunpOewNaPLLfioQxA0oiLzV876biq14gCYF3k8hUY5mbFtAaXbQabXtWCTfT1KnjDRZs4/W9wO/tIwXDvHEmtiURTHoR8uriGq2DNcBO2qf9E95PfybqObjixu2HAb8q6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021242; c=relaxed/simple;
	bh=4mW1l163HEBJlF7jgeTLtvFXIHv4JgpHKouvNhyCopM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAnUv6iWgV0pTlgkGqUc7z+YxQMVqEQxWmw6tMkcg1DmMuK8uyEuagAxyFGBK2X6WaM0TmwwTonbTHukYMZEN5pcjQ5bxgRqc5ZVaoXQSOwIRxR4rVbe8fwt3Ed4TPR3Ht8GvwaEvyRC37fzZDn2TB6mb1aPEKFV+L0WIUcVd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmC7pbG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D57C116C6;
	Sat,  1 Nov 2025 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021241;
	bh=4mW1l163HEBJlF7jgeTLtvFXIHv4JgpHKouvNhyCopM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KmC7pbG3YkOMd+7g918cdD2BpOI7oFdF9qnxui4hsUok0+bmX4TQNx2xAn5m2S4Nn
	 yB+XGNZpcNY3qD/0jz8c1PuFnU1/LBikJ8pBFdOAsdxM3Vlds9dLZ86Sh+2sCK3KpS
	 6GWOO1GI2JW805fbb2WbpIewsPcpabhvN7rmD/4zDwKqkZbS8odntB1+IotOKxj30Q
	 Z8l9oPUDZsHJaceCN/AFGIIF6RmQdtMgTpoPMbmU/p7PmTqJPmKjw84h6oa7allm8c
	 arhvyipfJC7GaPUhWm5o3sQuBb+GgrKujoaYcenSKnLoKv4Rab50MYJhdQy6k968TM
	 ND6VLOxB6s1Ag==
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
Subject: [PATCH 18/22] mm/damon/tests/vaddr-kunit: handle alloc failures in damon_test_split_evenly_fail()
Date: Sat,  1 Nov 2025 11:20:12 -0700
Message-ID: <20251101182021.74868-19-sj@kernel.org>
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

damon_test_split_evenly_fail() is assuming all dynamic memory allocation
in it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/vaddr-kunit.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 484223f19545..1b0f21c2e376 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -256,7 +256,16 @@ static void damon_test_split_evenly_fail(struct kunit *test,
 		unsigned long start, unsigned long end, unsigned int nr_pieces)
 {
 	struct damon_target *t = damon_new_target();
-	struct damon_region *r = damon_new_region(start, end);
+	struct damon_region *r;
+
+	if (!t)
+		kunit_skip(test, "target alloc fail");
+
+	r = damon_new_region(start, end);
+	if (!r) {
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 
 	damon_add_region(r, t);
 	KUNIT_EXPECT_EQ(test,
-- 
2.47.3

