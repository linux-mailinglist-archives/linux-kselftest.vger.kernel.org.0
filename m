Return-Path: <linux-kselftest+bounces-37690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0E6B0B71A
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179201897F81
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8085122331C;
	Sun, 20 Jul 2025 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulFZUcOD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A3F1CFBC;
	Sun, 20 Jul 2025 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031820; cv=none; b=VKuScW9/7cfNRimwg755TPoR08xIpKEHDO0nxEXbSaMWdUEuXAtXCx6YTGhXCIUOQSWXnSHAeM+iDirLgVpxm7ul8VeKwYQTZJXbqEqzpukATYnUKfPPWHZbD+w7SKws0LP4DgNzrB1fZLmyspbLttVJsCXwQZGcuU1vElLrfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031820; c=relaxed/simple;
	bh=BVyAzLCX6KSwysObZ8ul7hmIo/e9lFQwzRApis7bbiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gb50s3mRJPwCoK7yQKey094/oZtQRzywNwQnNn475JEdVi2bdhat5hu8pRXN/SHieKjIPQOp1k9CdgTpRD0ys/xZRY1xDp56D34KR3BJOidKtO00a+0jaKEWWYTXRCIlHnQGZv8Or3EoQxpGbRny4bXRz6H9bwPv5CEnxhFXnzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulFZUcOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA392C4CEEB;
	Sun, 20 Jul 2025 17:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031819;
	bh=BVyAzLCX6KSwysObZ8ul7hmIo/e9lFQwzRApis7bbiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ulFZUcODLpOMEYtvJpC61dzm4lP1iy1rSRQhLhR0nEwW63Pvw5d3uofFF+LMgYtCS
	 zFrxo2XGaM9YHjZEnffrS6jGX4DAXMLW7F1soW1I3lqNqzX91N3Qz4xuyTY4UfTk5+
	 RzfXFLHZxDzpCW1GAgRoL35C2b5rCbMfUTc/RB1oe64DwakaIJKj0yVYb3zM76Fp5+
	 b4cM1cz585DVySH/gGJsFIqlcLKsZx7C3erhl8dlUUC0eXnIE1equ4t7bxnRWy7JvH
	 P9nMtXUFYmHlj/m5JGmZR2+Qr8Wwyz7WqU9zqRT7NJ7of8QiBfhJg9xigc7KqZ+E/y
	 GJS1lI8pFRgvQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/22] selftests/damon/_damon_sysfs: support monitoring intervals goal setup
Date: Sun, 20 Jul 2025 10:16:33 -0700
Message-Id: <20250720171652.92309-4-sj@kernel.org>
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
control.  Add support of the monitoring intervals auto-tune goal setup
for more tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 43 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index f853af6ad926..ec6230929d36 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -405,18 +405,56 @@ class DamonTarget:
         return write_file(
                 os.path.join(self.sysfs_dir(), 'pid_target'), self.pid)
 
+class IntervalsGoal:
+    access_bp = None
+    aggrs = None
+    min_sample_us = None
+    max_sample_us = None
+    attrs = None    # owner DamonAttrs
+
+    def __init__(self, access_bp=0, aggrs=0, min_sample_us=0, max_sample_us=0):
+        self.access_bp = access_bp
+        self.aggrs = aggrs
+        self.min_sample_us = min_sample_us
+        self.max_sample_us = max_sample_us
+
+    def sysfs_dir(self):
+        return os.path.join(self.attrs.interval_sysfs_dir(), 'intervals_goal')
+
+    def stage(self):
+        err = write_file(
+                os.path.join(self.sysfs_dir(), 'access_bp'), self.access_bp)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'aggrs'), self.aggrs)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'min_sample_us'),
+                         self.min_sample_us)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'max_sample_us'),
+                         self.max_sample_us)
+        if err is not None:
+            return err
+        return None
+
 class DamonAttrs:
     sample_us = None
     aggr_us = None
+    intervals_goal = None
     update_us = None
     min_nr_regions = None
     max_nr_regions = None
     context = None
 
-    def __init__(self, sample_us=5000, aggr_us=100000, update_us=1000000,
+    def __init__(self, sample_us=5000, aggr_us=100000,
+                 intervals_goal=IntervalsGoal(), update_us=1000000,
             min_nr_regions=10, max_nr_regions=1000):
         self.sample_us = sample_us
         self.aggr_us = aggr_us
+        self.intervals_goal = intervals_goal
+        self.intervals_goal.attrs = self
         self.update_us = update_us
         self.min_nr_regions = min_nr_regions
         self.max_nr_regions = max_nr_regions
@@ -436,6 +474,9 @@ class DamonAttrs:
             return err
         err = write_file(os.path.join(self.interval_sysfs_dir(), 'aggr_us'),
                 self.aggr_us)
+        if err is not None:
+            return err
+        err = self.intervals_goal.stage()
         if err is not None:
             return err
         err = write_file(os.path.join(self.interval_sysfs_dir(), 'update_us'),
-- 
2.39.5

