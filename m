Return-Path: <linux-kselftest+bounces-4280-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0028784D306
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 21:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9DE28EB77
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 20:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA4B129A74;
	Wed,  7 Feb 2024 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKgp/zT8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55337129A68;
	Wed,  7 Feb 2024 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337905; cv=none; b=awO4IAA7rrCQJGXGv+rhbdSqduL24SZfTY9EHHeof/iAlJn40jU2JviX8innoJbCh9Vu9Tw5MQKhWmS3Ceql+i08C3ul7ph7W5ml9UJ6zYxmXPHcfVlWmXbmbl2xkZsAm+vQJ9+s1QoJhxEass8L0P8EZf9Rh0ygQCJhH+DqNlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337905; c=relaxed/simple;
	bh=eTfAT8I3Zrsng6f7SuRxQKWrP7lIEivzKE3OpfIwwxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NNNZ/v6HpOXAaHXJM3QzUFepWuf/A15ZJo7OyimKO9JELZ03TPL00eWZ+nVp1J+sqOaxyKmllJ3fsQPso9dkFu3+KaNz/CAOiyotME3GfWZF/DDW8THfaW4sWIZm6n3UgVHBVYlL0iPdsssUAWI4G+5qemv5DPXKolLuEiqHk+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKgp/zT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374E9C4166D;
	Wed,  7 Feb 2024 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707337904;
	bh=eTfAT8I3Zrsng6f7SuRxQKWrP7lIEivzKE3OpfIwwxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JKgp/zT8soGxMNVpEjgN4T11q/PH3dSEMmOCuxrZk1KHb+x4aO+vHKx3WghdJTjjI
	 U1vxJoRUqSA7K4mUYmEwBW/w7cVZ/AzEVXOVi2WJGSqr85PnQHEVDdbCphy53Hiobe
	 ewQwBW7Pj5BnELlzpz1x6bHuaUUXU1pXc7qQN322bFOVRh4Xb0IFrPID3NY1DlUp7b
	 SnTkVHx91YfY8ZxZosB/ENWyTggk4AGpTLXidmrJmcjX6q21CdrSENztmqzzCi4WBs
	 AUnNKvucq+cG0+WD5BN7QIV7fUw/7zlR91K8CILvWsb1THqfz3lx4WtJWh7OFb7FSi
	 3SpnJ3QJj9rXQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] selftests/damon: add a test for DAMOS apply intervals
Date: Wed,  7 Feb 2024 12:31:31 -0800
Message-Id: <20240207203134.69976-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207203134.69976-1-sj@kernel.org>
References: <20240207203134.69976-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest for DAMOS apply intervals.  It runs two schemes having
different apply interval agains an artificial memory access workload,
and check if the scheme with smaller apply interval was applied more
frequently.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |  2 +-
 .../selftests/damon/damos_apply_interval.py   | 67 +++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/damon/damos_apply_interval.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 9c3783f1a39d..b545fedafb3b 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -12,7 +12,7 @@ TEST_PROGS += debugfs_rm_non_contexts.sh
 TEST_PROGS += sysfs.sh sysfs_update_removed_scheme_dir.sh
 TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
 TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
-TEST_PROGS += damos_quota.py
+TEST_PROGS += damos_quota.py damos_apply_interval.py
 TEST_PROGS += reclaim.sh lru_sort.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/damon/damos_apply_interval.py b/tools/testing/selftests/damon/damos_apply_interval.py
new file mode 100755
index 000000000000..f04d43702481
--- /dev/null
+++ b/tools/testing/selftests/damon/damos_apply_interval.py
@@ -0,0 +1,67 @@
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
+    # Set quota up to 1 MiB per 100 ms
+    kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
+            contexts=[_damon_sysfs.DamonCtx(
+                ops='vaddr',
+                targets=[_damon_sysfs.DamonTarget(pid=proc.pid)],
+                schemes=[
+                    _damon_sysfs.Damos(
+                        access_pattern=_damon_sysfs.DamosAccessPattern(
+                            # >= 25% access rate, >= 200ms age
+                            nr_accesses=[5, 20], age=[2, 2**64 - 1]),
+                        # aggregation interval (100 ms) is used
+                        apply_interval_us=0),
+                    # use 10ms apply interval
+                    _damon_sysfs.Damos(
+                        access_pattern=_damon_sysfs.DamosAccessPattern(
+                            # >= 25% access rate, >= 200ms age
+                            nr_accesses=[5, 20], age=[2, 2**64 - 1]),
+                        # explicitly set 10 ms apply interval
+                        apply_interval_us=10 * 1000)
+                    ] # schemes
+                )] # contexts
+            )]) # kdamonds
+
+    err = kdamonds.start()
+    if err != None:
+        print('kdamond start failed: %s' % err)
+        exit(1)
+
+    wss_collected = []
+    nr_quota_exceeds = 0
+    while proc.poll() == None:
+        time.sleep(0.1)
+        err = kdamonds.kdamonds[0].update_schemes_stats()
+        if err != None:
+            print('stats update failed: %s' % err)
+            exit(1)
+    schemes = kdamonds.kdamonds[0].contexts[0].schemes
+    nr_tried_stats = [s.stats.nr_tried for s in schemes]
+    if nr_tried_stats[0] == 0 or nr_tried_stats[1] == 0:
+        print('scheme(s) are not tried')
+        exit(1)
+
+    # Because the second scheme was having the apply interval that is ten times
+    # lower than that of the first scheme, the second scheme should be tried
+    # about ten times more frequently than the first scheme.  For possible
+    # timing errors, check if it was at least nine times more freuqnetly tried.
+    ratio = nr_tried_stats[1] / nr_tried_stats[0]
+    if ratio < 9:
+        print('%d / %d = %f (< 9)' %
+              (nr_tried_stats[1], nr_tried_stats[0], ratio))
+        exit(1)
+
+if __name__ == '__main__':
+    main()
-- 
2.39.2


