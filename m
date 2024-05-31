Return-Path: <linux-kselftest+bounces-11015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A308D62B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33A928ACF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535941779BB;
	Fri, 31 May 2024 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cd7VRIKb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13AE176AC9;
	Fri, 31 May 2024 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161265; cv=none; b=h2gJE0pcvFrroPuwDr0kNAt1aU3Y4hMAsIxXqhn9wfoqoKET+nYnb/R5MhMxpXm7yRaGOfnt+QsDKHXIRHXD4vJcB0fsdVOFp6kWSKsqy3LX8CWsUtWaoMYOaNqysnZSY9EMDgXK0QG0y6yirsanmPGF1EILGYTwQIxLKjwwixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161265; c=relaxed/simple;
	bh=CvFqSJiNzfsGJ0vkCckpwpi4AWMEa7rfewympWlIBiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+/M9XZnAVOCxJpfrJCGZudgHMbyYUpTrhkthRewW46etlNpLUx1AXuEpYNw2ywpCvvv7TpfrinrHoDUdxY+qqw/zg/sMlwe7Gszhz9BCzZbG/7cGUxdFam6aROe0C2HVBaZdOo/CYQ1wgCLZtfXGeJT6jRqygLUM/O9H4Utbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cd7VRIKb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717161264; x=1748697264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CvFqSJiNzfsGJ0vkCckpwpi4AWMEa7rfewympWlIBiE=;
  b=cd7VRIKbbA5V8+XXP8VkesR6kroGd00OPp1Fzln14N5bMYXpkQCgBqcp
   HrozOO/1GZ0I7uckCb7TnDCdVfAnKOfkQnuzpZbZjWj2YtQdQMFFOssfR
   SyY/7jCzvcLnDlP0y7mXdAGHGhlpR10iDAeH5G+UFKQAzAKWi6PAnxAnA
   aeCAhy6aWiAQWztTgty8UoczdJN3t+0PRlkn3dtbw4yGJI2k2mDx6HF5m
   c0V0zp8L/mRGuiQTQlUiYc5Vj9O2cMwRe9q04haKuKh+UQJ2TmY2LLBeN
   CMQRkkNajmNdthJv4g82MTbD7WLxXGTUJn4lwLG+f5d7qFG/cVDTMKWRQ
   A==;
X-CSE-ConnectionGUID: 0noPJ0dzSh6uLWNso3nWsQ==
X-CSE-MsgGUID: /oTECt9dRqW7w+R5se8ITg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17501591"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="17501591"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:14:23 -0700
X-CSE-ConnectionGUID: xdABLVBuTx2nkFoeVUs5AQ==
X-CSE-MsgGUID: 05NSAZhBSHCaDnD00btXsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36240683"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:14:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 15/16] selftests/resctrl: Remove mongrp from CMT test
Date: Fri, 31 May 2024 16:11:41 +0300
Message-Id: <20240531131142.1716-16-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
References: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The CMT selftest instantiates a monitor group to read LLC occupancy.
Since the test also creates a control group, it is unnecessary to
create another one for monitoring because control groups already
provide monitoring too.

Remove the unnecessary monitor group from the CMT selftest.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
--

v4:
- New patch
---
 tools/testing/selftests/resctrl/cmt_test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 238f514ba7e6..b63fa1e93307 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -17,12 +17,12 @@
 #define MAX_DIFF_PERCENT	15
 
 #define CON_MON_LCC_OCCUP_PATH		\
-	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
+	"%s/%s/mon_data/mon_L3_%02d/llc_occupancy"
 
 static int cmt_init(const struct resctrl_val_param *param, int domain_id)
 {
 	sprintf(llc_occup_path, CON_MON_LCC_OCCUP_PATH, RESCTRL_PATH,
-		param->ctrlgrp, param->mongrp, domain_id);
+		param->ctrlgrp, domain_id);
 
 	return 0;
 }
@@ -146,7 +146,6 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 	struct resctrl_val_param param = {
 		.resctrl_val	= CMT_STR,
 		.ctrlgrp	= "c1",
-		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
 		.mask		= ~(long_mask << n) & long_mask,
 		.num_of_runs	= 0,
-- 
2.39.2


