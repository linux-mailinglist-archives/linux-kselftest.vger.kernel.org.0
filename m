Return-Path: <linux-kselftest+bounces-43841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC1FBFED69
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964831891436
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358F9239E9A;
	Thu, 23 Oct 2025 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9w7oAey"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075E423814D;
	Thu, 23 Oct 2025 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182746; cv=none; b=smhd4lFtZZKSyaLOxGQlRZHJji4LBBlEdwx1m/xU5PaqtUn0/vHE2gFZHAkx8TIK7XS96brEBkwkyTSmKK5BABNLnBXBEMf093CyZ/2gWHDJgNYQDtFHT9Uvc1NIsphNEkMbnSmRJBVWKCX0RwpWCd/bZJXl0zB8RsgaTjjH0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182746; c=relaxed/simple;
	bh=/16NLG9ELNo7TPBr96lQkGZnNgiuxdJz+m68NvFaNcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajmKoT01pxWyXh7bPFgWRnU0neILexO+XUZ66vsDWr/hoTy8CycVTEW9riD5K8ouRrUgZbj+SPq9EgmPWOyXBkjAPJbrsju8hAPhfEJ+0zHHgcgzkSA6grL1gAVXdPJKA5XBWltIi4OQ1GH5OxOSU8vwPN+GheBPcwbPvrTckl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9w7oAey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC3FC19423;
	Thu, 23 Oct 2025 01:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761182745;
	bh=/16NLG9ELNo7TPBr96lQkGZnNgiuxdJz+m68NvFaNcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T9w7oAeykIWaG2b8dcXHBbWDStlzXq/7msaN2BG0ZoTNk7bKVgmTlNnXZQ90CV8k8
	 7+GsyqdsSIllGEvFwu70cYKwoYfNHtLJR/qy9lgrU14MfprVr+3k2c2f+eJwdRKIIR
	 gHKpkNAISrjsytHVyrHbpxKZc6vA8NpNYhEKHjQzkGTUINgV4oqjiukQxz40jlh71s
	 Lc0Fvw3UOoKn+IOT2GNcApT86fGUo9yw50N1NRsrG5YBVpbAvP0ZaKAAcW9s1XHrhy
	 f8r8gElXIgE4GaDALfZ+5CvIn7vZZ7tM9RwwbLmeKdJ/CulqW5I4eMcd0bU0DRzZns
	 j/TZzqWjTXPwA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 8/9] sysfs.py: extend assert_ctx_committed() for monitoring targets
Date: Wed, 22 Oct 2025 18:25:32 -0700
Message-ID: <20251023012535.69625-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023012535.69625-1-sj@kernel.org>
References: <20251023012535.69625-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

assert_ctx_committed() is not asserting monitoring targets commitment,
since all existing callers of the function assume no target changes.
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

