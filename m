Return-Path: <linux-kselftest+bounces-36063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9175CAEC87D
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 18:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C34189E8BC
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF342571B6;
	Sat, 28 Jun 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqacQgdf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650424A046;
	Sat, 28 Jun 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751126677; cv=none; b=Nzbb64+tffr1jWBIthLyAVWPzOLBEnVMFYyy9VkuxdiMFCTpafzBhxI7c0Ye1cdBnT4IMtYQ6xejXzbRmkyNis2BPxELYBWQz+uTqoIW7nmILQ97crf/OMUYs8blXykwqHo2aqArHIpn1DUZGsuYMVRIk3ZpcU7fE27Jo6WGt8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751126677; c=relaxed/simple;
	bh=wq56Vg1wiYwnpAsrjZ3THKuY4FAoz9PHZqmw/hYGZ0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cK8T4D5eXdNksEE8I3rBb/qGN1lygw8vlh/WKHkFWq2b5liNVLG9ec7e78FEzrn3jLgKV6pN0h2jOOlIONahWMH7xxzoH3XMiXPzXDlPw4UV3+PTHjdDS4a8ySUji3Ru1ezJpoOMmLbu+HLQg8AP9oA856PS+0izzw3eLxKU8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqacQgdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19389C4CEEA;
	Sat, 28 Jun 2025 16:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751126677;
	bh=wq56Vg1wiYwnpAsrjZ3THKuY4FAoz9PHZqmw/hYGZ0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GqacQgdfGAfSTiVWwh8Hf4WAzqL0w7VEwuQRy4PDoA+3fr7Y1nfPvCuB0QcULDgAV
	 qwUvXKNBUN5SeuirbpZ2z/wy1Axj+N2ePqQ9ff7u647IxlVdraxthss4B2MuuwjBl4
	 NGGVDbOqOAVgjAXXxy2cpBtvOUetAMGDi8oaMI1o6jiO5dtc2Pt0aZHh8obhC+PEGh
	 hxznqYVavAcNdlVS4rbyvl3sheHFLGt8gr0KZt/VZSDBv/TDvIB5+o3fiCq6tIM6nN
	 +1d6FNLK62oJ/zTA6FCfAtcP+t0CEApLiUg0anoekolkZdwJVxdSjVY3Kc15VuxQDE
	 AB6Bfzv8VfF6g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/6] selftests/damon/sysfs.py: test adaptive targets parameter
Date: Sat, 28 Jun 2025 09:04:27 -0700
Message-Id: <20250628160428.53115-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628160428.53115-1-sj@kernel.org>
References: <20250628160428.53115-1-sj@kernel.org>
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

