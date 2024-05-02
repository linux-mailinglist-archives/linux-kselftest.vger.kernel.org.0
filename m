Return-Path: <linux-kselftest+bounces-9271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3858B9F7B
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 19:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9231C2228F
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 17:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6785171076;
	Thu,  2 May 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKebqnen"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C04317106A;
	Thu,  2 May 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670849; cv=none; b=Q8WfcZ5YB5JTRZOXDQ1z+m0p0eNv2LHCOstmJVVTLSf/9/9zJRGx+N3QkZrfvSqq1ChUxeffN3GDfLdA2OlWFcoAPo/vQ7me1GWa0RE/y5R5buejRnPojyF97lCenRQyXSL/9VV34idBItma3deBTOiAR5nrwct7eTd/0ritOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670849; c=relaxed/simple;
	bh=eEWaWZuCUVNjcnEDhQvZezH6s4ajL/w8rs19eZgBqzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ch/xymXuRhgohysfeBWeMkUbQGkJj6Gc4zA4pPgp77u/HAH0CbkZ9RD3CyL1ENum2V1T+1wtnWX8dsbk0zyhh/vy86oVRYwH/E7b4yz/sv65+f81EJqgSzVMHDpycgxUWNeKuTYuG6CdtS31eylgdLOb9EHzG12bzz98x9m3x8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKebqnen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8C4C4AF19;
	Thu,  2 May 2024 17:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714670849;
	bh=eEWaWZuCUVNjcnEDhQvZezH6s4ajL/w8rs19eZgBqzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKebqnenIBHYk1o6RYjJ4Y+xs13OsNlBIXuc5Czx/u47e/HiLgix36VAoQ9uJFdpG
	 SNZoV1iJwX0OtmVdeAkGwqeEzZL3oVR1QZC4/1BFqiGBKwlw60MKOC+w8BIi99hoVN
	 TXuT8eBlkg4ESgiLjFWPKtNAaDBg5t3CY/8Bcj+zOCRw+im61SDI3zrLxneFEiBYzE
	 WMn9r7AKRefWgMq54Yi2fkRl9JHHJBZf7eJfRVQg1PeefOmn918RDR6IaN6d8Q4DZj
	 mPcqgeeENXwB9X4aoceet90qSbZNkhKf7ZPDhUN1D7ylCSYDdt0Xn20j6KzmnJj0ET
	 Dso/ZuNs3RBUg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/damon: add a test for DAMOS quota goal
Date: Thu,  2 May 2024 10:27:18 -0700
Message-Id: <20240502172718.74166-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502172718.74166-1-sj@kernel.org>
References: <20240502172718.74166-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest for DAMOS quota goal.  It tests the feature by setting a
user_input metric based goal, change the current feedback, and check if
the effective quota size is increased and decreased as expected.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |  2 +-
 .../selftests/damon/damos_quota_goal.py       | 77 +++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/damon/damos_quota_goal.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 789d6949c247..06c248880172 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -16,7 +16,7 @@ TEST_PROGS += debugfs_target_ids_pid_leak.sh
 TEST_PROGS += sysfs.sh sysfs_update_removed_scheme_dir.sh
 TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
 TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
-TEST_PROGS += damos_quota.py damos_apply_interval.py
+TEST_PROGS += damos_quota.py damos_quota_goal.py damos_apply_interval.py
 TEST_PROGS += reclaim.sh lru_sort.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/damon/damos_quota_goal.py b/tools/testing/selftests/damon/damos_quota_goal.py
new file mode 100755
index 000000000000..18246f3b62f7
--- /dev/null
+++ b/tools/testing/selftests/damon/damos_quota_goal.py
@@ -0,0 +1,77 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import subprocess
+import time
+
+import _damon_sysfs
+
+def main():
+    # access two 10 MiB memory regions, 2 second per each
+    sz_region = 10 * 1024 * 1024
+    proc = subprocess.Popen(['./access_memory', '2', '%d' % sz_region, '2000'])
+
+    goal = _damon_sysfs.DamosQuotaGoal(
+            metric=_damon_sysfs.qgoal_metric_user_input, target_value=10000)
+    kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
+            contexts=[_damon_sysfs.DamonCtx(
+                ops='vaddr',
+                targets=[_damon_sysfs.DamonTarget(pid=proc.pid)],
+                schemes=[_damon_sysfs.Damos(
+                    action='stat',
+                    quota=_damon_sysfs.DamosQuota(
+                        goals=[goal], reset_interval_ms=100),
+                    )] # schemes
+                )] # contexts
+            )]) # kdamonds
+
+    err = kdamonds.start()
+    if err != None:
+        print('kdamond start failed: %s' % err)
+        exit(1)
+
+    score_values_to_test = [0, 15000, 5000, 18000]
+    while proc.poll() == None:
+        if len(score_values_to_test) == 0:
+            time.sleep(0.1)
+            continue
+
+        goal.current_value = score_values_to_test.pop(0)
+        expect_increase = goal.current_value < goal.target_value
+
+        err = kdamonds.kdamonds[0].commit_schemes_quota_goals()
+        if err is not None:
+            print('commit_schemes_quota_goals failed: %s' % err)
+            exit(1)
+
+        err = kdamonds.kdamonds[0].update_schemes_effective_quotas()
+        if err is not None:
+            print('before-update_schemes_effective_quotas failed: %s' % err)
+            exit(1)
+        last_effective_bytes = goal.effective_bytes
+
+        time.sleep(0.5)
+
+        err = kdamonds.kdamonds[0].update_schemes_effective_quotas()
+        if err is not None:
+            print('after-update_schemes_effective_quotas failed: %s' % err)
+            exit(1)
+
+        print('score: %s, effective quota: %d -> %d (%.3fx)' % (
+            goal.current_value, last_effective_bytes, goal.effective_bytes,
+            goal.effective_bytes / last_effective_bytes
+            if last_effective_bytes != 0 else -1.0))
+
+        if last_effective_bytes == goal.effective_bytes:
+            print('efective bytes not changed: %d' % goal.effective_bytes)
+            exit(1)
+
+        increased = last_effective_bytes < goal.effective_bytes
+        if expect_increase != increased:
+            print('expectation of increase (%s) != increased (%s)' %
+                  (expect_increase, increased))
+            exit(1)
+        last_effective_bytes = goal.effective_bytes
+
+if __name__ == '__main__':
+    main()
-- 
2.39.2


