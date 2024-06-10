Return-Path: <linux-kselftest+bounces-11573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2401902565
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9C0281E31
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3829140E29;
	Mon, 10 Jun 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="As0sHoW9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4141420DD;
	Mon, 10 Jun 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032644; cv=none; b=bbfKVOsv9BHPcHk9KKry//t0O86s91mbvLi5DLJbYUbLYo/jjmxjUCKNUPhrEbrEU0n9LnY228ZxmIeGBCex2L0t/3C8dadX1cA0P+WUKqlWc+mtioZCpIlnC48zbicPCKp3c3EL9ou29yRHFnPLtZOQ+L3mO4pDkWfL5WPL4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032644; c=relaxed/simple;
	bh=eheohbSQURPQS0WEawrCBZbNeF43tCvxTAbYaEVSAm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACpUnbot17G+Zckh8XN4UIcg28Gw5tbDUOL/zg81x0Hf4g2z2MRwBYn1WCgdYAm0V4D0A918AJi3X62xN51J87YRT4T8qL2x4dbCm/uBIdLkxP3NiPghRMTbtOEmNBej/fAmZZ4r/HaHKiWRrF5dPXQRH3APOFDUAGhZHalYS6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=As0sHoW9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718032644; x=1749568644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eheohbSQURPQS0WEawrCBZbNeF43tCvxTAbYaEVSAm8=;
  b=As0sHoW9+/kWnfPXRSYe74WNXKUmRPRYK4844VVLCrzH2mBp8lNZe6WO
   MoRYUQIAaSYJa0A5VwU4fXq2maF32kIpEzB93AvCzetiH25S8A/n4evDI
   QglzULCMUZSpxxAOmgKg5r4cIlUzXxk8dgo5e5n5XCT6Cs5qVawRWOJYr
   Vi9i3jObPAO6Xd7BOBRIwYaR2i3OFuO765dhjz/eWC7xqpNnD2mUVAdVF
   iNr9w1EqOoaljhEp5hREx4mn+i9Dlrt3GdXLOWqyhi7dQwllDXrH0rDyV
   UIIDrQM6azCZekQg/scd5WegUAk2QI3XGXpo8zob10eaerltbeTTvqoRq
   w==;
X-CSE-ConnectionGUID: NLTR8XymQaOWyxse2p8ylg==
X-CSE-MsgGUID: dVOu+rf7T0aQoZxsjCpJFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="26115496"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="26115496"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:17:23 -0700
X-CSE-ConnectionGUID: i+JHnuP/Rs+mKs2cFE9fIg==
X-CSE-MsgGUID: MGaG4EiZSPW8wAfTGEH0qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="44026637"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.194])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:17:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 15/16] selftests/resctrl: Remove mongrp from CMT test
Date: Mon, 10 Jun 2024 18:14:56 +0300
Message-Id: <20240610151457.7305-16-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
References: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
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
---

v7:
- Fix separator to use 3 dashes
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


