Return-Path: <linux-kselftest+bounces-44596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC7C284E0
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 19:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0EC44EE38D
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A372E2FF161;
	Sat,  1 Nov 2025 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0pNGtMs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C312FE573;
	Sat,  1 Nov 2025 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762021239; cv=none; b=GYPiYSAsNEihR2snnLGuWF6Bn9MnNvheFKo4NJ39n5FqoaCs+wuIocZDZfe6Md+/p9p/ZMSqV18uDPE96ynvfAHNh/bLtj5QHlxXLm4ZOa/Ycc8OjDXRoHuYDvgkOHrhFKPN/L5QCQWLx5fW9yms/3Gzdefut+z7MRjfwlaZjFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762021239; c=relaxed/simple;
	bh=57kC+8zBcKudPnCnx3LGmauWpC85FOLpVi+rp5j0Qcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLioVINTm6EOawfybV3CJOA2qqIdTh+FPLBkFLZmelMa3uAwirmnAieJQjj4acF4WcCkQ53TD2NudFIzscE5B6eEmttptbGP2QR3Z60VvTsAHP+q284rLo0E98BBUzeLT8lI+qNXg769XGXta2bV5V5p116nZv8UmD+HTLuDhKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0pNGtMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C2AC116C6;
	Sat,  1 Nov 2025 18:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762021238;
	bh=57kC+8zBcKudPnCnx3LGmauWpC85FOLpVi+rp5j0Qcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q0pNGtMsrufRK+kEJFJrtki3V3cJOp38O3M0vlm+UIv8hX31367RJuWecM0108LCc
	 v7XKC9Q62+gQVFmuxewnLt87M1IhTLf1nPSXBs1V5/QGIvm4u04sgxjysm1aQc2noh
	 LWyVKFH+7KvlCR8eZUWDkUzAakj+7QxSDvz6KtNjG11xXaxD/PMCNqApWPFB2BBkwM
	 Ga7qs2fUk3Lnsx5Qx/Am3lZkB2WM3nesVH/yZNeDCZhmouO4a/JIpKdsLA3U1sFgyZ
	 8iWbxO588pd6OoDf+OwoZHuIq9iq5K65b2C5Fki6kavJ493+CEKGwLhkrHCndTlUHW
	 OOZUbfIik8afg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/22] mm/damon/tests/core-kunit: handle alloc failures in damon_test_ops_registration()
Date: Sat,  1 Nov 2025 11:20:03 -0700
Message-ID: <20251101182021.74868-10-sj@kernel.org>
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

damon_test_ops_registration() is assuming all dynamic memory allocation
in it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Fixes: 4f540f5ab4f2 ("mm/damon/core-test: add a kunit test case for ops registration")
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 10618cdd188e..96c8f1269f44 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -320,6 +320,9 @@ static void damon_test_ops_registration(struct kunit *test)
 	struct damon_operations ops = {.id = DAMON_OPS_VADDR}, bak;
 	bool need_cleanup = false;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
 	/* DAMON_OPS_VADDR is registered only if CONFIG_DAMON_VADDR is set */
 	if (!damon_is_registered_ops(DAMON_OPS_VADDR)) {
 		bak.id = DAMON_OPS_VADDR;
-- 
2.47.3

