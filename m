Return-Path: <linux-kselftest+bounces-11374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CED590043E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974CD28D0FF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1646194122;
	Fri,  7 Jun 2024 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWziUTxt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7724E1922C4;
	Fri,  7 Jun 2024 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764941; cv=none; b=Cc06eQqWoOWqsMJjv8TbmRWPFXWDKvh3RgP59CGxxmQDm1iZ+AYYmFjJImTHVAHAlhRZo14P1c6suKSDupB68y5PEEC/Fz9frZJLSR1HQ2INXDtSZSNanhHW/E859ahqcP1FjJi6H3QQ2Eblr1Tz0EXFR/KmyKLBOO6o+d/XPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764941; c=relaxed/simple;
	bh=BKYA8H1ndfnYfZRhScci+pVcEuQkAu6Yh4Tj0Qt1yhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WY7qAmxfOoi2g1XwkxqPMUPvPHt7o2sZjCRze/kz0UHnbCL5/GHaPInMd/eXJDYEgbAmoQyB3TV1HIjliEE7leOQAessFCd/tHS4wHBUpjgo2Alje/TtZSW9Y+2q9EwJJqWDoY6re061p1FKXKW0d96vkV3bbsRBCOfsCwfUDGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWziUTxt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717764940; x=1749300940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BKYA8H1ndfnYfZRhScci+pVcEuQkAu6Yh4Tj0Qt1yhE=;
  b=IWziUTxtHMVZrnuQdAYWN8iBY2LNb9ByNTaCmziUxC6+0dhn1kMVvfs1
   6hddLULPz+C+bAhcPi4yYiFAas4LeuqwxwRxS7dmlIvXj8MJfQXlzwBWQ
   NUiGnrNghYWg4/2X8pWxtLHG0d/cuGRlYpaVWchWFIaXtsiYwjLIrRNJe
   aZoIhtBt5yZ9ZKNDIBd0DRFLSjlXymZvFwwe3nd1zkw2IvbsAJUXE50XL
   equtwLBbR7mfes8Jdr9TCzN0rCtuoLeHsa4o71bEGxWcu0dgWT9uwFL58
   mcbKiA5tTKB5JQYjtOtXYiqwBJcP0p3d16huQXYQHbmXwsPfcGcCFjahQ
   Q==;
X-CSE-ConnectionGUID: KdeBC4xdQyiMbWsTLaom1w==
X-CSE-MsgGUID: EHoCCobAQKu77HOP9369lQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="25055994"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="25055994"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:55:40 -0700
X-CSE-ConnectionGUID: q4z5NCEUR5ux6ADIqpxRGw==
X-CSE-MsgGUID: hUQ1fW7/Rsqo0Ov9CPzbBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="69484104"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:55:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Babu Moger <babu.moger@amd.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 15/16] selftests/resctrl: Remove mongrp from CMT test
Date: Fri,  7 Jun 2024 15:53:15 +0300
Message-Id: <20240607125316.7089-16-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com>
References: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com>
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
Tested-by: Babu Moger <babu.moger@amd.com>
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


