Return-Path: <linux-kselftest+bounces-45428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C960C53905
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 18:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C6AB547434
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 15:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD54345CC5;
	Wed, 12 Nov 2025 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPituJcF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63C3345CBE;
	Wed, 12 Nov 2025 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962163; cv=none; b=Lb13TI4IxOw5aiAsrd0fZsfJK460jzD6VqxmoQ1mmkwZVUI41t8CQJ9+Wc8NiAJGbfNOypVFGlQ8wygykySkgFrdQ87wz+F7NXH/OijTLu9V9nJJL5J8U+dtJN9mFynXUwO84PMHxAT4TV4yvkku1fsEL6EAYyj0GC5aSbkUF9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962163; c=relaxed/simple;
	bh=ipqbHpurnSVvOIPX2qXsTqde4IbogP7c/9c05Brr93w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfhjIIO1BRj6L3m6y1lj6RYxauUTwYezrxVT9/e03M4nEN/BpU1mLBk04Ak+15aKHR9g0GBUDkyRKe4hFOq0Exsm+wo9AdybxhvgqL9Bah5JO4mWl1GkNKRV004sNJT0n5Qh1t9jYhN65cK7S5aDvKnts4vSaEh4Kh0pcghE8N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPituJcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7079AC4CEF5;
	Wed, 12 Nov 2025 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762962163;
	bh=ipqbHpurnSVvOIPX2qXsTqde4IbogP7c/9c05Brr93w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KPituJcFNSjD5P+6aPcagVN3PDZTIuLo6Chdee4DGXczD42xk/RYHpsFtOpSMPV2w
	 igC1fhqrXpXvYjeAZ5uX6tawwU1Vpm82tNw4zXOBvLP2r+j/kgv6VWOMuBZ37HH3j6
	 +HHSzHW56t9Af4AeL/NraNZ0QcK2yjWO6ORCouO+o8mlaW6wGjKnR2LEVF4E9Z/DK1
	 fv1fk43sm+4Fr6bzIw0/eWUO3rLsKpB7m+awnK52NgUfEoN1HmY3d+uYx6ndW57SlW
	 c/bHxyfZRAQvrKG5+Ya/V3B4kfOmCZ1jwG30ay6XjiegnhPYtlPmA8KbhaFKOm8xpv
	 eqEYcsuEhq7wQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 7/9] selftests/damon/sysfs.py: merge DAMON status dumping into commitment assertion
Date: Wed, 12 Nov 2025 07:41:10 -0800
Message-ID: <20251112154114.66053-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112154114.66053-1-sj@kernel.org>
References: <20251112154114.66053-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For each test case, sysfs.py makes changes to DAMON, dumps DAMON
internal status and asserts the expectation is met.  The dumping part
should be the same for all cases, so it is duplicated for each test
case.  Which means it is easy to make mistakes.  Actually a few of those
duplicates are not turning DAMON off in case of the dumping failure.  It
makes following selftests that need to turn DAMON on fails with -EBUSY.
Merge the status dumping into commitment assertion with proper dumping
failure handling, to deduplicate and avoid the unnecessary following
tests failures.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 43 ++++++++------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index b4c5ef5c4d69..9cca71eb0325 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -185,7 +185,15 @@ def assert_ctx_committed(ctx, dump):
     assert_monitoring_targets_committed(ctx.targets, dump['adaptive_targets'])
     assert_schemes_committed(ctx.schemes, dump['schemes'])
 
-def assert_ctxs_committed(ctxs, dump):
+def assert_ctxs_committed(kdamonds):
+    status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+    if err is not None:
+        print(err)
+        kdamonds.stop()
+        exit(1)
+
+    ctxs = kdamonds.kdamonds[0].contexts
+    dump = status['contexts']
     assert_true(len(ctxs) == len(dump), 'ctxs length', dump)
     for idx, ctx in enumerate(ctxs):
         assert_ctx_committed(ctx, dump[idx])
@@ -202,13 +210,7 @@ def main():
         print('kdamond start failed: %s' % err)
         exit(1)
 
-    status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
-    if err is not None:
-        print(err)
-        kdamonds.stop()
-        exit(1)
-
-    assert_ctxs_committed(kdamonds.kdamonds[0].contexts, status['contexts'])
+    assert_ctxs_committed(kdamonds)
 
     context = _damon_sysfs.DamonCtx(
             monitoring_attrs=_damon_sysfs.DamonAttrs(
@@ -256,12 +258,7 @@ def main():
     kdamonds.kdamonds[0].contexts = [context]
     kdamonds.kdamonds[0].commit()
 
-    status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
-    if err is not None:
-        print(err)
-        exit(1)
-
-    assert_ctxs_committed(kdamonds.kdamonds[0].contexts, status['contexts'])
+    assert_ctxs_committed(kdamonds)
 
     # test online commitment of minimum context.
     context = _damon_sysfs.DamonCtx()
@@ -270,12 +267,7 @@ def main():
     kdamonds.kdamonds[0].contexts = [context]
     kdamonds.kdamonds[0].commit()
 
-    status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
-    if err is not None:
-        print(err)
-        exit(1)
-
-    assert_ctxs_committed(kdamonds.kdamonds[0].contexts, status['contexts'])
+    assert_ctxs_committed(kdamonds)
 
     kdamonds.stop()
 
@@ -303,17 +295,8 @@ def main():
         exit(1)
     kdamonds.kdamonds[0].contexts[0].targets[1].obsolete = True
     kdamonds.kdamonds[0].commit()
-
-    status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
-    if err is not None:
-        print(err)
-        kdamonds.stop()
-        exit(1)
-
     del kdamonds.kdamonds[0].contexts[0].targets[1]
-
-    assert_ctxs_committed(kdamonds.kdamonds[0].contexts, status['contexts'])
-
+    assert_ctxs_committed(kdamonds)
     kdamonds.stop()
 
 if __name__ == '__main__':
-- 
2.47.3

