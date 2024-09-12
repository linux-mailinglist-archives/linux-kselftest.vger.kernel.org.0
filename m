Return-Path: <linux-kselftest+bounces-17863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CF397700D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 20:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70687B236C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C601C2315;
	Thu, 12 Sep 2024 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JF3I60B4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2671C1AC8;
	Thu, 12 Sep 2024 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164302; cv=none; b=kEROgHM8Woc6bsi8ce3TxaMgNj1gTQ6KJQ9MAkghmRmEnZsDLXl2WoatiW6rpqE139rgKDh73tP4PQIXyYb/fg4sgmA+c+KR7lWRoRJ2jHClC3/+Vr8F7H0i/E4CkEdrpiAWeD58tI1qs0v99gc1lY768t97WrOZKcXesOgQ4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164302; c=relaxed/simple;
	bh=50bfxJYl40uFsNDlPpwTgHHyGEMj7MLBfEaCUOJS8x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1DETCb2knsmHDLDeKQnap3cHiKJBX/StVykSkQ6acFg9XfDweKCYUfe37D/XtB2yqptTUZoi7jPjpt+pBevpAJ3EoPhqz17sZ0DaMDMAkuO0wqy90o4X7fgO33iMtzXieyiGpJw7H8D8OsBBPNZIssZqNuzs6z2bftfjThDxNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JF3I60B4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726164301; x=1757700301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=50bfxJYl40uFsNDlPpwTgHHyGEMj7MLBfEaCUOJS8x8=;
  b=JF3I60B4mJDhYv03SiF/hffX5qB8MpfNPjSSx3JdY1VlD2GU1DWjRrUH
   Odm6mOYUxviH93sfpags5ik+IOk1sk/SUVH8URi0UrnqNTJOfOLt5Iwf2
   2QG1e3ZYC5avxnjO63RP6kpLr7cRDYoAfE10YwUkbJVmlMpxW/8Jh8EbD
   TvoOzqNOr5Pf4O1Z33skrxrKoY2lFL6NXQOjjueIznqq7NRmUa0770ulj
   vqpbowGsYpHMhUm+sUH5VTtBLoIV3C5+j7rGPTrAoPZ0NU6V/dg+m5AWy
   yPw17l913triD7UnlxtVq915RIPRPG13tl+p1fGOWiFGNfWsgFd+JRC55
   A==;
X-CSE-ConnectionGUID: Dp7fKhhtR1qjSMr/bNulew==
X-CSE-MsgGUID: WiE7Vsf8R7m2hwS0BynK4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24976618"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24976618"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:53 -0700
X-CSE-ConnectionGUID: M99khh2KSlGihpGhdGDRWQ==
X-CSE-MsgGUID: 9EP+TjQKRbesQjLTd/GAiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67724631"
Received: from b04f130c85c0.jf.intel.com (HELO rchatre-desk1.jf.intel.com) ([10.165.154.99])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:53 -0700
From: Reinette Chatre <reinette.chatre@intel.com>
To: fenghua.yu@intel.com,
	shuah@kernel.org,
	tony.luck@intel.com,
	peternewman@google.com,
	babu.moger@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com,
	reinette.chatre@intel.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 11/13] selftests/resctrl: Use cache size to determine "fill_buf" buffer size
Date: Thu, 12 Sep 2024 11:14:00 -0700
Message-ID: <ad51e32e5d4f8d99b691e7269e5179228e6a13a7.1726164080.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726164080.git.reinette.chatre@intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default the MBM and MBA tests use the "fill_buf" benchmark to
read from a buffer with the goal to measure the memory bandwidth
generated by this buffer access.

Care should be taken when sizing the buffer used by the "fill_buf"
benchmark. If the buffer is small enough to fit in the cache then
it cannot be expected that the benchmark will generate much memory
bandwidth. For example, on a system with 320MB L3 cache the existing
hardcoded default of 250MB is insufficient.

Use the measured cache size to determine a buffer size that can be
expected to trigger memory access while keeping the existing default
as minimum that has been appropriate for testing so far.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Ensure buffer is at least double L3 cache size. (Ilpo)
- Support user override of default buffer size. (Ilpo)
---
 tools/testing/selftests/resctrl/mba_test.c | 8 +++++++-
 tools/testing/selftests/resctrl/mbm_test.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7e43056c8737..d8d9637c1951 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -182,7 +182,13 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 		fill_buf.memflush = uparams->fill_buf->memflush;
 		param.fill_buf = &fill_buf;
 	} else if (!uparams->benchmark_cmd[0]) {
-		fill_buf.buf_size = DEFAULT_SPAN;
+		unsigned long cache_total_size = 0;
+
+		ret = get_cache_size(uparams->cpu, "L3", &cache_total_size);
+		if (ret)
+			return ret;
+		fill_buf.buf_size = cache_total_size * 2 > DEFAULT_SPAN ?
+				    cache_total_size * 2 : DEFAULT_SPAN;
 		fill_buf.memflush = 1;
 		param.fill_buf = &fill_buf;
 	}
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index b1f03a73333f..7635ee6b9339 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -149,7 +149,13 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 		fill_buf.memflush = uparams->fill_buf->memflush;
 		param.fill_buf = &fill_buf;
 	} else if (!uparams->benchmark_cmd[0]) {
-		fill_buf.buf_size = DEFAULT_SPAN;
+		unsigned long cache_total_size = 0;
+
+		ret = get_cache_size(uparams->cpu, "L3", &cache_total_size);
+		if (ret)
+			return ret;
+		fill_buf.buf_size = cache_total_size * 2 > DEFAULT_SPAN ?
+				    cache_total_size * 2 : DEFAULT_SPAN;
 		fill_buf.memflush = 1;
 		param.fill_buf = &fill_buf;
 	}
-- 
2.46.0


