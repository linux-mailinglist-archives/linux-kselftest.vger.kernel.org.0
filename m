Return-Path: <linux-kselftest+bounces-37702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5DCB0B730
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931F4174DD6
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1C3239E9A;
	Sun, 20 Jul 2025 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3W69egp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC6239E8A;
	Sun, 20 Jul 2025 17:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031833; cv=none; b=KxHJsDK1A5oFhDdyYPCGzph1ao68TgGH6jPO/KI2ETcaLpUK1OniGqxEaYVeK2SZRDFKmWrxMlfzO8d/edu8463eua66/xFdA8wnKYjUCBUPAl54x7nPXRMZyNeFZcGv1Hgb6ODxqXdkxK9rkd3mgYMD4vKyDCr7ANExvTvkMNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031833; c=relaxed/simple;
	bh=ERpV8blO5HNqiTijey9V1Uxn0Ow5E/IYjTdkk8p12JU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rwsLt5alxiLZaKO1a+ZD0E3hHR1QzIA012Rq54vpdvgroWed6vogEPTma8HjzOBs9GiH5xB29ZLjmXAKrysCfxcdd53nDanZPmUfz0Cm8BVfWnhB9ubi4vkVIj5WzgOW48NoD7hmWCWLpRTrKkXPsbXtAGNWN8rRuebP36P25M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3W69egp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08B3C4CEE7;
	Sun, 20 Jul 2025 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031832;
	bh=ERpV8blO5HNqiTijey9V1Uxn0Ow5E/IYjTdkk8p12JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F3W69egp4Lt7yKSHpQdSNCJC91Zv6+Jo5RaSAXKK4AluK9lXV2QP9pvsKB/fSvT2H
	 0Xbk7kEsKifnO7NQheDvMBRS65mm5ncl364TKaHZEfpRzp4PobZEbj/39iUalevILx
	 7lxzNBVdRoxTQkhR2SFerG6TTHYjwF5vt0ZJio07y69eM/QjADC56iwtCqy3qp3Jym
	 BQBkWniGejfogDTM56EI3KDMrcQrjunI9SLf9J5V7bsUdIQzPvzVMl1ojPSDvYiC5O
	 O9z/fLnzl//BE7Ddw9PKQkflM+v7pVpGNpzk7Tczo6jkkonDgVDsUJUT4kOxw91Tut
	 CU414XfXX5/2A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 15/22] selftests/damon/sysfs.py: test DAMOS destinations commitment
Date: Sun, 20 Jul 2025 10:16:45 -0700
Message-Id: <20250720171652.92309-16-sj@kernel.org>
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

Current DAMOS commitment assertion is not testing quota destinations
commitment.  Add the test.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 93f20c5c6780..803f38b61ab3 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -69,6 +69,13 @@ def assert_quota_committed(quota, dump):
     assert_true(
             dump['weight_age'] == quota.weight_age_permil, 'weight_age', dump)
 
+
+def assert_migrate_dests_committed(dests, dump):
+    assert_true(dump['nr_dests'] == len(dests.dests), 'nr_dests', dump)
+    for idx, dest in enumerate(dests.dests):
+        assert_true(dump['node_id_arr'][idx] == dest.id, 'node_id', dump)
+        assert_true(dump['weight_arr'][idx] == dest.weight, 'weight', dump)
+
 def main():
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(
@@ -132,14 +139,8 @@ def main():
     if scheme['target_nid'] != -1:
         fail('damos target nid', status)
 
-    migrate_dests = scheme['migrate_dests']
-    if migrate_dests['nr_dests'] != 0:
-        fail('nr_dests', status)
-    if migrate_dests['node_id_arr'] != []:
-        fail('node_id_arr', status)
-    if migrate_dests['weight_arr'] != []:
-        fail('weight_arr', status)
-
+    assert_migrate_dests_committed(_damon_sysfs.DamosDests(),
+                                   scheme['migrate_dests'])
     assert_quota_committed(_damon_sysfs.DamosQuota(), scheme['quota'])
     assert_watermarks_committed(_damon_sysfs.DamosWatermarks(),
                                 scheme['wmarks'])
-- 
2.39.5

