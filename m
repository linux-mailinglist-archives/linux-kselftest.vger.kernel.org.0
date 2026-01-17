Return-Path: <linux-kselftest+bounces-49220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E02D38B6C
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 03:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CE4E303EB89
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 02:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E036A3101BF;
	Sat, 17 Jan 2026 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFgHni2f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD19E30F927;
	Sat, 17 Jan 2026 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768615659; cv=none; b=GbU096blcxh5k7XJkvoyWljZN2qI7HGvHut9XxV2wI7TFT2kOkijsefhbsVf5lo7f/qVsQFOuKphuBIQr1CYyGaUX+la+16PECub31T1LcmWZouvHbsWW6lQE+5OCKHHSlQ/lUaCte7kBQD3wZZooKlzAeX0Sck9G8Ia1qmDj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768615659; c=relaxed/simple;
	bh=hotNE+mkKLh4E3ZrIzL4sCf5Wg0MeE2kOyjLK5ej2kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeHjIBizMGA1tV7CNbeU2NvUhNJTu8DYV3CRJP0ytRTWZcvbRSpd6VCtlKr4kHh0KdTfjvwQ9lv0gwdNL50j7YIJgnEhUUSvRIpm5whwQI76dF/nnMy536KJUkivf9T8jK1iqzP4On5uD9QXdVktF+V5jvsbSvYBbpSUI0jYhW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFgHni2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8446FC19423;
	Sat, 17 Jan 2026 02:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768615659;
	bh=hotNE+mkKLh4E3ZrIzL4sCf5Wg0MeE2kOyjLK5ej2kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFgHni2fBFLxaEC3ayWzPAfAqtL435n6RT3GbJ0EFn8rFi4YlLAGRb1zj2eThEYIv
	 keP/Y2hkwZwDxdmIWSPhk7LmY6CV+10esWPRC8JdsFlRygYvZp7mrDrZp+fbz8dg5q
	 L9O+dBYohuLOvUdmylv+vu9ZSD1uz7qvyWQr3oBhWPZp/ttNabXHq/oKmeOsyxtBPA
	 kdUWTZyD/isx884RtprXEYVzvhSJ2HDzoAhxahNsCrgxOhFF0s5WhC8lv/akPZRmRw
	 3eNPqeo94qInMmFaEAOgCejOGLYAKLL9j8NRbUIZ2SFngRMpnsH9mEUOX0Ume6hO/W
	 YAvd4WjwQ20EQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/5] selftests/damon/wss_estimation: test for up to 160 MiB working set size
Date: Fri, 16 Jan 2026 18:07:25 -0800
Message-ID: <20260117020731.226785-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260117020731.226785-1-sj@kernel.org>
References: <20260117020731.226785-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON reads and writes Accessed bits of page tables without manual TLB
flush for two reasons.  First, it minimizes the overhead.  Second, real
systems that need DAMON are expected to be memory intensive enough to
cause periodic TLB flushes.  For test setups that use small test
workloads, however, the system's TLB could be big enough to cover whole
or most accesses of the test workload.  In this case, no page table walk
happens and DAMON cannot show any access from the test workload.

The test workload for DAMON's working set size estimation selftest is
such a case.  It accesses only 10 MiB working set, and it turned out
there are test setups that have TLBs large enough to cover the 10 MiB
data accesses.  As a result, the test fails depending on the test
machine.

Make it more reliable by trying larger working sets up to 160 MiB when
it fails.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 ...te_schemes_tried_regions_wss_estimation.py | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
index 90ad7409a7a6..bf48ef8e5241 100755
--- a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
@@ -6,9 +6,8 @@ import time
 
 import _damon_sysfs
 
-def main():
-    # access two 10 MiB memory regions, 2 second per each
-    sz_region = 10 * 1024 * 1024
+def pass_wss_estimation(sz_region):
+    # access two regions of given size, 2 seocnds per each region
     proc = subprocess.Popen(['./access_memory', '2', '%d' % sz_region, '2000'])
     kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
             contexts=[_damon_sysfs.DamonCtx(
@@ -36,20 +35,38 @@ def main():
 
         wss_collected.append(
                 kdamonds.kdamonds[0].contexts[0].schemes[0].tried_bytes)
+    err = kdamonds.stop()
+    if err is not None:
+        print('kdamond stop failed: %s' % err)
+        exit(1)
 
     wss_collected.sort()
     acceptable_error_rate = 0.2
     for percentile in [50, 75]:
         sample = wss_collected[int(len(wss_collected) * percentile / 100)]
         error_rate = abs(sample - sz_region) / sz_region
-        print('%d-th percentile (%d) error %f' %
-                (percentile, sample, error_rate))
+        print('%d-th percentile error %f (expect %d, result %d)' %
+                (percentile, error_rate, sz_region, sample))
         if error_rate > acceptable_error_rate:
             print('the error rate is not acceptable (> %f)' %
                     acceptable_error_rate)
             print('samples are as below')
             print('\n'.join(['%d' % wss for wss in wss_collected]))
-            exit(1)
+            return False
+    return True
+
+def main():
+    # DAMON doesn't flush TLB.  If the system has large TLB that can cover
+    # whole test working set, DAMON cannot see the access.  Test up to 160 MiB
+    # test working set.
+    sz_region_mb = 10
+    max_sz_region_mb = 160
+    while sz_region_mb <= max_sz_region_mb:
+        test_pass = pass_wss_estimation(sz_region_mb * 1024 * 1024)
+        if test_pass is True:
+            exit(0)
+        sz_region_mb *= 2
+    exit(1)
 
 if __name__ == '__main__':
     main()
-- 
2.47.3

