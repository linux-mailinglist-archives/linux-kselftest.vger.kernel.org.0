Return-Path: <linux-kselftest+bounces-12723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E98F916FD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 20:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E836A1F232B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 18:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B317C9F1;
	Tue, 25 Jun 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkQxuGZQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9EB1779BA;
	Tue, 25 Jun 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338748; cv=none; b=IOfQ9wfCPpLR76GurkSdyN18vWapPgFbgr6QuKEvzbw3RU3hdXyZ7PTvzkGRyRq+GRJyx7SiOSluYOGbDBYte/uM/z2rVP+iEtc3hOJm/BJdy+SiaBjYSpwsBwwsXy67EZHhMTCExdfLZyeTLi9A3v59sDm/bvNiUxWPHmrjCbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338748; c=relaxed/simple;
	bh=NVtILSH+9XYglOUzDKTB4NeWGCqUXF9j4Ar1OAT5e/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XWOXnIGLTt9pYOu6kzuP6otczkQcIgQ9oTDuSIL6qqY2eBRNzoRFRzdJVfhfwgUS/vnfOD+TKWwynwUFfy8WzrbrWq7IFWy7955VSzL9hm16s4iwuXDHurZt4SvI+oRc7TCmhczO2kmUjwi3SXqUVaJ8MAR5QDY1s5ijYnglZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkQxuGZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CABC4AF0B;
	Tue, 25 Jun 2024 18:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719338748;
	bh=NVtILSH+9XYglOUzDKTB4NeWGCqUXF9j4Ar1OAT5e/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CkQxuGZQDXDSFVVkxd+cWTiZYH9I8X/TYlIjNbrGHDCeUjCwfc99G2TAMubyPKLvE
	 Ttbt8FSCaARYyIm2t69Cc620QeD8bOnvdvMoQaKIrG++rqPy9RgvXqPkvOcaA29ECE
	 qQLYRrC545HJC3vFtMGhbLcrAgJG0bOYNcS+uUmEtO/2CKjZxiHesf8Ni8g+NUeQba
	 r4A4E2J3oZhGyQbU6XX2X2jRn3KK/GPF3fxXzorBTTMJX5vbPDjqkve/6oXz28464T
	 1BRM/pV6sXNzmGMUBXXbF2gA5mxQUBbswUOoU7b4Dlj5iLuYH5OOwgKBvwp8ye/AsO
	 IIUNQcghvm0Jg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] selftests/damon: implement test for min/max_nr_regions
Date: Tue, 25 Jun 2024 11:05:36 -0700
Message-Id: <20240625180538.73134-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625180538.73134-1-sj@kernel.org>
References: <20240625180538.73134-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a kselftest for DAMON's {min,max}_nr_regions' parameters.  The
test ensures both the minimum and the maximum number of regions limit is
respected even if the workload's real number of regions is less than the
minimum or larger than the maximum limits.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile        |  2 +-
 .../selftests/damon/damon_nr_regions.py       | 85 +++++++++++++++++++
 2 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/damon/damon_nr_regions.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 356b4e9a515d..1e2e98cc809d 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -13,7 +13,7 @@ TEST_PROGS = debugfs_attrs.sh debugfs_schemes.sh debugfs_target_ids.sh
 TEST_PROGS += sysfs.sh
 TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
 TEST_PROGS += damos_quota.py damos_quota_goal.py damos_apply_interval.py
-TEST_PROGS += damos_tried_regions.py
+TEST_PROGS += damos_tried_regions.py damon_nr_regions.py
 TEST_PROGS += reclaim.sh lru_sort.sh
 
 # regression tests (reproducers of previously found bugs)
diff --git a/tools/testing/selftests/damon/damon_nr_regions.py b/tools/testing/selftests/damon/damon_nr_regions.py
new file mode 100644
index 000000000000..dd2735923c59
--- /dev/null
+++ b/tools/testing/selftests/damon/damon_nr_regions.py
@@ -0,0 +1,85 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import subprocess
+import time
+
+import _damon_sysfs
+
+def test_nr_regions(real_nr_regions, min_nr_regions, max_nr_regions):
+    '''
+    Create process of the given 'real_nr_regions' regions, monitor it using
+    DAMON with given '{min,max}_nr_regions' monitoring parameter.
+
+    Exit with non-zero return code if the given {min,max}_nr_regions is not
+    kept.
+    '''
+    sz_region = 10 * 1024 * 1024
+    proc = subprocess.Popen(['./access_memory_even', '%d' % real_nr_regions,
+                             '%d' % sz_region])
+
+    # stat every monitored regions
+    kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
+            contexts=[_damon_sysfs.DamonCtx(
+                monitoring_attrs=_damon_sysfs.DamonAttrs(
+                    min_nr_regions=min_nr_regions,
+                    max_nr_regions=max_nr_regions),
+                ops='vaddr',
+                targets=[_damon_sysfs.DamonTarget(pid=proc.pid)],
+                schemes=[_damon_sysfs.Damos(action='stat',
+                    )] # schemes
+                )] # contexts
+            )]) # kdamonds
+
+    err = kdamonds.start()
+    if err is not None:
+        proc.terminate()
+        print('kdamond start failed: %s' % err)
+        exit(1)
+
+    collected_nr_regions = []
+    while proc.poll() is None:
+        time.sleep(0.1)
+        err = kdamonds.kdamonds[0].update_schemes_tried_regions()
+        if err is not None:
+            proc.terminate()
+            print('tried regions update failed: %s' % err)
+            exit(1)
+
+        scheme = kdamonds.kdamonds[0].contexts[0].schemes[0]
+        if scheme.tried_regions is None:
+            proc.terminate()
+            print('tried regions is not collected')
+            exit(1)
+
+        nr_tried_regions = len(scheme.tried_regions)
+        if nr_tried_regions <= 0:
+            proc.terminate()
+            print('tried regions is not created')
+            exit(1)
+        collected_nr_regions.append(nr_tried_regions)
+        if len(collected_nr_regions) > 10:
+            break
+    proc.terminate()
+    kdamonds.stop()
+
+    test_name = 'nr_regions test with %d/%d/%d real/min/max nr_regions' % (
+            real_nr_regions, min_nr_regions, max_nr_regions)
+    if (collected_nr_regions[0] < min_nr_regions or
+        collected_nr_regions[-1] > max_nr_regions):
+        print('fail %s' % test_name)
+        print('number of regions that collected are:')
+        for nr in collected_nr_regions:
+            print(nr)
+        exit(1)
+    print('pass %s ' % test_name)
+
+def main():
+    # test min_nr_regions larger than real nr regions
+    test_nr_regions(10, 20, 100)
+
+    # test max_nr_regions smaller than real nr regions
+    test_nr_regions(15, 3, 10)
+
+if __name__ == '__main__':
+    main()
-- 
2.39.2


