Return-Path: <linux-kselftest+bounces-37689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF4DB0B718
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47527AB94F
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4273A221F06;
	Sun, 20 Jul 2025 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksnNqjLw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177AA221D9E;
	Sun, 20 Jul 2025 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031819; cv=none; b=Fg60uX5pERqgorDrvkp6cHYnKfSp0r5snZX7p/W4DlBQpwz4iEEkhHLH3qcyu2Klu3TkFxNwUCe4dIvP+hpp0S0xMc5WrKVWwxHEl5irPtupiHMKmvWANxiHrxwYyfbGDu3ZRy2YZ2BPcoMXbMN90bb+j8M8nfkUXrVgRSMwJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031819; c=relaxed/simple;
	bh=8wvSMyV6CHpOMSi+h6VFlcgrNrlLEQXoEfGY0Ixxzx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pn9jpbC76FYNqv45btQxPPFhuNSCdXpWCQN7djTgV0wIXllfE9SA2Fbzya1DsR/7tIbtQu2UDAHvnRFNT1L5lqR/GWLoIqrQph0c5mCwLEy1OBeASFlPDdDo+6SJbBdTw12F32r5K0uBQysvlO9OYMjL2RXzwSWgYpw05YIqutk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksnNqjLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD02C4CEFB;
	Sun, 20 Jul 2025 17:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031818;
	bh=8wvSMyV6CHpOMSi+h6VFlcgrNrlLEQXoEfGY0Ixxzx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ksnNqjLwmIBv9cprB+iVdxapHXYRWuHIv7lBatBbzqJAR6RM6AdrgVAKxmzKW6x4Z
	 fW42gGK6CTUxsEtYi0Xky7soUz555ekLZ+gRTDqvnqrkXDm+QAJHLCaj9R16A2CwYk
	 n1Glu/83kOe/MbdFwXxcXRY5uBWf2jCLfy/1eAMJaNrKAMqKHLwYJhTCBrIgbNp7IA
	 UUDryw9tzehM2o5YHjVkxvGX/poiaqb+/8zOIhLeLp3aWCHLHPotLSU0YEe4K61uRm
	 Pg9w4l7EY2fmUfyqZyiUUqqUmm2osn93UsKCiAWeOww+rU4va9Fi19dogD19FDzq2S
	 /qR8vqVBB3rzg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/22] selftests/damon/_damon_sysfs: support DAMOS filters setup
Date: Sun, 20 Jul 2025 10:16:32 -0700
Message-Id: <20250720171652.92309-3-sj@kernel.org>
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
control.  Add support of DAMOS filters setup for more tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 115 +++++++++++++++++-
 1 file changed, 111 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index d81aa11e3d32..f853af6ad926 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -201,6 +201,96 @@ class DamosWatermarks:
         if err is not None:
             return err
 
+class DamosFilter:
+    type_ = None
+    matching = None
+    allow = None
+    memcg_path = None
+    addr_start = None
+    addr_end = None
+    target_idx = None
+    min_ = None
+    max_ = None
+    idx = None
+    filters = None  # owner filters
+
+    def __init__(self, type_='anon', matching=False, allow=False,
+                 memcg_path='', addr_start=0, addr_end=0, target_idx=0, min_=0,
+                 max_=0):
+        self.type_ = type_
+        self.matching = matching
+        self.allow = allow
+        self.memcg_path = memcg_path,
+        self.addr_start = addr_start
+        self.addr_end = addr_end
+        self.target_idx = target_idx
+        self.min_ = min_
+        self.max_ = max_
+
+    def sysfs_dir(self):
+        return os.path.join(self.filters.sysfs_dir(), '%d' % self.idx)
+
+    def stage(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'type'), self.type_)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'matching'),
+                         self.matching)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'allow'), self.allow)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'memcg_path'),
+                         self.memcg_path)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'addr_start'),
+                         self.addr_start)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'addr_end'),
+                         self.addr_end)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'damon_target_idx'),
+                         self.target_idx)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'min'), self.min_)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'max'), self.max_)
+        if err is not None:
+            return err
+        return None
+
+class DamosFilters:
+    name = None
+    filters = None
+    scheme = None   # owner scheme
+
+    def __init__(self, name, filters=[]):
+        self.name = name
+        self.filters = filters
+        for idx, filter_ in enumerate(self.filters):
+            filter_.idx = idx
+            filter_.filters = self
+
+    def sysfs_dir(self):
+        return os.path.join(self.scheme.sysfs_dir(), self.name)
+
+    def stage(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'nr_filters'),
+                         len(self.filters))
+        if err is not None:
+            return err
+        for filter_ in self.filters:
+            err = filter_.stage()
+            if err is not None:
+                return err
+        return None
+
 class DamosStats:
     nr_tried = None
     sz_tried = None
@@ -227,8 +317,10 @@ class Damos:
     access_pattern = None
     quota = None
     watermarks = None
+    core_filters = None
+    ops_filters = None
+    filters = None
     apply_interval_us = None
-    # todo: Support watermarks, stats
     idx = None
     context = None
     tried_bytes = None
@@ -237,6 +329,7 @@ class Damos:
 
     def __init__(self, action='stat', access_pattern=DamosAccessPattern(),
                  quota=DamosQuota(), watermarks=DamosWatermarks(),
+                 core_filters=[], ops_filters=[], filters=[],
                  apply_interval_us=0):
         self.action = action
         self.access_pattern = access_pattern
@@ -245,6 +338,16 @@ class Damos:
         self.quota.scheme = self
         self.watermarks = watermarks
         self.watermarks.scheme = self
+
+        self.core_filters = DamosFilters(name='core_filters',
+                                         filters=core_filters)
+        self.core_filters.scheme = self
+        self.ops_filters = DamosFilters(name='ops_filters',
+                                         filters=ops_filters)
+        self.ops_filters.scheme = self
+        self.filters = DamosFilters(name='filters', filters=filters)
+        self.filters.scheme = self
+
         self.apply_interval_us = apply_interval_us
 
     def sysfs_dir(self):
@@ -271,9 +374,13 @@ class Damos:
         if err is not None:
             return err
 
-        # disable filters
-        err = write_file(
-                os.path.join(self.sysfs_dir(), 'filters', 'nr_filters'), '0')
+        err = self.core_filters.stage()
+        if err is not None:
+            return err
+        err = self.ops_filters.stage()
+        if err is not None:
+            return err
+        err = self.filters.stage()
         if err is not None:
             return err
 
-- 
2.39.5

