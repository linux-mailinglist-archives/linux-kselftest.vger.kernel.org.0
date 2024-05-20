Return-Path: <linux-kselftest+bounces-10438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5873B8C9D6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 14:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7931C22CB2
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 12:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548FA5E099;
	Mon, 20 May 2024 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ScbJn3A/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7B356754;
	Mon, 20 May 2024 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208365; cv=none; b=mUGbuDr4oDp0r2dIDX9706INksrMBHEC5aO4K5BeAXdOgy5iKCtkxpXU0WLcHSvWfjAeW4Qcl1Dfx8dr982lBzlix/+ukGUdSH76R17nEz0lGcyO7p52B7zRl6Iq8M4OdeZ/bdNwK1ePYu4Cgc4AwCF1OejR0+Z9NTdCFwb/Bcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208365; c=relaxed/simple;
	bh=DeuVhYVGlbeHQx+ZSQaZAGwOZQyUcwm1aYbJ2e5hPsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6rTVmmRAaNNSPyl0Brn0XWESp7nVg4ra36o6TRrffZk++ZY0BaG/KP5NBA5Q1scc274j2lOdIuk/XBlZlMP1ZnDflOtpFdJcEVxXRHxc4Q6deHav0+pAX1c+Ttre/Xu5UIBo9+FxI/XeKHQu8gwcxWirgHSQYzYXEJI/kpgwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ScbJn3A/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716208364; x=1747744364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DeuVhYVGlbeHQx+ZSQaZAGwOZQyUcwm1aYbJ2e5hPsk=;
  b=ScbJn3A/LmK5iiMjav8q69/IuyETsXQrO0gHOVCnZcnJe+2/c6tBgjjh
   62fTBfVSvlgON3+2XKIGk+CBfs1n+ZyIdieerd+bSSJ5FiD9FbgtEcWqF
   dklzpGfWJBVnMZtqr1PxeDQViVoTkt526R7cEbbxnXgBOtIU9ly8AJEJE
   3mauIZDP4xvGJeKx/7qtb58oDwDNwYg0SmVQNSXoQ5NmUg8Ny7vkH27YL
   R1gVHEzKwNOSMglohTFmuiOtAJWP+Mna8eXc5NIYit5Oufkmz4WWS6FhF
   W9jKNbtn1zIEXw+ku3LmgCWyM9yrg7dgsYoRCLyau4RKflbyeCA5KGbCT
   A==;
X-CSE-ConnectionGUID: lrfcJXKNQ92JefuX3F7d5Q==
X-CSE-MsgGUID: 8n7hoCUoRYWXCYziCNyXZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23475491"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="23475491"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:32:44 -0700
X-CSE-ConnectionGUID: GQtPIMLERHS3/rjb18IPlg==
X-CSE-MsgGUID: jDAXmw/YSEST+IftWVvl3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="63747811"
Received: from unknown (HELO localhost) ([10.245.247.114])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 05:32:41 -0700
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
Subject: [PATCH v4 15/16] selftests/resctrl: Remove mongrp from CMT test
Date: Mon, 20 May 2024 15:30:19 +0300
Message-Id: <20240520123020.18938-16-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The CMT selftest instanciates a monitor group to read LLC occupancy.
Since the test also creates a control group, it is unnecessary to
create another one for monitoring because control groups already
provide monitoring too.

Remove the unnecessary monitor group from the CMT selftest.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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


