Return-Path: <linux-kselftest+bounces-16358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C780395FF8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 05:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060D81C2207A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 03:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D6142AB5;
	Tue, 27 Aug 2024 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN3BAgGR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0163A27E;
	Tue, 27 Aug 2024 03:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727828; cv=none; b=hfmhQM0vcAKddt1pqU0ekrr8A9wo8L60xPmD6eaPBR8429fXvCtF6whvUwJeDO3t22moV9vih0AZQvrhBeKpV7xOfU73TApjGv3KgxB83D+ruLm3H0eyi+yU3e4T+lGPcRGfJez89AnUziYqIA9tBnMl593C1nN8HMCMW+NHnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727828; c=relaxed/simple;
	bh=UIcEtsuF2oQygozWT/Xm716/UFpvZjJFMlGL0LY1swc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aA0azyFWE4phxBZc+lx0BzcdhTb9ZsGRR89ogveo6rbpk92TvgN26b/oJGwqffLTgKo9boyjW35Z45v1SP3IHqDqpsiNSlkwpWpQCLy71V6LdAf0+shlgrtHBA+n9H1Im6+FesGFn4Mm+DHzo+x/Md/AptjGMmZdrW8SAte1WCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN3BAgGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F6EC8B7BC;
	Tue, 27 Aug 2024 03:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724727828;
	bh=UIcEtsuF2oQygozWT/Xm716/UFpvZjJFMlGL0LY1swc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vN3BAgGR8uk5yCGefcqXr81gTPvEJR9+4CckN/1Z8Dp3mqKnHTsX+gXGeU+15of7x
	 uVcEBYRigBYq0V2jRjyeXnYCQQdaVPNK7fASrI6H1Pzm2RAKD/hHDyVINmSGDLUoih
	 WdNhBwHHF/Qkm2YtWPriYj17Wx2uxnwBy0YTbSI2kPpQCUhdTcwfeVfLxSZeP81ACZ
	 W0wCD9/2S19ssGlhvehiXjNtT4nSE3HDm2REQZUoIBDttpxkv4f3gybyIXACLXucl+
	 kZXH1ki6pbeCeRA5TCSn7YgZQHHeNUQDRjhGuZX1mAHYic9iM2pVsf0DOKi38sbt+d
	 yfdb4Yftbbstw==
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
Subject: [PATCH 4/9] mm/damon/core-test: test only vaddr case on ops registration test
Date: Mon, 26 Aug 2024 20:03:31 -0700
Message-Id: <20240827030336.7930-5-sj@kernel.org>
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

DAMON ops registration kunit test tests both vaddr and paddr use cases
in parts of the whole test cases.  Basically testing only one ops use
case is enough.  Do the test with only vaddr use case.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 0cee634f3544..ef36d586d6ee 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -246,16 +246,12 @@ static void damon_test_split_regions_of(struct kunit *test)
 static void damon_test_ops_registration(struct kunit *test)
 {
 	struct damon_ctx *c = damon_new_ctx();
-	struct damon_operations ops, bak;
+	struct damon_operations ops = {.id = DAMON_OPS_VADDR}, bak;
 
-	/* DAMON_OPS_{V,P}ADDR are registered on subsys_initcall */
+	/* DAMON_OPS_VADDR is registered on subsys_initcall */
 	KUNIT_EXPECT_EQ(test, damon_select_ops(c, DAMON_OPS_VADDR), 0);
-	KUNIT_EXPECT_EQ(test, damon_select_ops(c, DAMON_OPS_PADDR), 0);
 
 	/* Double-registration is prohibited */
-	ops.id = DAMON_OPS_VADDR;
-	KUNIT_EXPECT_EQ(test, damon_register_ops(&ops), -EINVAL);
-	ops.id = DAMON_OPS_PADDR;
 	KUNIT_EXPECT_EQ(test, damon_register_ops(&ops), -EINVAL);
 
 	/* Unknown ops id cannot be registered */
-- 
2.39.2


