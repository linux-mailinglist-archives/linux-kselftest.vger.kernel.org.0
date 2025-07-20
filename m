Return-Path: <linux-kselftest+bounces-37699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AABB0B72C
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6F81696AB
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111AA237164;
	Sun, 20 Jul 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+FErqnG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D921822172C;
	Sun, 20 Jul 2025 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031830; cv=none; b=TCAbSz4YI0LuyJnxpmc61d067ZjKzLUjDITuJ3jvz3uRe5P/k6Zn2M5ljfzS9drE5njyDEg6SO0+wW8IQYvmt81mm4HyOdHm6NxhCIvu5xP2Og/y5DFmLtcqk7t3XJzXdzaireZNi/KWBTwumsRF0L5S+LAkBZKweqf1SbDgjGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031830; c=relaxed/simple;
	bh=5DVJPjAFv4Z5cR2LSqJtd6K261syubl14OoCYWIJf+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2lwS0ugqsCba18rMOls220ch6cmpDF7U/B+q8nPrS9qnPZvQeslvYWkFxSK3Y+Gj1X7DXxKov7aqY4n1zt6HyPezJeuqIMQ3RRHQoEkH0cligBifjvY9RvCR/E5NWQiC0cE0HvRAXwRL1AII3HRz7msPUOwGqrpduxLdIEUeFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+FErqnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55046C4CEE7;
	Sun, 20 Jul 2025 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031829;
	bh=5DVJPjAFv4Z5cR2LSqJtd6K261syubl14OoCYWIJf+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+FErqnGuJLxgqC6IN+1c2UIPAD1gj80yPK72GJB7xmInTGtNcTMNLiRVAQagIPip
	 IQrDEy+upWQgjgXm4Dzgl5eHwm9x79c6XwVyS8635JLr4+VXVLlx2GHsrYAIC+X5H8
	 AkQsUdhm7Uq8lfb9uliP90ZYj+6BgW1tKyuzI+XHgmB4dn6otjHE5W8beON+iynU1e
	 SKO1X8kD+SP656xYtVD4yi74jBYN7eSszIlUg41NTsUe80HHQFhT16ag6fnKqYokmh
	 mjCO7lus0/m43kwX3Y3iequsKlw6JMD0cvtnVZVaxpMmYQHqFWubyqtDHzATiw2RAz
	 uHDbHVEMsm+vg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 12/22] selftests/damon/sysfs.py: generalize DAMOS Watermarks commit assertion
Date: Sun, 20 Jul 2025 10:16:42 -0700
Message-Id: <20250720171652.92309-13-sj@kernel.org>
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

DamosWatermarks commitment assertion is hard-coded for a specific test
case.  Split it out into a general version that can be reused for
different test cases.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index e67008fd055d..91a28d97b015 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -25,6 +25,22 @@ def fail(expectation, status):
     print(json.dumps(status, indent=4))
     exit(1)
 
+def assert_true(condition, expectation, status):
+    if condition is not True:
+        fail(expectation, status)
+
+def assert_watermarks_committed(watermarks, dump):
+    wmark_metric_val = {
+            'none': 0,
+            'free_mem_rate': 1,
+            }
+    assert_true(dump['metric'] == wmark_metric_val[watermarks.metric],
+                'metric', dump)
+    assert_true(dump['interval'] == watermarks.interval, 'interval', dump)
+    assert_true(dump['high'] == watermarks.high, 'high', dump)
+    assert_true(dump['mid'] == watermarks.mid, 'mid', dump)
+    assert_true(dump['low'] == watermarks.low, 'low', dump)
+
 def main():
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(
@@ -100,14 +116,8 @@ def main():
             }:
         fail('damos quota', status)
 
-    if scheme['wmarks'] != {
-            'metric': 0,
-            'interval': 0,
-            'high': 0,
-            'mid': 0,
-            'low': 0,
-            }:
-        fail('damos wmarks', status)
+    assert_watermarks_committed(_damon_sysfs.DamosWatermarks(),
+                                scheme['wmarks'])
 
     kdamonds.stop()
 
-- 
2.39.5

