Return-Path: <linux-kselftest+bounces-37706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4D7B0B73A
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F351766CD
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E4123D29B;
	Sun, 20 Jul 2025 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVTw87av"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676CE23D28D;
	Sun, 20 Jul 2025 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031838; cv=none; b=oJ9BtmL9J1S0e3xg9Lqn04ZR/b2zksnJ2WTxY4yWLe9MxtRqab4A3ex0w94ulVFKOUyLjHfPPf7JpfCC+hJDMKpmZHsdCZRnGXhDatr/5qdOItSzAoPX8au2ps+EPsKfTF8K+0i41IohYnMejcbmRMMlgWxdEO7IeavLE5hE40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031838; c=relaxed/simple;
	bh=tlyYCuebypsS1rYr+0TB9gAjyBmHC3iclhm4zOJtldg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QYwDSgulmkpLq2/K5NbWpu8QAb+X4eKQoRtj0fABBsT7NoG2b0kAd5V36EfGOtUvTNOVzoX5aLyQsQi0foW6YJq6A2ZSqeAtCZdg4gnYOvKwH6cOavzxkLs1AUjv3Cxo+eU77uBAHQI/aaOhKiZvhAu0iPAbhTJJP4YWv75QRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVTw87av; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DFCC4CEEB;
	Sun, 20 Jul 2025 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031838;
	bh=tlyYCuebypsS1rYr+0TB9gAjyBmHC3iclhm4zOJtldg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PVTw87avXtYA3rlMLOZL0pfGKrDZ+cdzVOb4lTjpiTIF84ms95iyxsh+rOfq7gags
	 LwDwKL84bi8mp+zA0YauWcVJpjJZNXOD1yTnsdWC+RMGpDL9AaObxqiox8VE0ANHZQ
	 XNVB7HkLj3rtOw26WEV5JrgiNZwzcpCvysg6S11oRMyWG3hof371doDi0mbiMXj8cI
	 404auVsTNIBKzvbjbu3n5OQ/N/VIliWnFwU3yG2EjKegKBGUpxowLabI+uPtYskZpu
	 3CAJ757G+dIrEoHTY8GInkFyqugT/gpiTOgyUMrUBRl9NZhtwbfJxbVYHnrBgvegCT
	 /rys963tR8GZw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 20/22] selftests/damon/sysfs.py: generalize DAMON context commit assertion
Date: Sun, 20 Jul 2025 10:16:50 -0700
Message-Id: <20250720171652.92309-21-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720171652.92309-1-sj@kernel.org>
References: <20250720171652.92309-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON context commitment assertion is hard-coded for a specific test
case.  Split it out into a general version that can be reused for
different test cases.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 28 +++++++++++++++-----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index ed4c3e9fc972..429865e5ac9c 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -160,6 +160,21 @@ def assert_monitoring_attrs_committed(attrs, dump):
     assert_true(dump['max_nr_regions'] == attrs.max_nr_regions,
                 'max_nr_regions', dump)
 
+def assert_ctx_committed(ctx, dump):
+    ops_val = {
+            'vaddr': 0,
+            'fvaddr': 1,
+            'paddr': 2,
+            }
+    assert_true(dump['ops']['id'] == ops_val[ctx.ops], 'ops_id', dump)
+    assert_monitoring_attrs_committed(ctx.monitoring_attrs, dump['attrs'])
+    assert_schemes_committed(ctx.schemes, dump['schemes'])
+
+def assert_ctxs_committed(ctxs, dump):
+    assert_true(len(ctxs) == len(dump), 'ctxs length', dump)
+    for idx, ctx in enumerate(ctxs):
+        assert_ctx_committed(ctx, dump[idx])
+
 def main():
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(
@@ -177,18 +192,7 @@ def main():
         print(err)
         exit(1)
 
-    if len(status['contexts']) != 1:
-        fail('number of contexts', status)
-
-    ctx = status['contexts'][0]
-
-    assert_monitoring_attrs_committed(_damon_sysfs.DamonAttrs(), ctx['attrs'])
-
-    if ctx['adaptive_targets'] != [
-            { 'pid': 0, 'nr_regions': 0, 'regions_list': []}]:
-        fail('adaptive targets', status)
-
-    assert_schemes_committed([_damon_sysfs.Damos()], ctx['schemes'])
+    assert_ctxs_committed(kdamonds.kdamonds[0].contexts, status['contexts'])
 
     kdamonds.stop()
 
-- 
2.39.5

