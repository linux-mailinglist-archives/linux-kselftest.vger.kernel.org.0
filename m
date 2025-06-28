Return-Path: <linux-kselftest+bounces-36064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C433EAEC87F
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 18:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1AF17AC7C2
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DEA2571C9;
	Sat, 28 Jun 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWThUJGM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657024E4D4;
	Sat, 28 Jun 2025 16:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751126677; cv=none; b=EFGk9NEon6Eic3Vti8ROF3QGvRmlSqbszMdk1ljV/RD4dV0x9JGC247+yqev0KaEqxZcFkqZI5kbJOyMVD6+Z61582JLS9H3lMePa81OkqP9L5C2phLsEisayuW8k8MQHcZaO0/WlyWKB5T0FNDtSOd1zMtSBjHnrjEFXl79ZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751126677; c=relaxed/simple;
	bh=pHn9v+99jI3xSiVYbi8lj20xdzjr33kYRD7kjoO8nBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=juJ0+eAQLS9fI+Wt/nEY1vAYkTwPfAX4r6G9R48IpFiBK+zLraiuqHwLOly646UXnVEhNyprO1o4d1lk0GcttpyKm+q2Xm5LaDy6ICLZbwrg19aYsI4r2k7ncZ/ZXOPTkCvyWk/+qjbPal1F4GiImC48upmfh+BGNRATUEx50pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWThUJGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB55C4CEED;
	Sat, 28 Jun 2025 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751126675;
	bh=pHn9v+99jI3xSiVYbi8lj20xdzjr33kYRD7kjoO8nBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWThUJGMxmZ9QzBclE+lbiYiSfrIsn1T9tlYlp/FqQuMJEPPDcqepJN5XeHpDzReE
	 PbqAfvW6Tz0uWXRMGKGVWitby+edQLBAdIX+OM6V5Z6hcz/OHdQqhqMqmfWemabo8E
	 ohCL68eUSjTEY3Pl3v5tmov4J7y2Px5Qkr3MV5BcXBLeydm1fsxgWvl/8U2mlqb8KA
	 /Mw03VzTki158ViwLNhGTTYnawJ3IjsesAyW7bSZsnhdG7nZEEZuRSHxMJCDvFNqF/
	 /KJlLrAYYf58jIK+TlENvlqR463iTv4F7uu9le17ti5hEpp6FINPJeOw70IX7owwYT
	 b2yu8eZO/kzPA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/6] selftests/damon: add python and drgn-based DAMON sysfs test
Date: Sat, 28 Jun 2025 09:04:25 -0700
Message-Id: <20250628160428.53115-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628160428.53115-1-sj@kernel.org>
References: <20250628160428.53115-1-sj@kernel.org>
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

