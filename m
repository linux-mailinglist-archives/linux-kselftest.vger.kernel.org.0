Return-Path: <linux-kselftest+bounces-4277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A5384D300
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 21:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F7E1C24E87
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 20:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457E5127B46;
	Wed,  7 Feb 2024 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdziAUn9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A31B76039;
	Wed,  7 Feb 2024 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337903; cv=none; b=dvfrwedygiv5+6KCTzhCxKmQ8xA0VYgLya953AQehl0DfIAc9AVzDArJLCVva6PHGwL9QxsQcq8hE48etBbo82gSCfVgyuOSiI3yfwiBnAnG/aM9qJre1mZOg/5Tw9viPcFMtlh4vCTQM4VTUjPxJFFpoNNd63GInZLKvphzSmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337903; c=relaxed/simple;
	bh=SwdeOXExaKQGPJVJ2NaT/lednGj9CW7yt27zl0ck87s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ecfLvRA1TEPEQhSQSWbXbCecjgtRQ7W0AuPau8kYu3ox5XFJSQtB0Iv7z/aaG8S6ePyd+ZPi+u3B+VWZYRfHLxsHVhG8S25syQbBrWErKYJKcsIBCESnUPI1r0D5lr5+SS1MED4+jRtiQujQRxFCbA5JJ8HgRtv5aWj/aJbI8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdziAUn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA011C433A6;
	Wed,  7 Feb 2024 20:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707337902;
	bh=SwdeOXExaKQGPJVJ2NaT/lednGj9CW7yt27zl0ck87s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdziAUn989qZYGouOke5VJZROLyvwJMYpwiWYmq66BUEXenv4+YEFtDUWAJ+A9e46
	 4RcITM/aROpBnV+7byqwfQVSsuyZPtFLLVl+f8ctcCaXnoDBxj77Kj7brTuY7MxQzf
	 6NO9ac8gHvUjq74gTlJ4q47izd+Hf6ebBXti6tL+WXPNCl37Qsm8WS036hCLnt6xHx
	 4B0sBDrpLG1W2uOj69vF8f5540kveMiYpR8ER1drvalND7Cz/HlPbut0+TCVD/d7yH
	 EAs7LM4X6EwP+4OXCl44FY2ZUcPhdn5aGcueatWZCkqpFk+6X66NXx0kXHlRCjKbgK
	 O5Yym670dAtVA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] selftests/damon/_damon_sysfs: support DAMOS stats
Date: Wed,  7 Feb 2024 12:31:28 -0800
Message-Id: <20240207203134.69976-3-sj@kernel.org>
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
DAMOS stats.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index b4f6e385c564..a75244451684 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -96,6 +96,20 @@ class DamosQuota:
         if err != None:
             return err
 
+class DamosStats:
+    nr_tried = None
+    sz_tried = None
+    nr_applied = None
+    sz_applied = None
+    qt_exceeds = None
+
+    def __init__(self, nr_tried, sz_tried, nr_applied, sz_applied, qt_exceeds):
+        self.nr_tried = nr_tried
+        self.sz_tried = sz_tried
+        self.nr_applied = nr_applied
+        self.sz_applied = sz_applied
+        self.qt_exceeds = qt_exceeds
+
 class Damos:
     action = None
     access_pattern = None
@@ -104,6 +118,7 @@ class Damos:
     idx = None
     context = None
     tried_bytes = None
+    stats = None
 
     def __init__(self, action='stat', access_pattern=DamosAccessPattern(),
                  quota=DamosQuota()):
@@ -322,6 +337,23 @@ class Kdamond:
                     return err
                 scheme.tried_bytes = int(content)
 
+    def update_schemes_stats(self):
+        err = write_file(os.path.join(self.sysfs_dir(), 'state'),
+                'update_schemes_stats')
+        if err != None:
+            return err
+        for context in self.contexts:
+            for scheme in context.schemes:
+                stat_values = []
+                for stat in ['nr_tried', 'sz_tried', 'nr_applied',
+                             'sz_applied', 'qt_exceeds']:
+                    content, err = read_file(
+                            os.path.join(scheme.sysfs_dir(), 'stats', stat))
+                    if err != None:
+                        return err
+                    stat_values.append(int(content))
+                scheme.stats = DamosStats(*stat_values)
+
 class Kdamonds:
     kdamonds = []
 
-- 
2.39.2


