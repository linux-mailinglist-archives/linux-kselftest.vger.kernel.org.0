Return-Path: <linux-kselftest+bounces-1701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB6080F634
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78601281F69
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01AA81E21;
	Tue, 12 Dec 2023 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRYglFPH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3080053;
	Tue, 12 Dec 2023 19:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0459C433CA;
	Tue, 12 Dec 2023 19:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702408335;
	bh=DR2Fa3ovjeZyoem+oDl1suN899iJhJUC8UTSzsABCII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRYglFPHtFeydr48Km9Sa9erA75e8UthD942v4D8hIgASGiY2dwkC4QPS0tMb9Gcr
	 9e2sSgB1CAt6n4QLv8UCVbDWbcOw6TbbftaAttRkPsNY82glveOXuyIzrqT3T85D8c
	 isiteR6bbcdJbOmGNTNw4+eY0U/SNqwAnB2f0vaneU2EigtbDeED26FrMoPMcIEHwe
	 3vstJeiNPH1GEP96vBMXZ6C0hZ2L9Y1ZlrfwWCqZEFyUvc0HyyBG4a9plrX1lETL7F
	 /QYp97YiJKgnXVIy0g5DDefUk3RrahxMjmtj6c4K/VEoC7nXueQd0yeepxcdwX0uHe
	 Et1+MU2vMFUUw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] selftests/damon/_damon_sysfs: implement kdamonds start function
Date: Tue, 12 Dec 2023 19:12:03 +0000
Message-Id: <20231212191206.52917-3-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212191206.52917-1-sj@kernel.org>
References: <20231212191206.52917-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the tests-writing-purpose DAMON sysfs control module to support
the kdamonds start functionality.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 206 ++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 78101846ab66..6b99f87a5f1e 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -1,5 +1,28 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import os
+
+sysfs_root = '/sys/kernel/mm/damon/admin'
+
+def write_file(path, string):
+    "Returns error string if failed, or None otherwise"
+    string = '%s' % string
+    try:
+        with open(path, 'w') as f:
+            f.write(string)
+    except Exception as e:
+        return '%s' % e
+    return None
+
+def read_file(path):
+    '''Returns the read content and error string.  The read content is None if
+    the reading failed'''
+    try:
+        with open(path, 'r') as f:
+            return f.read(), None
+    except Exception as e:
+        return None, '%s' % e
+
 class DamosAccessPattern:
     size = None
     nr_accesses = None
@@ -18,6 +41,35 @@ class DamosAccessPattern:
         if self.age == None:
             self.age = [0, 2**64 - 1]
 
+    def sysfs_dir(self):
+        return os.path.join(self.scheme.sysfs_dir(), 'access_pattern')
+
+    def stage(self):
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'sz', 'min'), self.size[0])
+        if err != None:
+            return err
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'sz', 'max'), self.size[1])
+        if err != None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'nr_accesses', 'min'),
+                self.nr_accesses[0])
+        if err != None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'nr_accesses', 'max'),
+                self.nr_accesses[1])
+        if err != None:
+            return err
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'age', 'min'), self.age[0])
+        if err != None:
+            return err
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'age', 'max'), self.age[1])
+        if err != None:
+            return err
+
 class Damos:
     action = None
     access_pattern = None
@@ -30,6 +82,39 @@ class Damos:
         self.access_pattern = access_pattern
         self.access_pattern.scheme = self
 
+    def sysfs_dir(self):
+        return os.path.join(
+                self.context.sysfs_dir(), 'schemes', '%d' % self.idx)
+
+    def stage(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'action'), self.action)
+        if err != None:
+            return err
+        err = self.access_pattern.stage()
+        if err != None:
+            return err
+
+        # disable quotas
+        err = write_file(os.path.join(self.sysfs_dir(), 'quotas', 'ms'), '0')
+        if err != None:
+            return err
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'quotas', 'bytes'), '0')
+        if err != None:
+            return err
+
+        # disable watermarks
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'watermarks', 'metric'), 'none')
+        if err != None:
+            return err
+
+        # disable filters
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'filters', 'nr_filters'), '0')
+        if err != None:
+            return err
+
 class DamonTarget:
     pid = None
     # todo: Support target regions if test is made
@@ -39,6 +124,18 @@ class DamonTarget:
     def __init__(self, pid):
         self.pid = pid
 
+    def sysfs_dir(self):
+        return os.path.join(
+                self.context.sysfs_dir(), 'targets', '%d' % self.idx)
+
+    def stage(self):
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'regions', 'nr_regions'), '0')
+        if err != None:
+            return err
+        return write_file(
+                os.path.join(self.sysfs_dir(), 'pid_target'), self.pid)
+
 class DamonAttrs:
     sample_us = None
     aggr_us = None
@@ -55,6 +152,40 @@ class DamonAttrs:
         self.min_nr_regions = min_nr_regions
         self.max_nr_regions = max_nr_regions
 
+    def interval_sysfs_dir(self):
+        return os.path.join(self.context.sysfs_dir(), 'monitoring_attrs',
+                'intervals')
+
+    def nr_regions_range_sysfs_dir(self):
+        return os.path.join(self.context.sysfs_dir(), 'monitoring_attrs',
+                'nr_regions')
+
+    def stage(self):
+        err = write_file(os.path.join(self.interval_sysfs_dir(), 'sample_us'),
+                self.sample_us)
+        if err != None:
+            return err
+        err = write_file(os.path.join(self.interval_sysfs_dir(), 'aggr_us'),
+                self.aggr_us)
+        if err != None:
+            return err
+        err = write_file(os.path.join(self.interval_sysfs_dir(), 'update_us'),
+                self.update_us)
+        if err != None:
+            return err
+
+        err = write_file(
+                os.path.join(self.nr_regions_range_sysfs_dir(), 'min'),
+                self.min_nr_regions)
+        if err != None:
+            return err
+
+        err = write_file(
+                os.path.join(self.nr_regions_range_sysfs_dir(), 'max'),
+                self.max_nr_regions)
+        if err != None:
+            return err
+
 class DamonCtx:
     ops = None
     monitoring_attrs = None
@@ -79,6 +210,46 @@ class DamonCtx:
             scheme.idx = idx
             scheme.context = self
 
+    def sysfs_dir(self):
+        return os.path.join(self.kdamond.sysfs_dir(), 'contexts',
+                '%d' % self.idx)
+
+    def stage(self):
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'operations'), self.ops)
+        if err != None:
+            return err
+        err = self.monitoring_attrs.stage()
+        if err != None:
+            return err
+
+        nr_targets_file = os.path.join(
+                self.sysfs_dir(), 'targets', 'nr_targets')
+        content, err = read_file(nr_targets_file)
+        if err != None:
+            return err
+        if int(content) != len(self.targets):
+            err = write_file(nr_targets_file, '%d' % len(self.targets))
+            if err != None:
+                return err
+        for target in self.targets:
+            err = target.stage()
+            if err != None:
+                return err
+
+        nr_schemes_file = os.path.join(
+                self.sysfs_dir(), 'schemes', 'nr_schemes')
+        content, err = read_file(nr_schemes_file)
+        if int(content) != len(self.schemes):
+            err = write_file(nr_schemes_file, '%d' % len(self.schemes))
+            if err != None:
+                return err
+        for scheme in self.schemes:
+            err = scheme.stage()
+            if err != None:
+                return err
+        return None
+
 class Kdamond:
     state = None
     pid = None
@@ -92,6 +263,27 @@ class Kdamond:
             context.idx = idx
             context.kdamond = self
 
+    def sysfs_dir(self):
+        return os.path.join(self.kdamonds.sysfs_dir(), '%d' % self.idx)
+
+    def start(self):
+        nr_contexts_file = os.path.join(self.sysfs_dir(),
+                'contexts', 'nr_contexts')
+        content, err = read_file(nr_contexts_file)
+        if err != None:
+            return err
+        if int(content) != len(self.contexts):
+            err = write_file(nr_contexts_file, '%d' % len(self.contexts))
+            if err != None:
+                return err
+
+        for context in self.contexts:
+            err = context.stage()
+            if err != None:
+                return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'state'), 'on')
+        return err
+
 class Kdamonds:
     kdamonds = []
 
@@ -100,3 +292,17 @@ class Kdamonds:
         for idx, kdamond in enumerate(self.kdamonds):
             kdamond.idx = idx
             kdamond.kdamonds = self
+
+    def sysfs_dir(self):
+        return os.path.join(sysfs_root, 'kdamonds')
+
+    def start(self):
+        err = write_file(os.path.join(self.sysfs_dir(),  'nr_kdamonds'),
+                '%s' % len(self.kdamonds))
+        if err != None:
+            return err
+        for kdamond in self.kdamonds:
+            err = kdamond.start()
+            if err != None:
+                return err
+        return None
-- 
2.34.1


