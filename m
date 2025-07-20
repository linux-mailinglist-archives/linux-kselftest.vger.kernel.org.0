Return-Path: <linux-kselftest+bounces-37694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FECB0B723
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B55B3BE3CA
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC81A22A7E2;
	Sun, 20 Jul 2025 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej57wPJM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF012288E3;
	Sun, 20 Jul 2025 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031824; cv=none; b=iXqnbfE1oXjJ/aH2lpDkdK8JAK5loO9meCCq6EZ855KBZok9rBnag5xSLU0XZ6WKQsHw38HGri08barfsqoOy35b7s58NWRRxPGX8pa1KJojJc4JDN3LSY8uat4kLy2zP6s6VNBOVTz5Bru306TR50IOf0TSYnpmS5YzqA0IOVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031824; c=relaxed/simple;
	bh=ZQzqfi/OS5yYOXrb3FU1Hs0VW2GsZiQOy/FfBc9gMsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TYu2V1MNiSpdlai2cCksjfDNiyPejpIyeKuB/u3nzujm9GqVKbyLAFraFDCgfvwQvyIyNNl65Y7p1P0XmiMbtKoQsiZ83FMbiVkhfb9V5NCFdXQx/E4fEiXNpVpZpJzKJNnylmqh0T70SiYuJAPqDxavhi57wQO4NV5j0zoERwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej57wPJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0B0C4CEEB;
	Sun, 20 Jul 2025 17:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031824;
	bh=ZQzqfi/OS5yYOXrb3FU1Hs0VW2GsZiQOy/FfBc9gMsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ej57wPJM6GnJ6epoo02iL8cEI0EfB5/8/kC8od503jaDb36jF1GNg67eNfMQcnA86
	 80OSIHIRwkeI4SOFl8G3lPRl8/f45CF4BNWvAYf2VbpjKeQv5gpyXfXlCt/N8L9yJS
	 /iOZkda+a3m/4fSygtrfECsOMNUFnG0vyWUMaa+lZzDSehNmyqxVF/l9wPmdMFUpRC
	 HnBU7N0isCAq23CR3d14RfYhC95TMq7mdsO/+Gi1zWvGFVWZqRk8SNSGw7zNL60o6v
	 Q6oq2MCvSWWYvmB4lCM7VpwvD9+hpUH8WPkB82rWRZEBC/+zC215ed031czrm5PUc6
	 qZVY7jhdw/bxA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/22] selftests/damon/_damon_sysfs: support DAMOS target_nid setup
Date: Sun, 20 Jul 2025 10:16:37 -0700
Message-Id: <20250720171652.92309-8-sj@kernel.org>
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
control.  Add support of DAMOS action destination target_nid setup for
more tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 2d95ab564885..70860d925503 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -395,6 +395,7 @@ class Damos:
     ops_filters = None
     filters = None
     apply_interval_us = None
+    target_nid = None
     dests = None
     idx = None
     context = None
@@ -404,7 +405,7 @@ class Damos:
 
     def __init__(self, action='stat', access_pattern=DamosAccessPattern(),
                  quota=DamosQuota(), watermarks=DamosWatermarks(),
-                 core_filters=[], ops_filters=[], filters=[],
+                 core_filters=[], ops_filters=[], filters=[], target_nid=0,
                  dests=DamosDests(), apply_interval_us=0):
         self.action = action
         self.access_pattern = access_pattern
@@ -423,6 +424,7 @@ class Damos:
         self.filters = DamosFilters(name='filters', filters=filters)
         self.filters.scheme = self
 
+        self.target_nid = target_nid
         self.dests = dests
         self.dests.scheme = self
 
@@ -462,6 +464,11 @@ class Damos:
         if err is not None:
             return err
 
+        err = write_file(os.path.join(self.sysfs_dir(), 'target_nid'), '%d' %
+                         self.target_nid)
+        if err is not None:
+            return err
+
         err = self.dests.stage()
         if err is not None:
             return err
-- 
2.39.5

