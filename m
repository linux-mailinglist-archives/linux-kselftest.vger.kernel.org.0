Return-Path: <linux-kselftest+bounces-9395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CAB8BB209
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 20:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757801F23386
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82A9158856;
	Fri,  3 May 2024 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNN27e7D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D2158845;
	Fri,  3 May 2024 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759404; cv=none; b=nVnOOiJNq2rjwd8c04nmUSjN7EgHhlHKYzDfxUbL8qt1V+pz/EqR2u1HdNM+YuPlkw2sbwxwiSOsW0KbKSPkFE/UpG9wxZrR+LVxGPedllJm9VTeu+yEyvRtGpI73GrPu5MbYcIklWr33lkVlvKt6UcLx/sY9vricjNVi0+kh4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759404; c=relaxed/simple;
	bh=3OCJo+mdOOU+eYdVwx29gwu7K+0FClrtGDmTiLBUZvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ciuoz4YUwhiyZoNh+i8Fv1hJT1QsZFKDf+GNK1/JzG7ELLcMVUjJW16lJOKYs4Lmn38CAI+TtRpZBuKKBfCRRt0/akXP+a6F4vVOsT81J9K3IcLC56tyvjIeMQxWvvSzetdSXM8DfoOt4CB+4mW8vco/B1d9XhqWKPc8UHtJ6ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNN27e7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC55C4AF48;
	Fri,  3 May 2024 18:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714759404;
	bh=3OCJo+mdOOU+eYdVwx29gwu7K+0FClrtGDmTiLBUZvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNN27e7D0zmbKWvmat7LzEJ39cI0NXToH46je6GTKxDPulfpOt3Z+Hq0yQfmDRFCG
	 YzLjFaAxqfcNfFodwdGgqkgdn7gM23A0H3HOgN6wPDz6/JDzbYbwOwPvO8jLQ44148
	 NJRIPYUQcnKfnmYFVTsRN7zt2P/QM0wO6rnqCyceKpojejtqUUslxMcrkltmbeEP01
	 FNbdumleZNUFrX8fq9RtfVWcxYWrayO6CV/yLnhKeF8BpqGsvUywy5IqnIWqcouWzm
	 IbdAeCODmvwrjnL4E5ZgHWDSl6aVG3/lDSrMYXIrKTnZmHP5lBUzfEDWcRm6YWo35Q
	 kZG9dG+PQvCYA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] selftests/damon/_damon_sysfs: find sysfs mount point from /proc/mounts
Date: Fri,  3 May 2024 11:03:11 -0700
Message-Id: <20240503180318.72798-4-sj@kernel.org>
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

_damon_sysfs.py assumes sysfs is mounted at /sys.  In some systems, that
might not be true.  Find the mount point from /proc/mounts file content.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index fffa74a78bd7..5367e98817a9 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -2,7 +2,18 @@
 
 import os
 
-sysfs_root = '/sys/kernel/mm/damon/admin'
+ksft_skip=4
+
+sysfs_root = None
+with open('/proc/mounts', 'r') as f:
+    for line in f:
+        dev_name, mount_point, dev_fs = line.split()[:3]
+        if dev_fs == 'sysfs':
+            sysfs_root = '%s/kernel/mm/damon/admin' % mount_point
+            break
+if sysfs_root is None:
+    print('Seems sysfs not mounted?')
+    exit(ksft_skip)
 
 def write_file(path, string):
     "Returns error string if failed, or None otherwise"
-- 
2.39.2


