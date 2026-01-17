Return-Path: <linux-kselftest+bounces-49222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0F9D38B6D
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 03:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 241B73036C64
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 02:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3C73128A2;
	Sat, 17 Jan 2026 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5G6ObI8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D383126DB;
	Sat, 17 Jan 2026 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768615660; cv=none; b=dN3ggRYHTLpaXofxM3wjoBZI4VGDeIOrWtE8Z5/HpQ8kcGaMya4oFkdufIBpAwWlmegW+pUZHp1HY0Z0urYuE5oLBRaNjl1BtrWnY3BdeH3bFSQD4ca4rQwe4iTXp6GtK8L+g98lk3BYq8aFnoRCNjep1LUbq3qLeEgNNCMQbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768615660; c=relaxed/simple;
	bh=j53bKE/6kD2pppzUnBcXuqbjxn53YKphj01tk4fSuMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4mvpgWo2sb2OeeUnf30zgzgDgmd9/+vjsYrHqeJlhEAlieUC3ouTypkW7vfUSxgSDw8hGQ1DwIWt+/zOw/yfsktGHC/bQcSxd1uXGEQo954y6PzhFZoFdVTRTbBrDD7LRDGIYhR7CYNNvzTfVJQ9pFybXStPbrHaUI2WJEMLBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5G6ObI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B74C116C6;
	Sat, 17 Jan 2026 02:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768615660;
	bh=j53bKE/6kD2pppzUnBcXuqbjxn53YKphj01tk4fSuMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5G6ObI8XH9zVIBydWbJGWRkJcj7D6Ee7V0OYWFvkHPwHMsn84TbbgJ52vGMXtLFe
	 LAdbttivZWioN9Ncr4XwvlVLDJSlc/Hu2iGM3IkcfUM9C4NSlSdJ51Xl60fd+ODUh5
	 TB+9U6Cti9YlJKfNwXE1vELsxPEzJqqaD28UEOsubwOtQ5MIY6H/oqilMRvvQfA4nQ
	 EaCa/gH7/dDyP4eKRpqZ/n5M2YkM051uuSzoGErBm9niuKX1FPs25/2Q2nEkH2VA6x
	 3DbZkyCaZPJe4J5DaZuESWCD+DY1tMP4sLkBa/nAJtflWZAgLSlkY/siTlbMwiy9RH
	 vF1azDzezWe5Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/5] selftests/damon/wss_estimation: ensure number of collected wss
Date: Fri, 16 Jan 2026 18:07:27 -0800
Message-ID: <20260117020731.226785-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260117020731.226785-1-sj@kernel.org>
References: <20260117020731.226785-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON selftest for working set size estimation collects DAMON's working
set size measurements of the running artificial memory access generator
program until the program is finished.  Depending on how quickly the
program finishes, and how quickly DAMON starts, the number of collected
working set size measurements may vary, and make the test results
unreliable.  Ensure it collects 40 measurements by using the repeat mode
of the artificial memory access generator program, and finish the
measurements only after the desired number of collections are made.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../sysfs_update_schemes_tried_regions_wss_estimation.py    | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
index bf48ef8e5241..cdccb9f0f855 100755
--- a/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
+++ b/tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_wss_estimation.py
@@ -8,7 +8,8 @@ import _damon_sysfs
 
 def pass_wss_estimation(sz_region):
     # access two regions of given size, 2 seocnds per each region
-    proc = subprocess.Popen(['./access_memory', '2', '%d' % sz_region, '2000'])
+    proc = subprocess.Popen(
+            ['./access_memory', '2', '%d' % sz_region, '2000', 'repeat'])
     kdamonds = _damon_sysfs.Kdamonds([_damon_sysfs.Kdamond(
             contexts=[_damon_sysfs.DamonCtx(
                 ops='vaddr',
@@ -26,7 +27,7 @@ def pass_wss_estimation(sz_region):
         exit(1)
 
     wss_collected = []
-    while proc.poll() == None:
+    while proc.poll() is None and len(wss_collected) < 40:
         time.sleep(0.1)
         err = kdamonds.kdamonds[0].update_schemes_tried_bytes()
         if err != None:
@@ -35,6 +36,7 @@ def pass_wss_estimation(sz_region):
 
         wss_collected.append(
                 kdamonds.kdamonds[0].contexts[0].schemes[0].tried_bytes)
+    proc.terminate()
     err = kdamonds.stop()
     if err is not None:
         print('kdamond stop failed: %s' % err)
-- 
2.47.3

