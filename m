Return-Path: <linux-kselftest+bounces-11367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD5B90041F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 14:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8513B1C2381F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 12:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF51193074;
	Fri,  7 Jun 2024 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSmlbEke"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C85190678;
	Fri,  7 Jun 2024 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764881; cv=none; b=HviIgPONs2D9G61B/UF6E6qTBQPM1G2O3lu9llruiCtzJUL3fDR0+arWueNUtibMGI9AV0/hQn1KBQZVLw6cV9sREZ0teugw8q549+vv/n1v5GA0ptww3eWA0pPiz7g0r8r2UzY8eWeLQuBQWhXerOUrcuWSw/pK/5VbEeCMQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764881; c=relaxed/simple;
	bh=pqbjmHujA1WLwaWy+nUMvRHVaRTjFoHR11jKlXQYaBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8IbRkO/0egZMXfqyom2fSBpZG6ziL5K7LKlEEocC7Zx2nIeu78DIruwoNkhb4KVCLuKNi+IQ5CCy/ejkmQxwcUMavROJ0baBByOPievuRtDVhycW5UkThy/p8G4A1ag+3p4UEr9qiL/XqqdiicoV9QlMPZpAabIIRAy9tV9U+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSmlbEke; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717764880; x=1749300880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pqbjmHujA1WLwaWy+nUMvRHVaRTjFoHR11jKlXQYaBY=;
  b=LSmlbEkeSviWoXbFDjcaffU3iLMjdx3q0PaJHBUT72VZrdqqWdUrQ8J1
   b/icETJuIl2duIVLrsSxr6Zqlpdd7PLEkYfsTnwJDP+qZIggf+RLvXIEY
   Fn9oaBbSPpNng3x6HY25uqDaI0GPLEfYOFLYoiwkjgcbkVaEo7THRF4fF
   57HNd7gq9LtQDGPChY9dJx/SJm3D51ZN276ebKXQA4fCzz/AHJrZH74Eu
   V5ZkXOoET73BQf9ItBekzxFq+wy2g2ditw0fEdi0qUn7pFVR/hTvt5rao
   DmmUaJP4vf6ufS4wCzvdnuLh0kh1WhljTcRKsUizIfTT2JoeP5Pjt+C2b
   Q==;
X-CSE-ConnectionGUID: SwyGhYxeQDiPJ1J6X8S8fQ==
X-CSE-MsgGUID: JrDy4oerSaygu8GJxt4gUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14664798"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14664798"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:54:39 -0700
X-CSE-ConnectionGUID: 9xc3s684TlGaXIAzPvPM+w==
X-CSE-MsgGUID: Pz0O+Dp3QXSeFYa3UkOAmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="75797329"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.184])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:54:36 -0700
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
Subject: [PATCH v6 08/16] selftests/resctrl: Simplify mem bandwidth file code for MBA & MBM tests
Date: Fri,  7 Jun 2024 15:53:08 +0300
Message-Id: <20240607125316.7089-9-ilpo.jarvinen@linux.intel.com>
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
index 7eaf3cd0f024..9d6982be3b68 100644
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


