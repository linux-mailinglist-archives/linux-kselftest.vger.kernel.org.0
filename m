Return-Path: <linux-kselftest+bounces-12719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A69916FCA
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 20:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2EB91F229C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E339817B511;
	Tue, 25 Jun 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owYguYF0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C3817B437;
	Tue, 25 Jun 2024 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338746; cv=none; b=ncGnnF1hbTyLpUecEW78dphQpEngqe59A7OMeAa2KuIY4UuTcLxiP6mTni1bzy5qqe5nUTpRaBGsd8F36/IB0UTNp4qgpnp5g8u9JimBAA5TsURpzG7TWAzFHHWhlUEo18CJwP/NHyW7yC5LZSpuIAhqgAbITOD3bHyec8rbqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338746; c=relaxed/simple;
	bh=IqlT1IPKcASfwAbySeLSD/8umJwtipY7yMwxEMFH+lY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mis8g+C3Tvz+ST65kdoOooTQLuT1QLZnCITtvx92Ox4b+8FS7Snn2jnopRyMWt82beoh1XFPL9igwIBGQ0N92iclMA2+++yCEVJC5aDBrXC0x1NZD9I9jiLxfIiGYda/LzaXKWBNuSJwMpD4IvnZxFIWAsZgQb6VvRBRJNubKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owYguYF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FCAC4AF11;
	Tue, 25 Jun 2024 18:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719338745;
	bh=IqlT1IPKcASfwAbySeLSD/8umJwtipY7yMwxEMFH+lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owYguYF08Cx4JYwOY6o1g0owoG2dsbNcaU/uOyKCAB27ayZjRretUhozMpE1EHQlu
	 Aj/K7T8lVNM7nt8K2aJagUURVKGF67WC2KKzKvP+ndwQ3nlbi/8hIhtH4xJJwEwWMC
	 ThpMW7G8krb7u9VhvABkwUTDXPcgKXz2DBHuNhgWEaVQl394tetaG8Ms9gUq5MH2sS
	 aS+Rv3BrsQ4PHUfZhg9IkyG8wZvNHeeLcdD4K1a5CBmgnPIjFRZKzgHV9xNgresdvb
	 aFOt+PLj2NZTMUdfPsJUIpGXnhZePKEGbStW8i8bxkRVLIiz5q1uhRGX2tOE6rOD9D
	 bnZlZ4OaBptyQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] selftests/damon/_damon_sysfs: support schemes_update_tried_regions
Date: Tue, 25 Jun 2024 11:05:32 -0700
Message-Id: <20240625180538.73134-3-sj@kernel.org>
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

Implement schemes_update_tried_regions DAMON sysfs command on
_damon_sysfs.py, to use on implementations of future tests for the
feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 2bd44c32be1b..f975742f29b3 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -175,16 +175,24 @@ class DamosStats:
         self.sz_applied = sz_applied
         self.qt_exceeds = qt_exceeds
 
+class DamosTriedRegion:
+    def __init__(self, start, end, nr_accesses, age):
+        self.start = start
+        self.end = end
+        self.nr_accesses = nr_accesses
+        self.age = age
+
 class Damos:
     action = None
     access_pattern = None
     quota = None
     apply_interval_us = None
-    # todo: Support watermarks, stats, tried_regions
+    # todo: Support watermarks, stats
     idx = None
     context = None
     tried_bytes = None
     stats = None
+    tried_regions = None
 
     def __init__(self, action='stat', access_pattern=DamosAccessPattern(),
                  quota=DamosQuota(), apply_interval_us=0):
@@ -398,6 +406,31 @@ class Kdamond:
         err = write_file(os.path.join(self.sysfs_dir(), 'state'), 'on')
         return err
 
+    def update_schemes_tried_regions(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'state'),
+                         'update_schemes_tried_regions')
+        if err is not None:
+            return err
+        for context in self.contexts:
+            for scheme in context.schemes:
+                tried_regions = []
+                tried_regions_dir = os.path.join(
+                        scheme.sysfs_dir(), 'tried_regions')
+                for filename in os.listdir(
+                        os.path.join(scheme.sysfs_dir(), 'tried_regions')):
+                    tried_region_dir = os.path.join(tried_regions_dir, filename)
+                    if not os.path.isdir(tried_region_dir):
+                        continue
+                    region_values = []
+                    for f in ['start', 'end', 'nr_accesses', 'age']:
+                        content, err = read_file(
+                                os.path.join(tried_region_dir, f))
+                        if err is not None:
+                            return err
+                        region_values.append(int(content))
+                    tried_regions.append(DamosTriedRegion(*region_values))
+                scheme.tried_regions = tried_regions
+
     def update_schemes_tried_bytes(self):
         err = write_file(os.path.join(self.sysfs_dir(), 'state'),
                 'update_schemes_tried_bytes')
-- 
2.39.2


