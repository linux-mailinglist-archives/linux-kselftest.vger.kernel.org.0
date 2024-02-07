Return-Path: <linux-kselftest+bounces-4278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C4C84D301
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 21:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBEC1C24AD7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 20:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75B5127B74;
	Wed,  7 Feb 2024 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fi0iIujP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF48127B6A;
	Wed,  7 Feb 2024 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337903; cv=none; b=ReMf41TxJt02g82c2JRvTso401EjwAhHDCMVEmqzBMv0pFNs/0pcIiVjTVRLUzySmPRr2IpQTtqX+y3SzQlGU0FGWmIPm7yd8D6UvBRRDmoTa+RGIl0iQYEYvTmN3n3o2+kfUa0xd4MYc30bbq/7+78CMaJ8fxFEgToz8UouPws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337903; c=relaxed/simple;
	bh=9lLmi3bov7hQSKSz6Wm19r7FnAY+g94q4B/k/Jgsk9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZFGEBVLFnu2VjfV2vR7xw8Js9krah8gzCdvnU/21bDhhF6bgdNT7FZHAVAjSVrcmUXyFg/abJ8M+otrhYKH7U5DSgq+lrXUqIV7qIrrdNZQFFVFhjKrH5mnF/rQAwg08RpS6cdFhoZC+J7/cPuyw+MBG6YCq5l/0Z1UQ3TTiErU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fi0iIujP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F1EC43141;
	Wed,  7 Feb 2024 20:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707337903;
	bh=9lLmi3bov7hQSKSz6Wm19r7FnAY+g94q4B/k/Jgsk9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fi0iIujPz1cj5u9k8DV6O6k6jYHVEQy6PRbsmappiAAOUQnYijCrUO8m+mPpuZQ/X
	 /Qo1XhekVUHY0pnANoHsgiT0y8eK/BMSLC0y9cvyLOUdXjSE4Z5pGSRSMoGYHhyAim
	 6ciDGu9LMatd++0cRpr5guC30UwMHR2ZkSRBnXrH+P2hqXseTOV9V0AYm4ptQ+1oR8
	 WyrAKtkKkKNbHEftXNZBqMKYhKIrCO073GUohgJLzwsRXP5cFQ37mbbhO3MOD+Hjea
	 vWnP8dF05TL/cauWKBUB90aZFB1nilt2afMb5jOh3Dw+y0IppRqhHOpKyNog663RqN
	 X4qIwvmvgRO/A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] selftests/damon/_damon_sysfs: support DAMOS apply interval
Date: Wed,  7 Feb 2024 12:31:29 -0800
Message-Id: <20240207203134.69976-4-sj@kernel.org>
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
DAMOS apply interval.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index a75244451684..d23d7398a27a 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -114,6 +114,7 @@ class Damos:
     action = None
     access_pattern = None
     quota = None
+    apply_interval_us = None
     # todo: Support watermarks, stats, tried_regions
     idx = None
     context = None
@@ -121,12 +122,13 @@ class Damos:
     stats = None
 
     def __init__(self, action='stat', access_pattern=DamosAccessPattern(),
-                 quota=DamosQuota()):
+                 quota=DamosQuota(), apply_interval_us=0):
         self.action = action
         self.access_pattern = access_pattern
         self.access_pattern.scheme = self
         self.quota = quota
         self.quota.scheme = self
+        self.apply_interval_us = apply_interval_us
 
     def sysfs_dir(self):
         return os.path.join(
@@ -139,6 +141,11 @@ class Damos:
         err = self.access_pattern.stage()
         if err != None:
             return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'apply_interval_us'),
+                         '%d' % self.apply_interval_us)
+        if err != None:
+            return err
+
         err = self.quota.stage()
         if err != None:
             return err
-- 
2.39.2


