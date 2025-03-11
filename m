Return-Path: <linux-kselftest+bounces-28700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD7FA5BABE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 09:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF5C189630D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 08:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BE9222569;
	Tue, 11 Mar 2025 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpPO/8x2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543461DE894;
	Tue, 11 Mar 2025 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681343; cv=none; b=V+L1OCUoK6DJijFmMYE5VIOFBmcQF+EuC9sYbGdRx7CkNFCV95HHy+vrq8aWR2CB3vd0nA9xumzWsbF5Y163hd8P/3M9QMHntXvni833JT7RuEKiY1/FOfmInPLRk4nDQEoH4nPhMpqDWNw1Q3VJhP1bZgLSyvKWbKnYssOaAuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681343; c=relaxed/simple;
	bh=oDgMFfKoOYNvurMdYjsKlHk+6v4ec6TZPOD47GjfsLU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XtbOlbUp5eejAMaEJ5HNXgRA5K5mhkuD5AwlHAGWgOpIKthINwI3KQZD67HbEsiN86WaB+aS/t8jB2pto6Nv2nopoiadbqwTXgS9WE0VYb+UrbDqRvkp0bt+ew1U0x590lLLFH62vc9V+XVItVUj559zRq/WUHchcp7+QkaFL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpPO/8x2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741681341; x=1773217341;
  h=from:to:cc:subject:date:message-id;
  bh=oDgMFfKoOYNvurMdYjsKlHk+6v4ec6TZPOD47GjfsLU=;
  b=mpPO/8x2coacSu2P6qOwudWw3oJw5YOmR3EwMrkwbvyv+t0Om0tnR/1y
   TMtderfvUGd4lLzVHmSOEdY66A0LedP100aP/BA/aTTCBSmY0/avxGHK6
   gsNL+V7hzuNTdEYuL90+c8DZEg0ybzoWchx04xktKPXwaiJXifTUMZ/33
   mkslmY+Hghzh8OdWWQpWyqWYXLa/9nUTfiUqTTwbmcs9PGF33uQ6VWXof
   SbbKThVb1h8PnmaWd9iJigCIOA9c5V4NzXNKO92AttoAiqPbzOsDcoAR4
   FpWeDtgIN5lw4oW4O8EmwwTq5um6mnJ79mtJYeD7AsEUlGGmUN+dRe6eZ
   Q==;
X-CSE-ConnectionGUID: zmLL13wlRQ2QxC+ML4WhHA==
X-CSE-MsgGUID: KDIhl/GdQ92p7mjDBIuO7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="68067096"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="68067096"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 01:22:21 -0700
X-CSE-ConnectionGUID: wBS/iF1eQN+yUTCZnNwSiA==
X-CSE-MsgGUID: aj6FqxiVRdSzGBOjGhIA0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="120202946"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 01:22:19 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com,
	yi1.lai@intel.com
Subject: [PATCH 1/1] selftests/mincore: Allow read-ahead pages to reach the end of the file
Date: Tue, 11 Mar 2025 16:09:40 +0800
Message-Id: <20250311080940.21413-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

When running the mincore_selftest on a system with an XFS file system, it
failed the "check_file_mmap" test case due to the read-ahead pages reaching
the end of the file. The failure log is as below:

   RUN           global.check_file_mmap ...
  mincore_selftest.c:264:check_file_mmap:Expected i (1024) < vec_size (1024)
  mincore_selftest.c:265:check_file_mmap:Read-ahead pages reached the end of the file
  check_file_mmap: Test failed
           FAIL  global.check_file_mmap

This is because the read-ahead window size of the XFS file system on this
machine is 4 MB, which is larger than the size from the #PF address to the
end of the file. As a result, all the pages for this file are populated.

  blockdev --getra /dev/nvme0n1p5
    8192
  blockdev --getbsz /dev/nvme0n1p5
    512

This issue can be fixed by extending the current FILE_SIZE 4MB to a larger
number, but it will still fail if the read-ahead window size of the file
system is larger enough. Additionally, in the real world, read-ahead pages
reaching the end of the file can happen and is an expected behavior.
Therefore, allowing read-ahead pages to reach the end of the file is a
better choice for the "check_file_mmap" test case.

Reported-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 tools/testing/selftests/mincore/mincore_selftest.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index e949a43a6145..efabfcbe0b49 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -261,9 +261,6 @@ TEST(check_file_mmap)
 		TH_LOG("No read-ahead pages found in memory");
 	}
 
-	EXPECT_LT(i, vec_size) {
-		TH_LOG("Read-ahead pages reached the end of the file");
-	}
 	/*
 	 * End of the readahead window. The rest of the pages shouldn't
 	 * be in memory.
-- 
2.17.1


