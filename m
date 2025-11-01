Return-Path: <linux-kselftest+bounces-44599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3876BC2850C
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9053BCD2D
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A7E2FC034;
	Sat,  1 Nov 2025 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p55R7JFT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B629E30148B;
	Sat,  1 Nov 2025 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021240; cv=none; b=W9PAM7tTJw7MHQkvyLwm4PGBrsaNzbA2PqNv/ydG+UZ+acq9DvwVPaPC1bTSSG+gX7/gYFgiin/SYTGamPAueZUN4PoTmplONNj9NCQzm/eJ4OaehsgaXWBbBn6u5mjdy0fELzk1xZrfFYUhHCQ/JEkaRrSKO15kzg1XDS+WLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021240; c=relaxed/simple;
	bh=aL/KESmFEPfvW+PugHkjq38nxTmwTmF3JMfeWbPs6P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jF42e4AqpqyQO/aO7f0OP3v1ulN7YtYNLtPz7cK6999TWJFU1CPzdIrfGWklVFGN67zkdvU7EwiwMk5JRR07cQUUjCmvdNOFGC9BRZhUiWhUQ9YYN+chyE+e8X3nfVxlt1oZdVLMq2Es1DS4PEzR9ITSsJZCHk1sbcPQHSqyb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p55R7JFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109F6C113D0;
	Sat,  1 Nov 2025 18:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021240;
	bh=aL/KESmFEPfvW+PugHkjq38nxTmwTmF3JMfeWbPs6P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p55R7JFTxkg/I9BBaVkwXTv2pes8Vjux58YMHOKp3lMhyu7/gdCsDsR1qfujtGGO/
	 463oNbe4vlLVpBLDse+CTlABK1OKgjJQH4w0hpj5rts961V61Ed3u/JSleneL/UmwB
	 7d0FO0j67wS83+q/hyeveCIZ7nfdWVRBCV5OLnPG5kC86fx+tv46AG97vK1o3yfBeV
	 RYfNa7CpCyVo+jp0fPhzUYx/OYWh4+OmC83YU6M1tr76KithJk1Gf306JjqCbOwh0/
	 T8RzYxGEtD2y7JfX1UQQB29Ey3EOSdntbcZ7k2FBeXs2tU8K2OeqPYhufJGUcCjBWw
	 iNk+Yq9qZbQ2A==
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
Subject: [PATCH 13/22] mm/damon/tests/core-kunit: handle alloc failres in damon_test_new_filter()
Date: Sat,  1 Nov 2025 11:20:07 -0700
Message-ID: <20251101182021.74868-14-sj@kernel.org>
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

damon_test_new_filter() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.
In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Fixes: 2a158e956b98 ("mm/damon/core-test: add a test for damos_new_filter()")
Cc: <stable@vger.kernel.org> # 6.6.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index b9bd69a57e62..03c7ac31db5c 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -505,6 +505,8 @@ static void damos_test_new_filter(struct kunit *test)
 	struct damos_filter *filter;
 
 	filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true, false);
+	if (!filter)
+		kunit_skip(test, "filter alloc fail");
 	KUNIT_EXPECT_EQ(test, filter->type, DAMOS_FILTER_TYPE_ANON);
 	KUNIT_EXPECT_EQ(test, filter->matching, true);
 	KUNIT_EXPECT_PTR_EQ(test, filter->list.prev, &filter->list);
-- 
2.47.3

