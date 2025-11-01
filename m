Return-Path: <linux-kselftest+bounces-44589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9465EC284AC
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB81189CEED
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11502FC014;
	Sat,  1 Nov 2025 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjfWg275"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CC62FBE0F;
	Sat,  1 Nov 2025 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021237; cv=none; b=afV/V5NYEaO+KRTbQBHBBqEt+VYCLA9MVamfH5TreiwBLaqXcZRaJ8Ue9owC0LHWSSoCSzxgZHWBRrhSUn206kRrt9r0tks7PYL0N4arHJsLPkHqa2MKNDWDq5flIlGY3YEj3xN1cPpgmZ8AzoD8/gkHXcA0Jv40W3JWo821IFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021237; c=relaxed/simple;
	bh=pDU2J5kjF0mDExz6cAUb5XwN43HUszp8OiQLnrE7vDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyZNTTkdBtgrX+07OIaiLnvY4+aGBdIa9EPsKC17/tvkLtOQe78yMVPpCBl2Dl+gAuQGvdWtrgx7thjafO7KPX/YJSGqVDCzGSv798KdDup0IbV8kE+BdjYPqvBv0PyPrzTfMHb8SeUcOTtTr2pR4o0FnFhS4tua7uZvSMXvkRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjfWg275; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC60C116B1;
	Sat,  1 Nov 2025 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021237;
	bh=pDU2J5kjF0mDExz6cAUb5XwN43HUszp8OiQLnrE7vDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjfWg275qIcqCglMB1pNp6XR9Vg/I76R2wghTcpkgMjU+pMcG/oAyVN63rubsrOU4
	 66VxNV9bKKV6mHnxcLtqcLvMup9T8H8dBiYozR/dFWadBrMheQ3PgYeKZnFWWWlsMj
	 YuwKb1XkEnqeir/aZOlPZx5tzin/yqHbgWNfYvN4SmccwSkJ2tUu0i5Z5dw5PSac5o
	 XuSWP3jy54dQRj+vUcX7F/KL+0LgDoXvC8AAZsGrh9eB05XnpYevil+X/bXiw96yoK
	 /siThDcrZxIidLTTVVuBC6F1N2MYjM4IyiOXvhSaXO8guTBxf9w2F/hC6qkKrmW31r
	 OBUbclFw8Ehcg==
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
Subject: [PATCH 03/22] mm/damon/tests/core-kunit: handle memory failure from damon_test_target()
Date: Sat,  1 Nov 2025 11:19:57 -0700
Message-ID: <20251101182021.74868-4-sj@kernel.org>
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

damon_test_target() is assuming all dynamic memory allocation in it will
succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.
In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index a2c9ee7a5de1..6e8a605277a3 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -58,7 +58,14 @@ static void damon_test_target(struct kunit *test)
 	struct damon_ctx *c = damon_new_ctx();
 	struct damon_target *t;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
 	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
 	KUNIT_EXPECT_EQ(test, 0u, nr_damon_targets(c));
 
 	damon_add_target(c, t);
-- 
2.47.3

