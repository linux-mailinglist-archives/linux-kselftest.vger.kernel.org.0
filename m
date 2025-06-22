Return-Path: <linux-kselftest+bounces-35582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CBBAE3232
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 23:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C3E7A7547
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 21:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE923221FAC;
	Sun, 22 Jun 2025 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaIixRy7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37E4221F20;
	Sun, 22 Jun 2025 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626220; cv=none; b=Zud546nl/QY6B0S1/phmmW9csikweoG77gyS8ujv1YoHABmLIqpHfIxOr4J5BHrRfG9/4aISquH2OXgC0wpXttrvt42HeDXvGpyZaGblCIOt+RjDG3Vxsihd4LjUtjO74rRJiQCyf6cAqO62etdVDdxUvL3+EKgJ363HOvpBy+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626220; c=relaxed/simple;
	bh=wq56Vg1wiYwnpAsrjZ3THKuY4FAoz9PHZqmw/hYGZ0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f2unhT/qd04j+6gHodWllhp1Qw7jAF4xzEM4LENULT6YKKu5SXR4JipYTkTmQ/Xz9wTVqgiOp+3i9MzctnabOs14149/LyGQKEtI4YJ2mCw3yAnAN2YizNcFQkR86QxvSnDXxlQojYMK8/L0AvXonz/C8Xa9GaURs7PTDIul4FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaIixRy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275B3C4CEED;
	Sun, 22 Jun 2025 21:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750626220;
	bh=wq56Vg1wiYwnpAsrjZ3THKuY4FAoz9PHZqmw/hYGZ0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MaIixRy7wrfqugtBkE6n57j5d9DqUJ8iULV9x3oyydNNH0OULKzw31RRDLjOR/3AQ
	 Yw/aKpYfDHivMESbc8cbLB32j/ro104vww3LSkeJ9/qz53r72kvxUadksmA9TG1qR3
	 XiRNgQhTVaQiiH01tpN8QpWC0lqcMRlKZGmFMp+p1dE1BpbfeFtAQJLQyMXg4CAQhP
	 Ex2Q0PmnQDBgVoSNG+89SyGSHw3f4TONTfzpouUsj56bPYyqsuRq+yt4AaNq6yVh1g
	 RklY9JVrTqWNg4HfXkB0igHKg038TEVO1I2mow+BFznePMVwN0SwGAnFtSVvlTWeq5
	 VHfbbDGVrLDlQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/6] selftests/damon/sysfs.py: test adaptive targets parameter
Date: Sun, 22 Jun 2025 14:03:29 -0700
Message-Id: <20250622210330.40490-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622210330.40490-1-sj@kernel.org>
References: <20250622210330.40490-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DAMON sysfs interface functionality tests for setup of basic
adaptive targets parameters.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index a721901a880d..3b085268f342 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -27,7 +27,9 @@ def fail(expectation, status):
 
 def main():
     kdamonds = _damon_sysfs.Kdamonds(
-            [_damon_sysfs.Kdamond(contexts=[_damon_sysfs.DamonCtx()])])
+            [_damon_sysfs.Kdamond(
+                contexts=[_damon_sysfs.DamonCtx(
+                    targets=[_damon_sysfs.DamonTarget(pid=-1)])])])
     err = kdamonds.start()
     if err is not None:
         print('kdamond start failed: %s' % err)
@@ -60,8 +62,9 @@ def main():
     if attrs['max_nr_regions'] != 1000:
         fail('max_nr_regions')
 
-    if ctx['adaptive_targets'] != []:
-        fail('adaptive_targets')
+    if ctx['adaptive_targets'] != [
+            { 'pid': 0, 'nr_regions': 0, 'regions_list': []}]:
+        fail('adaptive targets', status)
 
     if ctx['schemes'] != []:
         fail('schemes')
-- 
2.39.5

