Return-Path: <linux-kselftest+bounces-37700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B9EB0B72E
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00FB16ABC5
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4630D238C1F;
	Sun, 20 Jul 2025 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIO8Tzv4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D461235078;
	Sun, 20 Jul 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031831; cv=none; b=EO5E2mTf41xmxu+9psBrXfz+BSfW/bgcICYfiFWLOWNFmWWoLavFavbevXP9WNVrSLPIaQv8KuJkhUupFh9Xjw0QopO1/M48kEP1xoml2kSg6RApkABUgjJuBCh+vdsiDGOTol4JkPZDM/A6R5ujrCu5fC7dMqbvNeFItPwgres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031831; c=relaxed/simple;
	bh=lGHkMcba/CR1vJvOM12egev5VxmQknIZ9A3KZprvdZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gtP0/cuzjF1ZUJJ4ypqwvbRzAorzi3F2KHZHXpOXRKjyLocuAY09VdXNVlaKhdXZVMhgvELa9dN9J0Rn2/EAVxCNbW2BgoXDx8/WgnR5UvalB0GO42LOdyhYvbNI/sTFihfEXU1jgVxskJKQEMCQr24iIbcRzuCNir74UmdxfeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIO8Tzv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717DAC4CEE7;
	Sun, 20 Jul 2025 17:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031830;
	bh=lGHkMcba/CR1vJvOM12egev5VxmQknIZ9A3KZprvdZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SIO8Tzv4fUCNM0P6jf76Nt74AOJffaEqtg8Upt26Vzlh5BkNlrCX5knjfLpNglUbn
	 gR3dYlWh2jXjQnsDHNS+S0uZgdkiq6khC+8v+s9glfteIdg0mmbviujpUYteT7zwH8
	 CqIc0+A0ibyrVgFIa+slw0ZuP7dq2+v5aUVTRyUhQhNg+iiTJPsL6UluBLg4/UiAgf
	 cwHWmBSE8YePcPjui8LW+YkAhtr0juiM/FZ60golVCwTnaFh6Em+F2ZuBsOYSESfCO
	 O262crcFEqyh7OQVEnzF9fg3zDwhTmV/7GLA+feFK985hYRimLAhJrNmCcb2TEVJPE
	 7Fvi2ppOiizqg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 13/22] selftests/damon/sysfs.py: generalize DamosQuota commit assertion
Date: Sun, 20 Jul 2025 10:16:43 -0700
Message-Id: <20250720171652.92309-14-sj@kernel.org>
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

DamosQuota commitment assertion is hard-coded for a specific test case.
Split it out into a general version that can be reused for different
test cases.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 31 +++++++++++++++++---------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 91a28d97b015..dbe9f1a3b976 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -41,6 +41,18 @@ def assert_watermarks_committed(watermarks, dump):
     assert_true(dump['mid'] == watermarks.mid, 'mid', dump)
     assert_true(dump['low'] == watermarks.low, 'low', dump)
 
+def assert_quota_committed(quota, dump):
+    assert_true(dump['reset_interval'] == quota.reset_interval_ms,
+                'reset_interval', dump)
+    assert_true(dump['ms'] == quota.ms, 'ms', dump)
+    assert_true(dump['sz'] == quota.sz, 'sz', dump)
+    # TODO: assert goals are committed
+    assert_true(dump['weight_sz'] == quota.weight_sz_permil, 'weight_sz', dump)
+    assert_true(dump['weight_nr_accesses'] == quota.weight_nr_accesses_permil,
+                'weight_nr_accesses', dump)
+    assert_true(
+            dump['weight_age'] == quota.weight_age_permil, 'weight_age', dump)
+
 def main():
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(
@@ -104,18 +116,15 @@ def main():
     if scheme['target_nid'] != -1:
         fail('damos target nid', status)
 
-    if scheme['quota'] != {
-            'reset_interval': 0,
-            'ms': 0,
-            'sz': 0,
-            'goals': [],
-            'esz': 0,
-            'weight_sz': 0,
-            'weight_nr_accesses': 0,
-            'weight_age': 0,
-            }:
-        fail('damos quota', status)
+    migrate_dests = scheme['migrate_dests']
+    if migrate_dests['nr_dests'] != 0:
+        fail('nr_dests', status)
+    if migrate_dests['node_id_arr'] != []:
+        fail('node_id_arr', status)
+    if migrate_dests['weight_arr'] != []:
+        fail('weight_arr', status)
 
+    assert_quota_committed(_damon_sysfs.DamosQuota(), scheme['quota'])
     assert_watermarks_committed(_damon_sysfs.DamosWatermarks(),
                                 scheme['wmarks'])
 
-- 
2.39.5

