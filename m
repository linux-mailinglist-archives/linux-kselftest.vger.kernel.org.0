Return-Path: <linux-kselftest+bounces-44591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14722C284B8
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2853BA737
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27302FC896;
	Sat,  1 Nov 2025 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSxZleUw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C142FC00D;
	Sat,  1 Nov 2025 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021237; cv=none; b=tJLbeIWxKntbPNGstCngdcTJ+zizs6I2dWjPUicS4ycSYkighlr04LRRsG9esGf9A1URyihF/i7bpv2VwJTBINXop3GrbwAr9YNHal4BEEYsu7qxDCQDwje5IrnGnotXWGKoJ+kVQD/s9YMj5qAX7E1HW7I2k+NM1sSnt+iGOXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021237; c=relaxed/simple;
	bh=PgfRRLXORijPzf0z5HMHsfa0ZrC+1SalbiD9xfUzyPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QquVz9NslNSZy9aXYXhqM7Uxy5OzUPuY79qWajjtzHaAAvgQIDscRRC6BvMso70hkrCBYwyw86VHq6CdVZ2iQIiq/Q6ZDhPB0RFjGjGbylvNoHfS/uotCsKOrS4AFhODcuuh6SepRmR+3MxfsMZM7U31vi9yGXQbKcPbzlfLh4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSxZleUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FF5C116C6;
	Sat,  1 Nov 2025 18:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021237;
	bh=PgfRRLXORijPzf0z5HMHsfa0ZrC+1SalbiD9xfUzyPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KSxZleUwuqRprD4u24yaPwktHSggSvqqzUDoN8rJzDncwxTjEUJJuHvfliQ0s5DUn
	 wBL2ZsLPWwes1sdWPSULDRT5AydRjEX3Ra23Ba2PpfmDFCVpMsDumVlLUdwKbErfTd
	 lOLmWlM8/r9G36rhQeZqVp/wxkidFOr1LwTGxpkva3din3cYQCdbLuzNk33xsSns0l
	 eEtpBxagoyNL8HrkMF/qEW4nq6IAOQN2NUWNG+FeFU1vmq7m/Aya1yYhOfzAgshoIQ
	 xS0Ti5eDXbNn4h3MNHH37FtGXMUe16EH/wrUikcDqLQMSWGZiX7s/Ei1ES2zAKvNB1
	 jqveyzZCTd1gg==
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
Subject: [PATCH 05/22] mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_at()
Date: Sat,  1 Nov 2025 11:19:59 -0700
Message-ID: <20251101182021.74868-6-sj@kernel.org>
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

damon_test_split_at() is assuming all dynamic memory allocation in it
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
index fd1e1ecaa2c9..f5f3152cb8df 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -148,8 +148,19 @@ static void damon_test_split_at(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r, *r_new;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
 	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
 	r = damon_new_region(0, 100);
+	if (!r) {
+		damon_destroy_ctx(c);
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	r->nr_accesses_bp = 420000;
 	r->nr_accesses = 42;
 	r->last_nr_accesses = 15;
-- 
2.47.3

