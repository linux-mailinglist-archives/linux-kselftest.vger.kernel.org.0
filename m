Return-Path: <linux-kselftest+bounces-4276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30DC84D2FD
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 21:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DDD28E698
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 20:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163821EA6E;
	Wed,  7 Feb 2024 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lx8mnNCB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3B01DFCF;
	Wed,  7 Feb 2024 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337902; cv=none; b=Y5ptnmAGeCePnxTmXtRU8u8RyVkGEjksqNZlfqFICbHsfKxU9ik/PTMZZzRxzhDZ4POb3wsQ4F+Iq8BBWDklO6DbGvQMuGujjgr6yUnHq74vhYW67VoGZiqE87Ie7PubU6rNnP37Nchog1uYkVQYsnKDfWlPAGCzfrMcod/67M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337902; c=relaxed/simple;
	bh=JQERS+AD7eJcXPmEIi+Gcjav4/4TJSgTRdHhSGiTeC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a48RB+kQZnQ9//V/P3YOPiUZX8bp9UlB4FP2BgHyWRkecDdXk6kDaSBt1Kh0RnHjH8Bw6j9KtvUN7iDDbFxTgfZu+XEpMn+wqu6KeWa9BdmJ/pP1+QcGuT7e33Bp49W8bCf8zCJsOvDQZvku7OfJO2tC655xKmqXh/I8zegAipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lx8mnNCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27297C43390;
	Wed,  7 Feb 2024 20:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707337901;
	bh=JQERS+AD7eJcXPmEIi+Gcjav4/4TJSgTRdHhSGiTeC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lx8mnNCB3FWWVgO2+jRkTgucZGTLeSzoBIZ/EFuBxNFxGuPQ0D8MFrtTw7iwrE1Na
	 aFQEjvUUK4Yev4Dy6G++TsGO2kIx4pcqN7D3BLsUKIALU3zTZalx1xNnZcvJZPrvsF
	 H8gT8OKhTA4A5tPW6EPXK+ZEpjk546ZmS104vhzh4148PSKRj4FOzL6qNZZDwX/Vyh
	 kMtuD1aZQm/PWZwzbxHibyvmi6bSLIQiPQhoQniGkMI61KXBripkvkHUukfFQGYqvm
	 AlXLfX0IgWrj5f4KRCZMdu1nEmvG5U82kPY3ZAZt+zPUu8QkR+FMe1jcOaIyNuRbYm
	 +QowLnrkH/NMQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] selftests/damon/_damon_sysfs: support DAMOS quota
Date: Wed,  7 Feb 2024 12:31:27 -0800
Message-Id: <20240207203134.69976-2-sj@kernel.org>
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

Update the test-purpose DAMON sysfs control Python module to support
DAMOS quota.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 42 +++++++++++++++----
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index e98cf4b6a4b7..b4f6e385c564 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -70,18 +70,48 @@ class DamosAccessPattern:
         if err != None:
             return err
 
+class DamosQuota:
+    sz = None                   # size quota, in bytes
+    ms = None                   # time quota
+    reset_interval_ms = None    # quota reset interval
+    scheme = None               # owner scheme
+
+    def __init__(self, sz=0, ms=0, reset_interval_ms=0):
+        self.sz = sz
+        self.ms = ms
+        self.reset_interval_ms = reset_interval_ms
+
+    def sysfs_dir(self):
+        return os.path.join(self.scheme.sysfs_dir(), 'quotas')
+
+    def stage(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'bytes'), self.sz)
+        if err != None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'ms'), self.ms)
+        if err != None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'reset_interval_ms'),
+                         self.reset_interval_ms)
+        if err != None:
+            return err
+
 class Damos:
     action = None
     access_pattern = None
-    # todo: Support quotas, watermarks, stats, tried_regions
+    quota = None
+    # todo: Support watermarks, stats, tried_regions
     idx = None
     context = None
     tried_bytes = None
 
-    def __init__(self, action='stat', access_pattern=DamosAccessPattern()):
+    def __init__(self, action='stat', access_pattern=DamosAccessPattern(),
+                 quota=DamosQuota()):
         self.action = action
         self.access_pattern = access_pattern
         self.access_pattern.scheme = self
+        self.quota = quota
+        self.quota.scheme = self
 
     def sysfs_dir(self):
         return os.path.join(
@@ -94,13 +124,7 @@ class Damos:
         err = self.access_pattern.stage()
         if err != None:
             return err
-
-        # disable quotas
-        err = write_file(os.path.join(self.sysfs_dir(), 'quotas', 'ms'), '0')
-        if err != None:
-            return err
-        err = write_file(
-                os.path.join(self.sysfs_dir(), 'quotas', 'bytes'), '0')
+        err = self.quota.stage()
         if err != None:
             return err
 
-- 
2.39.2


