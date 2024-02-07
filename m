Return-Path: <linux-kselftest+bounces-4279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C08AB84D304
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 21:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83849B2771B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 20:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E66823B8;
	Wed,  7 Feb 2024 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJJijCfm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903012881A;
	Wed,  7 Feb 2024 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337904; cv=none; b=ITU4Vo46XdOZgVOjjUCowmSgklietYGtXcOt01sLPG7/v2dPeR0cp9wfA/7Oq4cZ3OsqleZVpvOD3cRq+mXP/QuKueSF5mMDX2acYGlfPmLkBDgq8OVOWdQzYanHC022gJmpRUGYXS3i2j7KAazcFtZ/aGVJKpndxBEyTdz0ex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337904; c=relaxed/simple;
	bh=tz9uTb84Z42Yizp5Acw7rjIK4AMaxjqMzKQOqT/pm1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/7h+7c4CkVjmy8ecwRqas+Ush5ZWxiMb1lKWqmF+9/PUkOZ9CVkSqFbP2nGMqdniYJiokikrGLMB/WD5rhCsogl5tJ6E9u3NPkx/AqoNRNX8sN7jct0hmmxQQaAdGZaVssytySOhgmwKt4uAfM8w1RxaSl0t6pfuqWPqongbMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJJijCfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A8FC43390;
	Wed,  7 Feb 2024 20:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707337904;
	bh=tz9uTb84Z42Yizp5Acw7rjIK4AMaxjqMzKQOqT/pm1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJJijCfmw4GrlAMLBl2nP9yduJUcln0mxAT/q50sI+tVVLy2pIDCclwCxcNfCEWOG
	 3uKNB+jqzsufuPDqf9L25wuWkXRB3clhwftLcRVBOtVOUEmEO9S8Q181dKzi37GUII
	 aqtGfAyzwMiz0iE/qwfGcVHcQG99augNwfn8zblNS3xRUJtTnuyvWkcp3DDkMVQTLs
	 2F6ltet+/rUSxJuNO9aQjEUVy5vntT50wmjVCQ5ejj5fIqXFLj17s8lHTiCjCMpop+
	 bFWBaRWR7yfvnKot97njjwyosyXavwoeSgfyjAKNiOO1EH1z03lsyKV/Ew16tLZBML
	 aePPCZfS9eubA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] selftests/damon: add a test for DAMOS quota
Date: Wed,  7 Feb 2024 12:31:30 -0800
Message-Id: <20240207203134.69976-5-sj@kernel.org>
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

Add a selftest for verifying the DAMOS quota feature.  The test is very
similar to sysfs_update_schemes_tried_regions_wss_estimation.py.  It
starts an artificial workload of 20 MiB working set, run DAMON to find
the working set size, but with 1 MiB/100 ms size quota.  Then, it
collect the DAMON-found working set size every 100 ms and check if the
quota was always applied as expected.  For the confirmation, the tests
shows the stat-applied region size and the qt_exceeds stat.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile       |  1 +
 tools/testing/selftests/damon/damos_quota.py | 67 ++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100755 tools/testing/selftests/damon/damos_quota.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 8a1cc2bf1864..9c3783f1a39d 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -12,6 +12,7 @@ TEST_PROGS += debugfs_rm_non_contexts.sh
 TEST_PROGS += sysfs.sh sysfs_update_removed_scheme_dir.sh
 TEST_PROGS += sysfs_update_schemes_tried_regions_hang.py
 TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
+TEST_PROGS += damos_quota.py
 TEST_PROGS += reclaim.sh lru_sort.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/damon/damos_quota.py b/tools/testing/selftests/damon/damos_quota.py
new file mode 100755
index 000000000000..7d4c6bb2e3cd
--- /dev/null
+++ b/tools/testing/selftests/damon/damos_quota.py
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
+    sz_quota = 1024 * 1024 # 1 MiB
+    quota_reset_interval = 100 # 100 ms
+    kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
+            contexts=[_damon_sysfs.DamonCtx(
+                ops='vaddr',
+                targets=[_damon_sysfs.DamonTarget(pid=proc.pid)],
+                schemes=[_damon_sysfs.Damos(
+                    access_pattern=_damon_sysfs.DamosAccessPattern(
+                        # >= 25% access rate, >= 200ms age
+                        nr_accesses=[5, 20], age=[2, 2**64 - 1]),
+                    quota=_damon_sysfs.DamosQuota(
+                        sz=sz_quota, reset_interval_ms=quota_reset_interval)
+                    )] # schemes
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
+        err = kdamonds.kdamonds[0].update_schemes_tried_bytes()
+        if err != None:
+            print('tried bytes update failed: %s' % err)
+            exit(1)
+        err = kdamonds.kdamonds[0].update_schemes_stats()
+        if err != None:
+            print('stats update failed: %s' % err)
+            exit(1)
+
+        scheme = kdamonds.kdamonds[0].contexts[0].schemes[0]
+        wss_collected.append(scheme.tried_bytes)
+        nr_quota_exceeds = scheme.stats.qt_exceeds
+
+    wss_collected.sort()
+    for wss in wss_collected:
+        if wss > sz_quota:
+            print('quota is not kept: %s > %s' % (wss, sz_quota))
+            print('collected samples are as below')
+            print('\n'.join(['%d' % wss for wss in wss_collected]))
+            exit(1)
+
+    if nr_quota_exceeds < len(wss_collected):
+        print('quota is not always exceeded: %d > %d' %
+              (len(wss_collected), nr_quota_exceeds))
+        exit(1)
+
+if __name__ == '__main__':
+    main()
-- 
2.39.2


