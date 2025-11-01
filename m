Return-Path: <linux-kselftest+bounces-44603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D93DC2853C
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B493A8344
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64A03043C8;
	Sat,  1 Nov 2025 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWBnC0IS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71C1303A34;
	Sat,  1 Nov 2025 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021241; cv=none; b=Ro2eSEYxleyeFVFB5kDIQH7BsAmlYd/RYlZc2VRZ+pGhwpffhlpmayjq7lKKChhrWmiqbWyT3c4WXLwGCM6qsqpjPh/sakQa0PvW3SdNT/PytPdbBix5nCytLrDvtkOHwNiHzGNnPfqwu66CGe58cI4kzkkF7j3+IyOwp7pBCl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021241; c=relaxed/simple;
	bh=rTI/a9CS5rBMyRZ+VKSmerz3wZX4dc/X6jh4k0lkn/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESVBHKtoL0+/vpUJdow58Sh5xhSYmYIFB9jxcckl+9UgQxwxbq2YUhlAmUF4k59amtIy13SYjD1O5bMm9Gm1zIg4cih44d+hAIdJwgn6VpZWsZY2r1QLZjiQ8jJFaNO8oX9xolKRtBC3OFctkV7vTzzoSZ0CIBphNYQku/J1m1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWBnC0IS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A9CC19422;
	Sat,  1 Nov 2025 18:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021241;
	bh=rTI/a9CS5rBMyRZ+VKSmerz3wZX4dc/X6jh4k0lkn/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWBnC0ISE0B1RTenw+hmlIwbxoWWP1X0IWWsO8ttUS+7VTzsHuapAIIN103WKdPEd
	 v/qrdO11LEOa1TK55su6gBeYsPG9OtP+PcINpY8h7PT1YJ6uV/LSPvjMpyNB9ElR/o
	 bBTaRMOEf39uh6OR7qUy7csJcHryjca23v+pxfj2vbZ4bil7yvN2kPzGVCauAcEy5U
	 RbNdvzY10Nla27CkGcssDBB6shJtbHx4sszd1VTAE0bskQHWAORyYHKNGuUGKtgleB
	 bbsja4C5YAhRUXzrFLvrCcmXsBSkypaW0Ii407YasC8hA88pFsCbzYNv7vtyFu9WqQ
	 AKC2B35af2Gmw==
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
Subject: [PATCH 17/22] mm/damon/tests/vaddr-kunit: handle alloc failures on damon_do_test_apply_three_regions()
Date: Sat,  1 Nov 2025 11:20:11 -0700
Message-ID: <20251101182021.74868-18-sj@kernel.org>
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

damon_do_test_apply_three_regions() is assuming all dynamic memory
allocation in it will succeed.  Those are indeed likely in the real use
cases since those allocations are too small to fail, but theoretically
those could fail.  In the case, inappropriate memory access can happen.
Fix it by appropriately cleanup pre-allocated memory and skip the
execution of the remaining tests in the failure cases.

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/vaddr-kunit.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index fce38dd53cf8..484223f19545 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -136,8 +136,14 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 	int i;
 
 	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "target alloc fail");
 	for (i = 0; i < nr_regions / 2; i++) {
 		r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
+		if (!r) {
+			damon_destroy_target(t, NULL);
+			kunit_skip(test, "region alloc fail");
+		}
 		damon_add_region(r, t);
 	}
 
-- 
2.47.3

