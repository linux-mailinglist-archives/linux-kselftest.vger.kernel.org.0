Return-Path: <linux-kselftest+bounces-35583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD86BAE3233
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 23:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA7716F1CA
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 21:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFA3222571;
	Sun, 22 Jun 2025 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNud93s6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27AD222561;
	Sun, 22 Jun 2025 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626222; cv=none; b=nJoQ84DvZ34XacrwrTpQndpcWyJa3OG0RIv7qF05wFioUvlbQL+VeIC+dmTClB+y4YP3KfWXKLx489yhQZ7I0E7Nqj9x/Us1sx3E4pcmtxrTIpOUuti5Zp/uz8dkDgO59c9J0roFGaUJxgGPfoDSZJS55iyC2c6WDzAixR2qvxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626222; c=relaxed/simple;
	bh=CR4mzDVLH9lzs9or4TF7dOJ0izoFCJ1YoukXbycwrC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hCgA3pMlysSNjlgwg+E4ZDHOtPV3SLpemM8laJZQ9Wn7TRq1yc7xFF/S0szCM7A1RNygd6ADNClMafth+oGozjdrjn6ArCVXP54KXH2o9oDVnNsGUvTiY2YM5rmdO3Z2/ATgsacMdD5t3LrkaszzzVf0r2tCSPWPMuO8chgJKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNud93s6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341A5C4CEED;
	Sun, 22 Jun 2025 21:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750626222;
	bh=CR4mzDVLH9lzs9or4TF7dOJ0izoFCJ1YoukXbycwrC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pNud93s6qSRE2V1pdjrSodSG5/YV8dkAhP0AXa7Ckh4nHqDDcZ8kpKYu8dUyXDCbV
	 XGex9qXl94srCsIuUeNPqldNomDb9fjBSPmgfHaF8LZbyvrO0IhkwrNkZ6NdsNjUOL
	 A7yz2ZGNDs4eYkhVdNe3SwIcvYsIt84eYAlj/xBLumTlQ73JIxfBpb0cmd/yT+BGuW
	 8T2rHrsLo7mBWF18WGDhTXyeiSQRulKOoH+WJ4t1H60eXZ9L5WpTbzVi0gx72Dcajm
	 /buyKh9LyCnfqxvhwxrG0PU0F+BHzETLErcJaiiLOBHHbkcv+FdjRaWGvdzBLh9JH9
	 YJiWTmtiH8R9A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/6] selftests/damon/sysfs.py: test DAMOS schemes parameters setup
Date: Sun, 22 Jun 2025 14:03:30 -0700
Message-Id: <20250622210330.40490-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622210330.40490-1-sj@kernel.org>
References: <20250622210330.40490-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DAMON sysfs interface functionality tests for basic DAMOS schemes
parameters setup.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 46 ++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 3b085268f342..e67008fd055d 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -29,7 +29,9 @@ def main():
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(
                 contexts=[_damon_sysfs.DamonCtx(
-                    targets=[_damon_sysfs.DamonTarget(pid=-1)])])])
+                    targets=[_damon_sysfs.DamonTarget(pid=-1)],
+                    schemes=[_damon_sysfs.Damos()],
+                    )])])
     err = kdamonds.start()
     if err is not None:
         print('kdamond start failed: %s' % err)
@@ -66,8 +68,46 @@ def main():
             { 'pid': 0, 'nr_regions': 0, 'regions_list': []}]:
         fail('adaptive targets', status)
 
-    if ctx['schemes'] != []:
-        fail('schemes')
+    if len(ctx['schemes']) != 1:
+        fail('number of schemes', status)
+
+    scheme = ctx['schemes'][0]
+    if scheme['pattern'] != {
+            'min_sz_region': 0,
+            'max_sz_region': 2**64 - 1,
+            'min_nr_accesses': 0,
+            'max_nr_accesses': 2**32 - 1,
+            'min_age_region': 0,
+            'max_age_region': 2**32 - 1,
+            }:
+        fail('damos pattern', status)
+    if scheme['action'] != 9:   # stat
+        fail('damos action', status)
+    if scheme['apply_interval_us'] != 0:
+        fail('damos apply interval', status)
+    if scheme['target_nid'] != -1:
+        fail('damos target nid', status)
+
+    if scheme['quota'] != {
+            'reset_interval': 0,
+            'ms': 0,
+            'sz': 0,
+            'goals': [],
+            'esz': 0,
+            'weight_sz': 0,
+            'weight_nr_accesses': 0,
+            'weight_age': 0,
+            }:
+        fail('damos quota', status)
+
+    if scheme['wmarks'] != {
+            'metric': 0,
+            'interval': 0,
+            'high': 0,
+            'mid': 0,
+            'low': 0,
+            }:
+        fail('damos wmarks', status)
 
     kdamonds.stop()
 
-- 
2.39.5

