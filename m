Return-Path: <linux-kselftest+bounces-37693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B179B0B720
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FED8176119
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864712264B8;
	Sun, 20 Jul 2025 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UidaZlLp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC6E2264AD;
	Sun, 20 Jul 2025 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031823; cv=none; b=dP8gPxO3gFElFLjWLOhrj01tB3XVvNdnvsTeG/fp5PBfI14ZWxy3WZGZFvP8bpzDlugQ4OERSBsgVGcbLfytdI3LcwDEALn8LWxvCoyGthuE2wBsb1cQ6pEtOQ6rmZhChpTbwksGYizRHI/mnPZlCXdd7GQ3KgDnygEG8Mo1t0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031823; c=relaxed/simple;
	bh=XSthd9dlhJIV6ssLC4htorYpexWz5dqyUITsYAj+758=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ri+2eqVMhbfBSOmGFppw8YA87OHHnpy/A294UpH9u2BCc31c1KitI3BMYEoOezSZWkQ4scmbMu4TfZsF/ITX4Ys20LR3D+9RtypliTWXQo5UN8Rh8LlBhJFMWru5aWBYgyXJEtyn0wXn63olzi+x6W6thyQ7DcljNnSugf5tZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UidaZlLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DD4C4CEFA;
	Sun, 20 Jul 2025 17:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031823;
	bh=XSthd9dlhJIV6ssLC4htorYpexWz5dqyUITsYAj+758=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UidaZlLpAzxjA5v4RJcPbgi8JyTetTkgF1Gu4yNcVvzQTFtrqVCxriwR7VA8wIAwn
	 jFcaxzpuLy6oPpi6vvRKyxuneu69NtlaDdp6lL7awJhA88N3AWcsFskM40emcbh3HQ
	 p8w+vRb0QVUjHrgTU5RuXbwif1saOfXbvrYahk+poJoPkoY5N3GbuZ/VSnyCf/9OLB
	 2tGiUrJoN3AvGh97FJ2UYxUWERjQ3ACGpbdZbzCV18y0SRox0fBXWVIQs5TlIKaH7S
	 g348XUe2X19eJfw988sb41pj0YSnOVDJz4dWhd9c+YCgQTyKyaFvOS0LphfQn9mN+c
	 uUzFeulNteHCw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/22] selftests/damon/_damon_sysfs: support DAMOS action dests setup
Date: Sun, 20 Jul 2025 10:16:36 -0700
Message-Id: <20250720171652.92309-7-sj@kernel.org>
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
control.  Add support of DAMOS action destinations setup for more tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 56 ++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 23de9202b4e3..2d95ab564885 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -319,6 +319,52 @@ class DamosFilters:
                 return err
         return None
 
+class DamosDest:
+    id = None
+    weight = None
+    idx = None
+    dests = None    # owner dests
+
+    def __init__(self, id=0, weight=0):
+        self.id = id
+        self.weight = weight
+
+    def sysfs_dir(self):
+        return os.path.join(self.dests.sysfs_dir(), '%d' % self.idx)
+
+    def stage(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'id'), self.id)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'weight'), self.weight)
+        if err is not None:
+            return err
+        return None
+
+class DamosDests:
+    dests = None
+    scheme = None   # owner scheme
+
+    def __init__(self, dests=[]):
+        self.dests = dests
+        for idx, dest in enumerate(self.dests):
+            dest.idx = idx
+            dest.dests = self
+
+    def sysfs_dir(self):
+        return os.path.join(self.scheme.sysfs_dir(), 'dests')
+
+    def stage(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'nr_dests'),
+                         len(self.dests))
+        if err is not None:
+            return err
+        for dest in self.dests:
+            err = dest.stage()
+            if err is not None:
+                return err
+        return None
+
 class DamosStats:
     nr_tried = None
     sz_tried = None
@@ -349,6 +395,7 @@ class Damos:
     ops_filters = None
     filters = None
     apply_interval_us = None
+    dests = None
     idx = None
     context = None
     tried_bytes = None
@@ -358,7 +405,7 @@ class Damos:
     def __init__(self, action='stat', access_pattern=DamosAccessPattern(),
                  quota=DamosQuota(), watermarks=DamosWatermarks(),
                  core_filters=[], ops_filters=[], filters=[],
-                 apply_interval_us=0):
+                 dests=DamosDests(), apply_interval_us=0):
         self.action = action
         self.access_pattern = access_pattern
         self.access_pattern.scheme = self
@@ -376,6 +423,9 @@ class Damos:
         self.filters = DamosFilters(name='filters', filters=filters)
         self.filters.scheme = self
 
+        self.dests = dests
+        self.dests.scheme = self
+
         self.apply_interval_us = apply_interval_us
 
     def sysfs_dir(self):
@@ -412,6 +462,10 @@ class Damos:
         if err is not None:
             return err
 
+        err = self.dests.stage()
+        if err is not None:
+            return err
+
 class DamonTarget:
     pid = None
     # todo: Support target regions if test is made
-- 
2.39.5

