Return-Path: <linux-kselftest+bounces-9270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C93E8B9F79
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 19:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61ABEB2110B
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 17:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03C616FF4E;
	Thu,  2 May 2024 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emslM5hH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8816FF4A;
	Thu,  2 May 2024 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670848; cv=none; b=pHfQeWx2tpJ8EYmEugKis1Y7I8GUdnlM3xVFwMj/AwYJoZrGtaS7ecFJrNQx0qrVtL06+Yy5v3Z/AdmIFr5/dAqoBcO6gdTsySDD+NuIA7BUd/lQ+KGReEBkafAe9pumHTHnxGMSpX4gm2QueVyFVM2maGVqxRyi7Upxw8bSW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670848; c=relaxed/simple;
	bh=I63TfrbmSoQUarN68hoe/QgcSHNL3XEpjAZInckdvxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J4dtsrYVrGxAOeWELjWEUJVYisdeEMu9PO1uMIWUzjpD/WCzue+sZLFEKBq6RFYdmIjW/az/3j0QEv3OyERwQoGBe8Y2h01CYzOa6skzJ2zDbfLK8X8ZubtZYaeB+yPx+kGuyKgDAqqDMTAhrmu6Y0JHCw05mHEqyHPnUvX1QnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emslM5hH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D968FC116B1;
	Thu,  2 May 2024 17:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714670848;
	bh=I63TfrbmSoQUarN68hoe/QgcSHNL3XEpjAZInckdvxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=emslM5hHuculQgVIbvMTNrFTk3RZwSIu8woc1S4l3D/94fuVqnsBkJskI7EjqgWLe
	 nkqk5Lvp5XtUQz4fCj4sY9TesHcQHaXUHNk3/iWeSPhXYfcqNoDvPppp5m1ZbSP4tK
	 RfH5dADAd16/4hgmBvnFlmhsKW+oMVvcNvCbmonxzF3/0LtkHyciHHQ97ZLDLQRP+z
	 CQa0Q9FFYoV87VTLt0yZQSne+eizUoT7nMHcXbUeIIMeOByFQqQVjJTrkAX+sAIY+0
	 uyBWbxpGRlZhRSZ7OnqdZfF0QbMbLgV50lkih2A2xhxJekKKUl95GTcHPiM1GCgrmx
	 SM/KNBRqSUw9w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests/damon/_damon_sysfs: support quota goals
Date: Thu,  2 May 2024 10:27:17 -0700
Message-Id: <20240502172718.74166-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502172718.74166-1-sj@kernel.org>
References: <20240502172718.74166-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DAMON sysfs test purpose wrapper, _damon_sysfs.py, is not supporting
quota goals.  Implement the support for testing the feature.  The test
will be implemented and added by the following commit.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 84 ++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index d23d7398a27a..f80fdcef507c 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -70,16 +70,56 @@ class DamosAccessPattern:
         if err != None:
             return err
 
+qgoal_metric_user_input = 'user_input'
+qgoal_metric_some_mem_psi_us = 'some_mem_psi_us'
+qgoal_metrics = [qgoal_metric_user_input, qgoal_metric_some_mem_psi_us]
+
+class DamosQuotaGoal:
+    metric = None
+    target_value = None
+    current_value = None
+    effective_bytes = None
+    quota = None            # owner quota
+    idx = None
+
+    def __init__(self, metric, target_value=10000, current_value=0):
+        self.metric = metric
+        self.target_value = target_value
+        self.current_value = current_value
+
+    def sysfs_dir(self):
+        return os.path.join(self.quota.sysfs_dir(), 'goals', '%d' % self.idx) 
+
+    def stage(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'target_metric'),
+                         self.metric)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'target_value'),
+                         self.target_value)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'current_value'),
+                         self.current_value)
+        if err is not None:
+            return err
+        return None
+
 class DamosQuota:
     sz = None                   # size quota, in bytes
     ms = None                   # time quota
+    goals = None                # quota goals
     reset_interval_ms = None    # quota reset interval
     scheme = None               # owner scheme
 
-    def __init__(self, sz=0, ms=0, reset_interval_ms=0):
+    def __init__(self, sz=0, ms=0, goals=None, reset_interval_ms=0):
         self.sz = sz
         self.ms = ms
         self.reset_interval_ms = reset_interval_ms
+        self.goals = goals if goals is not None else []
+        for idx, goal in enumerate(self.goals):
+            goal.idx = idx
+            goal.quota = self
 
     def sysfs_dir(self):
         return os.path.join(self.scheme.sysfs_dir(), 'quotas')
@@ -96,6 +136,20 @@ class DamosQuota:
         if err != None:
             return err
 
+        nr_goals_file = os.path.join(self.sysfs_dir(), 'goals', 'nr_goals')
+        content, err = read_file(nr_goals_file)
+        if err is not None:
+            return err
+        if int(content) != len(self.goals):
+            err = write_file(nr_goals_file, len(self.goals))
+            if err is not None:
+                return err
+        for goal in self.goals:
+            err = goal.stage()
+            if err is not None:
+                return err
+        return None
+
 class DamosStats:
     nr_tried = None
     sz_tried = None
@@ -361,6 +415,34 @@ class Kdamond:
                     stat_values.append(int(content))
                 scheme.stats = DamosStats(*stat_values)
 
+    def update_schemes_effective_quotas(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'state'),
+                         'update_schemes_effective_quotas')
+        if err is not None:
+            return err
+        for context in self.contexts:
+            for scheme in context.schemes:
+                for goal in scheme.quota.goals:
+                    content, err = read_file(
+                            os.path.join(scheme.quota.sysfs_dir(),
+                                         'effective_bytes'))
+                    if err is not None:
+                        return err
+                    goal.effective_bytes = int(content)
+        return None
+
+    def commit_schemes_quota_goals(self):
+        for context in self.contexts:
+            for scheme in context.schemes:
+                for goal in scheme.quota.goals:
+                    err = goal.stage()
+                    if err is not None:
+                        print('commit_schemes_quota_goals failed stagign: %s'%
+                              err)
+                        exit(1)
+        return write_file(os.path.join(self.sysfs_dir(), 'state'),
+                         'commit_schemes_quota_goals')
+
 class Kdamonds:
     kdamonds = []
 
-- 
2.39.2


