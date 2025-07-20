Return-Path: <linux-kselftest+bounces-37688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA25B0B716
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7301897EFC
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE8C22069E;
	Sun, 20 Jul 2025 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYPoLVmZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E621E0BB;
	Sun, 20 Jul 2025 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031818; cv=none; b=Bq7QZkR+J9pg+JrB+2rwpnZScOqqB+i5H4ts72na4Zb1yoSrhNcoRho4nQWlv3szpgikpysyeGkSDTfdN5uQBqQPxrU2R6SGIvQHgB6Pxi43YVIA5ogKF1TLjHhBTqkEHwNkOkaAJhtV6o7qgV2wdDeTHf5i6jb/EMNxNaCoSzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031818; c=relaxed/simple;
	bh=klDlVkBZ+5xmWtK4VLtAAS75LNGvyVGfZkSj3ruHlzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KLIhbbJczK8acI7yNnnmDYiC/EOBbx7uzWm2z5AnZPVQvi1NUQpcsvX5SKyZcmwHSTPzm/ueXYZ8PqtRbJ+OilCOOmcbN/k3TEFgJxwDHOguSF6Oj9pDVnyyWJJg/FnO+PCnRXzuGmwg9mmEbIhcGalO+UXKvr6SeSmqRau9bWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYPoLVmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50D0C4AF09;
	Sun, 20 Jul 2025 17:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031817;
	bh=klDlVkBZ+5xmWtK4VLtAAS75LNGvyVGfZkSj3ruHlzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JYPoLVmZ8gR5HUNht4q8wFPW50+JhYMZrXs4ViXsVrCiVTi4Nt/Cae2cFYfOCYFv+
	 vIJIx5iFPDH4OpAb6gQ4OFS0+Ng9lv4mIxenqEsrEb2cg4AChTbjGZQOtvjt5xYLNO
	 ENvfKWzeoD7uwZef3jA3Cv0PjBTVX34Zw4PTVj0jh5sl54/nhbjvv2zwas5SI8pZOU
	 LqkJrHX36lWne5UmoJbVxan1l6phlqmPWtwaZnzwoPEGs8tlfbdaEgkfiWfvCciXIR
	 h5XYcBSNxlwsda+AveNViem7AnqY4xk4ZWLfKYtkOY5jxZninHl7KQdPm5uKnsDW+7
	 jOJwxwQZUtQcw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/22] selftests/damon/_damon_sysfs: support DAMOS watermarks setup
Date: Sun, 20 Jul 2025 10:16:31 -0700
Message-Id: <20250720171652.92309-2-sj@kernel.org>
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

_damon_sysfs.py contains code for test-purpose DAMON sysfs interface
control.  Add support of DAMOS watermarks setup for more tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 46 +++++++++++++++++--
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index f587e117472e..d81aa11e3d32 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -165,6 +165,42 @@ class DamosQuota:
                 return err
         return None
 
+class DamosWatermarks:
+    metric = None
+    interval = None
+    high = None
+    mid = None
+    low = None
+    scheme = None   # owner scheme
+
+    def __init__(self, metric='none', interval=0, high=0, mid=0, low=0):
+        self.metric = metric
+        self.interval = interval
+        self.high = high
+        self.mid = mid
+        self.low = low
+
+    def sysfs_dir(self):
+        return os.path.join(self.scheme.sysfs_dir(), 'watermarks')
+
+    def stage(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'metric'), self.metric)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'interval_us'),
+                         self.interval)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'high'), self.high)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'mid'), self.mid)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'low'), self.low)
+        if err is not None:
+            return err
+
 class DamosStats:
     nr_tried = None
     sz_tried = None
@@ -190,6 +226,7 @@ class Damos:
     action = None
     access_pattern = None
     quota = None
+    watermarks = None
     apply_interval_us = None
     # todo: Support watermarks, stats
     idx = None
@@ -199,12 +236,15 @@ class Damos:
     tried_regions = None
 
     def __init__(self, action='stat', access_pattern=DamosAccessPattern(),
-                 quota=DamosQuota(), apply_interval_us=0):
+                 quota=DamosQuota(), watermarks=DamosWatermarks(),
+                 apply_interval_us=0):
         self.action = action
         self.access_pattern = access_pattern
         self.access_pattern.scheme = self
         self.quota = quota
         self.quota.scheme = self
+        self.watermarks = watermarks
+        self.watermarks.scheme = self
         self.apply_interval_us = apply_interval_us
 
     def sysfs_dir(self):
@@ -227,9 +267,7 @@ class Damos:
         if err is not None:
             return err
 
-        # disable watermarks
-        err = write_file(
-                os.path.join(self.sysfs_dir(), 'watermarks', 'metric'), 'none')
+        err = self.watermarks.stage()
         if err is not None:
             return err
 
-- 
2.39.5

