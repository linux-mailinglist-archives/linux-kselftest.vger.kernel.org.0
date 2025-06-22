Return-Path: <linux-kselftest+bounces-35580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3A5AE322C
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 23:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0158016F367
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 21:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45AE2206BE;
	Sun, 22 Jun 2025 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kt8oW8Ep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843A220686;
	Sun, 22 Jun 2025 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626218; cv=none; b=g3/aXP5WGAx1DGFEC0TQKq4PjH/kqZ40TvNnXXe9gWgYPF8EqPAN0JM8B1tfmKfp+IcBODH1QbOQtNPkyL8X/V4yn9pF/Tmg+jncQ9s+3warAL3TUohddQXnciOxpspPbZG08Fw/SxpvAr6Zfd5w9WaLOSQcdMmAIVpuCzZshXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626218; c=relaxed/simple;
	bh=pHn9v+99jI3xSiVYbi8lj20xdzjr33kYRD7kjoO8nBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TRnxYQnMEAmk7oCnvgJ93CnRXp2619R04Eux8YHUftVYGzia6w/1p8t9DuPvKjoK+R21YaOP0H6amHbkZKuGuXasynB5Q3zZ4QEC8Yj0SPfJHK18/SGwiJanA2fQb0va2Drkh3FUD9OTNzFNjTlcRB5YCMn0824VLsgOplaovu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kt8oW8Ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97BEC4CEF1;
	Sun, 22 Jun 2025 21:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750626218;
	bh=pHn9v+99jI3xSiVYbi8lj20xdzjr33kYRD7kjoO8nBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kt8oW8Epd/RneOTAgnbfU7Ap9ThPd4rWlYYJqr5Al1DnENKRGu3jCHwUHt7BjrLKn
	 Kt/U/OiaGp0Kq4tEf1sdmbDVm/xAu3SosutN2zj/pNU/Kdh9JHi68whff9F+4UkkC+
	 3+egOtK2NqWa2M9VixcD7IimNUNvO7Ro6z6n/pp1Di2c4ooeaP4w3DF1QGAsfwwG8Z
	 DU+bZQ0ToG+Ytddap7fw1s3lhq7wK3qTQAQIEmxU87Fq8VL8YxFtqxix2ypWhC5FgN
	 6BBoMPPzSgxDj2JzY7Ml0RwqZM2bF/Fbp680EFv4+IJEdJ643ODv08+G0+SYC6W1tc
	 rGQDZASdhSlHw==
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
Subject: [RFC PATCH 3/6] selftests/damon: add python and drgn-based DAMON sysfs test
Date: Sun, 22 Jun 2025 14:03:27 -0700
Message-Id: <20250622210330.40490-4-sj@kernel.org>
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

Add a python-written DAMON sysfs functionality selftest.  It sets DAMON
parameters using Python module _damon_sysfs, reads updated kernel
internal DAMON status and parameters using a 'drgn' script, namely
drgn_dump_damon_status.py, and compare if the resulted DAMON internal
status is as expected.  The test is very minimum at the moment.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/Makefile |  1 +
 tools/testing/selftests/damon/sysfs.py | 42 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100755 tools/testing/selftests/damon/sysfs.py

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index e888455e3cf8..5b230deb19e8 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -7,6 +7,7 @@ TEST_FILES = _damon_sysfs.py
 
 # functionality tests
 TEST_PROGS += sysfs.sh
+TEST_PROGS += sysfs.py
 TEST_PROGS += sysfs_update_schemes_tried_regions_wss_estimation.py
 TEST_PROGS += damos_quota.py damos_quota_goal.py damos_apply_interval.py
 TEST_PROGS += damos_tried_regions.py damon_nr_regions.py
diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
new file mode 100755
index 000000000000..4ff99db0d247
--- /dev/null
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -0,0 +1,42 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import json
+import os
+import subprocess
+
+import _damon_sysfs
+
+def dump_damon_status_dict(pid):
+    file_dir = os.path.dirname(os.path.abspath(__file__))
+    dump_script = os.path.join(file_dir, 'drgn_dump_damon_status.py')
+    rc = subprocess.call(['drgn', dump_script, pid, 'damon_dump_output'],
+                         stderr=subprocess.DEVNULL)
+    if rc != 0:
+        return None, 'drgn fail'
+    try:
+        with open('damon_dump_output', 'r') as f:
+            return json.load(f), None
+    except Exception as e:
+        return None, 'json.load fail (%s)' % e
+
+def main():
+    kdamonds = _damon_sysfs.Kdamonds(
+            [_damon_sysfs.Kdamond(contexts=[_damon_sysfs.DamonCtx()])])
+    err = kdamonds.start()
+    if err is not None:
+        print('kdamond start failed: %s' % err)
+        exit(1)
+
+    status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+    if err is not None:
+        print(err)
+        exit(1)
+
+    if len(status['contexts']) != 1:
+        print('number of contexts: %d' % len(status['contexts']))
+        exit(1)
+    kdamonds.stop()
+
+if __name__ == '__main__':
+    main()
-- 
2.39.5

