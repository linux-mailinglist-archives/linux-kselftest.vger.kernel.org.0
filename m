Return-Path: <linux-kselftest+bounces-12724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4937E916FD4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 20:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DA71F233E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 18:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C5C17CA17;
	Tue, 25 Jun 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJX/VNho"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD717CA0A;
	Tue, 25 Jun 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338749; cv=none; b=LyFAlfkW3ltZpjJl71OcCd9U3p3UhwuAlw4E+PCIw+kjksdgcVRPD70ezDK5IQ8JtUkjdyTwnstZLw/kiuRytSDVNcKplKfIE7IgLkVuJtDafz+SpT7bYt6kCpFAWUrxKojvs1IgEaSoVKQLxAWz0KdzcdalZxRjsLE4HXNQ9a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338749; c=relaxed/simple;
	bh=gJIZChP/stfR9DmaAxQLH0gVjnmXTejsJJ91eVHAK8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qNfQv9KlkPE2KT5e712Eug2RPto1ttvQUQ5/IHNQ5cIhQ4J0BorrQ1oGKYB7ZH7q76PblXc0VZx8HtLnTk2wh+CWjslm//jqDIpZOZws/JbN2Dnu+Q+hhn90YT06QKy+1pnyIW78tuNMwBcaBgtNS5x6tyykYpgvHsw9fkW6mUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJX/VNho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D20C4AF0D;
	Tue, 25 Jun 2024 18:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719338749;
	bh=gJIZChP/stfR9DmaAxQLH0gVjnmXTejsJJ91eVHAK8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJX/VNhoKPVAhVJq94R8nCXyATG+V3v1HHEVqCWWYENRsI8vidfdlUx0uJE/rbRXU
	 CAOT9SwrvkvU2hfYyWb3prqwvbYJk9AXHcSvhoKxQMkx2rkCe4dz7Z+Y+yvRY+K3XH
	 Q/DiY6lgayFm5gtQqAZ7WLu0JE1vBwmEmHDV7IHUvHmm+RzJDENGNi86l8M8QFIaNH
	 +SrafYC6A892YXUxjZy0vhqQ8lAQXOCgor4LvUVNoeVU949S/rU0OqzlHVu1oSJ5L5
	 C9iKcuN40JhoVBFx/BDVzmeSAphRqMWG58z51QK7OwLFwynp1A3Wz1q+ncyP0pezzl
	 8nNEVKL/9SIbg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] _damon_sysfs: implement commit() for online parameters update
Date: Tue, 25 Jun 2024 11:05:37 -0700
Message-Id: <20240625180538.73134-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625180538.73134-1-sj@kernel.org>
References: <20240625180538.73134-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users can update DAMON parameters while it is running, using 'commit'
DAMON sysfs interface command.  For testing the feature in future tests,
implement a function for doing that on the test-purpose DAMON sysfs
interface wrapper Python module.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 17352b9d204d..6e136dc3df19 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -481,6 +481,25 @@ class Kdamond:
                     goal.effective_bytes = int(content)
         return None
 
+    def commit(self):
+        nr_contexts_file = os.path.join(self.sysfs_dir(),
+                'contexts', 'nr_contexts')
+        content, err = read_file(nr_contexts_file)
+        if err is not None:
+            return err
+        if int(content) != len(self.contexts):
+            err = write_file(nr_contexts_file, '%d' % len(self.contexts))
+            if err is not None:
+                return err
+
+        for context in self.contexts:
+            err = context.stage()
+            if err is not None:
+                return err
+        err = write_file(os.path.join(self.sysfs_dir(), 'state'), 'commit')
+        return err
+
+
     def commit_schemes_quota_goals(self):
         for context in self.contexts:
             for scheme in context.schemes:
-- 
2.39.2


