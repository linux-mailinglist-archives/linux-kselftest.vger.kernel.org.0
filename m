Return-Path: <linux-kselftest+bounces-11565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9457290255B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A7CB263E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 15:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CE5142E75;
	Mon, 10 Jun 2024 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AOrLsRez"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1B14A615;
	Mon, 10 Jun 2024 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032583; cv=none; b=TSBBB5DkHaYskmRHL2G5dtW/61ha2fzQdt+dZe5Hd765VM3gZ26Cm51eRIeie7OCmtw6m+xc+/WwMtCxUaVu8iUDX4Ybv7F08AWUTzmq0UhXNkj/eC0DMjdzfg5G+BYhp3fFU1/XV5WSOfD4H+nLw40WoBkffCZoNxoI05JGqUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032583; c=relaxed/simple;
	bh=LzZJorUKMfWLu+LV9cKuET0V/HPXuBpNfC2gyr750Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvycRZTUUPEFMrIAUSK69LTiT8RMhSXiX6mbFM9W++PiPLTXoI4+DP2/ZahM7Sp7lq5jK/EmnaJyAAM+5ar7dzfRdf3UPEuebrW6kpc1IjonwGd9J73rdxStc/l30o92bZTDARYbLiRjJVlPIDpUIejuYSJ3YLLhl5IvsiD8puE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AOrLsRez; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718032582; x=1749568582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LzZJorUKMfWLu+LV9cKuET0V/HPXuBpNfC2gyr750Mg=;
  b=AOrLsRez9JsEsIwrpbpmZNz4taHzTyNa+/llGXqS+Q+cg2M42Y1qM0fU
   WJyNBtqqn96V1KagB5wAPPATGWoNNqXG2zln7ySZQ/PVkfsFEOye9Bgn6
   V9q8peyfNOxc80G9wglHScqPjnur62STGs3llj9zfTeyESVl8z+EUIYPD
   mbeHjro7pLgkrfjzRkRjtPyWW1UorFNJwia6humtORLYDjFJ+gSuioS6L
   AkYXRIY9ndewC0+u973q9n2B2CaJXll+UJ0JQ1OGJPhGxFhqC2tQkukJr
   bnHVd0K3ybtxqDlQaE6xS6Uj3NWQ8lWjsz/HJDFmivFKylNLgNCkYd82h
   w==;
X-CSE-ConnectionGUID: LhaHpRT4RGGBiuBMHOgHSQ==
X-CSE-MsgGUID: puP2XK3QRjCmZMmRT7LOiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="25807773"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="25807773"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:16:21 -0700
X-CSE-ConnectionGUID: TX9kdILSTzG1+rOSoYH1TA==
X-CSE-MsgGUID: Exhibf6RR9OAzL0xRLmiIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39016945"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.194])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:16:17 -0700
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
Subject: [PATCH v7 08/16] selftests/resctrl: Simplify mem bandwidth file code for MBA & MBM tests
Date: Mon, 10 Jun 2024 18:14:49 +0300
Message-Id: <20240610151457.7305-9-ilpo.jarvinen@linux.intel.com>
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

initialize_mem_bw_resctrl() and set_mbm_path() contain complicated set
of conditions, each yielding different file to be opened to measure
memory bandwidth through resctrl FS. In practice, only two of them are
used. For MBA test, ctrlgrp is always provided, and for MBM test both
ctrlgrp and mongrp are set.

The file used differ between MBA/MBM test, however, MBM test
unnecessarily create monitor group because resctrl FS already provides
monitoring interface underneath any ctrlgrp too, which is what the MBA
selftest uses.

Consolidate memory bandwidth file used to the one used by the MBA
selftest. Remove all unused branches opening other files to simplify
the code.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v4:
- Remove also MBM .mongrp setup
v3:
- New patch
---
 tools/testing/selftests/resctrl/mbm_test.c    |  1 -
 tools/testing/selftests/resctrl/resctrl_val.c | 45 ++-----------------
 2 files changed, 4 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 3059ccc51a5a..96d279b06377 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -115,7 +115,6 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBM_STR,
 		.ctrlgrp	= "c1",
-		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= "reads",
 		.setup		= mbm_setup
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index b33cb1de295b..277c13b7a4c5 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -19,18 +19,10 @@
 #define MAX_TOKENS		5
 #define READ			0
 #define WRITE			1
-#define CON_MON_MBM_LOCAL_BYTES_PATH				\
-	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
 
 #define CON_MBM_LOCAL_BYTES_PATH		\
 	"%s/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
 
-#define MON_MBM_LOCAL_BYTES_PATH		\
-	"%s/mon_groups/%s/mon_data/mon_L3_%02d/mbm_local_bytes"
-
-#define MBM_LOCAL_BYTES_PATH			\
-	"%s/mon_data/mon_L3_%02d/mbm_local_bytes"
-
 #define CON_MON_LCC_OCCUP_PATH		\
 	"%s/%s/mon_groups/%s/mon_data/mon_L3_%02d/llc_occupancy"
 
@@ -430,43 +422,15 @@ static int get_mem_bw_imc(char *bw_report, float *bw_imc)
 	return 0;
 }
 
-void set_mbm_path(const char *ctrlgrp, const char *mongrp, int domain_id)
-{
-	if (ctrlgrp && mongrp)
-		sprintf(mbm_total_path, CON_MON_MBM_LOCAL_BYTES_PATH,
-			RESCTRL_PATH, ctrlgrp, mongrp, domain_id);
-	else if (!ctrlgrp && mongrp)
-		sprintf(mbm_total_path, MON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
-			mongrp, domain_id);
-	else if (ctrlgrp && !mongrp)
-		sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
-			ctrlgrp, domain_id);
-	else if (!ctrlgrp && !mongrp)
-		sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
-			domain_id);
-}
-
 /*
  * initialize_mem_bw_resctrl:	Appropriately populate "mbm_total_path"
  * @ctrlgrp:			Name of the control monitor group (con_mon grp)
- * @mongrp:			Name of the monitor group (mon grp)
  * @domain_id:			Domain ID (cache ID; for MB, L3 cache ID)
- * @resctrl_val:		Resctrl feature (Eg: mbm, mba.. etc)
  */
-static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
-				      int domain_id, char *resctrl_val)
+static void initialize_mem_bw_resctrl(const char *ctrlgrp, int domain_id)
 {
-	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
-		set_mbm_path(ctrlgrp, mongrp, domain_id);
-
-	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-		if (ctrlgrp)
-			sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH,
-				RESCTRL_PATH, ctrlgrp, domain_id);
-		else
-			sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH,
-				RESCTRL_PATH, domain_id);
-	}
+	sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH, RESCTRL_PATH,
+		ctrlgrp, domain_id);
 }
 
 /*
@@ -867,8 +831,7 @@ int resctrl_val(const struct resctrl_test *test,
 		if (ret)
 			goto out;
 
-		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
-					  domain_id, resctrl_val);
+		initialize_mem_bw_resctrl(param->ctrlgrp, domain_id);
 	} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
 		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
 					    domain_id, resctrl_val);
-- 
2.39.2


