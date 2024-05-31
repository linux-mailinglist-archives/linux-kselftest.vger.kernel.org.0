Return-Path: <linux-kselftest+bounces-11008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E698D6296
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29ABB289988
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC9A158DC8;
	Fri, 31 May 2024 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyLR7H3T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0247815748F;
	Fri, 31 May 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161191; cv=none; b=fOnFnn+QbCXEAD/PvX5RKJolOWRHH4ul6ZfaUWxxZGzKlDRSLTvn3G3uCGNd/IcmWIKjagtnTPs9WsyWLw02mKaqH/ryiSqXZfjyIuKxKpRd7bOwuqec+VRS9Sy8Kcvvn8RZNkGxURf7U9gHompPhjgyem2cJb4wwO2JZfncouE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161191; c=relaxed/simple;
	bh=FVYUrw6HrxepS0/aydUoZW2UnbvZcLRt5IGkscNRCGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQdByZWfT2vY6jvhFw7CNV2B614HUFQAOF4G5BZ6iv3NBJcd3LFPVhA+KMDqiwzBp13izKRo5mT7ik/hDnm/t08WGiatwDV2Pih3Uv3JGsOxRav37UKw0ugYHAqP5Vu+mmLy5/SgvbA0YTM2MC95oEDo6eE0s4/9oby/eGJ+OcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyLR7H3T; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717161190; x=1748697190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FVYUrw6HrxepS0/aydUoZW2UnbvZcLRt5IGkscNRCGM=;
  b=UyLR7H3T9JTitTxG1iR74/rYPt51BVuqgtmGxEqYOAepvmsvrFgGLsrs
   9V1SZ0LeI10jZ/R9rezU2UDZ24BpOyjKx+xm7YZVN1J+sKs0FUbBmg8xH
   bYlur7wSFwZRHkJkIBOFc1MCTDHQGWKdobUlUEXqh2lI6N5hhDLk+kXGg
   +8znkW1DoH7HboVDCaxYGdu/72SX3XK6JOtChdXmGAc3seThtLLtKih6z
   vYRlFxlEBzTPWE0tikOet/b3z/x5hbk211gpsLPaWUE6hXk6Ey0XD9BcH
   WyzQInGJkBASLc/vjZ0vouNeGt/oqL5WRy8lb54DhH+ebEhwx7HvJub0p
   g==;
X-CSE-ConnectionGUID: 8ZQHGnZ5QDGgYLtexF1xdA==
X-CSE-MsgGUID: NZp9DC7ASuG+A0+CQW466Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17501497"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="17501497"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:13:09 -0700
X-CSE-ConnectionGUID: 67vvM9m7SWGTQm3L7DNC4g==
X-CSE-MsgGUID: hMAj816WTj2l1XHyvwv6Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36240542"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.152])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:13:07 -0700
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
Subject: [PATCH v5 08/16] selftests/resctrl: Simplify mem bandwidth file code for MBA & MBM tests
Date: Fri, 31 May 2024 16:11:34 +0300
Message-Id: <20240531131142.1716-9-ilpo.jarvinen@linux.intel.com>
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
index e3670b8bc317..2a10b50c9e2a 100644
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
 
@@ -436,43 +428,15 @@ static int get_mem_bw_imc(char *bw_report, float *bw_imc)
 	return -1;
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
@@ -872,8 +836,7 @@ int resctrl_val(const struct resctrl_test *test,
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


