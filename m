Return-Path: <linux-kselftest+bounces-37703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE943B0B734
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D9A7A70B4
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6835322156D;
	Sun, 20 Jul 2025 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXB5Von2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D93723ABBF;
	Sun, 20 Jul 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031835; cv=none; b=BCv9lpA2kO289WYTF2oWUoasU+i1PcmSy9y2XBGnaiFGJhS0SL0NizX62+teLs7V9Q9yEy6RmN44OjBOdQMzI/cBNrAr5/GAbhhurb3rR1WHtU6DG9Uuf6S6VhyoLPX3GiNSineIT1MUbCCd3aczRUlrpFF1dQGh5f0N6M6Vv3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031835; c=relaxed/simple;
	bh=C+MxPYrYclaVcjxNdOPDcCVwFLKAkLjsoAGfPMtg1OA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nyi5YTpTW7//ubhDP8BLV+YSgBNUt+VwmhtOKSY68pNOgID0eGWa/eBVDGOwXymUDMwhzHq22hKzedYqB+3Sdtkd7IC2u7s7Bb56eZzKrR8pAAEZfuOP2efGSGGd7mCGjYv/jHyGl69ncQDycuOkSqbLhNbZKw2s0xdShJknIyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXB5Von2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECB5C4CEEB;
	Sun, 20 Jul 2025 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031833;
	bh=C+MxPYrYclaVcjxNdOPDcCVwFLKAkLjsoAGfPMtg1OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXB5Von2EQuwiNj2cE5N7Xo2r4+0Urh50yw+hf7Jyb8tgbWzn3FBGP+eZSDWpMOGA
	 NmJ62BsRk8eMKEKWUIH8QVdT5XRxJ2UNgU9IJsU5F972j4Kd3fhrL1d9b2atb7xXCd
	 yO6BobtBGJOBBcTj5NS0y2hpF6gRTBd6M9J9TAFkcU2WQzRttzz2coueEawxG419BA
	 gUr6I2MvtB+d+KzTDaD37SnqNyo5HbNjxrO/Fo1xjofMziYvUNYJQ5DGbS1JeQHQSk
	 8v0MyiDOaakxx4+7ZyGpiiFJxwYg5Xh24bUa7R4StMH8bnr3R7nAt9d/A0iv93c1Oh
	 dN7KxJ3gPTHdQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 16/22] selftests/damon/sysfs.py: generalize DAMOS schemes commit assertion
Date: Sun, 20 Jul 2025 10:16:46 -0700
Message-Id: <20250720171652.92309-17-sj@kernel.org>
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

DAMOS scheme commitment assertion is hard-coded for a specific test
case.  Split it out into a general version that can be reused for
different test cases.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 59 ++++++++++++++++----------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 803f38b61ab3..584a71cbb891 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -76,6 +76,42 @@ def assert_migrate_dests_committed(dests, dump):
         assert_true(dump['node_id_arr'][idx] == dest.id, 'node_id', dump)
         assert_true(dump['weight_arr'][idx] == dest.weight, 'weight', dump)
 
+def assert_access_pattern_committed(pattern, dump):
+    assert_true(dump['min_sz_region'] == pattern.size[0], 'min_sz_region',
+                dump)
+    assert_true(dump['max_sz_region'] == pattern.size[1], 'max_sz_region',
+                dump)
+    assert_true(dump['min_nr_accesses'] == pattern.nr_accesses[0],
+                'min_nr_accesses', dump)
+    assert_true(dump['max_nr_accesses'] == pattern.nr_accesses[1],
+                'max_nr_accesses', dump)
+    assert_true(dump['min_age_region'] == pattern.age[0], 'min_age_region',
+                dump)
+    assert_true(dump['max_age_region'] == pattern.age[1], 'miaxage_region',
+                dump)
+
+def assert_scheme_committed(scheme, dump):
+    assert_access_pattern_committed(scheme.access_pattern, dump['pattern'])
+    action_val = {
+            'willneed': 0,
+            'cold': 1,
+            'pageout': 2,
+            'hugepage': 3,
+            'nohugeapge': 4,
+            'lru_prio': 5,
+            'lru_deprio': 6,
+            'migrate_hot': 7,
+            'migrate_cold': 8,
+            'stat': 9,
+            }
+    assert_true(dump['action'] == action_val[scheme.action], 'action', dump)
+    assert_true(dump['apply_interval_us'] == scheme. apply_interval_us,
+                'apply_interval_us', dump)
+    assert_true(dump['target_nid'] == scheme.target_nid, 'target_nid', dump)
+    assert_migrate_dests_committed(scheme.dests, dump['migrate_dests'])
+    assert_quota_committed(scheme.quota, dump['quota'])
+    assert_watermarks_committed(scheme.watermarks, dump['wmarks'])
+
 def main():
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(
@@ -122,28 +158,7 @@ def main():
     if len(ctx['schemes']) != 1:
         fail('number of schemes', status)
 
-    scheme = ctx['schemes'][0]
-    if scheme['pattern'] != {
-            'min_sz_region': 0,
-            'max_sz_region': 2**64 - 1,
-            'min_nr_accesses': 0,
-            'max_nr_accesses': 2**32 - 1,
-            'min_age_region': 0,
-            'max_age_region': 2**32 - 1,
-            }:
-        fail('damos pattern', status)
-    if scheme['action'] != 9:   # stat
-        fail('damos action', status)
-    if scheme['apply_interval_us'] != 0:
-        fail('damos apply interval', status)
-    if scheme['target_nid'] != -1:
-        fail('damos target nid', status)
-
-    assert_migrate_dests_committed(_damon_sysfs.DamosDests(),
-                                   scheme['migrate_dests'])
-    assert_quota_committed(_damon_sysfs.DamosQuota(), scheme['quota'])
-    assert_watermarks_committed(_damon_sysfs.DamosWatermarks(),
-                                scheme['wmarks'])
+    assert_scheme_committed(_damon_sysfs.Damos(), ctx['schemes'][0])
 
     kdamonds.stop()
 
-- 
2.39.5

