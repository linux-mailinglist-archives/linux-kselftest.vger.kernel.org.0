Return-Path: <linux-kselftest+bounces-9396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA68BB20D
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 20:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F27B231A0
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD0D158878;
	Fri,  3 May 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZA9XkNE+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC215886D;
	Fri,  3 May 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759405; cv=none; b=iG5buyECkrIPCsEQNYD1tN7ZQAl25fx/mTiarsHLP+E1SBG0ZRMi1T96wgceHp4P+Rs0OzydhghBrMdKJxAKQstUM8tGRzVH9xzoB16ESIBTy5ZPgnwwVVu/C+jgOZy58DCd8qW7KqpO+wZ+6yJKCprd7p2WOWWVqVkEdnwxI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759405; c=relaxed/simple;
	bh=O896s/BxYxzWe3ajbJ4BImY+pg58FthjeGXrHo/B0j4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cDIv9AoC1YlLz0W0p/Bag9AfA4L30vnJhewDWoY1r0r7hZQaTsUVQthP1Av4efoTiDVykSSGhQ7fFkKte9pi2HfcUu0giYnj8qHZz5ChrtKNzwvEsggpNMmAY7Mq7IH6UV10P/MtYbxOC+x4zigSjIGTsyMB2pUcOuVOUjw8FtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZA9XkNE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574DBC4AF19;
	Fri,  3 May 2024 18:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714759404;
	bh=O896s/BxYxzWe3ajbJ4BImY+pg58FthjeGXrHo/B0j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZA9XkNE+qEOq2aveG/dzoklGtVvPqKqMVRlrhy5FdFGRb1twcaqBmFuykp3wJR9Fz
	 V1gFei8V8hmOgx0Om3/MYS0lSOy1AmFTu18wzIOd+LjyNSmfNDrPVLX2kNVSBy91yc
	 OJXEjSWp0OSOWag8SUTM2g4O3TPJdk4QbqC302K/rzrAFORsQ/DHAGbR/5AM4D07/j
	 wsXXEp1fS6dT/bFqk4Cb6AD+nxljDwPENxHadwdLiXv6mOhzyASMhGYVtAMdAqKGbT
	 VkA8ok60PcpOl5uaeqqAJxKuTnP70hou30XOt2n1FQAuAmYZWLrLr7/dI3BlDVcrWy
	 cFi3wMLJSxP+A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] selftests/damon/_damon_sysfs: use 'is' instead of '==' for 'None'
Date: Fri,  3 May 2024 11:03:12 -0700
Message-Id: <20240503180318.72798-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503180318.72798-1-sj@kernel.org>
References: <20240503180318.72798-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_damon_sysfs.py is using '==' or '!=' for 'None'.  Since 'None' is a
singleton, using 'is' or 'is not' is more efficient.  Use the more
efficient one.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 80 +++++++++----------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 5367e98817a9..01d4b8022d50 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -45,11 +45,11 @@ class DamosAccessPattern:
         self.nr_accesses = nr_accesses
         self.age = age
 
-        if self.size == None:
+        if self.size is None:
             self.size = [0, 2**64 - 1]
-        if self.nr_accesses == None:
+        if self.nr_accesses is None:
             self.nr_accesses = [0, 2**64 - 1]
-        if self.age == None:
+        if self.age is None:
             self.age = [0, 2**64 - 1]
 
     def sysfs_dir(self):
@@ -58,27 +58,27 @@ class DamosAccessPattern:
     def stage(self):
         err = write_file(
                 os.path.join(self.sysfs_dir(), 'sz', 'min'), self.size[0])
-        if err != None:
+        if err is not None:
             return err
         err = write_file(
                 os.path.join(self.sysfs_dir(), 'sz', 'max'), self.size[1])
-        if err != None:
+        if err is not None:
             return err
         err = write_file(os.path.join(self.sysfs_dir(), 'nr_accesses', 'min'),
                 self.nr_accesses[0])
-        if err != None:
+        if err is not None:
             return err
         err = write_file(os.path.join(self.sysfs_dir(), 'nr_accesses', 'max'),
                 self.nr_accesses[1])
-        if err != None:
+        if err is not None:
             return err
         err = write_file(
                 os.path.join(self.sysfs_dir(), 'age', 'min'), self.age[0])
-        if err != None:
+        if err is not None:
             return err
         err = write_file(
                 os.path.join(self.sysfs_dir(), 'age', 'max'), self.age[1])
-        if err != None:
+        if err is not None:
             return err
 
 qgoal_metric_user_input = 'user_input'
@@ -137,14 +137,14 @@ class DamosQuota:
 
     def stage(self):
         err = write_file(os.path.join(self.sysfs_dir(), 'bytes'), self.sz)
-        if err != None:
+        if err is not None:
             return err
         err = write_file(os.path.join(self.sysfs_dir(), 'ms'), self.ms)
-        if err != None:
+        if err is not None:
             return err
         err = write_file(os.path.join(self.sysfs_dir(), 'reset_interval_ms'),
                          self.reset_interval_ms)
-        if err != None:
+        if err is not None:
             return err
 
         nr_goals_file = os.path.join(self.sysfs_dir(), 'goals', 'nr_goals')
@@ -201,30 +201,30 @@ class Damos:
 
     def stage(self):
         err = write_file(os.path.join(self.sysfs_dir(), 'action'), self.action)
-        if err != None:
+        if err is not None:
             return err
         err = self.access_pattern.stage()
-        if err != None:
+        if err is not None:
             return err
         err = write_file(os.path.join(self.sysfs_dir(), 'apply_interval_us'),
                          '%d' % self.apply_interval_us)
-        if err != None:
+        if err is not None:
             return err
 
         err = self.quota.stage()
-        if err != None:
+        if err is not None:
             return err
 
         # disable watermarks
         err = write_file(
                 os.path.join(self.sysfs_dir(), 'watermarks', 'metric'), 'none')
-        if err != None:
+        if err is not None:
             return err
 
         # disable filters
         err = write_file(
                 os.path.join(self.sysfs_dir(), 'filters', 'nr_filters'), '0')
-        if err != None:
+        if err is not None:
             return err
 
 class DamonTarget:
@@ -243,7 +243,7 @@ class DamonTarget:
     def stage(self):
         err = write_file(
                 os.path.join(self.sysfs_dir(), 'regions', 'nr_regions'), '0')
-        if err != None:
+        if err is not None:
             return err
         return write_file(
                 os.path.join(self.sysfs_dir(), 'pid_target'), self.pid)
@@ -275,27 +275,27 @@ class DamonAttrs:
     def stage(self):
         err = write_file(os.path.join(self.interval_sysfs_dir(), 'sample_us'),
                 self.sample_us)
-        if err != None:
+        if err is not None:
             return err
         err = write_file(os.path.join(self.interval_sysfs_dir(), 'aggr_us'),
                 self.aggr_us)
-        if err != None:
+        if err is not None:
             return err
         err = write_file(os.path.join(self.interval_sysfs_dir(), 'update_us'),
                 self.update_us)
-        if err != None:
+        if err is not None:
             return err
 
         err = write_file(
                 os.path.join(self.nr_regions_range_sysfs_dir(), 'min'),
                 self.min_nr_regions)
-        if err != None:
+        if err is not None:
             return err
 
         err = write_file(
                 os.path.join(self.nr_regions_range_sysfs_dir(), 'max'),
                 self.max_nr_regions)
-        if err != None:
+        if err is not None:
             return err
 
 class DamonCtx:
@@ -329,24 +329,24 @@ class DamonCtx:
     def stage(self):
         err = write_file(
                 os.path.join(self.sysfs_dir(), 'operations'), self.ops)
-        if err != None:
+        if err is not None:
             return err
         err = self.monitoring_attrs.stage()
-        if err != None:
+        if err is not None:
             return err
 
         nr_targets_file = os.path.join(
                 self.sysfs_dir(), 'targets', 'nr_targets')
         content, err = read_file(nr_targets_file)
-        if err != None:
+        if err is not None:
             return err
         if int(content) != len(self.targets):
             err = write_file(nr_targets_file, '%d' % len(self.targets))
-            if err != None:
+            if err is not None:
                 return err
         for target in self.targets:
             err = target.stage()
-            if err != None:
+            if err is not None:
                 return err
 
         nr_schemes_file = os.path.join(
@@ -356,11 +356,11 @@ class DamonCtx:
             return err
         if int(content) != len(self.schemes):
             err = write_file(nr_schemes_file, '%d' % len(self.schemes))
-            if err != None:
+            if err is not None:
                 return err
         for scheme in self.schemes:
             err = scheme.stage()
-            if err != None:
+            if err is not None:
                 return err
         return None
 
@@ -384,16 +384,16 @@ class Kdamond:
         nr_contexts_file = os.path.join(self.sysfs_dir(),
                 'contexts', 'nr_contexts')
         content, err = read_file(nr_contexts_file)
-        if err != None:
+        if err is not None:
             return err
         if int(content) != len(self.contexts):
             err = write_file(nr_contexts_file, '%d' % len(self.contexts))
-            if err != None:
+            if err is not None:
                 return err
 
         for context in self.contexts:
             err = context.stage()
-            if err != None:
+            if err is not None:
                 return err
         err = write_file(os.path.join(self.sysfs_dir(), 'state'), 'on')
         return err
@@ -401,20 +401,20 @@ class Kdamond:
     def update_schemes_tried_bytes(self):
         err = write_file(os.path.join(self.sysfs_dir(), 'state'),
                 'update_schemes_tried_bytes')
-        if err != None:
+        if err is not None:
             return err
         for context in self.contexts:
             for scheme in context.schemes:
                 content, err = read_file(os.path.join(scheme.sysfs_dir(),
                     'tried_regions', 'total_bytes'))
-                if err != None:
+                if err is not None:
                     return err
                 scheme.tried_bytes = int(content)
 
     def update_schemes_stats(self):
         err = write_file(os.path.join(self.sysfs_dir(), 'state'),
                 'update_schemes_stats')
-        if err != None:
+        if err is not None:
             return err
         for context in self.contexts:
             for scheme in context.schemes:
@@ -423,7 +423,7 @@ class Kdamond:
                              'sz_applied', 'qt_exceeds']:
                     content, err = read_file(
                             os.path.join(scheme.sysfs_dir(), 'stats', stat))
-                    if err != None:
+                    if err is not None:
                         return err
                     stat_values.append(int(content))
                 scheme.stats = DamosStats(*stat_values)
@@ -471,10 +471,10 @@ class Kdamonds:
     def start(self):
         err = write_file(os.path.join(self.sysfs_dir(),  'nr_kdamonds'),
                 '%s' % len(self.kdamonds))
-        if err != None:
+        if err is not None:
             return err
         for kdamond in self.kdamonds:
             err = kdamond.start()
-            if err != None:
+            if err is not None:
                 return err
         return None
-- 
2.39.2


