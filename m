Return-Path: <linux-kselftest+bounces-43505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B09CBEDBAE
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 22:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF05519C19BA
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 20:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EBB2DA758;
	Sat, 18 Oct 2025 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDYx4y6w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692322D94A4;
	Sat, 18 Oct 2025 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760820293; cv=none; b=o6mqlpx8CyoTaKA86R/7Pxn5UAQiKAaXg4+dV4WpzMOMuVJ/fkK/MJ8reCGlBqzFv70//hWDx9j39wdaUr9csBju7opsGi3dfyc2J0Ox2A7u0vfdKKcNSjmE2nBFnFAxouz+Ph4akdjePRR8X46P1UPBvJFc6q2sZEL55nP+uos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760820293; c=relaxed/simple;
	bh=JDAR5vBDfrQKj9l07eWZCbXqGebT8PFUKr3f9iHJS+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6Z7OYbbhp1EOJd29luNKmbvyXJQhGo6hwkT8fOOlWsECH2J/CWbZcp7E1lzGTTJgKl8nY3ZwvGYbRW692PxBsq1IvP/nOtsZ5wDjncfVpsj+1UpyqkwM8a+SyxfqNDoSNREkiR1a1F4uxUfnN23+SxLb/OdcpgrcHHMlzt282Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDYx4y6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBCFC116B1;
	Sat, 18 Oct 2025 20:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760820293;
	bh=JDAR5vBDfrQKj9l07eWZCbXqGebT8PFUKr3f9iHJS+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FDYx4y6wSdB04oRFCmuLkrqCOm3Fdh8tM9f3mb5PxueJPZaw3cNorfkUUjXq3urLg
	 rDb2Tc+3mneR9llm1GcWC8cykf95pS34V1lznO4Fg0mY+vwnvWE75g7wNVHTPFTYvY
	 OBpUeWqpKSiInr6pk+r6ZIRj6JV8O2DL2wiMr312gb9eYm5KC8b3Wr+HC9tlJCpfNk
	 qmtwKre01Sj23dLd0x7T3Q5mgi8UkQT4IUd77sqYhuXR+7n5WMkY+7LQbqA77Q3jZY
	 ZXCR7lZgxHbg/WIEVZCGMM7VnS9CwlHAlTLDrf3NC6paaJ42GTHSvt9WdHtGVHFslT
	 rqedKtWmBI8NQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/4] sysfs.py: extend assert_ctx_committed() for monitoring targets
Date: Sat, 18 Oct 2025 13:44:44 -0700
Message-ID: <20251018204448.8906-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251018204448.8906-1-sj@kernel.org>
References: <20251018204448.8906-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

assert_ctx_committed() is not asserting monitoring targets commitment,
since all existing callers of the function assumes no target changes.
Extend it for future usage.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 2666c6f0f1a5..fd8d3698326e 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -164,6 +164,16 @@ def assert_monitoring_attrs_committed(attrs, dump):
     assert_true(dump['max_nr_regions'] == attrs.max_nr_regions,
                 'max_nr_regions', dump)
 
+def assert_monitoring_target_committed(target, dump):
+    # target.pid is the pid "number", while dump['pid'] is 'struct pid'
+    # pointer, and hence cannot be compared.
+    assert_true(dump['obsolete'] == target.obsolete, 'target obsolete', dump)
+
+def assert_monitoring_targets_committed(targets, dump):
+    assert_true(len(targets) == len(dump), 'len_targets', dump)
+    for idx, target in enumerate(targets):
+        assert_monitoring_target_committed(target, dump[idx])
+
 def assert_ctx_committed(ctx, dump):
     ops_val = {
             'vaddr': 0,
@@ -172,6 +182,7 @@ def assert_ctx_committed(ctx, dump):
             }
     assert_true(dump['ops']['id'] == ops_val[ctx.ops], 'ops_id', dump)
     assert_monitoring_attrs_committed(ctx.monitoring_attrs, dump['attrs'])
+    assert_monitoring_targets_committed(ctx.targets, dump['adaptive_targets'])
     assert_schemes_committed(ctx.schemes, dump['schemes'])
 
 def assert_ctxs_committed(ctxs, dump):
-- 
2.47.3

